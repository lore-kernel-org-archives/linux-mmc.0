Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAD5386438
	for <linux-mmc@vger.kernel.org>; Fri,  3 Apr 2026 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775213997; cv=none; b=Xndz5JVmlDcUrlip2u1nvcNjxKRnA8a86FPALeMAwoYSJs7S5ao2tWvhdL/Rlr1LnNUXq+bg0ZyuVM2pKAzhXMsmGAoeKAo26f8+4th1ExA9q6qHyeB4+oJqy8IVnR50mOLenWsmfszQ4hYAlwXN7zW1OddXJRphDUqq80oJN5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775213997; c=relaxed/simple;
	bh=SzXbUyLGlJXV2xRhynFBu0lZGEKyuQADxPDLqdtRktw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WDho/LQ9I8dX1LTTJtLvqUtFEeelaHCJ4xlannHD7BbuvjTOF0xpvtTMfeIgLTvHvomfgV5UVDeGbSAt7Stow/6AHc2Ms8YTZ9/+UzzdjJSegEW8o2XbfGNcFE/rFFop0wFGTBZd9sXB0Z1xP6qMMsUKVx8khw1RgslVGRkz9A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=io0DNUhA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cLAyeFwK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="io0DNUhA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cLAyeFwK"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63342mDi3780646
	for <linux-mmc@vger.kernel.org>; Fri, 3 Apr 2026 10:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jp3UsrPfBUdChQOLHTMkYPwGOmIvwsw4GdO
	3IsGCFXM=; b=io0DNUhAuVZfWA8/HJRuwezjyyAhDQ1SWq/rJfd8ehl4X42HpQ9
	7dHPArE2l0ccZrtlpGQCJWmqCgWtmRaSjp7Uhh78ERUTyyL1gClFJ6rLt5VMV+9k
	A+zvEVtodCpoSmZJDaQonqPLszaaZ23t19VilmyNdeJxA2xiOnBJGd2RAl+Rmsqg
	g6KsXSI0K75cKfBdsUWvRdvtDRj7YN3OS+OxWhl4KtySdHMoYR2FYefRcA8TmNKr
	Ku9dy0zLrvBVQnZI1M0SMFXadiLklOQ7dhC/3KFoXeZCHWxDXBjRAQ72wxBiZqrT
	LiNWHVC9TsJEq4fLfQ1KcZXJtk7EHC9ku8A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4da663h65e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Apr 2026 10:59:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b0f4e632caso26030495ad.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 Apr 2026 03:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775213994; x=1775818794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jp3UsrPfBUdChQOLHTMkYPwGOmIvwsw4GdO3IsGCFXM=;
        b=cLAyeFwKtjHJF7wSBpedCkKECaA7/sg3tuHpPvdFoshIiuMfAd9yFrrELqfd77K7Rt
         Fyh8iMyC9G5U1WgD+0mR0RR8wbY1xN6B2/EP5bPvImpV82M8RDfalk4oXfNVhN9ZLaeg
         CGOPnGmDgGfBYCkx8WU1z7dYsCvSC15mSAUlYIWuqPZ3RXODo0E9HdI4DikB6BOZTJRX
         jaEAM0lZUt3vSw/DawgzUXfk5tMRnFGPqe1w2rYPCBz3tyjeV14tsCBJM4+T6WzFQzGU
         goR6uQWs8T4wnGgO65KvUfidiE6PoWqvfMoSWehfNjuK/jR1EteMubVDxYzBAi9Ht+zt
         1QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775213994; x=1775818794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp3UsrPfBUdChQOLHTMkYPwGOmIvwsw4GdO3IsGCFXM=;
        b=i1p5UE0dQC496vO7Qk3EL2hSmx1X8JlvKm66ODUg73FTpHhyXB0I541jbmQTXq3uHZ
         hnpmaqBf8P9JXESO3md+1wzQC508v4wYL107gNUSs4aPl/ANKmLRJL2ye34abDIJrqI0
         OevlUwMX4YuXWuiD2MecAeksBh7L/wQPhhRxh+kDB4TOMbx7NQlndM758MYP0ETx0emY
         Qe4JziCgO3AXZqV1bCAaRN+hOvRYjsU3vvVVN4xcccdF/TEIRPmPaA2EIg6kmQgtyQw5
         17KHp2ckpClq8ghW+DE7ZS2tfUXYYxRgRxZ7dI6tkwCl/7jSaHwta/EYUj5t+e3vlVzV
         Iaag==
X-Gm-Message-State: AOJu0Yz8sOOo6x6IsXdG/1FHe7SoSsyskKwi+6vd6fMgpXQJqWkrW2Rt
	YYou4ctSnL/wdeAtJOpOvaBxqjFr8U+SPqfnagmjzITdtMOTc6N3yu8pR+85WKV1Q1De8dLEkBj
	r9j+fwRDa/CClwxkL5PH9hrG6+HmKHz3yhwLkuC36VqLkm3lbDRzwWp4K+qnLIzo=
X-Gm-Gg: AeBDietP6PkBuAtcVKVRIwnJTePQq2BfbQnm2soGudMF51Di9UD7Fdho+2ZJlc//t0d
	2JPgODF7XqCtfAtZw1iKsJElhSZkHkAEQsJ/AkxdDJoUdCSs4KbuXkxdDGY+4GAVRJitIA6M955
	TfRp4LvJBb7E0W9ZGWI9oRq/knIKzdOkCG+VJtsVbu1DmQVdnj3eduEqWTrRk5+8n8YXPv2C9sm
	2TWjJM4UOwa+NrD0d2rOg9b4i2wjhDeI7z3onjExEWWIOf867mYgYpoNbDGcuIOBAovtabpoTnr
	CADZDJiDfvNMQvo9C50MCst88pdM2+O2fXjFem/SDo9+KjP1NYYOj1aOjO3mcgqwBAX+LkUJYUc
	/UDpLSkLh9cU4MsPH6RDDMF1AFqZRC0BuQuDnlVduWATsMypEH98S
X-Received: by 2002:a17:903:4b2d:b0:2b2:4e5c:69a9 with SMTP id d9443c01a7336-2b281715f1amr27999905ad.5.1775213993962;
        Fri, 03 Apr 2026 03:59:53 -0700 (PDT)
X-Received: by 2002:a17:903:4b2d:b0:2b2:4e5c:69a9 with SMTP id d9443c01a7336-2b281715f1amr27999765ad.5.1775213993507;
        Fri, 03 Apr 2026 03:59:53 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478945asm75543575ad.28.2026.04.03.03.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 03:59:53 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: adrian.hunter@intel.com, ebiggers@kernel.org, abel.vesa@linaro.org,
        ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH] mmc: host: sdhci-msm: Fix the wrapped key handling
Date: Fri,  3 Apr 2026 16:29:49 +0530
Message-Id: <20260403105949.1007447-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA5NyBTYWx0ZWRfXxcw6vPL/X52I
 pwZnuqcLhD2ROUuXxVSVqUTxhxmcVX8vEHny7A87OxHcRbRhTWEtL3mUe0IpISAFpnt1RN/F7oy
 XHCjP7IDVrlfygyRKzxR45yO2gxGjRmbPsVjsZcfNYtV/Hgc1W1Gk9KqO6O3IHWyID5HqqTkDDa
 ChvyDD2UpJ5BpqKuckiDvAFri/eP6EyX4kw5iwD6qsW2GQcWiasTj6dPa+RJ8Nc+RllCUF1s2Tm
 NmYwwOoc0dLCQPmjVz8ohZptW8hH/oZYlHs5SI63C4WWfG0eZa8lViCk2eLTWVzY2GfWID16WCR
 iHCuMz/1hRqPwytWw9vO81p1PvKbQAjFDAeJRhxJekddvxQIozEVPnwLiLLuproBxNJWY2KfhKW
 0egBnCl3VT0QryMQFSBNG+MXBI0qd7yEbcAvcOKzmmEic0ZbR/Ta/1rfFp4XIRWa75tW80Jn0XT
 1xCM8H7UvnDAV4JLEmQ==
X-Proofpoint-GUID: 7yMWaBVydMSkXv3aYiRHye5fHfp1gTiD
X-Proofpoint-ORIG-GUID: 7yMWaBVydMSkXv3aYiRHye5fHfp1gTiD
X-Authority-Analysis: v=2.4 cv=Acu83nXG c=1 sm=1 tr=0 ts=69cf9daa cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=syXCSX0lvsCGUfyF93UA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030097

This change was originally intended to land with the patch series:
"mmc: host: sdhci-msm: Add support for wrapped keys". The fix was present
till v4 but was accidentally dropped in v5 while rebasing.

Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>

---
The patch serirs "mmc: host: sdhci-msm: Add support for wrapped keys"
was originally discussed here: https://lore.kernel.org/all/CAPDyKFqRG1_1aYavfrA0Ss85B0kcTnjVBeqLgq8PUJUcSx5LUg@mail.gmail.com/
---
 drivers/mmc/host/sdhci-msm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index da356627d9de..df0a038269d4 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1926,11 +1926,6 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	if (IS_ERR_OR_NULL(ice))
 		return PTR_ERR_OR_ZERO(ice);
 
-	if (qcom_ice_get_supported_key_type(ice) != BLK_CRYPTO_KEY_TYPE_RAW) {
-		dev_warn(dev, "Wrapped keys not supported. Disabling inline encryption support.\n");
-		return 0;
-	}
-
 	msm_host->ice = ice;
 
 	/* Initialize the blk_crypto_profile */
-- 
2.34.1

