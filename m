Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D970C4167E
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Nov 2021 18:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhKXSt0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbhKXStX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Nov 2021 13:49:23 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE1EC061574;
        Wed, 24 Nov 2021 10:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Reply-To:
        Content-ID:Content-Description;
        bh=eIJrpJif5BwSFiNbPidFLu9RNjRyc9mWZzLOM9omLQI=; b=wTfXuEiEd/ayinVA/3dJyqn1ZX
        Lnzq61zhPquD7Uu3Rmi8oGg6Ptk6PSPY2f4DgfFl5JjVVQR+katUUvvg1QGA3rFlpF1YN8r16xQWu
        6j7J1Bfucx2feleUPWeM0h6WckdELL0PSiGKCCagklUWZ5FWkeko1hTsIWW0ZE4JfxnyC7orWB6+I
        E+lGiZCYOPUcgmVr2dKNQZZqQoISSDmCqTxK7y1UDXxLJbYh/+GidbbolbaYIwvJW9OH1kGTQA8n0
        QByjh/MBkrK7XTf8S9TKAGU8PexLbXdUzBRW9awDAhVSWYKvE4Yz43i6J2OfRydVMFx1QdxFRUvMM
        hiCU+rXg==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mpxHY-00007s-48; Wed, 24 Nov 2021 18:46:12 +0000
From:   John Keeping <john@metanate.com>
To:     linux-mmc@vger.kernel.org
Cc:     John Keeping <john@metanate.com>, Heiko Stuebner <heiko@sntech.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/4] mmc: dw_mmc: exynos: use common_caps
Date:   Wed, 24 Nov 2021 18:46:02 +0000
Message-Id: <20211124184603.3897245-5-john@metanate.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211124184603.3897245-1-john@metanate.com>
References: <20211124184603.3897245-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Move the common MMC_CAP_CMD23 capability to common_caps so that only the
special case of MMC_CAP_1_8V_DDR and MMC_CAP_8_BIT_DATA are set via
caps/num_caps.  Both of those can, and should, be set via device tree
properties instead, so we can now say that exynos_dwmmc_caps is only
used for backwards compatibility.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/mmc/host/dw_mmc-exynos.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index c2dd29ef45c6..f76eeeb0cc53 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -526,15 +526,16 @@ static int dw_mci_exynos_prepare_hs400_tuning(struct dw_mci *host,
 
 /* Common capabilities of Exynos4/Exynos5 SoC */
 static unsigned long exynos_dwmmc_caps[4] = {
-	MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
-	MMC_CAP_CMD23,
-	MMC_CAP_CMD23,
-	MMC_CAP_CMD23,
+	MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA,
+	0,
+	0,
+	0,
 };
 
 static const struct dw_mci_drv_data exynos_drv_data = {
 	.caps			= exynos_dwmmc_caps,
 	.num_caps		= ARRAY_SIZE(exynos_dwmmc_caps),
+	.common_caps		= MMC_CAP_CMD23,
 	.init			= dw_mci_exynos_priv_init,
 	.set_ios		= dw_mci_exynos_set_ios,
 	.parse_dt		= dw_mci_exynos_parse_dt,
-- 
2.34.0

