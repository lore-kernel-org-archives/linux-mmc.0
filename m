Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA11EE7B9;
	Tue, 11 Feb 2025 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310399; cv=none; b=kbkedI+YhoeTYmXXmls//GDsDVbYRa1QaP60FAZuHLs36A2EoLqOiVbdlJfxquyDEtuYp7mUzBXh0gQeuFVyjZiI3zibK9dD6bCJ+S80mUvcZEuRgMuqSGsMiNh8ZLpDeyOwR6xQBlBEN88A87ilFW2DW1qPqD+40C3K+Djwu5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310399; c=relaxed/simple;
	bh=Z0Pk/eqoTkNBxDbXqmYLRjAjpntoKnoBmzRL1Oh+ZNc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lZg38npBlciJT2klcE0qtjuRH+dmUTiXaNSJwJQk23hh/3Fy1tex8ARQSp+NuYNtJu7v6j+25tWvQ9RRR6yRuqQ/vuz7HM0Mfvz6Gg7JYhe6VQcr+Vm110zFiXCQfHDMOitGge++W06Z/lW4EWl+bYRhBptqNHmOYiwW/UOFvZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=XT2akeMN; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="XT2akeMN"
Received: from pps.filterd (m0142705.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BKHxvJ040484;
	Tue, 11 Feb 2025 21:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS11142024; bh=D/zJ/hJDbT08mo+04qle
	vs+YHtGJj8evEeGLk8ycKLA=; b=XT2akeMNuDCbcfIY6AOjVlZAQPwdkcyVrteJ
	DBt941ioCuHNttySmsVg9viOAS7c5TBnB8dOMTfXEzTvvZxhYFVsdgSuKPoCUZba
	ana+zFzS52kyd+md/XgctsjZE9YTj92Be7fEqop/KgH85xFJX4hUV3O3q+lH4lS7
	Ypp9fXjDLUmll8Aq1l+zBbx4WIVduJMciKYdrheIVej5yQ3PHepQJLZxm4W0d6/S
	F5yNmgz48GUiYzXXJG1yh9umxI9kPbU/vX4t4ENxhzFQrDPHxEeAJhjdhq5+z7a/
	gneWB5DEtMYTz6B96WDpUrp+exaub+1v3HKKkeuf2YNy42GnGw==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 44rchj9yvw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 21:46:29 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 11 Feb 2025 15:46:27 -0600
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Tue, 11 Feb 2025 15:46:27
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
Subject: [PATCH] mmc: core: Wait for Vdd to settle on card power off
Date: Tue, 11 Feb 2025 15:46:11 -0600
Message-ID: <20250211214611.469260-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: b9RayU3FwZUiylKG_K_XHUMs7_Lx4pZW
X-Proofpoint-ORIG-GUID: b9RayU3FwZUiylKG_K_XHUMs7_Lx4pZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_09,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=803 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110143

The SD spec version 6.0 section 6.4.1.5 requires that Vdd must be
lowered to less than 0.5V for a minimum of 1 ms when powering off a
card. Increase our wait to 15 ms so that voltage has time to drain down
to 0.5V.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
Signed-off-by: Brad Mouring <brad.mouring@ni.com>
Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
---
 drivers/mmc/host/sdhci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f4a7733a8ad2..b15a1f107549 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2415,6 +2415,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		sdhci_set_power(host, ios->power_mode, ios->vdd);
 
+	if (ios->power_mode == MMC_POWER_OFF)
+		mdelay(15);
+
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
 
-- 
2.43.0

