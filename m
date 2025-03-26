Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7701A2642;
	Wed, 26 Mar 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022819; cv=none; b=c5Ws6YBjuMjgLnvga0oenedly9mE6sFHw1ja9Y8JXENs559qyOJS/PQjTY0DZl9+9fIP79VdbT7f9Of8kiQRXu/HkkwUQkF+bF+72P9IHBEksUSj2K6jFW2OlhpFL/Z8fziG3SMXwGyWMKLmWw5k3TuWIfe3hG6JE5uH+v0jAoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022819; c=relaxed/simple;
	bh=YMRAohbi2Dz401n4V/wa16n/WSG1I7lPaLiUl2Qf1rI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXv6btFxA/HFMXFvTEl/6lCe0PRPUDr0x8prHSEBpQw3PnREMF5Dqae7rfhEzkqncmUem/ybyKBPTMzm+Rm6H5LmDSDbjF79YSsyGiWK8NUXRFyv7VlDGNlNFgcxo3KTFBKzZeSS+J8G/dLePv/qSTN/PMvqWCuhgRL7JOl4X4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=ZCu3Bhe1; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="ZCu3Bhe1"
Received: from pps.filterd (m0142705.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QHT8kv034503;
	Wed, 26 Mar 2025 19:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=PU6PYT3MiOC/wAJweX5b3OMOWC8qcVg8pqlmsFdmaxM=; b=ZCu3Bhe1Xp1F
	AOxQRmio3pG65LQAkv9FSTU1FN/mFdcmHnEDftNNMdNNJlS/pxEBqHifQcIdas8K
	6WeUx58eai2gKudgcLj3K4ciTILIRW/WApfEl3DIMKzCpDrdfoXnLKQ72wKU7oj3
	0FwbZOWNm/kTqGmdmjHG9WDA5Rm7/41DXTspJA+cV/dAD/Xl4BBkZ+AgBQ89sZnM
	UecHm9KlrbWl5Vv9UT3agYyeadFGKCaEEULy0AfLrCX3DwYDiGopS9pW7znqBIOA
	L5zggHT+tdJRu+VJl0ZH3u1qaDGkI5j6Hd2k4yiyE6ZS3zANBTcj2pTbpvrt5mps
	iJ6QOWi/tQ==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 45mp15acqu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 19:30:49 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 26 Mar 2025 14:30:47 -0500
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.33) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Wed, 26 Mar 2025 14:30:47
 -0500
From: Erick Shepherd <erick.shepherd@ni.com>
To: <adrian.hunter@intel.com>
CC: <andy-ld.lu@mediatek.com>, <avri.altman@wdc.com>, <dsimic@manjaro.org>,
        <erick.shepherd@ni.com>, <jason.lai@genesyslogic.com.tw>,
        <jeff.johnson@oss.qualcomm.com>, <jonathan@raspberrypi.com>,
        <keita.aihara@sony.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <victor.shih@genesyslogic.com.tw>, <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] mmc: Add quirk to disable DDR50 tuning
Date: Wed, 26 Mar 2025 14:30:47 -0500
Message-ID: <20250326193047.1902835-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c6093207-2b68-4e3a-8a70-7ab4541ac59f@intel.com>
References: <c6093207-2b68-4e3a-8a70-7ab4541ac59f@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: anLfp7SwaW9XeKnc41Y_e7vegjp6DCEB
X-Proofpoint-GUID: anLfp7SwaW9XeKnc41Y_e7vegjp6DCEB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=968 malwarescore=0 clxscore=1015
 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260119

> Perhaps make a helper function (untested):=0D
=0D
Making a helper function seems like a good idea to me. How does this=0D
look? I tested it using the SD card with our issue to confirm the I/O=0D
errors no longer appear. I also tested it with another DDR50 SD card=0D
to make sure the tuning is still executed in that case. I don't have a=0D
SDR50 or SDR104 card on hand but could try to find them if you believe=0D
the helper function needs to be tested further.=0D
=0D
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c=0D
index cc757b850e79..fc3416027033 100644=0D
--- a/drivers/mmc/core/sd.c=0D
+++ b/drivers/mmc/core/sd.c=0D
@@ -613,6 +613,29 @@ static int sd_set_current_limit(struct mmc_card *card,=
 u8 *status)=0D
 	return 0;=0D
 }=0D
 =0D
+/*=0D
+ * Determine if the card should tune or not.=0D
+ */=0D
+static bool mmc_sd_use_tuning(struct mmc_card *card)=0D
+{=0D
+	/*=0D
+	 * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and=0D
+	 * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.=0D
+	 */=0D
+	if (mmc_host_is_spi(card->host))=0D
+		return false;=0D
+=0D
+	switch (card->host->ios.timing) {=0D
+	case MMC_TIMING_UHS_SDR50:=0D
+	case MMC_TIMING_UHS_SDR104:=0D
+		return true;=0D
+	case MMC_TIMING_UHS_DDR50:=0D
+		return !mmc_card_no_uhs_ddr50_tuning(card);=0D
+	}=0D
+=0D
+	return false;=0D
+}=0D
+=0D
 /*=0D
  * UHS-I specific initialization procedure=0D
  */=0D
@@ -656,14 +679,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)=
=0D
 	if (err)=0D
 		goto out;=0D
 =0D
-	/*=0D
-	 * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and=0D
-	 * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.=0D
-	 */=0D
-	if (!mmc_host_is_spi(card->host) &&=0D
-		(card->host->ios.timing =3D=3D MMC_TIMING_UHS_SDR50 ||=0D
-		 card->host->ios.timing =3D=3D MMC_TIMING_UHS_DDR50 ||=0D
-		 card->host->ios.timing =3D=3D MMC_TIMING_UHS_SDR104)) {=0D
+	if (mmc_sd_use_tuning(card)) {=0D
 		err =3D mmc_execute_tuning(card);=0D
 =0D
 		/*=0D
=0D
Regards,=0D
Erick=0D
