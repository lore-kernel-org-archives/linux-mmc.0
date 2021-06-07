Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C90C4743E
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Jun 2021 01:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E0B61090
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Jun 2021 01:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhFGBcf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 6 Jun 2021 21:32:35 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58807 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230078AbhFGBcf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Jun 2021 21:32:35 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 900305C00E6;
        Sun,  6 Jun 2021 21:30:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 06 Jun 2021 21:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=GRzcE4hI5AG2i78thbcMf/cB97
        dZ01L3NdzHyw2+Nv0=; b=e57ywDicKtu87q+d8RSK+Uh9L+fpAXqXjvcuSEdrNA
        4iHp3kY2ObBLPAtZqbbaQoNrY3Fu0qtd3G5q2F6DRnpOwCTgsK1qNs4Mvo0tiARr
        Bnyzxq8IzTvKZC5PlVnAWHSNAB2/yVEFYp3Wr+eA5dYW1X+uSqllNBfCrOgL+sZO
        m99glIg3eGoyH1S8TIDMfe/EFMEKv8gkrY7mgGibogV+eGPZ0SA/ZT3GBWJvonM2
        MoW3Odv/3r5OInfFmeQzpPXUC1yR0STMXiHw4RNszb++wEDNNbpZbAIMIe0xrxSp
        sEtXFbNteFGjeuoJ0xdpsT9LrJFmzzaWDYPJdrts6PIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GRzcE4hI5AG2i78th
        bcMf/cB97dZ01L3NdzHyw2+Nv0=; b=jrfBPDSHqWTSn1tTrDWLEYuUwOHA3dRg2
        r3x5OHNhDPozYBJj8tiGWPYrcTQtUvroc2ghN9bfxBIAjWsFwrCo92r1AFUYnFCi
        BIBo5hgOwRTIaF283gcjpHZdoIBIwHr2nwcvN9vxa3NBVIHuLR6K70Fct1CB1XkP
        tqh9oG79mhDBYV9bG52Wg+H5XAYZ2+R5KExo/m7qV+7oEuXW6Yf6Q60VMtBGjDYY
        yTY9andCckGWOBT1ZI9lBNuAKyYLqovPDnuOiWtyW+2XFooce05pfBRt+cLqvkIK
        i4lhY+l3xRT9dbFjeSNZs0QKRbeTNOXlvU1qzOFll6y5rAG4szjyQ==
X-ME-Sender: <xms:wXa9YEWDXwXFZ6g8NYlLZY_702XFeDVqDcXqN61vA4OdvtGDD5vqAw>
    <xme:wXa9YIn-LDtYf-omv_F4Kquy7u8LEEQ1Y1iMyHkNfLIg5mreol-J5IfL4BLGsK8nD
    BigXcdMJ5GE2iMrHw>
X-ME-Received: <xmr:wXa9YIbOgwrK3i4IsRFBsD2AHpHvLd1Vgl_naaekebiFIZpr6wyN1sFZctMZicU73zF8-YmsprQUX2MioLZOspj1aFld352E2Sc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtiedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuggftrfgrthhtvghrnhepkefhieffjeevfeevhedtieeihfefvdejle
    dvvddthefftedujeethfeuueelfedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:wXa9YDW_FsLN34ITeOFGjIeUOTXP3_6AE6GpQAYsYLqgC5f8my6Jgg>
    <xmx:wXa9YOnLmIp8wO6HSs98XjMzbLoyEgoTDkZSnkh4R-hUXYKZ8fw1cQ>
    <xmx:wXa9YIfE9NN3M8bUSqsZfw_sf9fUhZiipvyQY7pJYvRzl06OLFvb3w>
    <xmx:xHa9YMZD-CLNWEsaYLvqgHtO2oNiOxVYIBaF_Dsn2Kv0788WEYsX0Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jun 2021 21:30:38 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        steven_lee@aspeedtech.com
Subject: [PATCH] mmc: sdhci-of-aspeed: Turn down a phase correction warning
Date:   Mon,  7 Jun 2021 11:00:20 +0930
Message-Id: <20210607013020.85885-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The card timing and the bus frequency are not changed atomically with
respect to calls to the set_clock() callback in the driver. The result
is the driver sees a transient state where there's a mismatch between
the two and thus the inputs to the phase correction calculation
formula are garbage.

Switch from dev_warn() to dev_dbg() to avoid noise in the normal case,
though the change does make bad configurations less likely to be
noticed.

Reported-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index d001c51074a0..e4665a438ec5 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -150,7 +150,7 @@ static int aspeed_sdhci_phase_to_tap(struct device *dev, unsigned long rate_hz,
 
 	tap = div_u64(phase_period_ps, prop_delay_ps);
 	if (tap > ASPEED_SDHCI_NR_TAPS) {
-		dev_warn(dev,
+		dev_dbg(dev,
 			 "Requested out of range phase tap %d for %d degrees of phase compensation at %luHz, clamping to tap %d\n",
 			 tap, phase_deg, rate_hz, ASPEED_SDHCI_NR_TAPS);
 		tap = ASPEED_SDHCI_NR_TAPS;
-- 
2.30.2

