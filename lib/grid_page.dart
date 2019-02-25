import 'package:flutter/material.dart';

class GridPage extends StatefulWidget {
  final List<Widget> children;
  final int column; //列数
  final int row; //行数
  final double columnSpacing; //列间隔
  final double rowSpacing; //行间隔
  final double itemRatio; //每个item的宽高比，默认正方形

  GridPage({
    @required this.children,
    this.column = 4,
    this.row = 2,
    this.columnSpacing = 0.0,
    this.rowSpacing = 0.0,
    this.itemRatio = 1.0,
  });

  @override
  State<StatefulWidget> createState() {
    return GridPageState();
  }
}

class GridPageState extends State<GridPage> {
  ///每页的个数
  int _countPerPage;
  ///总页数
  int _pageCount;
  ///当前页
  int _currentPage;
  ///控制器
  PageController _controller;

  @override
  void initState() {
    _calculatePage();
    _controller = PageController();
    _currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(child: _buildPageView()),
            _buildCursor(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //释放资源
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  ///计算总页数及单页的item数目
  void _calculatePage() {
    assert(widget.children != null);
    _countPerPage = widget.row * widget.column;
    _pageCount = (widget.children.length / _countPerPage).ceil();
  }

  ///多个Item构建单页的GridView
  Widget _buildGrid(List<Widget> list) {
    return GridView.count(
      crossAxisCount: widget.column,
      children: list,
      mainAxisSpacing: widget.rowSpacing,
      crossAxisSpacing: widget.columnSpacing,
      childAspectRatio: widget.itemRatio,
    );
  }

  ///构建多个GridView
  List<Widget> _buildPages() {
    List<Widget> list = List();
    int index = 0;
    int realIndex;
    for (int i = 0; i < _pageCount; i++) {
      realIndex = index + _countPerPage > widget.children.length
          ? widget.children.length
          : index + _countPerPage;
      List l = widget.children.sublist(index, realIndex);
      index = realIndex;
      list.add(_buildGrid(l));
    }
    return list;
  }

  ///多个GridView构建PageView
  Widget _buildPageView() {
    return PageView(
      controller: _controller,
      children: _buildPages(),
      onPageChanged: (page) {
        setState(() {
          _currentPage = page;
        });
      },
    );
  }

  ///页标
  Widget _buildCursor() {
    List<Widget> list = List();
    for (int i = 0; i < _pageCount; i++) {
      list.add(_buildPoint(_currentPage == i));
    }
    return Container(
      child: Row(
        children: list,
        mainAxisSize: MainAxisSize.min,
      ),
      alignment: AlignmentDirectional.center,
    );
  }

  ///单个点
  Widget _buildPoint(bool focus) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
          width: 10, height: 10, color: focus ? Colors.black : Colors.grey),
    );
  }
}
