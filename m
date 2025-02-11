Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7711C26771B;
	Tue, 11 Feb 2025 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310464; cv=none; b=fHYEgNjzVQMczIjtYmpFnZhq0O1NwumrEPcUtAy64cq1O2Z17hPNe8y2/J9zuXAkqMsCO1HVdDmYjepelxJtEFdIKcFoaNK3KjUQLi3ptqy2p+08VqzFXG4XH3B3XG2kgO/UG3bHxiP3zYHKgZKp1PTo9YuwV7X4cQhpt/lZYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310464; c=relaxed/simple;
	bh=coqMg6R4RSna49dlawnOAeQor7Prt0yPKUxSGPFA8eY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TvTTDswgYeQgEDybdViNTizoXHMdmDHRieUab8CFiUyg9R88o8dpHz4zmtUutlqS30ooFFosKft5MK7QbB5D0MJTIr5etiwkkZzwS5xiB/0CIoDExIJ7tiK68sN5PXkVAAfHniRFzmT00xLgKSHDoZLQvEL0Xt9UrHlTKC7iOLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=beqzTGUZ; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="beqzTGUZ"
Received: from pps.filterd (m0359308.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BKitjD028129;
	Tue, 11 Feb 2025 21:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS11142024; bh=PfY/o2LEZ82A6MHkTD5g
	3kz8S6/9nqqtXO8mUdjoLBc=; b=beqzTGUZLggWQbkynxESm/exN46N0WH4DOB9
	NQZC+mHskXcNrjC1+Cuou7B8RqNS4QRQ5Enb32TxKx9gTf/I5azbkvyqPQjSFoVU
	61pww+6W0zKKFqerBBqjSFVFZTf6SxaO4KMMGbYQWiE+EWzgVJ1+JeKPMLmebAD+
	xecTFdtJwa6TZVVPyUA3pEqG1mZq+fGsER+hbLaU+aPrAvJbJV4e8tMustNGrhGy
	VhWBhuEmvSBjddb/FlqZqVV3VTRHiM/ZfQELdlg6i8TIRQlrtdpiDpCDlBDdbak8
	gQ7MAY+vPO9xUEMpV8XpK37vHb9ybJDzyq2NwwYq+IaYC4A0fg==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 44rduv8r6v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 21:47:40 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 11 Feb 2025 15:47:29 -0600
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Tue, 11 Feb 2025 15:47:29
 -0600
From: Erick Shepherd <erick.shepherd@ni.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <adrian.hunter@intel.com>, <gratian.crisan@emerson.com>,
        Erick Shepherd
	<erick.shepherd@ni.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Brad Mouring
	<brad.mouring@ni.com>
Subject: [PATCH] mmc: sdhci: Disable SD card clock before changing parameters
Date: Tue, 11 Feb 2025 15:46:45 -0600
Message-ID: <20250211214645.469279-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wZTGXKVQnpgO2u0HRB8QVwEnC_g-8fSk
X-Proofpoint-ORIG-GUID: wZTGXKVQnpgO2u0HRB8QVwEnC_g-8fSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_09,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=629 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502110143

Per the SD Host Controller Simplified Specification v4.20 §3.2.3, change
the SD card clock parameters only after first disabling the external card
clock. Doing this fixes a spurious clock pulse on Baytrail and Apollo Lake
SD controllers which otherwise breaks voltage switching with a specific
Swissbit SD card.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
Signed-off-by: Brad Mouring <brad.mouring@ni.com>
Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
---
 drivers/mmc/host/sdhci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f4a7733a8ad2..5f91b44891f9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2065,10 +2065,15 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	host->mmc->actual_clock = 0;
 
-	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if (clk & SDHCI_CLOCK_CARD_EN)
+		sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN,
+			SDHCI_CLOCK_CONTROL);
 
-	if (clock == 0)
+	if (clock == 0) {
+		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 		return;
+	}
 
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	sdhci_enable_clk(host, clk);
-- 
2.43.0

