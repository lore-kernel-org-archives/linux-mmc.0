Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FF205E02
	for <linux-mmc@vger.kernel.org>; Thu, 24 Jul 2025 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383253; cv=none; b=gSmNpqWR0AXcRR7/eud8J+n3SkS06tXPW5zAXlVRiTjXpbXQiSYtmVO5xKZhkawi4NmgkHuM9dew6D7aBm7LH3pwbD9TKnKsYr7DGqAzpGa1mZokaD77Xjf2fr1v9dCaU3wnX+Rqe6VkIGAp6lmRMwilgWmm499wAQvp/7oJ+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383253; c=relaxed/simple;
	bh=o0blOYLJr8IchlLvttLCXEt83aJbncuGmR7GKN3zGfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akk6ruvWrkWHTeVWuhQKvf3AjrbclazckqcetqRMYwgAUs3o1h2lwtXEK9qMNHfLB/faaEjlx06zOzizhYKqvsLpticgyGzcU4fdG/dJrf0FRL/+UuiN5ntQrXLlfvsqta9caKRok9Pn4CAXZXZydFNH/glvoH+rMo3gnICZLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=vFD/+0F0; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="vFD/+0F0"
Received: from pps.filterd (m0484890.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OGqtLh014956;
	Thu, 24 Jul 2025 18:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=at+ZRyTlpVBvyV/ioXlj2Oiiq8XXh5zMSf+NhZzSK1A=; b=vFD/+0F0N/+1
	rDmE66D/cPQWQnfD7cH4yma1BCTXuFi2s6CquCKEjyf0QRVvJV5duQvyuffZovl0
	xdiXv/DIuPpPzUmWRwj3m6aAReseZ6uWn6Hz21iX3GqWKGXSNn/dotDxdzaS8mxp
	uXV/Kz+P+Ey5mePCrcLARmm7J4mJhjhD191s08WD3OYLCKRzTsZ0SWAQ0jHGz7Zl
	A4AAVnQeNzFDSKawz7IdKXJddqUVthLJ2vHAtRrUdLZ4f7JpeLoq1NpWG13lbKBh
	iU1pyPdzff//+Aljx37i0WmfPhSJJ6H9IVtKFuIEGtTmt1geEstaHlt6GUOrD6G7
	sHw6QL252w==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 483rr7rsb2-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 18:54:07 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 24 Jul 2025 13:54:01 -0500
Received: from ershephe-ubuntu.ni.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Thu, 24 Jul 2025 13:54:01
 -0500
From: Erick Shepherd <erick.shepherd@ni.com>
To: <adrian.hunter@intel.com>
CC: <brad.mouring@ni.com>, <erick.shepherd@ni.com>, <kyle.roeschley@ni.com>,
        <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Disable SD card clock before changing parameters
Date: Thu, 24 Jul 2025 13:53:54 -0500
Message-ID: <20250724185354.815888-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7b124fe1-4f7b-4218-b564-e16ad2c3882f@intel.com>
References: <7b124fe1-4f7b-4218-b564-e16ad2c3882f@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kR9M-y0F9BF-mkGu7UleupBFhd5oKPPZ
X-Proofpoint-GUID: kR9M-y0F9BF-mkGu7UleupBFhd5oKPPZ
X-Authority-Analysis: v=2.4 cv=OZWYDgTY c=1 sm=1 tr=0 ts=6882814f cx=c_pps a=cVKeW2pxJVqlUTLH3Z+MUA==:117 a=cVKeW2pxJVqlUTLH3Z+MUA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=gVGD3344AAAA:8 a=DHE891H7Gske2VlohvUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xQEvYfgLW3QvObN0DhJi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDE0NiBTYWx0ZWRfXyqgW2DM9go1v sWmgQ89flh1cXhObcSjuVsMvle0sy4Feu9tYebjvMgH5aTK2B4VE4r+L99KNfKxN7XgnmOVqIJD TEZ7cdjxT14XeR/y3i4bE1RwtixyhXqSbsYwSSu8vOwts6/c3DrV7WWm96DpsOhE1wgs/ypGNRA
 OTOmGFvDfmzT1nPNf2niO9KlVlKWnFrX+lAt1RO7oCSCCTDwxvQS3ItBdae1HFbXMDlDxI8+Pwz pYIHfvMSZ9Bc59IdBnRZFjingScbO5GXVzHhVW2hh96zeeMu0AkM9NeVaJomi0BZ7zDioowYO5F IWQfOy8DduzQVPHiPIOZlePL0DkRG7T3bMcqdcziSbgnqHO/Lfr+2rqbzfitvy+h7WDJ2b5+cTH
 NaAW9IFj+S4ZuHq1F7yDeHDWvJ0OQjK0zvmSl4axMXqHo14aEgldIE3zAc/BHBgx985L9D72
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=851 malwarescore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240146

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
index b0b1d403f352..7ef821d16d39 100644
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
+	sdhci_set_clock(host, clock);
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

