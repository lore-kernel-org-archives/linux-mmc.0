Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FC8C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Nov 2021 11:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1ED461260
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Nov 2021 11:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhKJLIi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Nov 2021 06:08:38 -0500
Received: from smtp2.axis.com ([195.60.68.18]:33771 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhKJLIh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 10 Nov 2021 06:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1636542350;
  x=1668078350;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=caPzndcxFv8otJ0LhDsp2VRIrlEtU5v5zqXUzWEApsU=;
  b=RrLDDoTPJtSj8EfYM1lcVoMqoXr7lGvejPwak1NwnBQi9AkdX40U0Dpc
   GgPuN67NAU4y9jsHkeb5OmEsa1WXFY4L5kWOOwpYLFvj7cud5LdK9VMl7
   IgGno/eeILLzEuKTn7LvK7KpYtVhBCNh+ZlaSsUqNY3GsF+1cYIUcdBTk
   j0C35kIA5I8CIpXlVVLOWr7MTzo476AYsf2R0iKuhkN+3AdSnAfb7cPeY
   Nb11Md3PmFbJmYPhuslp0WzLz5vJ6mCFHlGeO9lZR3ZNNG6s2+XNMUAzK
   FyoOyJZzdAd31Xzq5I0gKc6AngnGTmAmtxdNH4/FABijIjPta2cKeB5xN
   A==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Doug Anderson <dianders@google.com>, <kernel@axis.com>,
        <linux-mmc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v3] mmc: dw_mmc: Allow lower TMOUT value than maximum
Date:   Wed, 10 Nov 2021 12:05:00 +0100
Message-ID: <20211110110500.4105-1-marten.lindahl@axis.com>
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

v3:
 - Use 'if-else' instead of 'goto'
 - Don't touch response field when maximize data field

 drivers/mmc/host/dw_mmc.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6578cc64ae9e..637ae2aea9fa 100644
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
+	tmp = DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz,
+			       NSEC_PER_SEC * clk_div);
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
+	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%06x",
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

