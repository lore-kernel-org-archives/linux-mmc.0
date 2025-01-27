Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CAE2905;
	Tue, 28 Jan 2025 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.142.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738024238; cv=none; b=pUI1KdXtqWZ1KLLsghWhY0Z2J1cZExKeut9Oj+eln/H2L1lag7+VY/2XI3I39fIUMCrE26+2yS/teFlvl7sJI++lLuqc99OALApebvrmAS8F+ClVPjPuO0Y36MxMBZv1trtczKyRPEoIB/jVLDy0tlgjTD7Wu/bn8caG+bU0ZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738024238; c=relaxed/simple;
	bh=oSu1No12DAXZ3ob8U8X0k6saR2iKLjftCokPHG6rzDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2arMJgxd0ciqwWIKx04PMoRN8xTUnIlyzjEfPv7NW9E/mX0rFphfqxS8vhI0PZ9Bz+Q44ZhWvFuI2Pl2nhgp0whCTvwnMiw3D0rUkGVnyGpLc66a/O9goFxbIi0+89n3IlwxCGcpPPMf7Jtjvdfa///0Yz0kAcvQPPXz7RfZHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=t7NSHVJF; arc=none smtp.client-ip=148.163.142.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="t7NSHVJF"
Received: from pps.filterd (m0144091.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RJXGA3015654;
	Mon, 27 Jan 2025 22:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=yWLMoIJAgq7ccgVoxQISOP+QpR+8l9Ft4+jA4PL35TE=; b=t7NSHVJFyuUq
	iLhjGQS2tGYw7b5ffbuZKXo3l9aK8Fq96Z/oKv5ylFaY4wn6B6OfXcZYcxGarPYA
	h56sBCEz9mT+4PVrgq1PMswi8jcH3Lg36zTRZh42QrbPYMcrlKSIrFmhkU31mCR5
	2poy1ue8UdgNGYZNQbMrj0KDi5AbVOqTaxqpsNHkG0D5BRUEAZe8BJX6PHR2RNW3
	a+lCYT3jpD0KDKlyYm1dIQu7Md8zcdxuonBpZLRpv2e0dK0jVtggw7p4nQ/cTIw5
	bi1E01SFqi3PsHYgBF9a2zWd7kJTW03cPXdbAu9vDnaTD9kcJKdWmjDVYmhcWl+K
	LywztFPoVQ==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 44egd7j0v4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 22:38:59 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 27 Jan 2025 16:38:39 -0600
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Mon, 27 Jan 2025 16:38:39
 -0600
From: Erick Shepherd <erick.shepherd@ni.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-mmc@vger.kernel.org>, <york.yang@csr.com>, <ulf.hansson@linaro.org>,
        Erick Shepherd <erick.shepherd@ni.com>
Subject: [RFC PATCH 2/2] mmc: Allow tuning to be skipped during card init
Date: Mon, 27 Jan 2025 16:36:54 -0600
Message-ID: <20250127223654.290904-2-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127223654.290904-1-erick.shepherd@ni.com>
References: <20250127223654.290904-1-erick.shepherd@ni.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FPR4O6EtQaVSx3utT-ouR29bxMZa2DBA
X-Proofpoint-GUID: FPR4O6EtQaVSx3utT-ouR29bxMZa2DBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_11,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=776
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270178

Add a new field to the mmc_host struct to track when the card should
skip the initial tuning and use it to conditionally stop tuning in the
mmc_sd_init_uhs_card function. Currently the new field only gets set
when a DDR50 card fails to tune, which indicates the card does not
support tuning.

Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
---
 drivers/mmc/core/sd.c    | 4 +++-
 include/linux/mmc/host.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index cc757b850e79..353715fd8f53 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -663,7 +663,8 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 	if (!mmc_host_is_spi(card->host) &&
 		(card->host->ios.timing == MMC_TIMING_UHS_SDR50 ||
 		 card->host->ios.timing == MMC_TIMING_UHS_DDR50 ||
-		 card->host->ios.timing == MMC_TIMING_UHS_SDR104)) {
+		 card->host->ios.timing == MMC_TIMING_UHS_SDR104) &&
+		!card->host->skip_init_tune) {
 		err = mmc_execute_tuning(card);
 
 		/*
@@ -676,6 +677,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 		if (err && card->host->ios.timing == MMC_TIMING_UHS_DDR50) {
 			pr_warn("%s: ddr50 tuning failed\n",
 				mmc_hostname(card->host));
+			card->host->skip_init_tune = 1;
 			err = 0;
 		}
 	}
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 68f09a955a90..91c4db6837c9 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -486,6 +486,7 @@ struct mmc_host {
 	unsigned int		use_spi_crc:1;
 	unsigned int		claimed:1;	/* host exclusively claimed */
 	unsigned int		doing_init_tune:1; /* initial tuning in progress */
+	unsigned int		skip_init_tune:1;	/* skip the initial tuning */
 	unsigned int		can_retune:1;	/* re-tuning can be used */
 	unsigned int		doing_retune:1;	/* re-tuning in progress */
 	unsigned int		retune_now:1;	/* do re-tuning at next req */
-- 
2.43.0

