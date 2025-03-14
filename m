Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7701624CB;
	Fri, 14 Mar 2025 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.142.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741981856; cv=none; b=d8sa9X0piKvznhHJJyQbC+lDlkmxvuLuGikS9gJJls1f0NEWHHRsoC8VdSI0FM3LwgwfIKHPT+y8pGhYbhTJ1P39azSUUrPJCfiia9lhM0z0Tp/Gxx+m1FUMaw48tjhJadzJooFLbMeDFmkphxqG/YhTopsHaInPZdhmBlFckfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741981856; c=relaxed/simple;
	bh=8qJT89Lf6Lbw/1ws3N8JEt2NsZOEWmh6WXL4jB2ewZQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EpKC8WQY/FtAiPvngev38Ic+iwY4m4aFukSPAytQFEGnPq7Uo0vbhSG7Bg670qiBmTh3x8X6qcamNj4CNuO3mIanhN7wBRgrmz8ePNks+8pTvF3wQVkEIERSv1jAP9+jbsPCyxeJu9qvDl3dp5wzWE5QXG6iy/EtnGW0PFpEJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=lDpoHH65; arc=none smtp.client-ip=148.163.142.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="lDpoHH65"
Received: from pps.filterd (m0144091.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EE814c029599;
	Fri, 14 Mar 2025 19:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS11142024; bh=ZBzgtNtsJfr+jyUfmvSN
	Q+N6CKgkDldcTnrHXjqMNCI=; b=lDpoHH65PRKIBCKvkrAuYMJjU1qf8GF3qBD7
	GTOxLz5y9F/OvsbwmQBVM2jX1xAG7xtS++hHGm4lqhb7SSq9E4oH94xbjXLrKtN0
	+ed1kSvGofIxQj2zAVYx2NJvJsV+ioIdi+Ti9g6DugZlnq7nJ8efA+Wp902qex51
	gLXMvsDyGOYjhVYDoJhETa0cEz5QWwk7ZU5WQ4y9QeffHlzy8dDQwSXQ9PMiKr03
	vsQt36bPVBJsAlZlFDgPvUa9siOHnGRckMz2dAqC1dowezV8O9JOt+G/D4Ev8aI4
	Z2zKxjqV8KJpqUEsgw2Cv430rTtcvHun0+EpKuj9waLYShSCew==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 45cnxtvucn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 19:50:44 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Mar 2025 14:50:33 -0500
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 14 Mar 2025 14:50:33
 -0500
From: Erick Shepherd <erick.shepherd@ni.com>
To: <linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, Erick Shepherd <erick.shepherd@ni.com>
Subject: [PATCH v2] mmc: host: Wait for Vdd to settle on card power off
Date: Fri, 14 Mar 2025 14:50:21 -0500
Message-ID: <20250314195021.1588090-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Yc65fUx64uuyvzvsmDWIXLTzRFQj8XRt
X-Proofpoint-GUID: Yc65fUx64uuyvzvsmDWIXLTzRFQj8XRt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_07,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140153

The SD spec version 6.0 section 6.4.1.5 requires that Vdd must be
lowered to less than 0.5V for a minimum of 1 ms when powering off a
card. Increase wait to 15 ms so that voltage has time to drain down
to 0.5V and cards can power off correctly. Issues with voltage drain
time were only observed on Apollo Lake and Bay Trail host controllers
so this fix is limited to those devices.

Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 1f0bd723f011..b1f7c11ea61e 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -610,9 +610,12 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 
 	sdhci_set_power(host, mode, vdd);
 
-	if (mode == MMC_POWER_OFF)
+	if (mode == MMC_POWER_OFF) {
+		if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD ||
+		    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BYT_SD)
+			usleep_range(15000, 17500);
 		return;
-
+	}
 	/*
 	 * Bus power might not enable after D3 -> D0 transition due to the
 	 * present state not yet having propagated. Retry for up to 2ms.
-- 
2.43.0

