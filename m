Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992C01C32;
	Thu, 13 Mar 2025 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741836964; cv=none; b=e7TlMNlofGAT7DbCiX/UWrfgkSBbqR/mtqWve4locxMZKpXG3fYYt/5Vtj0efjoWaOeZ3X3tgffs1K1ckXNIvrn2YAKAtgW2WBAtR9Eg4iRqTjdjiFP2Fwd8vchurwjLRoC0Pdt9lrALlmcOVMLT7zbT2gRSWHM9mp12m04oV7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741836964; c=relaxed/simple;
	bh=qgVVV4pLWYSi3Udrx2TJoSwnuOQIHLrJooGwPUr0zFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LExqq8CGl1cqMeyEzcCXbbvfpnGlssmzlzSCa83ppeLEbaiuAUOJ/ZtSYBcBRWk6dMlxIjnvvHrtzDXcDXtXqQmdJt0+tHpNPKVAd5CEmj/KQTdYxpYhYJNp2HyidVIMB9lXjcsVQbED9sKm2sP9+AV7dE/2cux/ny6T87SQIwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=qI8W0Hka; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="qI8W0Hka"
Received: from pps.filterd (m0359308.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D0n9Ek007659;
	Thu, 13 Mar 2025 03:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=AJ7+NYG6VySdhgUp0omQj6TsB98iszwGrWnabWpc/xg=; b=qI8W0HkaJ3sh
	TbaBGFVCgIe09kksmFB0UvO6mjWOLKLf0N35chkksLs8mvrrCrLHqY7FiB/HuQ/K
	NKxmr5k9uSPV19m8V4thhCq/vTbGos2mVr2xUNZC9TENxq2MNqs+l80ETBvMsZfx
	q2KmsJK/wK2bwXiLvmHM2GWDF3I86S0BRGkozp58jUnfLWEkedoTolPtAvBpukTq
	v4bxo/+XCjDk0o3B3MBtDGtEQdp/SpjnLChNxGIL/aKcqgtdiOUWXEI1GfMJN9ij
	TKhKwpAS222qjpgtid/FIPvVrxHzoWfJJ+f5/DLNGuHAUgt8Vv4G+6BVxm14RMHB
	JmrzA6vODg==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 45bn4yhyqn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 03:35:54 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 12 Mar 2025 22:35:52 -0500
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Wed, 12 Mar 2025 22:35:52
 -0500
From: Erick Shepherd <erick.shepherd@ni.com>
To: <adrian.hunter@intel.com>
CC: <brad.mouring@ni.com>, <erick.shepherd@ni.com>,
        <gratian.crisan@emerson.com>, <kyle.roeschley@ni.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc: core: Wait for Vdd to settle on card power off
Date: Wed, 12 Mar 2025 22:35:52 -0500
Message-ID: <20250313033552.1505631-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a7d1bf5d-6101-4282-92a8-11f9f3569d8b@intel.com>
References: <a7d1bf5d-6101-4282-92a8-11f9f3569d8b@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xUs7Rz_IUqUxOfczl-TEXXmVj0iAQKbO
X-Proofpoint-GUID: xUs7Rz_IUqUxOfczl-TEXXmVj0iAQKbO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 impostorscore=0 adultscore=0
 mlxlogscore=816 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130026

> What about something like this?=0D
=0D
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-p=
ci-core.c=0D
> index 1f0bd723f011..0789df732e93 100644=0D
> --- a/drivers/mmc/host/sdhci-pci-core.c=0D
> +++ b/drivers/mmc/host/sdhci-pci-core.c=0D
> @@ -610,8 +610,11 @@ static void sdhci_intel_set_power(struct sdhci_host =
*host, unsigned char mode,=0D
 =0D
>  	sdhci_set_power(host, mode, vdd);=0D
 =0D
> -	if (mode =3D=3D MMC_POWER_OFF)=0D
> +	if (mode =3D=3D MMC_POWER_OFF) {=0D
> +		if (slot->chip->pdev->device =3D=3D PCI_DEVICE_ID_INTEL_APL_SD)=0D
> +			usleep_range(15000, 17500);=0D
>  		return;=0D
> +	}=0D
 =0D
> 	/*=0D
> 	 * Bus power might not enable after D3 -> D0 transition due to the=0D
=0D
I talked to one of our digital hardware engineers who worked on this=0D
issue. He believes that the issue is likely affecting more than just =0D
Apollo Lake devices and recommended keeping the delay for all of our=0D
devices. Could something like this work?=0D
=0D
--- a/drivers/mmc/host/sdhci.c=0D
+++ b/drivers/mmc/host/sdhci.c=0D
@@ -2176,6 +2176,9 @@ EXPORT_SYMBOL_GPL(sdhci_set_power_noreg);=0D
 void sdhci_set_power(struct sdhci_host *host, unsigned char mode,=0D
 		     unsigned short vdd)=0D
 {=0D
+	if (mode =3D=3D MMC_POWER_OFF)=0D
+		usleep_range(15000, 17500);=0D
+=0D
 	if (IS_ERR(host->mmc->supply.vmmc))=0D
 		sdhci_set_power_noreg(host, mode, vdd);=0D
 	else=0D
  =0D
Regards,=0D
Erick=0D
