Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F82C28D82E;
	Mon, 21 Jul 2025 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091042; cv=none; b=pHTp9axwYkDdurQXMgKXrVFWxlV3xepApJriXpeR0j7/yttoVX8l11OSvWBxe4MPCUFprJxSOxVQdylH8T7mDKHvnpOGzy2s3wKskDSP9H7ZHyIfEDZi4lztmzi0FcTSSpr1DmF9ubIi4EVx1A3ybjZuVwMOV4D2/bVXT2jOo5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091042; c=relaxed/simple;
	bh=Yj7n7qknWPM7BD0ZFzNtOrfnM8ikFkSvHBGsIgH3dEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwpNR6I4YAGFEZRH7Nl6MwEt36he+5aIA8f7Hdz5Q3clhOaO32KjXj6mIdTJ2Sh08riHsPIc+KlIDY6kl9s+taP8KgBzSmayhZ1pJxD9ihjJzs5XCay64SCz4vjQus3mjLs3hmCtIrI7dmgOnVgC7eBwMCObS+IGeC5S5Xa2WyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QAKYi2oi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QAKYi2oi"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L8XXrr010702;
	Mon, 21 Jul 2025 09:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HQJyOZQMk8Nf+fLZm4IHsZMO
	oGvKxY1SXVjhV8RqIOA=; b=QAKYi2oiSf3Ov/eo1nIPdecyygAebtHaUc0UkYUC
	XNlSvpqLrg+j0PC7XMShE+3jRFLmMloMbjibJgqQsjtOLz0Lwkd9kgEbS/i49Er5
	SsN0vA0T0l1UL9KZZhM+VkJzXfOCGdRbIonQSGanrxuAQehGad5d0aFQgm0X/FUo
	QyXB/THwWaxxAWZ49Y3dl8LufzIZWuEtHy9xLm244RWqxCgOwtBC/UNNgvQOW2nb
	ty4O5HmwSvo2RgP5+jqHqaE8VJdRPZMAG0zv+tAo5265dYe5KtzJvM2Oz2ecXpxw
	nhZU8NQkaXe3m1dfO7WYmoK1PHSxZYELz/KEmtuA1NzAtQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481j500cq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 09:43:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56L9hpXq005870
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 09:43:51 GMT
Received: from hu-sayalil-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Jul 2025 02:43:49 -0700
From: Sayali Lokhande <quic_sayalil@quicinc.com>
To: <ulf.hansson@linaro.org>, <wsa+renesas@sang-engineering.com>,
        <avri.altman@wdc.com>, <adrian.hunter@intel.com>,
        <shawn.lin@rock-chips.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V1 1/1] mmc: sdio: Export an API to reinit the SDIO card
Date: Mon, 21 Jul 2025 15:13:28 +0530
Message-ID: <20250721094328.6556-2-quic_sayalil@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250721094328.6556-1-quic_sayalil@quicinc.com>
References: <20250721094328.6556-1-quic_sayalil@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oeTcVZk2DMp1L93nbVooq7WEK2-UAz8H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA4NiBTYWx0ZWRfX81a8vYMzLeVY
 LwXkvHQ9EP0C4UK5+GYjfzK1guK5n2KYTifTW4jNRzYllhQBLKfY8m63oFIVrsSnCb/3EEziDPp
 Bol3/E0XLubKITCFc6SMrVQdDTqJCEQlmWISC6x4f6IgYNY9sr1iHgTvFx/ec7cBTcz29mwkEFE
 V3MF5qhLGWkazwim3+q8gjONMBImafEfGbidqqi1YiF1FSs0hYdbKnh/aOoVghaFDvAyQI8z9Tf
 NMguNevZPfs3eJN/BBGTN3WZwFvE8KMTCorjolU08Z4qXye/i60vw+eJcdboWMaYbCZDpcDQFwM
 M3XxY+qTbRzBTh/m5JjG0tFQ5neqlDSEqX378v8qOr8ttINoNv8Pfp2CPZCwVWo+zY8rEIa4mWc
 ZG2fXI4noRbXXug6o1cOkrM1tRFjhil7JkjXqkPnIWRHTkD1XTEDeB5plmrQthy+NvayNCY7
X-Authority-Analysis: v=2.4 cv=CPMqXQrD c=1 sm=1 tr=0 ts=687e0bd8 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=flt_t2ij4EmPrG0qTdAA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: oeTcVZk2DMp1L93nbVooq7WEK2-UAz8H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_02,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 bulkscore=0 impostorscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210086

Some SDIO client drivers, manage external power to the SDIO card.
In such cases, the card may be power-cycled independently of the
MMC core's runtime PM state.
Currently, reinitialization of the SDIO card is tied to the runtime
PM resume path. However, if the card is powered off and on again before
the autosuspend delay expires, the runtime suspend/resume callbacks are
not triggered, leaving the card in an uninitialized state.

To address this, export sdio_reinit_card() so that client drivers can
explicitly trigger reinitialization after powering the card back on,
ensuring proper device state regardless of runtime PM behavior.

This change enables more robust handling of power-managed SDIO devices
in scenarios where runtime PM is disabled or insufficient.

Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
---
 drivers/mmc/core/core.h       | 1 +
 drivers/mmc/core/sdio.c       | 2 +-
 drivers/mmc/core/sdio_io.c    | 6 ++++++
 include/linux/mmc/sdio_func.h | 2 ++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 622085cd766f..737584fafd7a 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -147,6 +147,7 @@ static inline void mmc_claim_host(struct mmc_host *host)
 	__mmc_claim_host(host, NULL, NULL);
 }
 
+int mmc_sdio_reinit_card(struct mmc_host *host);
 int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq);
 void mmc_cqe_post_req(struct mmc_host *host, struct mmc_request *mrq);
 int mmc_cqe_recovery(struct mmc_host *host);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 0f753367aec1..fc3dda1a67c8 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -911,7 +911,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	return err;
 }
 
-static int mmc_sdio_reinit_card(struct mmc_host *host)
+int mmc_sdio_reinit_card(struct mmc_host *host)
 {
 	int ret;
 
diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index b774bf51981d..eae2fb361ec2 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -812,3 +812,9 @@ void sdio_retune_release(struct sdio_func *func)
 	mmc_retune_release(func->card->host);
 }
 EXPORT_SYMBOL_GPL(sdio_retune_release);
+
+int sdio_reinit_card(struct mmc_host *host)
+{
+	return mmc_sdio_reinit_card(host);
+}
+EXPORT_SYMBOL_GPL(sdio_reinit_card);
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index fed1f5f4a8d3..f33d0512b6a6 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -12,6 +12,7 @@
 #include <linux/mod_devicetable.h>
 
 #include <linux/mmc/pm.h>
+#include <linux/mmc/host.h>
 
 struct mmc_card;
 struct sdio_func;
@@ -132,6 +133,7 @@ extern void sdio_release_host(struct sdio_func *func);
 
 extern int sdio_enable_func(struct sdio_func *func);
 extern int sdio_disable_func(struct sdio_func *func);
+extern int sdio_reinit_card(struct mmc_host *host);
 
 extern int sdio_set_block_size(struct sdio_func *func, unsigned blksz);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

