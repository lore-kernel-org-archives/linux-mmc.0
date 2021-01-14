Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD43DC433E9
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 03:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A316023715
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 03:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbhANDQD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 22:16:03 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53749 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727768AbhANDQC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 22:16:02 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D82975C01E9;
        Wed, 13 Jan 2021 22:14:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Jan 2021 22:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Q1VncEwVP5Sn+
        LVJVlCf4rK+C+OhdnQWKLcdmzYhx+k=; b=lh1XOm/1p4RnqoRDBp2T/H/bTeYbs
        AkC/JW7pDsbE8HGoRLl/YF7+xI47F8O4Y5OCfoJnSN6S0z2n6AepNCv9uf1ZXSte
        hRjrk8ARiVAc00A01kizYibsV+fvvCU1e7WMnLCk4G8ZfjYUarjET9JqbcMyAboP
        3Jn1lj8YHi4qXaT/M/a7vvLJAUrGSMwMGR6u5s5Xk+eZ3VL/8IzyD3QqSqsY6hmq
        iDWm3A1mca6Alms0ih2GLrulN9Is/AdsVpDrRQQ65KLc7yis57DoffhVDYTkqL53
        yFgs4/FSC3kQgEmLAqjMSDKV8R269e59AYXxwlz7JluLMVa0j090J1ZRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Q1VncEwVP5Sn+LVJVlCf4rK+C+OhdnQWKLcdmzYhx+k=; b=BOZ/0EMR
        fJLtfTSoX/CP+DMjq3S1tygYCehtz0m4VC3OYp25PrOxkWEee6MYrfISMc6WwDtN
        coD7guonkCn8Zu4cLs3mndgsJiHpvLpAUsyDQ5KzICwjTddGMhEj26nLfSUx7CCI
        LYKDPAspY0G4sJUhXumL8aOZbXPpNefzkCkrbQIsABjv+cmMJ6kTlE2FCgKGhjAh
        K9I3C8a91LffOdlqDpQcyEAo+59g3N059Kr5Y/baxpT0GBXdfOLZ5qTeRrRhKUJN
        Qtf/fwUxm6+AhlHJtyshusoeHQfa7cs9LEES49Jb6L2tw0+P5XFJYpjpzGFYvfoJ
        G8U9NbcEt8UTMw==
X-ME-Sender: <xms:L7f_X-h_-L_eEbIORq06M1-HHWV3nQ19u_MTGvGMM2ym2NLiA4N8uQ>
    <xme:L7f_X_ABj2Hy0A9gmnGn2OV-P7YoFnXasOKKViyc9WBIrQkdFMvllu8R-lrG7yL-e
    JADo17GHbrXd2vKUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdeggdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucggtffrrghtthgvrhhnpeejgfdvveehteekveeggeellefgleette
    ejffelffdvudduveeiffegteelvefhteenucfkphepuddukedrvddutddrudejfedrgeek
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghnug
    hrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:L7f_X2HLQeYkRKlt4jCuh9_vEzx8_ZszoFhGCnzDfS5TRhqxyuZHHw>
    <xmx:L7f_X3QqDAf4J8pLFzdbJVaSweGWawGonRIscYaRQGCs16ikr6Kv_w>
    <xmx:L7f_X7wPhuX7VBI4_NMe0sapS8N9WSUDCZ-c4JLGc_k78SnCC51lCA>
    <xmx:L7f_XyzofLYur-O4Odp0aX8VB5jLGf3Em1DJoHvP0wiySQiFzdXe2Q>
Received: from localhost.localdomain (ppp118-210-173-48.adl-adc-lon-bras34.tpg.internode.on.net [118.210.173.48])
        by mail.messagingengine.com (Postfix) with ESMTPA id ABBE3240057;
        Wed, 13 Jan 2021 22:14:52 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v7 3/6] mmc: sdhci-of-aspeed: Add AST2600 bus clock support
Date:   Thu, 14 Jan 2021 13:44:30 +1030
Message-Id: <20210114031433.2388532-4-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210114031433.2388532-1-andrew@aj.id.au>
References: <20210114031433.2388532-1-andrew@aj.id.au>
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

