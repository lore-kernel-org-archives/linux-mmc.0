From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v2] mmc: core: Use maximum timeout values in case TACC field is zero
Date: Thu,  3 Apr 2014 17:32:05 +0200
Message-ID: <1396539125-37171-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.24]:51097 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbaDCPcg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Apr 2014 11:32:36 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, fabio.estevam@freescale.com, chris@printf.net
Cc: otavio@ossystems.com.br, linux-mmc@vger.kernel.org, Kernel@pengutronix.de

When plugging a specific micro SD card at MMC socket of a custom i.MX28 board,
we get the following kernel warning:

WARNING: CPU: 0 PID: 30 at drivers/mmc/host/mxs-mmc.c:342 mxs_mmc_start_cmd+0x34c/0x378()
Modules linked in:
CPU: 0 PID: 30 Comm: kworker/u2:1 Not tainted 3.14.0-rc5 #8
Workqueue: kmmcd mmc_rescan
[<c0015420>] (unwind_backtrace) from [<c0012cb0>] (show_stack+0x10/0x14)
[<c0012cb0>] (show_stack) from [<c001daf8>] (warn_slowpath_common+0x6c/0x8c)
[<c001daf8>] (warn_slowpath_common) from [<c001db34>] (warn_slowpath_null+0x1c/0x24)
[<c001db34>] (warn_slowpath_null) from [<c0349478>] (mxs_mmc_start_cmd+0x34c/0x378)
[<c0349478>] (mxs_mmc_start_cmd) from [<c0338fa0>] (mmc_start_request+0xc4/0xf4)
[<c0338fa0>] (mmc_start_request) from [<c03390b4>] (mmc_wait_for_req+0x50/0x164)
[<c03390b4>] (mmc_wait_for_req) from [<c03405b8>] (mmc_app_send_scr+0x158/0x1c8)
[<c03405b8>] (mmc_app_send_scr) from [<c033ee1c>] (mmc_sd_setup_card+0x80/0x3c8)
[<c033ee1c>] (mmc_sd_setup_card) from [<c033f788>] (mmc_sd_init_card+0x124/0x66c)
[<c033f788>] (mmc_sd_init_card) from [<c033fd7c>] (mmc_attach_sd+0xac/0x174)
[<c033fd7c>] (mmc_attach_sd) from [<c033a658>] (mmc_rescan+0x25c/0x2d8)
[<c033a658>] (mmc_rescan) from [<c003597c>] (process_one_work+0x1b4/0x4ec)
[<c003597c>] (process_one_work) from [<c0035de4>] (worker_thread+0x130/0x464)
[<c0035de4>] (worker_thread) from [<c003c824>] (kthread+0xb4/0xd0)
[<c003c824>] (kthread) from [<c000f420>] (ret_from_fork+0x14/0x34)

The error is due to an invalid value in CSD register of a specific 2GB micro
SD card. The CSD version of this card is 1.0 but the TACC field has the invalid
value 0.

cid:0000005553442020000000000000583f
csd:00000032535a83bfedb7ffbf1680003f
date:08/2005
erase_size:512
fwrev:0x0
hwrev:0x0
manfid:0x000000
name:USD
oemid:0x0000
preferred_erase_size:4194304
scr:0225000000000000
serial:0x00000000
type:SD

Since the kernel is making use of this TACC field to calculate the
SD card timeout, an invalid value 0 leads to a warning at mxs_ns_to_ssp_ticks()
and later the following misleading error messages appears in a loop:

mxs-mmc 80010000.ssp: card claims to support voltages below defined range
mxs-mmc 80010000.ssp: no support for card's volts
mmc0: error -22 whilst initialising MMC card

This error is only found on this 2GB SD card on mxs platform.
On x86 this card works without any problems.

The following patch based on the work of Peter Chan and Otavio Salvador. It
catches the case that the determined timeout is still 0 and set
it's to a valid value.

Successful tested on a i.MX28 board.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---

Changes in v2:
- fix spelling error in name
- use local variable with usec for checking

 drivers/mmc/core/core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 098374b..74306ec 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -815,6 +815,10 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 			data->timeout_ns = limit_us * 1000;
 			data->timeout_clks = 0;
 		}
+
+		/* assign limit value if invalid */
+		if (timeout_us == 0)
+			data->timeout_ns = limit_us * 1000;
 	}
 
 	/*
-- 
1.7.10.4

