From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 1/2] arm: samsung: support the second capability for
 samsung-soc
Date: Mon, 06 Feb 2012 16:52:56 +0900
Message-ID: <4F2F86D8.40202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:52642 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab2BFHxE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2012 02:53:04 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, 'kgene kim' <kgene.kim@samsung.com>, Girish K S <girish.shivananjappa@linaro.org>

In mmc, there are capabilities and use the host_caps.
That capability is expressed with bit[0:31].
But now..already filled the bit[0:31]...
so we need to denote with the other capability field.
(if we want to use the cache, powerclass, etc for eMMC..this field is necessary)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
---
Changelog v3:
	- based-on latest samsung-soc's for-next tree.
Changelog v2:
	- based-on samsung-soc's for-next tree.

 arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
 arch/arm/plat-samsung/platformdata.c       |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index f82f888..317e246 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -40,6 +40,7 @@ enum clk_types {
  * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
  * @max_width: The maximum number of data bits supported.
  * @host_caps: Standard MMC host capabilities bit field.
+ * @host_caps2: The second standard MMC host capabilities bit field.
  * @cd_type: Type of Card Detection method (see cd_types enum above)
  * @clk_type: Type of clock divider method (see clk_types enum above)
  * @ext_cd_init: Initialize external card detect subsystem. Called on
@@ -63,6 +64,7 @@ enum clk_types {
 struct s3c_sdhci_platdata {
 	unsigned int	max_width;
 	unsigned int	host_caps;
+	unsigned int	host_caps2;
 	unsigned int	pm_caps;
 	enum cd_types	cd_type;
 	enum clk_types	clk_type;
diff --git a/arch/arm/plat-samsung/platformdata.c b/arch/arm/plat-samsung/platformdata.c
index 0f70718..fa78aa7 100644
--- a/arch/arm/plat-samsung/platformdata.c
+++ b/arch/arm/plat-samsung/platformdata.c
@@ -53,6 +53,8 @@ void s3c_sdhci_set_platdata(struct s3c_sdhci_platdata *pd,
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->host_caps)
 		set->host_caps |= pd->host_caps;
+	if (pd->host_caps2)
+		set->host_caps2 |= pd->host_caps2;
 	if (pd->pm_caps)
 		set->pm_caps |= pd->pm_caps;
 	if (pd->clk_type)
-- 
1.7.4.1
