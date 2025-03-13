Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ECC13BAF1;
	Thu, 13 Mar 2025 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883602; cv=none; b=XXrBhFyhrpB0WMqtK2FVxHj0eyKuYtGKgjOoPHHAtHQ9tnMc1dZyG/WP0CLmQ9NGpOB2dLvfYdUeR8MKhAaSscFMgk7d5emSR3HX+p6Sr35rJbOxQCflOLLGyIXGHL4NbbS5OSgpjGb4U9qXEolC6ugBXNi7fYoeFKeKe7QRBPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883602; c=relaxed/simple;
	bh=Fk1Sw38RsovrWcOEK9Wv4pDEmhMSab8WX+0qeLrb8VA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCJ8qhVg/RiTpR9w+uGbbNzMTyCf8YHzCeZfosmqMLqj/QPMhxsC6Aq6ZVwDwGSKlxUlvjf5cgM7Q+uzp4EZAD6V7m58HBeyjkylAOk9qDY7sKWOy1L01o3GsvESzCHsnUR2S+O4KdKo7HPuzqB2CSwKJaPzbltArkjDx54B0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=ElKU9nVB; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="ElKU9nVB"
Received: from pps.filterd (m0142705.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DFsWO5018204;
	Thu, 13 Mar 2025 16:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=uGsSM+bjIB67eslV61aUbDQzWP1zi5zWBkuq/pqfoC8=; b=ElKU9nVBZO9a
	TO35z+DGLtTdFG4BBKbbv4i22PDSFvBBVl6Kylbud3NG7kPxaCAzDRuPWm8U3HEW
	UM7rqjVfqmIEl2mjB1K3+7JK4/w2LlG9aGudkpowfREqwe7QhYUn3bAN46qnk1Fe
	58e0RB4dnU1Kh37lrxXxyHIP6OHO6LSYzjY++zMjgxpa2eO9fbcqtG/37BvjiCcI
	6S5wFySn5X3qtWxPWCx/PV0ToKiV6i76Fvg+XgbhyG8i0S2GOK0108XE5ZSsvAVj
	reJwm93JVlMheq/EreRr9X/dSXa6lv3hYKqCe8XyIM6fLhdhIADccG8EZVvRT+6H
	/kJAaXuV1Q==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 45c25ms2cf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 16:32:25 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Mar 2025 11:32:23 -0500
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Thu, 13 Mar 2025 11:32:23
 -0500
From: Erick Shepherd <erick.shepherd@ni.com>
To: <adrian.hunter@intel.com>
CC: <andy-ld.lu@mediatek.com>, <avri.altman@wdc.com>, <cw9316.lee@samsung.com>,
        <dsimic@manjaro.org>, <erick.shepherd@ni.com>, <keita.aihara@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <quic_jjohnson@quicinc.com>, <ricardo@marliere.net>,
        <ulf.hansson@linaro.org>, <victor.shih@genesyslogic.com.tw>,
        <wsa+renesas@sang-engineering.com>
Subject: Re: [RFC PATCH V2 2/2] mmc: allow card to disable tuning
Date: Thu, 13 Mar 2025 11:32:23 -0500
Message-ID: <20250313163223.1514010-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <65238f8f-46b8-41f2-a992-0d1a150ae8c1@intel.com>
References: <65238f8f-46b8-41f2-a992-0d1a150ae8c1@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: XJTHY8tRz9hn534FshcTSJahoLDBL1A3
X-Proofpoint-ORIG-GUID: XJTHY8tRz9hn534FshcTSJahoLDBL1A3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_07,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=938
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130128

How does this look? I confirmed the changes stop the card from tuning=0D
and prevent the I/O errors. I can submit a new patch since these=0D
changes are substantially different than my initial ones.=0D
=0D
diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h=0D
index 3205feb1e8ff..756f80024635 100644=0D
--- a/drivers/mmc/core/card.h=0D
+++ b/drivers/mmc/core/card.h=0D
@@ -89,6 +89,7 @@ struct mmc_fixup {=0D
 #define CID_MANFID_MICRON       0x13=0D
 #define CID_MANFID_SAMSUNG      0x15=0D
 #define CID_MANFID_APACER       0x27=0D
+#define CID_MANFID_SWISSBIT     0x5D=0D
 #define CID_MANFID_KINGSTON     0x70=0D
 #define CID_MANFID_HYNIX	0x90=0D
 #define CID_MANFID_KINGSTON_SD	0x9F=0D
=0D
=0D
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c=0D
index 5241528f8b90..8962992f05aa 100644=0D
--- a/drivers/mmc/core/core.c=0D
+++ b/drivers/mmc/core/core.c=0D
@@ -937,6 +937,10 @@ int mmc_execute_tuning(struct mmc_card *card)=0D
 	if (!host->ops->execute_tuning)=0D
 		return 0;=0D
 =0D
+	if ((card->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING) &&=0D
+	    host->ios.timing =3D=3D MMC_TIMING_UHS_DDR50)=0D
+		return 0;=0D
+=0D
 	if (host->cqe_on)=0D
 		host->cqe_ops->cqe_off(host);=0D
=0D
 =0D
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h=0D
index 89b512905be1..7f893bafaa60 100644=0D
--- a/drivers/mmc/core/quirks.h=0D
+++ b/drivers/mmc/core/quirks.h=0D
@@ -34,6 +34,16 @@ static const struct mmc_fixup __maybe_unused mmc_sd_fixu=
ps[] =3D {=0D
 		   MMC_QUIRK_BROKEN_SD_CACHE | MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY,=0D
 		   EXT_CSD_REV_ANY),=0D
 =0D
+	/*=0D
+	 * Swissbit series S46-u cards throw I/O errors during tuning requests=0D
+	 * after the initial tuning request expectedly times out. This has=0D
+	 * only been observed on cards manufactured on 01/2019 that are using=0D
+	 * Bay Trail host controllers.=0D
+	 */=0D
+	_FIXUP_EXT("0016G", CID_MANFID_SWISSBIT, 0x5342, 2019, 1,=0D
+		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,=0D
+		   MMC_QUIRK_NO_UHS_DDR50_TUNING, EXT_CSD_REV_ANY),=0D
+=0D
 	END_FIXUP=0D
 };=0D
=0D
 =0D
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h=0D
index 526fce581657..ddcdf23d731c 100644=0D
--- a/include/linux/mmc/card.h=0D
+++ b/include/linux/mmc/card.h=0D
@@ -329,6 +329,7 @@ struct mmc_card {=0D
 #define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache suppo=
rt */=0D
 #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until th=
e write has occurred */=0D
 #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD p=
oweroff notify support */=0D
+#define MMC_QUIRK_NO_UHS_DDR50_TUNING	(1<<18) /* Disable DDR50 tuning */=0D
 =0D
 	bool			written_flag;	/* Indicates eMMC has been written since power on */=
=0D
 	bool			reenable_cmdq;	/* Re-enable Command Queue */=0D
-- =0D
=0D
Regards,=0D
Erick=0D
