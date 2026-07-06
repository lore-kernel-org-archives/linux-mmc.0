Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057842B73B;
	Mon,  6 Jul 2026 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341245; cv=none; b=MZCWHZbnILbyed+uRODhmZRcAfnAhQGSQhmzzdoThiVi7NGFGz6BYxlL1Z3eieROBs24o8mWwD5zJfxrhkX3GeFK2idab1jzXEPdrzZ1tisdsoifynZsoqoF3TrhnuU+i/BvGVhlN7Ew++1jz1ReRBR2k6OEDXG5aTp9p8keRjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341245; c=relaxed/simple;
	bh=lv4pNqlV2LLOtBngZ7+0w3lB9ZgCFolGueEZwb+eXvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZTqIQQ5pifvdX3MOik7QJlLZnLexuCPDG/7n4cvSYSSKjPVxwqy65znwb0kk6kQ8Fqtzvt2LaFZNs3NeFwkKyT48Qpo3dfo/vtu7cluO1ogXIEi+iJbGl5+hmFOc2wJ74fkGX0dFEUOhyT/m7kYmkSTwH49fLESvaKDgWSB3X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fBIdC2gZ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fBIdC2gZ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665NK1G31009311;
	Mon, 6 Jul 2026 12:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=a5qBw
	LJ1SiydWRWopG745VRT5VPXZJlVmFigbrSfY2s=; b=fBIdC2gZxcPeX7qxAyUTj
	g/WtjvHK6LdS1drFPzmpvYvAnyV7+IdZqMj7dD4UT/+pivZCt1OD18bf8YBGjvFS
	q8lKc1ifnQ4D5TGTCEk5hYu3wRrs3HbF5wOx2vz/An8KAs1cDznhFLa0G2gpch+k
	rbWNJKoWmBtAbzDzx0NKFp9E3yuU9JD6ohIcmYNTEgcovfn0LK3gVhYfFREhlXSA
	5k+nEla8zN1WwN13kRTaDBbyoDlPmUnj8vBlqA818Ur9B+T5Z07rQXAYcH30R/Me
	DUt7Iu/BIdBhS5uIHqCUkH2+rZ1g2SoSjE0op7mqTXHjcduP7B+xpYF/GbGKcuhO
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6rkbbmsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jul 2026 12:33:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 666CXXn6005634;
	Mon, 6 Jul 2026 12:33:59 GMT
Received: from brm-x62-22.us.oracle.com (brm-x62-22.us.oracle.com [10.80.150.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4f6rmp3244-1;
	Mon, 06 Jul 2026 12:33:59 +0000 (GMT)
From: Satyansh Shukla <satyansh.shukla@oracle.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: dwcmshc_bf3_hw_reset: Log eMMC reset calls
Date: Mon,  6 Jul 2026 06:33:57 -0600
Message-ID: <20260706123357.1512192-1-satyansh.shukla@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <3425c3da-86fd-469d-a3ec-7805138d3e2e@intel.com>
References: <3425c3da-86fd-469d-a3ec-7805138d3e2e@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607060128
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOCBTYWx0ZWRfX+meTPp/9wNil
 40RLBosHb0Cwh0tCHXK8nj3h7BvDDCWzP2oTgoGytKQfAYL5QRbQ93qOzAzOIYto3ZRLEI15nKj
 tBvmcJvXlXxvaVjU8EXgvj8p7UNkcx4i+b7FqUOBWYYfCbObPig9
X-Authority-Analysis: v=2.4 cv=QP1YgALL c=1 sm=1 tr=0 ts=6a4ba0b7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=n9bOmymY_TfqcxJohPcA:9
 a=zZCYzV9kfG8A:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12221
X-Proofpoint-GUID: WJx4zN8BrkBTUj58IY5crgsgHMKkK8e2
X-Proofpoint-ORIG-GUID: WJx4zN8BrkBTUj58IY5crgsgHMKkK8e2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOCBTYWx0ZWRfX0KdGKkYAyEde
 pKdpy3hW6WA6gmxARAxEdJkxAVd+w5j1Uz21sFGp+t9tjL4E2+8AObNhdb6sZTLZ/hfLTV248vY
 Ssw2Pt6y8PggZL7gyG1sblXwStDcsaWu5HLwYfPlbmskICE8RQ/NejvZjz8OOKgaSblN2RMPj+E
 P8KOFhLQUCl5v4/pdoBQQa2vk9NK0tdECs412MNMG1PLj6Mi3mH6Lub2wUkVCQUthVC095libQK
 E15qX77Ab1oo1wRq+d7mahOMj6KaVw2O1gUAW2kbv2QsJ/rtRhETRp09/MMALZJG8no9ni4oeWc
 h7Bpk2CAD5QWIXQCPjC3ij3tG87hSo5+kxm6wn56lcxHmnBm9M9/XoIMpjv7LwC3rI8c5Ko+d19
 6iD0ztEWenJ+HFvhNuKiPWlYIbPmcQtY017/WxVcd0cVrOLycPsiwvqDxLTVGBseJqMD0Tu4XyQ
 ZlXGWWGr3FzMuX29jm7lwyUFYtsEXngeiL9Ima2o=

Log when the BlueField-3 eMMC hardware reset path is invoked.

This makes it easier to diagnose cases where the controller recovery path
depends on issuing an eMMC reset, and helps confirm that the reset sequence
was attempted on affected systems.

Signed-off-by: Satyansh Shukla <satyansh.shukla@oracle.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index eef53455b8ee..a01668b66e7d 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -2013,6 +2013,7 @@ static void dwcmshc_bf3_hw_reset(struct sdhci_host *host)
 {
 	struct arm_smccc_res res = { 0 };
 
+	pr_debug("%s: resetting...\n", __func__);
 	arm_smccc_smc(BLUEFIELD_SMC_SET_EMMC_RST_N, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	if (res.a0)
-- 
2.43.7

