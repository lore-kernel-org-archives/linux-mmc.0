Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B527C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 11:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231AA60F14
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 11:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbhKHLjg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 06:39:36 -0500
Received: from smtp2.axis.com ([195.60.68.18]:51353 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhKHLjg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Nov 2021 06:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1636371412;
  x=1667907412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7a/IPKjgRrvobEfnYBcAiGbny8D0ol+SDvj/Anu/JQs=;
  b=ARPlKTlAIWApRc5SF0XAJLfM4nWyeavD4KP8oYCqtOWdBTKTraLep7hs
   jtcHu9AlEdQJBUBO6AExFaFabijaep+FjGEoMi2PNn2/Ssm0GXWTtmw/V
   9iLkN4Gi9Lg6iRGWZIJv+5NPTUVmR0Y2Ju7OBUxqmmJQKPvV4qO8y+Wib
   Xj0ULkj1sdIE3lEWj/v3Ww53DDG0B0k2AgRL5kBm1y5140z30+gHapB4y
   zLZvw1JepEf0SvAdvF8jDh6xDOq9kjjDm5ZOWuOUYJA2J1JRsoO9O+jB1
   Khh4m4CDpHAq0J08lPF/Aot2n+HuebbfvBDtHP/Q8YH0qLcMdlxHvEGSr
   g==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Doug Anderson <dianders@google.com>, <kernel@axis.com>,
        <linux-mmc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v2] mmc: dw_mmc: Allow lower TMOUT value than maximum
Date:   Mon, 8 Nov 2021 12:36:37 +0100
Message-ID: <20211108113637.3699-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The TMOUT register is always set with a full value for every transfer,
which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds.
Since the software dto_timer acts as a backup in cases when this timeout
is not long enough, it is normally not a problem. But setting a full
value makes it impossible to test shorter timeouts, when for example
testing data read times on different SD cards.

Add a function to set any value smaller than the maximum of 0xFFFFFF.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---

v2:
 - Calculate new value before checking boundaries
 - Include CLKDIV register to get proper value

 drivers/mmc/host/dw_mmc.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6578cc64ae9e..6edd7a231448 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1283,6 +1283,36 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 	mci_writel(host, CTYPE, (slot->ctype << slot->id));
 }
 
+static void dw_mci_set_data_timeout(struct dw_mci *host,
+				    unsigned int timeout_ns)
+{
+	unsigned int clk_div, tmp, tmout;
+
+	clk_div = (mci_readl(host, CLKDIV) & 0xFF) * 2;
+	if (clk_div == 0)
+		clk_div = 1;
+
+	tmp = DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz,
+			       NSEC_PER_SEC * clk_div);
+
+	if (!tmp || tmp > 0xFFFFFF) {
+		/* Set maximum */
+		tmout = 0xFFFFFFFF;
+		goto tmout_done;
+	}
+
+	/* TMOUT[7:0] (RESPONSE_TIMEOUT) */
+	tmout = 0xFF; /* Set maximum */
+
+	/* TMOUT[31:8] (DATA_TIMEOUT) */
+	tmout |= (tmp & 0xFFFFFF) << 8;
+
+tmout_done:
+	mci_writel(host, TMOUT, tmout);
+	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%06x",
+		timeout_ns, tmout >> 8);
+}
+
 static void __dw_mci_start_request(struct dw_mci *host,
 				   struct dw_mci_slot *slot,
 				   struct mmc_command *cmd)
@@ -1303,7 +1333,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 
 	data = cmd->data;
 	if (data) {
-		mci_writel(host, TMOUT, 0xFFFFFFFF);
+		dw_mci_set_data_timeout(host, data->timeout_ns);
 		mci_writel(host, BYTCNT, data->blksz*data->blocks);
 		mci_writel(host, BLKSIZ, data->blksz);
 	}
-- 
2.20.1

