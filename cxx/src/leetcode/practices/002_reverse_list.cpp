
#include "leetcode/leetcode.hpp"

TEST(practise_reverse, 001)
{
    auto fn = [](ListNode* root) -> ListNode* {
        ListNode dummy(0, nullptr);
        ListNode* cur = root;
        ListNode* prev = &dummy;
        while (cur != nullptr)
        {
            ListNode* next = cur->next;
            cur->next = dummy.next;
            dummy.next = cur;
            cur = next;
        }
        return dummy.next;
    };

    {
        std::vector<int> input = {
            1,
            2,
            3,
        };

        ListNode* li = td::createList(input);
        ListNode* reverseList = fn(li);
        EXPECT_THAT((std::vector<int>{3, 2, 1}), testing::ContainerEq(td::listToVec(reverseList)));
        td::deleteList(reverseList);
    }
}