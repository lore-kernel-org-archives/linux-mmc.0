Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9C1F419D;
	Thu, 13 Mar 2025 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898684; cv=none; b=C+2yNyK0uFPwGDGNSa92tGjhpiFGOMnGLeOr2gPhZZCwcG04czCzcoCcEi/s1LSDzYo+EvzfvMspw/lqEboNlLRep26RgV8umDcEKsTFe5Olg9/VraWf843sF5q19tEt25DnAUxlrQBO1PKeyiA+mfo9GctZzoXc4lAqqnoDvF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898684; c=relaxed/simple;
	bh=Y802YPgUelF5kdRztFzXGPveN+UuS2xYcoz143vw2yk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5eaeN0SBkmEFwY0v5gsGw3iumL0HvqsGTgV9II+Yq29kT9DsRIu7dAK48wRUhR/4o1aesukX8FH7iLUEPlHdGe6shvo23icVfGOOQqKrxXSJwL2UKnBIG0iaj4pQBItn6jJeBkZvGa7YND+Nysbq4/Ft063XNOCYHwNMFMT/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=HguGzJ76; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="HguGzJ76"
Received: from pps.filterd (m0142705.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DKbd54025198;
	Thu, 13 Mar 2025 20:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=qmZtXzry0+1HTLglhiWFVHKGFkCwlbgPOwkxBRFjUnY=; b=HguGzJ76aIaY
	kzbrnL5pRorPH5pD+RsVkReZQYJBPbFlwUwWOHxcNXDCawY14637XNabw5m29S/K
	dGYuhUsUCT7A8ynH8tCw/MJcm3wUm5Im2Uqsx6SxT1bz1icj8kCsEI/lcQFT6rOX
	4EX80KuRW3amIGgC1yqnKPLDXzZvi+P/g9H60Hp0Ob/yJ3C2RH9a47vTfoauqJtB
	3kg1a0rtJiEw38bbeYRHPrxGLdZUjAhooGMUK6ZI0zlv39tQlsGkvutHDhx9ejN3
	akA0zgUM3VkgHM5X5SLi/7yEF2eep+WOiwhApRR8cbXB6n4pDTRuCDvHZl/Bbj1d
	ZGdZwOjAbQ==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 45c6jgg3qc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 20:44:40 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Mar 2025 15:44:39 -0500
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Thu, 13 Mar 2025 15:44:39
 -0500
From: Erick Shepherd <erick.shepherd@ni.com>
To: <adrian.hunter@intel.com>
CC: <brad.mouring@ni.com>, <erick.shepherd@ni.com>,
        <gratian.crisan@emerson.com>, <kyle.roeschley@ni.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc: core: Wait for Vdd to settle on card power off
Date: Thu, 13 Mar 2025 15:44:38 -0500
Message-ID: <20250313204439.1582652-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <802daedb-d82c-4d0b-8e69-d166c169cbb1@intel.com>
References: <802daedb-d82c-4d0b-8e69-d166c169cbb1@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: jR-Ma8FunrZo4In4KTW4fxzlQAhqxqXQ
X-Proofpoint-ORIG-GUID: jR-Ma8FunrZo4In4KTW4fxzlQAhqxqXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_09,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=619
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130159

> sdhci is used by a number of drivers (drivers/mmc/host/sdhci*)=0D
> that typically use the regulator framework to meet voltage=0D
> requirements. So that is not the right place to make changes.=0D
=0D
> It would be best to put the affected PCI device IDs into=0D
> sdhci_intel_set_power() as I showed.=0D
=0D
I see, that makes sense. The majority of our devices are using either=0D
Apollo Lake or Bay Trail host controllers. Would it be ok to expand=0D
your solution to include both? I tested the following change on a few=0D
of our devices and confirmed the delay is called. If this looks good I=0D
can submit a V2 of this patch.=0D
=0D
--- a/drivers/mmc/host/sdhci-pci-core.c=0D
+++ b/drivers/mmc/host/sdhci-pci-core.c=0D
@@ -610,9 +610,12 @@ static void sdhci_intel_set_power(struct sdhci_host *h=
ost, unsigned char mode,=0D
 =0D
 	sdhci_set_power(host, mode, vdd);=0D
 =0D
-	if (mode =3D=3D MMC_POWER_OFF)=0D
+	if (mode =3D=3D MMC_POWER_OFF) {=0D
+		if (slot->chip->pdev->device =3D=3D PCI_DEVICE_ID_INTEL_APL_SD ||=0D
+		    slot->chip->pdev->device =3D=3D PCI_DEVICE_ID_INTEL_BYT_SD)=0D
+			usleep_range(15000, 17500);=0D
 		return;=0D
-=0D
+	}=0D
 	/*=0D
 	 * Bus power might not enable after D3 -> D0 transition due to the=0D
 	 * present state not yet having propagated. Retry for up to 2ms.=0D
-- =0D
=0D
Regards,=0D
Erick=0D
