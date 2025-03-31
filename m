Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFDF212FB0;
	Mon, 31 Mar 2025 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.142.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743459275; cv=none; b=m0vCtioG6E02JE5e1hXisXd5YB9AKqqbh7imlOmbmHNBNRYDkbv8mJMhF2lCdU/CztOXGqLroou0O0+vNGVUZlmudTmS8tvNo5lK2nH8wlEauXPSe9WOnfftCEd5gR5rR2RWyXLxGgM1RmUQOMrzSVfQl/vADi7srPRfAe5Ds+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743459275; c=relaxed/simple;
	bh=Omjqeb14TmXfSfFTHfsl8LkwOfJpDZqW/I1BPPX5Tfs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=chqow9iNKFE+PS/r3D8oHtmLna89Dwe+7n8Wkp7sV7KYJGCc1o2iFk4PzXeHa96vdSymucAhf7Clw9CR+JiWMfoobJ4wZaX6IYm9cLCKJm1VR6jKhN7S5cajwG6xqCJNdrpVdDgc6C2MgQ4acMyMYEMe1T3o1Txd23H+QAwrb+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=t+9a43Z5; arc=none smtp.client-ip=148.163.142.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="t+9a43Z5"
Received: from pps.filterd (m0144092.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VH9CfR032303;
	Mon, 31 Mar 2025 22:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS11142024; bh=oFvr8MrCcDO1CoeYhUQm
	pM6YRTzZjomUqPcXSlcNFJI=; b=t+9a43Z5wa6G0Kh0MaANxO0+gEjx5lr35eSv
	jn6dXe1rSUqctbDKxD0Bl7aQ5N2mlyiI69isuv6mTuqascLfJtOlezKjTaYQxKP/
	TP5+TMA4ZPHFr6Aqa1FoqD317J6PI0YZUF8GptUK6HhHGaGRDAxeXsyS/2hi4bHb
	dVfRBz/Clclq6SEARPGWyaAjwX9/FuouRKZTGeCjohmgciGS5MEZy8dRaboN0KXv
	X3JyuNGbxTc3yOGaHyNWjKz8uNvRxy2jN7yyJxHgMzCuz9otLPnbPYZwHTMeqJQY
	p+n475S+l0e71eIeqLLh30188Ptn79QYVzEMH3Vc+MwoprCA6w==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 45qy6qbbww-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 22:13:51 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 31 Mar 2025 17:13:39 -0500
Received: from ershephe-ubuntu.ni.corp.natinst.com (172.18.68.33) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Mon, 31 Mar 2025 17:13:39
 -0500
From: Erick Shepherd <erick.shepherd@ni.com>
To: <linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <keita.aihara@sony.com>, <linux-kernel@vger.kernel.org>,
        <avri.altman@wdc.com>, <wsa+renesas@sang-engineering.com>,
        <jason.lai@genesyslogic.com.tw>, <jeff.johnson@oss.qualcomm.com>,
        <victor.shih@genesyslogic.com.tw>, <andy-ld.lu@mediatek.com>,
        <dsimic@manjaro.org>, <jonathan@raspberrypi.com>,
        Erick Shepherd
	<erick.shepherd@ni.com>
Subject: [PATCH v2] mmc: Add quirk to disable DDR50 tuning
Date: Mon, 31 Mar 2025 17:13:37 -0500
Message-ID: <20250331221337.1414534-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zNxsMkL5vfSgs4L0ADYNtRDxzQ3hzTHg
X-Proofpoint-GUID: zNxsMkL5vfSgs4L0ADYNtRDxzQ3hzTHg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_10,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503310152

Adds the MMC_QUIRK_NO_UHS_DDR50_TUNING quirk and updates
mmc_execute_tuning() to return 0 if that quirk is set. This fixes an
issue on certain Swissbit SD cards that do not support DDR50 tuning
where tuning requests caused I/O errors to be thrown.

Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
---
 drivers/mmc/core/card.h   |  6 ++++++
 drivers/mmc/core/quirks.h | 10 ++++++++++
 drivers/mmc/core/sd.c     | 32 ++++++++++++++++++++++++--------
 include/linux/mmc/card.h  |  1 +
 4 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 3205feb1e8ff..9cbdd240c3a7 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -89,6 +89,7 @@ struct mmc_fixup {
 #define CID_MANFID_MICRON       0x13
 #define CID_MANFID_SAMSUNG      0x15
 #define CID_MANFID_APACER       0x27
+#define CID_MANFID_SWISSBIT     0x5D
 #define CID_MANFID_KINGSTON     0x70
 #define CID_MANFID_HYNIX	0x90
 #define CID_MANFID_KINGSTON_SD	0x9F
@@ -294,4 +295,9 @@ static inline int mmc_card_broken_sd_poweroff_notify(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY;
 }
 
+static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
+}
+
 #endif
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 89b512905be1..7f893bafaa60 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -34,6 +34,16 @@ static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
 		   MMC_QUIRK_BROKEN_SD_CACHE | MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY,
 		   EXT_CSD_REV_ANY),
 
+	/*
+	 * Swissbit series S46-u cards throw I/O errors during tuning requests
+	 * after the initial tuning request expectedly times out. This has
+	 * only been observed on cards manufactured on 01/2019 that are using
+	 * Bay Trail host controllers.
+	 */
+	_FIXUP_EXT("0016G", CID_MANFID_SWISSBIT, 0x5342, 2019, 1,
+		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
+		   MMC_QUIRK_NO_UHS_DDR50_TUNING, EXT_CSD_REV_ANY),
+
 	END_FIXUP
 };
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index cc757b850e79..fc3416027033 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -613,6 +613,29 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 	return 0;
 }
 
+/*
+ * Determine if the card should tune or not.
+ */
+static bool mmc_sd_use_tuning(struct mmc_card *card)
+{
+	/*
+	 * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and
+	 * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
+	 */
+	if (mmc_host_is_spi(card->host))
+		return false;
+
+	switch (card->host->ios.timing) {
+	case MMC_TIMING_UHS_SDR50:
+	case MMC_TIMING_UHS_SDR104:
+		return true;
+	case MMC_TIMING_UHS_DDR50:
+		return !mmc_card_no_uhs_ddr50_tuning(card);
+	}
+
+	return false;
+}
+
 /*
  * UHS-I specific initialization procedure
  */
@@ -656,14 +679,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 	if (err)
 		goto out;
 
-	/*
-	 * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and
-	 * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
-	 */
-	if (!mmc_host_is_spi(card->host) &&
-		(card->host->ios.timing == MMC_TIMING_UHS_SDR50 ||
-		 card->host->ios.timing == MMC_TIMING_UHS_DDR50 ||
-		 card->host->ios.timing == MMC_TIMING_UHS_SDR104)) {
+	if (mmc_sd_use_tuning(card)) {
 		err = mmc_execute_tuning(card);
 
 		/*
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 526fce581657..ddcdf23d731c 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -329,6 +329,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache support */
 #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
 #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
+#define MMC_QUIRK_NO_UHS_DDR50_TUNING	(1<<18) /* Disable DDR50 tuning */
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
-- 
2.43.0

