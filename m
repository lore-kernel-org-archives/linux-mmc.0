Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F2DC433E7
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1C920C56
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599075521;
	bh=uScesMbqyDE62hweEWPuyL7WWTMRh8MYCWsDxlC6EqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GPjTltBvCBpVOBp1b6g70N4hfLqcgtplkc01DQ+mTVQal+7vJT4A1d5jD+XPUtaUn
	 9tyzIfHldegElAy5Duo/UhGodBfs4Apxj4RwmjKWyk9JTsfoT5JaX+wfIufZMHSfEI
	 nSpqckuu8YGNJXF9rIckIe2+IN6zh0qEiKCOklec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgIBTig (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgIBTie (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Sep 2020 15:38:34 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9B42083B;
        Wed,  2 Sep 2020 19:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599075514;
        bh=uScesMbqyDE62hweEWPuyL7WWTMRh8MYCWsDxlC6EqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RWZFBv9MZSBEJpivw+ogGRJXdri2LjzrzENGHno3Cc4jWgRGxew0muj0MHLVHkhyH
         CSzuUd9/nDWhyW8Ro6kJsYEUcYIuQN1++f00Ha+B7Z4KAHDZmHyOXKOYsVjUuvz/VH
         1cCZ8Y++8Rx0BVeZqBmxRSy9B+KKFUyG/tNtGmgc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 10/11] mmc: sdhci-of-sparx5: Use proper printk format for dma_addr_t
Date:   Wed,  2 Sep 2020 21:36:57 +0200
Message-Id: <20200902193658.20539-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902193658.20539-1-krzk@kernel.org>
References: <20200902193658.20539-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

dma_addr_t size varies between architectures so use dedicated printk
format to fix compile testing warning (e.g. on 32-bit MIPS):

  drivers/mmc/host/sdhci-of-sparx5.c:63:11: warning:
    format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘dma_addr_t {aka unsigned int}’ [-Wformat=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/sdhci-of-sparx5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
index 14b5dad6575a..747f108a0ace 100644
--- a/drivers/mmc/host/sdhci-of-sparx5.c
+++ b/drivers/mmc/host/sdhci-of-sparx5.c
@@ -60,8 +60,8 @@ static void sdhci_sparx5_adma_write_desc(struct sdhci_host *host, void **desc,
 		return;
 	}
 
-	pr_debug("%s: write_desc: splitting dma len %d, offset 0x%0llx\n",
-		 mmc_hostname(host->mmc), len, addr);
+	pr_debug("%s: write_desc: splitting dma len %d, offset %pad\n",
+		 mmc_hostname(host->mmc), len, &addr);
 
 	offset = addr & (SZ_128M - 1);
 	tmplen = SZ_128M - offset;
-- 
2.17.1

