From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: core: add DT bindings for eMMC HS400 1.8/1.2V
Date: Fri, 21 Mar 2014 20:37:29 +0900
Message-ID: <000d01cf44f9$f0d2dc50$d27894f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:13649 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760185AbaCULha (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Mar 2014 07:37:30 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2S00E5IAYHNL70@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 21 Mar 2014 20:37:29 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>

Provide the option to configure these speed modes per host,
for those host driver's that can't distinguish this in runtime.
Specially, if host can support HS400, it means that host can also
support HS200.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
Note:
	Depending on [PATCH v3 5/5] mmc: add support for HS400 mode of eMMC5.0

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
index 453573d..4e35043 100644
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


