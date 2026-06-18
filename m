Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F27388866;
	Thu, 18 Jun 2026 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780027; cv=none; b=M82L3g1FiCCovt3iidBQyncCZ/n/8FFek3iqHcXk+PEVQN7vaiNDRqIw7BEWAcre1RZxutxIfH718zdSIyXIMvA47g02hIyIyZJyx/HYCszgnoF97YId8qhlALDqe93UvPCY5NlS5ZmOpiECq3VDybWNFJZbvPy+rH/KdAKldvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780027; c=relaxed/simple;
	bh=JJyNFVNj3A4vFc2n0hqjbDVp1xlI8/bFORGobDvSHyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kjBJpMYe61pqedETKS1KxIcXqks84C6kKHcfYvinfSQdAQD3JsLawM6oI8Ii83i7LUdFmmMSYvAQdvS220QtV5zLaTgs+7KpnmojJ6+1r/9/nphkttPW5LeJ2EBYs7rbh3k66CyubNx4Y+N1df8IBwn0EsCI6LAr0S6sXR8cVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XKqEiq2s; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XKqEiq2s"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I5dVAv2396252;
	Thu, 18 Jun 2026 10:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ch3U8Il20UNELvEAFr3wRz7Wl8Wqy
	+5Sq9RvZuvkq24=; b=XKqEiq2snekCPfsqvXMf9B9HZyE/xxd87inZ5/5UX2/Dc
	XJKfigqH9B8uN916TU0U8WkWjOHroVx4N2QHVOyb4RboD9URFvoW9d/lyMsmEAl+
	nUc3mCTv5eXKpfos40D1e1uxw7AgwoNnM6JowfsAnvef4VjTUVkYm+dpGsVH8Eer
	bKNqRatPKNVvzYs+jQacSxKEK8QBjCsnXGCN8mxwwqj3AQhe59fE6YLyFVU4vRis
	a1uHL6KKGtzq4S9EKRoxW+YMH7oI5/FRBN1XkatuPFPF1RQkg3qL3mmakzxB5amx
	57g8ABr+lgdYHJFW9hmimTCmhvX2nafoOGQkLG1Kg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4euefy2awj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 10:53:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65IAra9w031645;
	Thu, 18 Jun 2026 10:53:42 GMT
Received: from brm-x62-22.us.oracle.com (brm-x62-22.us.oracle.com [10.80.150.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ev14u0utd-1;
	Thu, 18 Jun 2026 10:53:39 +0000 (GMT)
From: Satyansh Shukla <satyansh.shukla@oracle.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: dwcmshc_bf3_hw_reset: Log eMMC reset calls
Date: Thu, 18 Jun 2026 04:53:19 -0600
Message-Id: <20260618105319.217717-1-satyansh.shukla@oracle.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606180101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEwMSBTYWx0ZWRfXyb1xbjCyoBsM
 xs5jWFNSM2JucvznF3hsl5xMjKjoEAN4eRD7rVa0kUJU4WnyZyKJzoEpA4FjZXLp9mivv2nGmH2
 8R4gpfLxP13Y0RD0xjrG7DUT/iLeoRFgIbxTcsRqI+ayyTub6+d77M+B44ygqQxVKQOF+66fLSR
 a/FTBN/X+5k3TQomHAd3zw0pOoUZfgGMYvu4DOyKauDbeSUGvEfIwQBbTC4NBXbVunYJQV6sUyn
 zwBdXUMQkeNEvWG+Ugy+XXh3XKiNGmycVOm/jMoDzKXbHlzryka9MZG8rGgOHJqBwfwTRCMfw5E
 XuqEi9zuq/ExhgfBlzhAPlKqjLmdQ3BWUGjmJu5xavKZev3hpvKR3zFtCza5mD16vCADlDNVo07
 a68iIlg+CB+4tSxrbt9KzhUyenogVDajLSYpofdpdEhmkupCzBvhgyX8SVqLJiJAD7jLgFShdZF
 8v2BddH7z7UbIi8+V34c9o010tQD9qX+NZXb1i0M=
X-Authority-Analysis: v=2.4 cv=Xt7K/1F9 c=1 sm=1 tr=0 ts=6a33ce36 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=srqlFv8YiyK0XlN9uJMA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEwMSBTYWx0ZWRfX/jeHQAcb/+JE
 V/58G7V3yGeA5zTaImRrpfjkpFDM4tJeBuVu3LZpcQAYpx8GAtJXtHKABkBdiPdZPd6Tf3sTo9s
 mEXKK+lheJoiwY0WzkbPCKuignM+BdrAinxtBj3dzptt5Vnadtok
X-Proofpoint-GUID: P6CeYajIhSYljUvoBGwgaMM6cYPkFQI-
X-Proofpoint-ORIG-GUID: P6CeYajIhSYljUvoBGwgaMM6cYPkFQI-

Log when the BlueField-3 eMMC hardware reset path is invoked and
whether the RST_N SMC call succeeds.

This makes it easier to diagnose cases where the controller recovery path
depends on issuing an eMMC reset, and helps confirm that the reset sequence
was attempted on affected systems.

Signed-off-by: Satyansh Shukla <satyansh.shukla@oracle.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index b9ecd91f44ad..8acd4652a12b 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -2019,10 +2019,13 @@ static void dwcmshc_bf3_hw_reset(struct sdhci_host *host)
 {
 	struct arm_smccc_res res = { 0 };
 
+	pr_info("%s: resetting...\n", __func__);
 	arm_smccc_smc(BLUEFIELD_SMC_SET_EMMC_RST_N, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	if (res.a0)
 		pr_err("%s: RST_N failed.\n", mmc_hostname(host->mmc));
+	else
+		pr_info("%s: RST_N succeeded.\n", mmc_hostname(host->mmc));
 }
 
 static const struct sdhci_ops sdhci_dwcmshc_bf3_ops = {
-- 
2.31.1

