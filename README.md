# AdaptTableViewCell
![image](https://github.com/Koneey/AdaptTableViewCell/blob/master/introduction/AdatpTableViewCell.gif)

#简介:
TableViewCell自动适应文本高度

#使用方法:
##TitleInputTableViewCell初始化:
    - (instancetype)initCellAtIndexPath:(NSIndexPath *)indexPath placeHolderTitle:(NSString *)placeHolder text:(NSString *)text;

##代理类需要实现<TitleInputTableViewCellDelegate>代理
*TitleInputTableViewCellDelegate* 代理方法包括:
    - (void)heightWillChangedTitleInputCell:(TitleInputTableViewCell *)cell;
    - (void)heightDidChangedTitleInputCell:(TitleInputTableViewCell *)cell;
    - (void)cellTextDidChange:(TitleInputTableViewCell *)cell;

