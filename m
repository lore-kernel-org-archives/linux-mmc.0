Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D6AC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 15:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7386B61076
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 15:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhKCP0p (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Nov 2021 11:26:45 -0400
Received: from smtp2.axis.com ([195.60.68.18]:12122 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231651AbhKCP0p (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 3 Nov 2021 11:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1635953049;
  x=1667489049;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QQfsKOBZxkgyPGWXlx3A1QzypGo0rBdL6wi++CVr4ko=;
  b=WvcrTYkzMLRXsY+ZMrvD8TFjxfjnRHsMhpWUh6Y24YWWTO5QG3Bm5vs1
   0x39HErclwPtqTI5g5raORe6dipD6ZWcf+SbbDmxr4bG0NYNHehWBPUya
   7vsmwv1HyIm39ZhYGISUqALfrfHVlOJeG+ZdyE7CbgHo+s1NX1hBqTipp
   8tp2nq95OOqxLlRdldk4IMVUS3qFZytzTxWsqtrT//KcZrAWWxH/qxVzA
   wB4KBYKJbRp8JllheWkVqFaekeuEhCnV95wzCKze8c0EWCAUmxw8L9AHt
   wfYAYjnDYVSayEMeESP4wNl8Ta2KH1IZ9s9BhSjXjdzhc3xtVdt7Ww1Zh
   A==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Doug Anderson <dianders@google.com>, <kernel@axis.com>,
        <linux-mmc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH] mmc: dw_mmc: Allow lower TMOUT value than maximum
Date:   Wed, 3 Nov 2021 16:23:59 +0100
Message-ID: <20211103152359.24699-1-marten.lindahl@axis.com>
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
 drivers/mmc/host/dw_mmc.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6578cc64ae9e..0d23b8ed9403 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -54,6 +54,7 @@
 
 #define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
 #define DW_MCI_FREQ_MIN	100000		/* unit: HZ */
+#define DW_MCI_DATA_TMOUT_NS_MAX	83886075
 
 #define IDMAC_INT_CLR		(SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI | \
 				 SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
@@ -1283,6 +1284,32 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 	mci_writel(host, CTYPE, (slot->ctype << slot->id));
 }
 
+static void dw_mci_set_data_timeout(struct dw_mci *host, u32 timeout_ns)
+{
+	u32 timeout, freq_mhz, tmp, tmout;
+
+	if (!timeout_ns || timeout_ns > DW_MCI_DATA_TMOUT_NS_MAX) {
+		/* Set maximum */
+		tmout = 0xFFFFFFFF;
+		goto tmout_done;
+	}
+
+	timeout = timeout_ns;
+	freq_mhz = DIV_ROUND_UP(host->bus_hz, NSEC_PER_MSEC);
+
+	/* TMOUT[7:0] (RESPONSE_TIMEOUT) */
+	tmout = 0xFF; /* Set maximum */
+
+	/* TMOUT[31:8] (DATA_TIMEOUT) */
+	tmp = DIV_ROUND_UP_ULL((u64)timeout * freq_mhz, MSEC_PER_SEC);
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

