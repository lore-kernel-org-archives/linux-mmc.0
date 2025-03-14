Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B20D15B122;
	Fri, 14 Mar 2025 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.142.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982345; cv=none; b=GOuKTUyeJSqvyRLQSN/b71TuCMgmqcDjS7JNXt+rWTR+k62ceRdYsLQ94VAzqYtpAEDHDxnlKBAawnz4Gx9AUS8H7zN59jnfPZYWiM7iPJeyB2vkaZ4qZ3WVRg/z/K+t0+nUgObxpOyho7+AS7iWoDLOiNr4rsuQZRrJl/GAhk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982345; c=relaxed/simple;
	bh=qpADqbD8cyaXnRCS5BTQv0v58wlWGnQ9E6uqvSF8Qlg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IN+vfH9OtpWAIipoZBYYPK84EVyDFX724eKv1jR1/YdYnK76UH6X1dx76iiIEw1dZuqcjmyK+gyuWpO98SmZUi9X6gN9w7lOAFh9Wf0LGWtbI4h0aFgvZVgFHwrGW5dXfMTPI1jOVG46aO6fxGul9OY6kXdTb56INKVb1Tj8Vjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=TVTw6r72; arc=none smtp.client-ip=148.163.142.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="TVTw6r72"
Received: from pps.filterd (m0144091.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EE8Rqg031097;
	Fri, 14 Mar 2025 19:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS11142024; bh=k0NyECRggPo4eHprLwKw
	atGq8Zg/3wV8nRq1tMaQXRI=; b=TVTw6r72q7R54erLeY+NmSGhFwHTSX7cuOGi
	7MnvJ7l2fjhnu0jbOtwlVyJZhKJhzCu6+NQVA36lpbfp9DxFj5WsNFN0HobsXTE9
	+Y4/4P/q2kqqvkSC4cAEgTILW9fIqZmKN+EIJiF1qkvpFAbk+NuhUIQly3aF7Zh4
	40ekwzWreCyqQPyYhMZpBi+jShlcMFHcYtSU0av6x+kzI2GH3RBehPHlBGTs6yHj
	F+RCv/tcDVifIqqKWRfy5OUKhyN86SE47NGBF/fqTUBgGi04vQ8HDAV3+x+bBnul
	EeRg8hHozIWRuNfcSAdD4BZLI4H6HEmT8cBuKK+vVC0FArGOrA==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 45cnxtvxy2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 19:58:35 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Mar 2025 14:58:34 -0500
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 14 Mar 2025 14:58:34
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
Subject: [PATCH] mmc: Add quirk to disable DDR50 tuning
Date: Fri, 14 Mar 2025 14:58:32 -0500
Message-ID: <20250314195832.1588159-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FJN8fU8j9H9iQ3fhKG6Qa2aZQFh3FcSg
X-Proofpoint-GUID: FJN8fU8j9H9iQ3fhKG6Qa2aZQFh3FcSg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_08,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=859 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1011 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140153

Adds the MMC_QUIRK_NO_UHS_DDR50_TUNING quirk and updates
mmc_execute_tuning() to return 0 if that quirk is set. This fixes an
issue on certain Swissbit SD cards that do not support DDR50 tuning
where tuning requests caused I/O errors to be thrown.

Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
---
 drivers/mmc/core/card.h   |  1 +
 drivers/mmc/core/core.c   |  4 ++++
 drivers/mmc/core/quirks.h | 10 ++++++++++
 include/linux/mmc/card.h  |  1 +
 4 files changed, 16 insertions(+)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 3205feb1e8ff..756f80024635 100644
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
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5241528f8b90..8962992f05aa 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -937,6 +937,10 @@ int mmc_execute_tuning(struct mmc_card *card)
 	if (!host->ops->execute_tuning)
 		return 0;
 
+	if ((card->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING) &&
+	    host->ios.timing == MMC_TIMING_UHS_DDR50)
+		return 0;
+
 	if (host->cqe_on)
 		host->cqe_ops->cqe_off(host);
 
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

