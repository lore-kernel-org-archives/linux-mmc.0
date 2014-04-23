From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 6/6] mmc: core: add DT bindings for eMMC HS400 1.8/1.2V
Date: Wed, 23 Apr 2014 17:15:08 +0900
Message-ID: <000f01cf5ecc$23c92d80$6b5b8880$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <006701cf2a58$c628e050$527aa0f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:23036 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbaDWIPJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 04:15:09 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4H0002B5L8F670@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 23 Apr 2014 17:15:08 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Jackey Shen' <jackey.shen@amd.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Fariya Fatima' <fariyaf@gmail.com>, "'John W. Linville'" <linville@tuxdriver.com>

Provide the option to configure these speed modes per host,
for those host driver's that can't distinguish this in runtime.
Specially, if host can support HS400, it means that host can also
support HS200.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt |    2 ++
 drivers/mmc/core/host.c                       |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 9dce540..3c18001 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -38,6 +38,8 @@ Optional properties:
 - mmc-highspeed-ddr-1_2v: eMMC high-speed DDR mode(1.2V I/O) is supported
 - mmc-hs200-1_8v: eMMC HS200 mode(1.8V I/O) is supported
 - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
+- mmc-hs400-1_8v: eMMC HS400 mode(1.8V I/O) is supported
+- mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index fdea825..95cceae 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -447,6 +447,10 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
 	if (of_find_property(np, "mmc-hs200-1_2v", &len))
 		host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
+	if (of_find_property(np, "mmc-hs400-1_8v", &len))
+		host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
+	if (of_find_property(np, "mmc-hs400-1_2v", &len))
+		host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
 
 	return 0;
 
-- 
1.7.0.4


