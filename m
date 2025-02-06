Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900C1D2F53;
	Thu,  6 Feb 2025 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879140; cv=none; b=PxDxAMaCCjHE/KW/qd9zF7/S4WLPwqTCjqI9cWz8rpH2yGRUEQP1USxj8vOSr0dN5SHudoTOvrIInkwLAZQx5GkypDNDvJvwlWJJhWjk17ifCE72aJtVtAelmxYHZw+VUqa1mu+LWbGCPcu4rfMlZnJD+8/GGMmbnpd0ILR+nVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879140; c=relaxed/simple;
	bh=ZIeqTrvmbR9snqUYDscmNtkWd2EkzydSXkZq1MsgNEs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sExAU1fzqVnCxf0W8Z1h0VXURZSOcqMmh27znGoZGGEZzCMg66R1lTD0dMHhkh653Bgm2Gp/74zjhVCrlKHHzoaYCwTYM/LMsXU+3BKufWNevhe0VZdjKL/e2tQbA0A8IfCHFfhoBHiDW0t0y33B3yHMchsAmpD8u+vPpKNCI4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=cJ8WQMvi; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="cJ8WQMvi"
Received: from pps.filterd (m0142705.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516L4MU1008099;
	Thu, 6 Feb 2025 21:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS11142024; bh=v+pbfDrHMVpfCeucJRMI
	kMFUsZoz0NpmEnB1H+pTTzQ=; b=cJ8WQMvijGSbjLD/+ir4mftj09AsJlrwwz2p
	1EpneafcwOyyHWBieHPX8mT0bVMM7iqPp4Th0aQySSFIAe9vd/HdXE1Yz5FQXcJJ
	XXBwmWKZlMCY20i345ayoqf7uyy6LlkSJT1vrum9gIctIS1s+GVf5vWDab1VmQQe
	0ymgbfRI3JGfigAnPbpqwfKNlSIjJOQIeE5XIUU1ChFeEexMceVH8xGwWDinSe82
	v0gAzEKAYMdDfCWqxz/5a1r01fJIWmiUfhq4GnQIS0BBikcg9Xlv9Xe3qdh08hQJ
	g3ZxffoSxrepNAM914VmuY+Z0RhaGkj0bJp+/x1dO1muZgL2Cw==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 44n4nx03a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 21:09:35 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 6 Feb 2025 15:09:34 -0600
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Thu, 6 Feb 2025 15:09:34 -0600
From: Erick Shepherd <erick.shepherd@ni.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <adrian.hunter@intel.com>, <avri.altman@wdc.com>,
        <wsa+renesas@sang-engineering.com>, <quic_jjohnson@quicinc.com>,
        <andy-ld.lu@mediatek.com>, <victor.shih@genesyslogic.com.tw>,
        <keita.aihara@sony.com>, <dsimic@manjaro.org>,
        <cw9316.lee@samsung.com>, <ricardo@marliere.net>,
        Erick Shepherd <erick.shepherd@ni.com>
Subject: [RFC PATCH V2 1/2] mmc: Update sdhci tune function to return errors
Date: Thu, 6 Feb 2025 15:08:34 -0600
Message-ID: <20250206210835.2980500-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XZayGiEp20p3pI_7h3GSDPfBukwHf9Qf
X-Proofpoint-GUID: XZayGiEp20p3pI_7h3GSDPfBukwHf9Qf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 mlxlogscore=484 lowpriorityscore=0
 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502060167

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

