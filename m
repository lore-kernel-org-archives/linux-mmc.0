Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD4F2FB99F
	for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983755; cv=none; b=YT31UiX3Es2UGFyk7g3uAvKPZfFggwYD5oG1G92wHLWocwkbV2WXGuwx8955qAPdsTKbU2lr2D62FVV5EZlp/ktrKeocPhaHra9Q1OGj41DwKVcRhGIhC+BvrPWo52A+r20lTA+AvQzaEZu9Ybu7BxAJG0UIQpcwIH8l80Cmv/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983755; c=relaxed/simple;
	bh=Ly7lLYY3bIPXjpAH7bKNc9BZsAhfKZRUM/kCY/y4Aig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cIOrDZ3a6fAoi3NUiulW4QsnShAFBT4bLDLuPGkYGZ3wTENuv0I4AJajJZGAI1BPmNpjCPPw/fwA10yhJHOt3UvNkJo5JluWylnEQSXQZC7aAl1wF/VYG3kFh+BsW1DRxsXSJFleeU9Fx7R1RHTbxwg9wmIUVdAbTP6dHaI8xOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TfgUHrDc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UIUA2tsj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TfgUHrDc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UIUA2tsj"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO7vaf42372923
	for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 11:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=M3M9y8dqcilpF3eUX0QRY29iWzqFVt7BaBs
	tvCWE+yo=; b=TfgUHrDcnwjv/khYff1QO0rat0iapcvQJqd1qEOSLJHvzUhEgqX
	/anQwmYe1YnWjJt3x4DFnp36U2vprbH3QP0kIJ3gptTUxqvdSdhh0u9+5lVnmCmx
	Ub0fhOOf5Flxajm/67G8UezTkCzbAxxb2h8Ihfs3Rr9ZRvJzTl5YTHyYiNayHmpc
	tUTAE1CG36rzrYniB+KHdPOVEtR3jhr0gt4fD7Cukln+S2jthB4LUkauf587cH3f
	b+Qyj0aWdCVn25mVKxnqou1vugfJa+EKCU8Ml2LI0P/bzhX35PsLS7AFllJeTOX7
	w+8nNXcXrRqrB6ev1iEJHuxe6HkZQP9kpoQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak694vsx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 11:29:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2955555f73dso67150325ad.0
        for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 03:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763983753; x=1764588553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M3M9y8dqcilpF3eUX0QRY29iWzqFVt7BaBstvCWE+yo=;
        b=UIUA2tsjydy3TiYLIUS7rF2ZCj3tmJ+TjecnOiY6r8ZEMg41awQBc2c0obdzY+4Ndg
         qaWuOYMkBFUnJlSeTzH9D+6mtpBkVXfx7uQ31Qfj2Lk/Nuy/bgqCjxlNJidPwbEarPnh
         qWJj9ndvRmwpkwM8IC5x6rWpPc2yY2Oez2tj8mW/WzHP4YtkkT3rJ/98i56nIiaaI5LI
         xctUcimnrpglnJmo221NDqEeTtWJ6ck3xib3xlXQF7BNyY0F3NbpwGTMLhHmhOele8d6
         CscPnOKWZEVL7FLbUvygnvYkUSZbfRtIxyd8xH5FCUwLKzODQvPAOlEhQWh2NQ0tJeW9
         2Dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763983753; x=1764588553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3M9y8dqcilpF3eUX0QRY29iWzqFVt7BaBstvCWE+yo=;
        b=jkDtz+Tm+g6abWBx1Nk1L3iDsS1/eI1k5z48Y2nvupyHBP9KfhiikbmphHCksyeW20
         srHeKUezn66Rkl2ini10La+VrdMkJExKGzVuTR/N+DUBICbG3S3gcnItnIslULFjH8JV
         rgPV1ypQeL9UT6PSAqQ3zk3Vtm3bcSJpzdj4HqUsHl6JFw+eagSq7CAoQxBJtCjKt1PB
         pOF2cEVUJBBZDCmN0SUpqTpLCStyF57BcYieCNmdkFxNypH4mumHK72VOEnmR2sBqAQ9
         hhCH83FnH19sipFr1aOZuHJrXTqp7qeLwLe9vxFulyGUU0QMAxjJ+CPCL9drUSyOfK9q
         Svdw==
X-Gm-Message-State: AOJu0YzDnnLaA9i8jjAw9dL+Fn1xJF/lEMefkrM9b20gmH0jr3VHfG4a
	mANKdGRVpuqiXA5mMMMalm4Ux0c8hXRNgI90hEe6RbaiUTT6lNw2idB3o2KUk8chzbBSyRdmSRH
	12ZHjOwBg3CWDtsg99FsBIhaL9GXwsyaoctprh/UCaTFYHJ0sRZR3DmjVbplLwYQ=
X-Gm-Gg: ASbGncvpPPs3hwhU/yZbSYs59Dnt+AgJMdexf/BoSNe1+51ueyjbBda7PlXOm7TdiF8
	/AOw0vcgjk9ujMvYSO7qsuSd702rar2HVBF6MNhzJpr06SAQyReb6qbuG2nNK58LS1wt42nUgJz
	VIXSBfQSHzivmLBexr/w8M635TI0DAgxvhC9bxdai9SBVMNzmbRw5tq9Y+7C9XOcFl43Bb4OrvZ
	trFDfDQTXSE2OkQCbaMrtEyhXz0cqAsNvyhCWYHyFoPkkIUpwCI6GYpWDLChimYCAQxyiWyrihy
	/MrffwQNhoVk3ysA8lCeUJvHQ9KirQgWZKUfnaKo/CeNJhVLtS+3aE51GBOu+7q4v3x4pzQaG8o
	UsNXosOAT/o+Gm6h2kqaILm2fwYvVkKd3BK9FKOd6
X-Received: by 2002:a17:902:d4d0:b0:295:9383:543 with SMTP id d9443c01a7336-29b6bee2c8emr139460165ad.27.1763983752651;
        Mon, 24 Nov 2025 03:29:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6HDY47fcT6Lp1tR/8iFhrEEnMqzWSigNega4FnN7afcdlOzSJ4ONZeVJtQJ7yGBhH6cXbog==
X-Received: by 2002:a17:902:d4d0:b0:295:9383:543 with SMTP id d9443c01a7336-29b6bee2c8emr139459925ad.27.1763983752134;
        Mon, 24 Nov 2025 03:29:12 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b27509dsm132034165ad.78.2025.11.24.03.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:29:11 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH] mmc: host: sdhci-msm: Add support for wrapped keys
Date: Mon, 24 Nov 2025 16:59:08 +0530
Message-Id: <20251124112908.3193211-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEwMSBTYWx0ZWRfXzFzG7E78Cgl6
 P6i+GqwirxH5G9tvhlmgUEFyJ3fNEwO4ke2mWbgy+Nhi/Bc1VK7rmUSwBrOfpL0vHz/RJz/xzhZ
 Mw/+M7hOH8Y29Zi02lBeWyaP6rZcyjXwZKbs34t0ES1J+JgPvTq5m3XlLQdcXOsl1RKN0pD5pa6
 1ectg1ml/qH64t6k17NaxGpt/v173nPTfQgEgPzJG3FpD6DVTd+uICJCR74b/brD1XERPWYZKZ7
 E6+Uxyo1WS3JBigJQoDhSzqYrfMI3lv3qTrsPO62zrvdL94tjufFgxdELyZsaby3DWIu3AJd6pJ
 vzJ1rdmlWRws4woArSR41ZSN+oKnTmi1o0FlpUr/DhHLvJPYOhyMpjV0sJsFD4XmzvvdmxmL/RO
 KM7wgWqQfv1bmKl1egNvvtw0DrtpCw==
X-Authority-Analysis: v=2.4 cv=YJqSCBGx c=1 sm=1 tr=0 ts=69244189 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ZyxRHT4sbPtUm1NgsYkA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _kFjrD9fCLjeGzMk8q6ZAQ0D3QSbmSYX
X-Proofpoint-ORIG-GUID: _kFjrD9fCLjeGzMk8q6ZAQ0D3QSbmSYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240101

Add the wrapped key support for sdhci-msm by implementing the needed
methods in struct blk_crypto_ll_ops and setting the appropriate flag in
blk_crypto_profile::key_types_supported.

This is a reworked version of the patchset
https://lore.kernel.org/all/20241101031539.13285-1-quic_spuppala@quicinc.com/
that was sent by Seshu Madhavi Puppala.

My changes rebase it to use the custom crypto profile support.

Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 drivers/mmc/host/sdhci-msm.c | 51 +++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4e5edbf2fc9b..351f2a77068b 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1911,11 +1911,6 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	if (IS_ERR_OR_NULL(ice))
 		return PTR_ERR_OR_ZERO(ice);
 
-	if (qcom_ice_get_supported_key_type(ice) != BLK_CRYPTO_KEY_TYPE_RAW) {
-		dev_warn(dev, "Wrapped keys not supported. Disabling inline encryption support.\n");
-		return 0;
-	}
-
 	msm_host->ice = ice;
 
 	/* Initialize the blk_crypto_profile */
@@ -1929,7 +1924,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 
 	profile->ll_ops = sdhci_msm_crypto_ops;
 	profile->max_dun_bytes_supported = 4;
-	profile->key_types_supported = BLK_CRYPTO_KEY_TYPE_RAW;
+	profile->key_types_supported = qcom_ice_get_supported_key_type(ice);
 	profile->dev = dev;
 
 	/*
@@ -2009,9 +2004,53 @@ static int sdhci_msm_ice_keyslot_evict(struct blk_crypto_profile *profile,
 	return qcom_ice_evict_key(msm_host->ice, slot);
 }
 
+static int sdhci_msm_ice_derive_sw_secret(struct blk_crypto_profile *profile,
+					  const u8 *eph_key, size_t eph_key_size,
+					  u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	struct sdhci_msm_host *msm_host =
+		sdhci_msm_host_from_crypto_profile(profile);
+
+	return qcom_ice_derive_sw_secret(msm_host->ice, eph_key, eph_key_size,
+					sw_secret);
+}
+
+static int sdhci_msm_ice_import_key(struct blk_crypto_profile *profile,
+				    const u8 *raw_key, size_t raw_key_size,
+				    u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct sdhci_msm_host *msm_host =
+		sdhci_msm_host_from_crypto_profile(profile);
+
+	return qcom_ice_import_key(msm_host->ice, raw_key, raw_key_size, lt_key);
+}
+
+static int sdhci_msm_ice_generate_key(struct blk_crypto_profile *profile,
+				      u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct sdhci_msm_host *msm_host =
+		sdhci_msm_host_from_crypto_profile(profile);
+
+	return qcom_ice_generate_key(msm_host->ice, lt_key);
+}
+
+static int sdhci_msm_ice_prepare_key(struct blk_crypto_profile *profile,
+				     const u8 *lt_key, size_t lt_key_size,
+				     u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct sdhci_msm_host *msm_host =
+		sdhci_msm_host_from_crypto_profile(profile);
+
+	return qcom_ice_prepare_key(msm_host->ice, lt_key, lt_key_size, eph_key);
+}
+
 static const struct blk_crypto_ll_ops sdhci_msm_crypto_ops = {
 	.keyslot_program	= sdhci_msm_ice_keyslot_program,
 	.keyslot_evict		= sdhci_msm_ice_keyslot_evict,
+	.derive_sw_secret	= sdhci_msm_ice_derive_sw_secret,
+	.import_key		= sdhci_msm_ice_import_key,
+	.generate_key		= sdhci_msm_ice_generate_key,
+	.prepare_key		= sdhci_msm_ice_prepare_key,
 };
 
 #else /* CONFIG_MMC_CRYPTO */
-- 
2.34.1

