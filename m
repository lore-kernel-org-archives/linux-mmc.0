Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ED0C3526B
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 03:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B4123AC6
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 03:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbgLRDzS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Dec 2020 22:55:18 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43041 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732665AbgLRDzS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2020 22:55:18 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3B2D35C00F5;
        Thu, 17 Dec 2020 22:54:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Dec 2020 22:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Q1VncEwVP5Sn+
        LVJVlCf4rK+C+OhdnQWKLcdmzYhx+k=; b=k1SXvNzpHK19iAEYL4EhT92jU0tE+
        j+tTsE1qJVJrktXaAG3YxAUa5C1ZHK6fGMbPegvhZMvF9aetvq9XOctZcLnYvWG4
        Av45N5UKvUJRz0dyAqiFrMAuDVxyS4KL0hPG28Al8SIaDNgFUNjY/N4YA4A/jxJ8
        vyPIOAf7VJT71ySUSF5vi4Z20dJi5XZfwYacSOO4Vy3f5zj57Jbam2ndOTSkEFTx
        o6aeZITT6u7VALxh87FW91iYk2hYH0wHAfyjxA9iZxblEEl656yMTPRtUZ4CtGFp
        4/5T9afX7k5OEiHv88pfS8UkStVxD6qdQe1/QSmKDxg5pPvgI+qHl+cYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Q1VncEwVP5Sn+LVJVlCf4rK+C+OhdnQWKLcdmzYhx+k=; b=N2qIFdmQ
        BXhUnaLOsrHV0QaUMw9ZEvQhJ+pLZrViOR5l2si3bQrFmTD8bPGM73pOLUP2Z3zp
        SBTPmfIMZURhClrVlxzAxSOmS8WfM37kHb9R8sdXuIjurT85vdtdZc6hnBRekXTG
        l77OyYYccLXf9O55uV9qOOQE35OrLByxIOuChobAE4ASTNGuu66Gx0ZOptcHu1ou
        DaSEQgTb5R6BpVuYi0k+lXpu7ozXqxT7oHsW2thDEPdspQ03XYB7XY6sR7ah4V/S
        sf8SMhrb8/TtP0ak0aZ9tUZddJi7vVAMczXtJMnzClgHQilYT7cnoVBDTeOU/XcU
        1m/jiLIAFcx63w==
X-ME-Sender: <xms:5CfcX7BPnoJMOvvGdmBAQJxE0PVzRIwiozM_yZRgn4A5EsjRM24Oug>
    <xme:5CfcX_dVeUWnSxznQrkloDLxYyGFgYv7yz-Wr2NIKFDeJBvIYhiFxnxmbMvC_Cb5c
    QTR6pP2QPCt60byRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudelhedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppeduvddtrddvtddrjeejrddvuddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnug
    hrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:5CfcX47FCgGRrNRfGPs_BPV06lYnFHroYpFvDM2lFcqu2uxC74_20g>
    <xmx:5CfcXyUMv6oDzDuf_Gz0t3bmqMWQG2x63ZsYCvgsRTlUXaOv1BtitQ>
    <xmx:5CfcX37ZSoQg2Vc0hVa-K991H5lxMt6XJ_3gRFXHOxHkQhMcArlESg>
    <xmx:5CfcXyoVw7axqGBK3BgP56EgjMObtjSpcWZ_Y7XY6inz3kxQJd3B6Q>
Received: from localhost.localdomain (unknown [120.20.77.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 55003108005B;
        Thu, 17 Dec 2020 22:54:07 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v6 3/6] mmc: sdhci-of-aspeed: Add AST2600 bus clock support
Date:   Fri, 18 Dec 2020 14:23:35 +1030
Message-Id: <20201218035338.1130849-4-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201218035338.1130849-1-andrew@aj.id.au>
References: <20201218035338.1130849-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The AST2600 can achieve HS200 speeds with a change to the bus clock
divisor behaviour. The divisor can also be more accurate with respect
to the requested clock rate, but keep the one-hot behaviour for
backwards compatibility with the AST2400 and AST2500.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 37 ++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index b1a14e7dda82..4b30f6a1178e 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -59,6 +59,7 @@ struct aspeed_sdhci_phase_desc {
 };
 
 struct aspeed_sdhci_pdata {
+	unsigned int clk_div_start;
 	const struct aspeed_sdhci_phase_desc *phase_desc;
 	size_t nr_phase_descs;
 };
@@ -200,10 +201,13 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host;
 	unsigned long parent, bus;
+	struct aspeed_sdhci *sdhci;
 	int div;
 	u16 clk;
 
 	pltfm_host = sdhci_priv(host);
+	sdhci = sdhci_pltfm_priv(pltfm_host);
+
 	parent = clk_get_rate(pltfm_host->clk);
 
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
@@ -214,7 +218,23 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (WARN_ON(clock > host->max_clk))
 		clock = host->max_clk;
 
-	for (div = 2; div < 256; div *= 2) {
+	/*
+	 * Regarding the AST2600:
+	 *
+	 * If (EMMC12C[7:6], EMMC12C[15:8] == 0) then
+	 *   period of SDCLK = period of SDMCLK.
+	 *
+	 * If (EMMC12C[7:6], EMMC12C[15:8] != 0) then
+	 *   period of SDCLK = period of SDMCLK * 2 * (EMMC12C[7:6], EMMC[15:8])
+	 *
+	 * If you keep EMMC12C[7:6] = 0 and EMMC12C[15:8] as one-hot,
+	 * 0x1/0x2/0x4/etc, you will find it is compatible to AST2400 or AST2500
+	 *
+	 * Keep the one-hot behaviour for backwards compatibility except for
+	 * supporting the value 0 in (EMMC12C[7:6], EMMC12C[15:8]), and capture
+	 * the 0-value capability in clk_div_start.
+	 */
+	for (div = sdhci->pdata->clk_div_start; div < 256; div *= 2) {
 		bus = parent / div;
 		if (bus <= clock)
 			break;
@@ -316,6 +336,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 	int ret;
 
 	aspeed_pdata = of_device_get_match_data(&pdev->dev);
+	if (!aspeed_pdata) {
+		dev_err(&pdev->dev, "Missing platform configuration data\n");
+		return -EINVAL;
+	}
 
 	host = sdhci_pltfm_init(pdev, &aspeed_sdhci_pdata, sizeof(*dev));
 	if (IS_ERR(host))
@@ -334,7 +358,7 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 	else if (slot >= 2)
 		return -EINVAL;
 
-	if (dev->pdata && slot < dev->pdata->nr_phase_descs) {
+	if (slot < dev->pdata->nr_phase_descs) {
 		dev->phase_desc = &dev->pdata->phase_desc[slot];
 	} else {
 		dev_info(&pdev->dev,
@@ -396,6 +420,10 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct aspeed_sdhci_pdata ast2400_sdhci_pdata = {
+	.clk_div_start = 2,
+};
+
 static const struct aspeed_sdhci_phase_desc ast2600_sdhci_phase[] = {
 	/* SDHCI/Slot 0 */
 	[0] = {
@@ -426,13 +454,14 @@ static const struct aspeed_sdhci_phase_desc ast2600_sdhci_phase[] = {
 };
 
 static const struct aspeed_sdhci_pdata ast2600_sdhci_pdata = {
+	.clk_div_start = 1,
 	.phase_desc = ast2600_sdhci_phase,
 	.nr_phase_descs = ARRAY_SIZE(ast2600_sdhci_phase),
 };
 
 static const struct of_device_id aspeed_sdhci_of_match[] = {
-	{ .compatible = "aspeed,ast2400-sdhci", },
-	{ .compatible = "aspeed,ast2500-sdhci", },
+	{ .compatible = "aspeed,ast2400-sdhci", .data = &ast2400_sdhci_pdata, },
+	{ .compatible = "aspeed,ast2500-sdhci", .data = &ast2400_sdhci_pdata, },
 	{ .compatible = "aspeed,ast2600-sdhci", .data = &ast2600_sdhci_pdata, },
 	{ }
 };
-- 
2.27.0

