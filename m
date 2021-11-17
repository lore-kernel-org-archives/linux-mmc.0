Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CEBC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 16:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 473A9608FB
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 16:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhKQQMo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Nov 2021 11:12:44 -0500
Received: from smtp2.axis.com ([195.60.68.18]:54557 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229841AbhKQQMo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 Nov 2021 11:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1637165386;
  x=1668701386;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9WUvjXtmAESJtDfugOoRyAEXuAxwve3P8qTQgHm5WA8=;
  b=cFkZa1j5g7tz8Yk38Agi7pGFB6TIemf8yTxroauXWWB2Toc+05lVEaf6
   it9ycMKIoWEXLflH/DLeRFeJQSxwHh9RuHRprBXzAWrQ65wijUgAngkhk
   8eXzGvHllDiEKpFM9eLnYGiA/lbXQDnLDHn6W6PCQ1FKY5YoFmojP6cip
   nGukqjCz41kndma0LhWsMXP82F5aMqYIMEypwUtkrn8B9fOHtR/mKo9J7
   TEd16/KdD57NWN4feC9lWvRlsPPIDeNePPiSPe7nM3krV/3zsxc5oJiCa
   H502DLCAavI+2dF5hT+CG5eCMqx40x8i0I/CPcn8KkB37Wdo4ywPHUCD1
   A==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Doug Anderson <dianders@google.com>, <kernel@axis.com>,
        <linux-mmc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v4] mmc: dw_mmc: Allow lower TMOUT value than maximum
Date:   Wed, 17 Nov 2021 17:08:59 +0100
Message-ID: <20211117160859.8732-1-marten.lindahl@axis.com>
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

 drivers/mmc/host/dw_mmc.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d977f34f6b55..8e9d33e1b96c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1283,6 +1283,32 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
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
+	tmp = DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz, NSEC_PER_SEC);
+	tmp = DIV_ROUND_UP(tmp, clk_div);
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
@@ -1303,7 +1329,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 
 	data = cmd->data;
 	if (data) {
-		mci_writel(host, TMOUT, 0xFFFFFFFF);
+		dw_mci_set_data_timeout(host, data->timeout_ns);
 		mci_writel(host, BYTCNT, data->blksz*data->blocks);
 		mci_writel(host, BLKSIZ, data->blksz);
 	}
-- 
2.20.1

