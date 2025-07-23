Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43C2207DE2
	for <linux-mmc@vger.kernel.org>; Wed, 23 Jul 2025 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753306958; cv=none; b=l+TN/IHLFEaVIuma/G5m0zJ+4+4ZeR8G/gWCVxlaEWmAuBuiWecqidHdssQhE2rh3qcBcGjq+oJRGcf9aJsm5CqTGJRTGrXe8vXh1g+DD+JyVVCOrCKZkHNYKJk4Nc8yf15I0xEtZ1WmgtbKK6OY2f0Z5vFTkS8Y+tkHy3QcdKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753306958; c=relaxed/simple;
	bh=JYYVWItuW5+/7v30B2XLqotrMwoL5MCdveXIgQDHqwc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rTobO9QtjrrDzL6ZBxkNa10doYxjQLkBp5p7VRuiPDeHKGSfdD0W8RtGkuuZ3zieXF2DqJ1UpSMFe2HU+gIM1nkVjJGVChg3NVfn1ebESEecTeWNxk/YvS03bBvFbpfiiISofdMXaCY545pCiaV0SKwG0CjgcA67ezzsVK+drpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=hCONpHYv; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="hCONpHYv"
Received: from pps.filterd (m0484886.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NAjU0i031889;
	Wed, 23 Jul 2025 21:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS11142024; bh=HQ4P20EFDorQrZ1MVpmo
	W6Jf0Pf/nI9FkwnfEwEswj4=; b=hCONpHYvHOTTvqAZ1S1zYTYdHk/fQrHy/Zbr
	FyLmRH+xbIOEd6wtZZP5fqJ+fFZUHLojTyBq4rOcsDKXJNAzYLENJyGsqYnMztPV
	ch8YlHE5SXq8kSqFZvQj5wR08VVfANnAakHFfPDfryGyxftpPUOl8lCF9Ky66tcN
	HV6ImhOxnjEZXQpqj3Ec7a7iAtzqWIyv0ZY1GF9V8O5WA/jrq9LSgRI8jC8y91n2
	fvT+CDwsLG4Vq2ifhHTBqMIivaJLVzg0lSuDwNUPpEC8HOgw0qN3v5fKPnunbW+g
	XX+JJ3seUEHB0KQWzTEC4Kq8bNzRu+EKI0giZ+mNYzK6yDQYIw==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 482w3r4wdk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 21:42:28 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 23 Jul 2025 16:42:26 -0500
Received: from ershephe-ubuntu.ni.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Wed, 23 Jul 2025 16:42:25
 -0500
From: Erick Shepherd <erick.shepherd@ni.com>
To: <linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        Erick Shepherd
	<erick.shepherd@ni.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Brad Mouring
	<brad.mouring@ni.com>
Subject: [PATCH] mmc: sdhci: Disable SD card clock before changing parameters
Date: Wed, 23 Jul 2025 16:42:16 -0500
Message-ID: <20250723214216.3259-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: juZj7wfRAzRRDsKDHCzAHWyUFXArWH17
X-Authority-Analysis: v=2.4 cv=TJdFS0la c=1 sm=1 tr=0 ts=68815744 cx=c_pps a=cVKeW2pxJVqlUTLH3Z+MUA==:117 a=cVKeW2pxJVqlUTLH3Z+MUA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=gVGD3344AAAA:8 a=DHE891H7Gske2VlohvUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xQEvYfgLW3QvObN0DhJi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE4NSBTYWx0ZWRfXxgBX5ze0oHTH iiQoJ1QCWVWtpSm5hc8Wc9Vqb8oFHHJF8hkB0ExtdmyZ9eWP37+egDioYBukKSTO3WiM7ClmRq6 JmKlg4W/CukTxqzbtYUvCgf4HLtmlaAGcWM4fSBWzLK/enAeEDT25eFDHgrLn+VOLYfgFKHL3Fq
 ZCkSs370w1P0umlxft/kulFKBH91+Y+sFKLdSREk8qNw525NAkMeK4Q+XT68EW7Zusv4po5VxCV B7GX+FiNoDOZdro2yPsKqGvOgz3sT3CZ8W2TirRks4Z5WZDJ0gdRR7IrVdmbjbNTeF2+jPto9x6 NxyiGMsDdUzQwudYEtSVQCsW8h97fLTz41I3mdZCXrVwcNa/ehJ39GJE3rtzsOG6O94Yuq9CcY/
 SBNes9r1o7NDp48hvjSJ4ns2CG+B7NGK0769yt/p42gQHfDS+bTVQ1XLWHXOzBaUFVQwmeKR
X-Proofpoint-ORIG-GUID: juZj7wfRAzRRDsKDHCzAHWyUFXArWH17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxlogscore=885 phishscore=0 priorityscore=1501
 mlxscore=0 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230185

Per the SD Host Controller Simplified Specification v4.20 §3.2.3, change
the SD card clock parameters only after first disabling the external card
clock. Doing this fixes a spurious clock pulse on Baytrail and Apollo Lake
SD controllers which otherwise breaks voltage switching with a specific
Swissbit SD card. This change is limited to Intel host controllers to
avoid an issue reported on ARM64 devices.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
Signed-off-by: Brad Mouring <brad.mouring@ni.com>
Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index b0b1d403f352..d586dbaecae5 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -689,8 +689,19 @@ static int intel_start_signal_voltage_switch(struct mmc_host *mmc,
 	return 0;
 }
 
+static void sdhci_intel_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	/* Stop card clock separately to avoid glitches on clock line */
+	if (clk & SDHCI_CLOCK_CARD_EN)
+		sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN, SDHCI_CLOCK_CONTROL);
+
+ sdhci_set_clock(host, clock);
+}
+
 static const struct sdhci_ops sdhci_intel_byt_ops = {
-	.set_clock		= sdhci_set_clock,
+	.set_clock		= sdhci_intel_set_clock,
 	.set_power		= sdhci_intel_set_power,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
@@ -700,7 +711,7 @@ static const struct sdhci_ops sdhci_intel_byt_ops = {
 };
 
 static const struct sdhci_ops sdhci_intel_glk_ops = {
-	.set_clock		= sdhci_set_clock,
+	.set_clock		= sdhci_intel_set_clock,
 	.set_power		= sdhci_intel_set_power,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
-- 
2.43.0

