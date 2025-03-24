Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420818B03;
	Mon, 24 Mar 2025 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.142.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844154; cv=none; b=NlcHrPj/8NrfbGK8B1DUmVGkYprw3tnzhOxge4E9mgMoPnVzHxvIE6rNMcFmjEvCWaP++68IVyqGFvj/F7aSoV8HoVAxZQFb+LRJDLjRclasY9gEbI/wxaWPnSCVgC4Rj6WXd4x8MpxUGefhYGU06rn27exRKQimu69m0Vtp/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844154; c=relaxed/simple;
	bh=yJDMXLZzTHk3EZq76Q74N4Zwvzvre3uZR9K9t14AwoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZb06jcpsQiixzvGMNmb+db/0mrqYAgld0J7AAVnHHHhWzeYxSguJku+eRVnqCC8qQUGEmuQ3mJuyJOK26m8R+lABGwk2E+ubLv2B+UjqIMkvB6a2KIrXQn0w7dXOKwnRzdroY7OW+9db9+613vqzWjbECpedWzdqU2BN+/52JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=mw3UaA9m; arc=none smtp.client-ip=148.163.142.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="mw3UaA9m"
Received: from pps.filterd (m0144091.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OD2W3k001531;
	Mon, 24 Mar 2025 19:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=czoJ/paFLCwaFLFspLyWITZgqMgVHu04NTA7upDGRSA=; b=mw3UaA9mQlkg
	feFrrKbQUnnLUvi3tboPLvOxNHUWq9adcNw0nYEx5wppKjXpTw17V3AaLA8JtUaN
	dHTNg870Ks9t7lmPzOcBxmZz+IECm73T09QIwzv7EGd/T9vsc0NbAwKPiXAE1R8i
	eadHiolb9sB1Za1+UAg8O9OVPDY2Om6HUf8lo9yhTvrz84Hq0FHdqTvMYCCMrBdg
	i7yqCalwNgQQP6vjTHEDonluLcUjBEypP8tXpLm5FJuMyM7+liOh12tZ+rLYymrs
	muB7yuIduWxmsJsTl/w6DQZT/Y0NnJTbBI/RNSST3A1WHRzldK1EiyjyB7rhIBWJ
	jhOQitHP1w==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 45k7x1w8gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 19:22:02 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 24 Mar 2025 14:21:16 -0500
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.33) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Mon, 24 Mar 2025 14:21:16
 -0500
From: Erick Shepherd <erick.shepherd@ni.com>
To: <ulf.hansson@linaro.org>
CC: <adrian.hunter@intel.com>, <andy-ld.lu@mediatek.com>,
        <avri.altman@wdc.com>, <dsimic@manjaro.org>, <erick.shepherd@ni.com>,
        <jason.lai@genesyslogic.com.tw>, <jeff.johnson@oss.qualcomm.com>,
        <jonathan@raspberrypi.com>, <keita.aihara@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <victor.shih@genesyslogic.com.tw>, <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] mmc: Add quirk to disable DDR50 tuning
Date: Mon, 24 Mar 2025 14:21:16 -0500
Message-ID: <20250324192116.1756281-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPDyKFqrT0zXVRya=sgEOdjmn7D6xb-e+nD9Q4JpVnh1ddu_Fw@mail.gmail.com>
References: <CAPDyKFqrT0zXVRya=sgEOdjmn7D6xb-e+nD9Q4JpVnh1ddu_Fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ambo5f-lN4Bq9HsUUGgFt5ONALa__j-F
X-Proofpoint-GUID: ambo5f-lN4Bq9HsUUGgFt5ONALa__j-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=728
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240138

> Please move this to mmc_sd_init_uhs_card() instead. Moreover, please=0D
> add a helper in drivers/mmc/core/card.h for=0D
> MMC_QUIRK_NO_UHS_DDR50_TUNING, similar to other quirks.=0D
=0D
Sorry for the late response, how does this look? I can change the=0D
MMC_QUIRK_NO_UHS_DDR50_TUNING check to be before the tuning=0D
if-statement instead of within it if that seems more appropriate.=0D
=0D
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
@@ -294,4 +295,9 @@ static inline int mmc_card_broken_sd_poweroff_notify(co=
nst struct mmc_card *c)=0D
 	return c->quirks & MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY;=0D
 }=0D
 =0D
+static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)=0D
+{=0D
+	return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;=0D
+}=0D
+=0D
=0D
--- a/drivers/mmc/core/sd.c=0D
+++ b/drivers/mmc/core/sd.c=0D
@@ -664,6 +664,10 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)=
=0D
	if (!mmc_host_is_spi(card->host) &&=0D
 		(card->host->ios.timing =3D=3D MMC_TIMING_UHS_SDR50 ||=0D
 		 card->host->ios.timing =3D=3D MMC_TIMING_UHS_DDR50 ||=0D
 		 card->host->ios.timing =3D=3D MMC_TIMING_UHS_SDR104)) {=0D
+		if ((card->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING) &&=0D
+		    card->host->ios.timing =3D=3D MMC_TIMING_UHS_DDR50)=0D
+			goto out;=0D
+=0D
 		err =3D mmc_execute_tuning(card);=0D
 =0D
 		/*=0D
=0D
Regards,=0D
Erick=0D
