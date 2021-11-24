Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406B2C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Nov 2021 18:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhKXStZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhKXStX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Nov 2021 13:49:23 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DE0C061748;
        Wed, 24 Nov 2021 10:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Reply-To:
        Content-ID:Content-Description;
        bh=R6d+fdmVlW1mqNTDMqcWULS5Btx0udfWYQ0h5v3+RgE=; b=Oduy2hVDi7trTPFC5lx+7E2bUo
        c5pCeVXpyjSz5qRi1X3VTyez0AtpP6BcXgqc+MULCLS3GuLazo/J3EFW62sk+RQbJZXIHpkrCYPqq
        zSvZWPIuqnrjC2jGT9IPQiY+PuEjvkxKNrE1AzqxY0r2aHY3/x5SRj0mVwcCDk5d9ebKOA35PyKr0
        61mGZvVRFijIINPCSw2Xa8ISX7yE+30kL3lnqk0QL1XMwzWD4tg92GiDJToOWnzQC/KBoouT7klCA
        2V2CH1LXaglx6T8eCdI4Ilqcr+P+kqwA8LTpiezfUGIzvAxJy+YSAvCBBugPcmFQriqwQtdG5ukrs
        nP37Ax8Q==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mpxHX-00007s-5y; Wed, 24 Nov 2021 18:46:11 +0000
From:   John Keeping <john@metanate.com>
To:     linux-mmc@vger.kernel.org
Cc:     John Keeping <john@metanate.com>, Heiko Stuebner <heiko@sntech.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/4] mmc: dw_mmc: rockchip: use common_caps
Date:   Wed, 24 Nov 2021 18:46:01 +0000
Message-Id: <20211124184603.3897245-4-john@metanate.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211124184603.3897245-1-john@metanate.com>
References: <20211124184603.3897245-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The capabilities for all instances are the same, so use common_caps
instead of caps/num_caps to remove the dependency on the mshcN device
tree alias.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index d36991acd6df..95d0ec0f5f3a 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -300,21 +300,12 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 	return 0;
 }
 
-/* Common capabilities of RK3288 SoC */
-static unsigned long dw_mci_rk3288_dwmmc_caps[4] = {
-	MMC_CAP_CMD23,
-	MMC_CAP_CMD23,
-	MMC_CAP_CMD23,
-	MMC_CAP_CMD23,
-};
-
 static const struct dw_mci_drv_data rk2928_drv_data = {
 	.init			= dw_mci_rockchip_init,
 };
 
 static const struct dw_mci_drv_data rk3288_drv_data = {
-	.caps			= dw_mci_rk3288_dwmmc_caps,
-	.num_caps		= ARRAY_SIZE(dw_mci_rk3288_dwmmc_caps),
+	.common_caps		= MMC_CAP_CMD23,
 	.set_ios		= dw_mci_rk3288_set_ios,
 	.execute_tuning		= dw_mci_rk3288_execute_tuning,
 	.parse_dt		= dw_mci_rk3288_parse_dt,
-- 
2.34.0

