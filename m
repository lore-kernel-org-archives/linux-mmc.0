Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE39C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Nov 2021 11:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99AA660F9B
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Nov 2021 11:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhKSLPS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Nov 2021 06:15:18 -0500
Received: from smtp2.axis.com ([195.60.68.18]:54985 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232004AbhKSLPS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 19 Nov 2021 06:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1637320335;
  x=1668856335;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8WeFC/KT9JBpt3ETrMVAMNY4OtPvnB0kYgQOsjKEQAQ=;
  b=WqJ8RqWfu5ZWH8X5UDYOAKl9ChOBNxF0F+bFXHhDetDQtq4LwaYDU/4c
   qoBFnUoQUOgWdS2/59O+P2BjrsdwJ7u9Vb1RFoOlPoV5//BZIJtKQAgdm
   TS+ItMn+QZYtNWFtS1cdWU0eQF/NQIKTlK6cgGqM7jQb8bnM0HZDGXl71
   wxwHSSeOlQ/sNUJq3ofsj8HWKZFJ3pqI1cPd+KSavl1wv2csRgDhrxfYB
   Zpad+Ip9AGusS+VMfIgVdx1NkNq6K3f5Tcjk7ZN9fzUzGY5wLlN+asrQK
   YR4FAU7ohYUGg4Epk15X/FAkD2ufMxG84XR8X/sdO6zwB9wj106C1nw+6
   w==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Doug Anderson <dianders@google.com>, <kernel@axis.com>,
        <linux-mmc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v5] mmc: dw_mmc: Allow lower TMOUT value than maximum
Date:   Fri, 19 Nov 2021 12:12:01 +0100
Message-ID: <20211119111201.1823-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The TMOUT register is always set with a full value for every transfer,
which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds.
This is normally good enough to complete the request, but setting a full
value makes it impossible to test shorter timeouts, when for example
testing data read times on different SD cards.

Add a function to set any value smaller than the maximum of 0xFFFFFF.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---

v2:
 - Calculate new value before checking boundaries
 - Include CLKDIV register to get proper value

v3:
 - Use 'if-else' instead of 'goto'
 - Don't touch response field when maximize data field

v4:
 - Prevent 32bit divider overflow by splitting the operation
 - Changed %06x to %#08x as suggested by Doug
 - Rephrased commit msg as suggested by Doug

v5:
 - Use u32 type for CPU reg access
 - Make tmp 64bit to handle INT_MAX parameters

 drivers/mmc/host/dw_mmc.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d977f34f6b55..210252d33b95 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1283,6 +1283,33 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 	mci_writel(host, CTYPE, (slot->ctype << slot->id));
 }
 
+static void dw_mci_set_data_timeout(struct dw_mci *host,
+				    unsigned int timeout_ns)
+{
+	u32 clk_div, tmout;
+	unsigned long tmp;
+
+	clk_div = (mci_readl(host, CLKDIV) & 0xFF) * 2;
+	if (clk_div == 0)
+		clk_div = 1;
+
+	tmp = DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz, NSEC_PER_SEC);
+	tmp = DIV_ROUND_UP_ULL(tmp, clk_div);
+
+	/* TMOUT[7:0] (RESPONSE_TIMEOUT) */
+	tmout = 0xFF; /* Set maximum */
+
+	/* TMOUT[31:8] (DATA_TIMEOUT) */
+	if (!tmp || tmp > 0xFFFFFF)
+		tmout |= (0xFFFFFF << 8);
+	else
+		tmout |= (tmp & 0xFFFFFF) << 8;
+
+	mci_writel(host, TMOUT, tmout);
+	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%#08x",
+		timeout_ns, tmout >> 8);
+}
+
 static void __dw_mci_start_request(struct dw_mci *host,
 				   struct dw_mci_slot *slot,
 				   struct mmc_command *cmd)
@@ -1303,7 +1330,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 
 	data = cmd->data;
 	if (data) {
-		mci_writel(host, TMOUT, 0xFFFFFFFF);
+		dw_mci_set_data_timeout(host, data->timeout_ns);
 		mci_writel(host, BYTCNT, data->blksz*data->blocks);
 		mci_writel(host, BLKSIZ, data->blksz);
 	}
-- 
2.20.1

