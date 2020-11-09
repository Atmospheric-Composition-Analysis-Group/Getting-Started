Group storage policy
====================

This is a rolling copy of the group's storage policy. Our group's allocation is 500 TB of Active
plus 500 TB of Archive. Our Active allocation is at `/storage1/fs1/rvmartin/Active` and our Achive
allocation is at `/storage1/fs1/rvmartin/Archive`. RIS asserts that these filesystem are more
complicated than simply disks and tapes, but they say Active can be thought of as "like hard
drives", and Archive can be thought of as "like tapes".

To transfer data between Active and Archive, you should use Globus.

Policy
------

This policy is not intended to impose any restrictions on your usage of Compute1 or Storage1. It's
moreso intended to facilitate the data lifecycle of the group.

1. The Archive directory should have the same structure as the Active directory. If you are
   archiving `rvmartin/Active/lbindle/sgv` it should go in `rvmartin/Archive/lbindle/sgv`.
2. If you are done with a directory, and it can be archived, move it to Archive. If at any point you
   need to bring it back, it's easy to do with Globus (mind you it might take several days if it's
   large).
3. Before you leave the group, archive your entire project directory.
4. Every 6 months to a year, go through your directories and archive anything that you can.

