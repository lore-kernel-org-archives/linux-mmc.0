Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B0C1DA10C;
	Mon, 27 Jan 2025 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021591; cv=none; b=tq9mXB8L+WfTFJkPXs05BylM6+DK7yp7061gJm8QniFcU5+UYIrU14AuVRxDohLemhzNoy+IcFXiz5e6uT9CqrFXCVuqf2RBoA9Gjmf/4LcIEp63vpOyWCCvw0RP1ezF5uip1LBRB6bhPPF01gF3ui/lJjl1GREJa9FsEXnSPV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021591; c=relaxed/simple;
	bh=ZIeqTrvmbR9snqUYDscmNtkWd2EkzydSXkZq1MsgNEs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F2tde/YtKQGLfKyafAZAJQi2SwZv2LyVtwgQrY0zh5f9l1bn8r2Js89ye2QBjWNxo86kq2IOIfnhGRO/fWhjPafCdrmBn6zW64cGEQi2xWEU1icLHokZHaLwMpWAX1sD5gbebBcPNdnkigV8F430B+7taHH5xpFMJnm9//F5jnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=D9ue6UdD; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="D9ue6UdD"
Received: from pps.filterd (m0359308.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RLPNSk016928;
	Mon, 27 Jan 2025 22:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS11142024; bh=v+pbfDrHMVpfCeucJRMI
	kMFUsZoz0NpmEnB1H+pTTzQ=; b=D9ue6UdDXGIXuCTp0Gazzik35BVXaAhzBO6v
	Uld6ZwOqzuHV015I7v006I8SIKiH2Yk2aMm2TLa4aBTwNnf34g9ZggD4LW9amNQ9
	H0kh2rNQXJ6ZVryKRY5iKUN4xdbkQ/J2TuEPAzZ4RXldizK2VQkPX4pquoIh/yys
	JeHCIeYWgiGfDAAadpaEu6TRI1dO+GbgI/CusSEHMTh7Gda9TFoJnGqejUCyxLaE
	VIBL0THDYdxtrkG8cWTl2bJcNa2fWOBGtLLLLQqOUVr7ZEdrBOc7BJ7gIHjP42UM
	ayUWmAJZQ6JyW7WNuCm0HVkRmoa4nKLZk4Rjs5QCyIrL/ovR7g==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 44ej1y8sc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 22:38:25 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 27 Jan 2025 16:38:24 -0600
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Mon, 27 Jan 2025 16:38:24
 -0600
From: Erick Shepherd <erick.shepherd@ni.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-mmc@vger.kernel.org>, <york.yang@csr.com>, <ulf.hansson@linaro.org>,
        Erick Shepherd <erick.shepherd@ni.com>
Subject: [RFC PATCH 1/2] mmc: Update sdhci tune function to return errors
Date: Mon, 27 Jan 2025 16:36:53 -0600
Message-ID: <20250127223654.290904-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fDDuOaCe8ImDrnlpF02lRhZdD4oEkbbV
X-Proofpoint-GUID: fDDuOaCe8ImDrnlpF02lRhZdD4oEkbbV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_11,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=372 bulkscore=0 mlxscore=0 spamscore=0 clxscore=1011
 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501270177

Updates the sdhci_execute_tuning function to return the error code
that was returned by the __sdhci_execute_tuning function.
Previously this code was only stored in host->tuning_err and not
actually returned.

Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f4a7733a8ad2..b35b8917fa1e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2967,7 +2967,8 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	sdhci_start_tuning(host);
 
-	host->tuning_err = __sdhci_execute_tuning(host, opcode);
+	err = __sdhci_execute_tuning(host, opcode);
+	host->tuning_err = err;
 
 	sdhci_end_tuning(host);
 out:
-- 
2.43.0

