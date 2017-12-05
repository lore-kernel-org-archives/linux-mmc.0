From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFT 0/3] mmc: renesas_sdhi: Add eMMC HS400 mode support
Date: Tue,  5 Dec 2017 13:37:53 +0100
Message-ID: <20171205123756.18424-1-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Hi,

this short series represents work-in-progress to add eMMC HS400
support to the SDHI driver and enable the feature on the
R-Car Gen3 based Salvator-X* boards.

As it stands this series seems to need more work:
* H3 ES1.0/Salvator-X appears slightly slower with this work that without
* M3-W ES1.0/Salvator-X and H3 ES2.0/Salvator-XS does not initialise
  the eMMC with this work present

Test results are provided at the end of this email including tests run with
the BSP v4.5.9 (which seems to work well).

Work on this series had been hindered to some extend by instability of eMMC
without these patches in my environment as reported in "Possible regression
due to "arm64: renesas: salvator: set driver type for eMMC"".


The base used for testing these patches was:
* A merge of renesas-devel-20171205-v4.15-rc2 and mmc/next; and
* Reversion of d3decc2c34c8 ("arm64: dts: renesas: salvator: set driver type for eMMC")
* "[PATCH] mmc: core: properly init drv_type"

To aid testing this patchset is available in git as a topic branch

https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/sdhi-hs400

And the base is available as:

https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/sdhi-hs400.base


Ai Kyuse (2):
  mmc: tmio: Add eMMC HS400 mode support
  mmc: renesas_sdhi: Add eMMC HS400 mode support

Takeshi Kihara (1):
  arm64: dts: salvator-common: Enable HS400 of SDHI2

 arch/arm64/boot/dts/renesas/salvator-common.dtsi |   1 +
 drivers/mmc/host/renesas_sdhi_core.c             | 123 ++++++++++++++++++++---
 drivers/mmc/host/tmio_mmc.h                      |   5 +
 drivers/mmc/host/tmio_mmc_core.c                 |  29 +++++-
 4 files changed, 140 insertions(+), 18 deletions(-)

-- 
2.11.0


TEST DATA


H3 ES1.0 / Salvator-X
=====================

H3 ES1.0: BSP v3.5.9 (hs400 not enabled in BSP)
-----------------------------------------------

# dmesg | grep mmc
[    2.594980] sh_mobile_sdhi ee140000.sd: mmc0 base at 0xee140000 max
clock rate 200 MHz
[    2.721370] mmc0: new HS200 MMC card at address 0001
[    2.723478] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB 
[    2.723627] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
[    2.723757] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
[    2.723880] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB

# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=1024 iflag=direct
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 13.2866 s, 80.8 MB/s

H3 ES1.0: BSP v3.5.9, hs400 enabled
-----------------------------------

# dmesg | grep mmc
[    2.601743] sh_mobile_sdhi ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    2.721647] mmc0: new HS400 MMC card at address 0001
[    2.726294] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB 
[    2.730460] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
[    2.734598] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
[    2.738731] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB
...

# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=2048 iflag=direct
2048+0 records in
2048+0 records out
2147483648 bytes (2.1 GB) copied, 15.7728 s, 136 MB/s

H3 ES1.0: Before (345fad481b8 topic/sdhi-hs400.base)
----------------------------------------------------

# dmesg | grep mmc
[    2.561404] renesas_sdhi_internal_dmac ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    2.681408] mmc0: new HS200 MMC card at address 0001
[    2.688103] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB 
[    2.693249] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
[    2.719066] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
[    2.719587] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB, chardev (243:0)
...

# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 10.3295 s, 52.0 MB/s

H3 ES1.0: After (010c62827298 topic/sdhi-hs400)
-----------------------------------------------

root@Debian:~# dmesg | grep mmc
[    2.437400] renesas_sdhi_internal_dmac ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    2.530669] mmc0: new HS400 MMC card at address 0001
[    2.531998] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB 
[    2.532529] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
[    2.532941] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
[    2.533460] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB, chardev (243:0)
...

root@Debian:~# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=64 iflag=direct
64+0 records in
64+0 records out
67108864 bytes (67 MB) copied, 1.34285 s, 50.0 MB/s

M3-W ES1.0 / Salvator-X
=======================

M3-W ES1.0: BSP v3.5.9 (hs400 enabled in BSP)
---------------------------------------------

# dmesg | grep mmc
[    2.335990] sh_mobile_sdhi ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    2.533513] mmc0: new HS400 MMC card at address 0001
[    2.547956] mmcblk0: mmc0:0001 eMMC   28.8 GiB 
[    2.559903] mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
[    2.575909] mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
[    2.599020] mmcblk0rpmb: mmc0:0001 eMMC   partition 3 4.00 MiB
[    2.619400]  mmcblk0: p1
...

# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 10.1324 s, 53.0 MB/s

M3-W ES1.0: BSP v3.5.9, hs400 disabled
--------------------------------------

# dmesg | grep mmc
[    2.354686] sh_mobile_sdhi ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    3.064544] mmc0: new HS200 MMC card at address 0001
[    3.070070] mmcblk0: mmc0:0001 eMMC   28.8 GiB 
[    3.074814] mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
[    3.100849] mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
[    3.107005] mmcblk0rpmb: mmc0:0001 eMMC   partition 3 4.00 MiB
[    3.122783]  mmcblk0: p1

# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 10.2417 s, 52.4 MB/s

M3-W ES1.0: Before (345fad481b8 topic/sdhi-hs400.base)
------------------------------------------------------

# dmesg | grep mmc
[    1.878735] renesas_sdhi_internal_dmac ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    2.029867] mmc0: new HS200 MMC card at address 0001
[    2.031282] mmcblk0: mmc0:0001 eMMC   28.8 GiB 
[    2.031773] mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
[    2.032197] mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
[    2.032941] mmcblk0rpmb: mmc0:0001 eMMC   partition 3 4.00 MiB, chardev (243:0)
[    2.039922]  mmcblk0: p1
...

# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 11.2138 s, 47.9 MB/s

H3-W ES1.0: After (010c62827298 topic/sdhi-hs400)
-------------------------------------------------

# dmesg | grep mmc
[    1.884618] renesas_sdhi_internal_dmac ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    2.044911] mmc0: new HS400 MMC card at address 0001
[    2.046374] mmcblk0: mmc0:0001 eMMC   28.8 GiB 
[    2.046875] mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
[    2.047386] mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
[    2.048163] mmcblk0rpmb: mmc0:0001 eMMC   partition 3 4.00 MiB, chardev (243:0)
[    2.249641] print_req_error: I/O error, dev mmcblk0, sector 0
[    2.251433] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[    2.328775] print_req_error: I/O error, dev mmcblk0, sector 0
[    2.336424] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[    2.343742]  mmcblk0: unable to read partition table
...
[   11.533287] mmc0: tuning execution failed: -5
[   11.672124] mmc0: tuning execution failed: -5
[   11.678307] mmc0: tried to reset card, got error -5
[   11.693848] print_req_error: I/O error, dev mmcblk0, sector 0
[   11.710474] print_req_error: I/O error, dev mmcblk0, sector 1
[   11.722104] print_req_error: I/O error, dev mmcblk0, sector 2
[   11.738357] print_req_error: I/O error, dev mmcblk0, sector 4
[   11.746710] print_req_error: I/O error, dev mmcblk0, sector 5
[   11.754399] print_req_error: I/O error, dev mmcblk0, sector 6
[   11.763664] print_req_error: I/O error, dev mmcblk0, sector 7
[   11.774534] print_req_error: I/O error, dev mmcblk0, sector 0
[   11.782452] print_req_error: I/O error, dev mmcblk0, sector 1
[   11.790411] print_req_error: I/O error, dev mmcblk0, sector 2
[   11.800623] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[   11.862566] mmc0: cache flush error -74
[   11.972587] mmc0: tuning execution failed: -5
[   11.978324] mmc0: tried to reset card, got error -5
[   11.999404] Buffer I/O error on dev mmcblk0boot1, logical block 1008, async page read
[   12.010950] mmc0: cache flush error -74
[   12.133609] mmc0: tuning execution failed: -5
[   12.140934] mmc0: tried to reset card, got error -5
[   12.155970] Buffer I/O error on dev mmcblk0boot0, logical block 1008, async page read

# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=64 iflag=direct
[   59.251014] print_req_error: 37 callbacks suppressed
[   59.251030] print_req_error: I/O error, dev mmcblk0, sector 0
[   59.262269] print_req_error: I/O error, dev mmcblk0, sector 1
[   59.269016] print_req_error: I/O error, dev mmcblk0, sector 2
[   59.275174] print_req_error: I/O error, dev mmcblk0, sector 3
[   59.281250] print_req_error: I/O error, dev mmcblk0, sector 4
[   59.287328] print_req_error: I/O error, dev mmcblk0, sector 5
[   59.293387] print_req_error: I/O error, dev mmcblk0, sector 6
[   59.299496] print_req_error: I/O error, dev mmcblk0, sector 7
[   59.305737] print_req_error: I/O error, dev mmcblk0, sector 8
[   59.311738] print_req_error: I/O error, dev mmcblk0, sector 9
dd: error reading '/dev/mmcblk0': Input/output error
0+0 records in
0+0 records out
0 bytes (0 B) copied, 0.391551 s, 0.0 kB/s

H3 ES2.0 / Salvator-XS
======================

H3 ES2.0: BSP v3.5.9 (hs400 enabled in BSP)
-------------------------------------------

# dmesg | grep mmc
[    2.731653] sh_mobile_sdhi ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    3.417988] mmc0: new HS400 MMC card at address 0001
[    3.418291] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB 
[    3.418397] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
[    3.418499] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
[    3.418595] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB
...

# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=2048 iflag=direct 
2048+0 records in
2048+0 records out
2147483648 bytes (2.1 GB) copied, 9.09945 s, 236 MB/s

H3 ES2.0: BSP v3.5.9, hs400 disabled
------------------------------------

# dmesg | grep mmc
[    2.744042] sh_mobile_sdhi ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    2.861917] mmc0: new HS200 MMC card at address 0001
[    2.868087] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB 
[    2.868202] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
[    2.872312] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
[    2.876423] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB
...

# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=2048 iflag=direct
2048+0 records in
2048+0 records out
2147483648 bytes (2.1 GB) copied, 14.1931 s, 151 MB/s

H3 ES2.0: Before (345fad481b8 topic/sdhi-hs400.base)
----------------------------------------------------

# dmesg | grep mmc
[    2.518906] renesas_sdhi_internal_dmac ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    2.608745] mmc0: new HS200 MMC card at address 0001
[    2.609641] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB 
[    2.609984] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
[    2.610330] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
[    2.610719] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB, chardev (243:0)
...

# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 8.32918 s, 64.5 MB/s

H3 ES2.0: After (010c62827298 topic/sdhi-hs400)
-----------------------------------------------

root@Debian:~# dmesg | grep mmc
[    2.518244] renesas_sdhi_internal_dmac ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    2.700219] mmc0: new HS400 MMC card at address 0001
[    2.701193] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB 
[    2.701548] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
[    2.701880] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
[    2.702274] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB, chardev (243:0)
[    2.726711] mmc0: mmc_select_hs400 failed, error -84
[    2.901629] mmc0: mmc_select_hs400 failed, error -84
[    2.930620] mmc0: mmc_select_hs400 failed, error -84
[    2.937035] mmcblk0: error -84 requesting status
...
[    3.111482] mmc0: tuning execution failed: -5
[    3.116838] mmc0: tried to reset card, got error -5
[    3.122749] mmcblk0: recovery failed!
[    3.127499] print_req_error: I/O error, dev mmcblk0, sector 0
[    3.134288] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[    3.143073]  mmcblk0: unable to read partition table
[    3.178781] renesas_sdhi_internal_dmac ee160000.sd: mmc2 base at 0xee160000 max clock rate 200 MHz
...

root@Debian:~# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=64 iflag=direct
64+0 records in
64+0 records out
67108864 bytes (67 MB) copied, 1.66178 s, 40.4 MB/s
