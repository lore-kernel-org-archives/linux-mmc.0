Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FHv6FaN4"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC954D49;
	Tue, 21 Nov 2023 22:05:06 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AM651kV070737;
	Wed, 22 Nov 2023 00:05:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1700633101;
	bh=KOtalysxXMQWduGNHD1aD8QXnv0lkOox7G7gvSeJRLw=;
	h=From:To:CC:Subject:Date;
	b=FHv6FaN4NL90M+olbjVZNx90wra5k5aZS1QGnLRTu8/hopB4OiplptSGHt/j8pTby
	 7gCgfEdopI4VxIQ41eOTW0O7ZQ2QJm4kQ61DpljFuyXq5O8L+qH4YWzZZdEEZtqLBU
	 7JChDxO+SDNqF2oA1nHp/T5ohSV+wWdpfynS1l3U=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AM651os015230
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Nov 2023 00:05:01 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 00:05:00 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 00:05:00 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AM64wFv033328;
	Wed, 22 Nov 2023 00:04:59 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] mmc: sdhci_am654: Drop lookup for deprecated ti,otap-del-sel
Date: Wed, 22 Nov 2023 11:32:14 +0530
Message-ID: <20231122060215.2074799-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

ti,otap-del-sel has been deprecated since v5.7 and there are no users of
this property and no documentation in the DT bindings either.
Drop the fallback code looking for this property, this makes
sdhci_am654_get_otap_delay() much easier to read as all the TAP values
can be handled via a single iterator loop.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

v2:
* Drop legacy_otapdly as pointed out by Adrian

v1: https://lore.kernel.org/r/20231110072535.2695134-1-vigneshr@ti.com

 drivers/mmc/host/sdhci_am654.c | 37 ++++++----------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 967bd2dfcda1..d659c59422e1 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -141,7 +141,6 @@ static const struct timing_data td[] = {
 
 struct sdhci_am654_data {
 	struct regmap *base;
-	bool legacy_otapdly;
 	int otap_del_sel[ARRAY_SIZE(td)];
 	int itap_del_sel[ARRAY_SIZE(td)];
 	int clkbuf_sel;
@@ -272,11 +271,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_set_clock(host, clock);
 
 	/* Setup DLL Output TAP delay */
-	if (sdhci_am654->legacy_otapdly)
-		otap_del_sel = sdhci_am654->otap_del_sel[0];
-	else
-		otap_del_sel = sdhci_am654->otap_del_sel[timing];
-
+	otap_del_sel = sdhci_am654->otap_del_sel[timing];
 	otap_del_ena = (timing > MMC_TIMING_UHS_SDR25) ? 1 : 0;
 
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
@@ -314,10 +309,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	u32 mask, val;
 
 	/* Setup DLL Output TAP delay */
-	if (sdhci_am654->legacy_otapdly)
-		otap_del_sel = sdhci_am654->otap_del_sel[0];
-	else
-		otap_del_sel = sdhci_am654->otap_del_sel[timing];
+	otap_del_sel = sdhci_am654->otap_del_sel[timing];
 
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
 	val = (0x1 << OTAPDLYENA_SHIFT) |
@@ -577,32 +569,15 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
 	int i;
 	int ret;
 
-	ret = device_property_read_u32(dev, td[MMC_TIMING_LEGACY].otap_binding,
-				 &sdhci_am654->otap_del_sel[MMC_TIMING_LEGACY]);
-	if (ret) {
-		/*
-		 * ti,otap-del-sel-legacy is mandatory, look for old binding
-		 * if not found.
-		 */
-		ret = device_property_read_u32(dev, "ti,otap-del-sel",
-					       &sdhci_am654->otap_del_sel[0]);
-		if (ret) {
-			dev_err(dev, "Couldn't find otap-del-sel\n");
-
-			return ret;
-		}
-
-		dev_info(dev, "Using legacy binding ti,otap-del-sel\n");
-		sdhci_am654->legacy_otapdly = true;
-
-		return 0;
-	}
-
 	for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
 
 		ret = device_property_read_u32(dev, td[i].otap_binding,
 					       &sdhci_am654->otap_del_sel[i]);
 		if (ret) {
+			if (i == MMC_TIMING_LEGACY) {
+				dev_err(dev, "Couldn't find mandatory ti,otap-del-sel-legacy\n");
+				return ret;
+			}
 			dev_dbg(dev, "Couldn't find %s\n",
 				td[i].otap_binding);
 			/*
-- 
2.42.0

