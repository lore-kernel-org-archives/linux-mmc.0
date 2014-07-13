From: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
Subject: [PATCH 4/4] mmc: core: hold SD Clock before CMD11 during Signal
Date: Sun, 13 Jul 2014 13:21:10 +0800
Message-ID: <1405228870-5088-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1405228870-5088-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:44266 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbaGMFXm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Jul 2014 01:23:42 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so3658452pad.9
        for <linux-mmc@vger.kernel.org>; Sat, 12 Jul 2014 22:23:42 -0700 (PDT)
In-Reply-To: <1405228870-5088-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.green@linaro.org, patches@linaro.org, jaswinder.singh@linaro.org, arnd@arndb.de, olof@lixom.net, linux@arm.linux.org.uk, chris@printf.net, anton@enomsg.org, t.takinishi@jp.fujitsu.com, mollie.wu@linaro.org, Vincent.Yang@tw.fujitsu.com

Voltage Switch Procedure

This patch is to fix an issue found on mb86s7x platforms.

[symptom]
There are some UHS-1 SD memory cards sometimes cannot be detected correctly,
e.g., Transcend 600x SDXC 64GB UHS-1 memory card.
During Signal Voltage Switch Procedure, failure to switch is indicated
by the card holding DAT[3:0] low.

[analysis]
According to SD Host Controller Simplified Specification Version 3.00
chapter 3.6.1, the Signal Voltage Switch Procedure should be:
(1) Check S18A; (2) Issue CMD11; (3) Check CMD 11 response;
(4) Stop providing SD clock; (5) Check DAT[3:0] should be 0000b;
(6) Set 1.8V Signal Enable; (7) Wait 5ms; (8) Check 1.8V Signal Enable;
(9) Provide SD Clock; (10) Wait 1ms; (11) Check DAT[3:0] should be 1111b;
(12) error handling

With CONFIG_MMC_CLKGATE=y, sometimes there is one more gating/un-gating
SD clock between (2) and (3). In this case, some UHS-1 SD cards will hold
DAT[3:0] 0000b at (11) and thus fails Signal Voltage Switch Procedure.

[solution]
By mmc_host_clk_hold() before CMD11, the additional gating/un-gating
SD clock between (2) and (3) can be prevented and thus no failure at (11).
It has been verified with many UHS-1 SD cards on mb86s7x platforms and
works correctly.

Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
---
 drivers/mmc/core/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7dc0c85..764af63 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1428,6 +1428,8 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
 		pr_warning("%s: cannot verify signal voltage switch\n",
 				mmc_hostname(host));
 
+	mmc_host_clk_hold(host);
+
 	cmd.opcode = SD_SWITCH_VOLTAGE;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
@@ -1438,8 +1440,6 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
 
 	if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
 		return -EIO;
-
-	mmc_host_clk_hold(host);
 	/*
 	 * The card should drive cmd and dat[0:3] low immediately
 	 * after the response of cmd11, but wait 1 ms to be sure
-- 
1.9.0

