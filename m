Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99622C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Oct 2022 23:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiJQX4W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Oct 2022 19:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiJQX4L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2022 19:56:11 -0400
Received: from smtpcmd0641.aruba.it (smtpcmd0641.aruba.it [62.149.156.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 285B27E02B
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 16:56:06 -0700 (PDT)
Received: from localhost.localdomain ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id kZxkoIDsHJpY4kZxloMdtH; Tue, 18 Oct 2022 01:56:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666050965; bh=ASdoZ49/eBN4z0vuWYdhxmygfqGvGO4gQmCrBmTGXXw=;
        h=From:To:Subject:Date:MIME-Version;
        b=bLivJUDKVqRo5A0YFaILlBLK3hI4GMlzR9+5MOK7UNcEjIiu5wNQz2dPyK+DnIBZO
         ugBrk8VvjfGhnD5qGuwu0PIorWUoLcuAeAcGjwFJDxx3geylI0NmORveU3BaqFLvyi
         h7zG5EA+VSe0W/QNOWavqo+kpzblkBsgzgZXaK+mLsfKd+ynXk5MD30fiiOXh2yyhG
         9GPHMx+ldVbeiFwNknTcMurEgUxMkydYgdTTwcycT92Qt8E2pIseOur+g4UDZZAGU/
         DDWOG3GnJhcuZADof6jW0z5ydBGfCipJ9JH+6PJKJ6QeCSOQp0YRgvGRTCmGvEjUOU
         luarMiz1Y0rJQ==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 3/5] mmc: sdhci-esdhc-imx: improve imxrt1050 data
Date:   Tue, 18 Oct 2022 01:56:00 +0200
Message-Id: <20221017235602.86250-3-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017235602.86250-1-giulio.benetti@benettiengineering.com>
References: <20221017235602.86250-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPrn7ntQdoekybvwfhFyO67CFnqXTpbenwSu5crc4XKZ5ExrFtLgKub6vuPX7iwmOxEApIB8wqcmul4VKipnrJ27OwlZeUrE7KmNoEviAUNFWy5I+1jK
 Er10ZCTFieqmKEHNcDB6Ng7qMSpyAFxg7ipKt/VcvJolwBx6RX8S+M39hOOc/VOvYWnecqGjNzK/kVcPY7JZifJTtYIWPnYAARwEY58+xTp/XQvKvyTSFB1Z
 C6UfaD7j4D19FwrNcGCHX8XhVIyVugL4O+RAAdaMEbh0+fJZoac2gSx1NlaWbiZ0GahmGCYIP4Ef8QqEsEFQjxYu/YKQCY+GHHY5/pq4+U1hGkFOaVRTtlTO
 76N/gnGQVpL9VPF1n4+10sQCFizSAjUPk//MMKeog7rVul0qYBwEpbOcjfEdXAqD7GKRmoQlasBn9eNPFXU4SDIgx2ED23AbFRi7yN7afF1dJDEWDsehoKq6
 5hm0KOOkD4snEZOezBo0yu/wvojYXOX7oST69pEwuYUGzCrQgBGb2mMAqzvcrQzCVF/Va8oAv3VfNQWwQvrhCOBmx1SGBgA6grB4179aeZWCL8gwLON7c5MZ
 TY0=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

i.MXRT1050 usdhc is not affected by ESDHC_FLAG_ERR004536 so let's remove
it. It supports ESDHC_FLAG_STD_TUNING and ESDHC_FLAG_HAVE_CAP1 so let's add
them.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 55981b0f0b10..4bc0a2914a95 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -306,7 +306,8 @@ static struct esdhc_soc_data usdhc_imx7ulp_data = {
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
 };
 static struct esdhc_soc_data usdhc_imxrt1050_data = {
-	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_HS200 | ESDHC_FLAG_ERR004536,
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
 };
 
 static struct esdhc_soc_data usdhc_imx8qxp_data = {
-- 
2.34.1

