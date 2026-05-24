Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6210731A56C
	for <linux-mmc@vger.kernel.org>; Sun, 24 May 2026 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650779; cv=none; b=YpVdZyGMwvuWbuybOe6w7oZ+/OSus4PF2NlEV2QBiH2SqYHXl03xYHI3540Rs/FjjBnmGcn5+Ng+RdKeGQf5Ghy9myr9k15ZqOvrxqZE8ViAtWRAdVaL0JWRB5Xihoeg84kki/bNptr87OjfJYMC2FLVXLnSaDnzAzuFk4HIzBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650779; c=relaxed/simple;
	bh=WLJrEQF9Y7NigQZClz8IucXv+mmGIUfUo3zkdRhYPGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QPrDqC+K1o86LNHeDn21wKDYszZA9RghdUWwCzUfu+GBD94QpKxc1iWZ6PXcvaLD3RIJf+6lSUAkVWU9EzCBgQ3K1r1X9Tu4qP6tiMEqTacqq8fEvIEzqizq9oGFVrxGiyoCKKLIimygtLuZZGQM2nx8zy9gp87HlbVJFikUuCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jZ+7v7ND; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BQXfYmB7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jZ+7v7ND";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BQXfYmB7"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64O7w5dc168750
	for <linux-mmc@vger.kernel.org>; Sun, 24 May 2026 19:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R8XmU6cOQ/nUtzY4wcyLNE01H6LUhVcm8naRNpnvf7E=; b=jZ+7v7NDQIGCudWU
	xUjP2SFcxjJzcaCnekSSD1CkYG0EJ9h+0dve/XZpnPR4BWKXYRAJQMT1WaWsJWCp
	2KbvemIr9zaMXS6e4NPc6R8mgpeGKLw34tMuHYnKJSrNNtPwifZ79uCXHDzlFam1
	pr15z3wdPZNuMU9CCGl4gk6NFdg/PW2BwEoIZBOG7qquLAg8vCX7oDsOdqvidV5w
	hYefZqjDoEjhSio2wn/HekkZ8z3hx/DWMgRp3tu0ow09Cs4TGmU/RTAbi1VExVoP
	lVslYY1QApPU5w6h00800sTDPwNC60lxE9xFne1P835B9qdrPHnV/Jy0nVjSr9yS
	Tc26MA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0u31q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 24 May 2026 19:26:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba268cb5e6so92948365ad.1
        for <linux-mmc@vger.kernel.org>; Sun, 24 May 2026 12:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779650777; x=1780255577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8XmU6cOQ/nUtzY4wcyLNE01H6LUhVcm8naRNpnvf7E=;
        b=BQXfYmB7/BqLV3VjFY6cOaclIb9uk2Omfwfv5Faf6SgbSj3kA5MgXC4HiJM5gCsie5
         AodPloeFeOr6gG8MGNTBSmLYJ6xeP/iB7mULV3FU4E2mQLzJoTOr0FaLGy0SClIujX6E
         W4fR08rPfTFY/TX/xBKZSPYM4djHDuL2LeZk5n9GVJTPF+sgAsB/hPn/5gTbgYXyAIq8
         b8xUtTAK4NMz0srpul5OJIKxspCEkMgJ2IUbOzsFltqMdHRe/qAYlukkiZRVzZulVE0p
         USqoBaeFfayuWwNTKSLqyHjdJlGzKgQxj1o3xmxv03mz3t9aSF9F+vzce/IofmWT3Rmn
         cpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650777; x=1780255577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R8XmU6cOQ/nUtzY4wcyLNE01H6LUhVcm8naRNpnvf7E=;
        b=WAJblLQhnEvIBCRrBaclA5g1J3LGg6vTm964CP5CJ7Xfcw3i6fwYvCFGNFLbiZP8Ly
         zLMOxjZwiN3yg8ltqKfB3u2qSTr+3D8T9Pb8VwojnPyP7qRi45tZqwyMffXclpxXCS8E
         jVoefXhEN7t/TmyaD24G0W3/zi8j0lqgeR5u1VCy5X2JNZ6CHFsJg/p+TZiEwgb3RLUD
         xkb20J2A6C4kug/K3tFtMuSl06z8qGhpzuCpqdsq97jYIy9fi53o8BJ4EDtBrORWSwzy
         ZIi/XjV4oGaaHlXR96ib9xUL4EiqQrQCnoyaYG/3EWTQB2c5sbu8BpxFxQb4H8sh5mAV
         vfAA==
X-Forwarded-Encrypted: i=1; AFNElJ8NQ/D4SG0+XlKey+Sh7Q7Cdu7dwgdT0TsKbMwe6OqBAb0UZttLRmLFHKHzzOc9deqCHYoZlawPum0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs0xw25kJFWWtu8zjkimLnrZSnPLpoTnoT2JHFLz35HiCVVDUf
	QieI0oOAfb3dtNpTeT9nYXoavaURvjBiYxgxbVz6TbPD3p9bqUTLDrUwxowlmA61hHoUj1UfCdV
	gLZUj4LxhYM4DamyHwgkvuho+16526xg558Ew/FEqtwWV9MNAUNA7mO79Xjyn/ho=
X-Gm-Gg: Acq92OHTkraenpVqp1FYhaNXbifGc/uYGt4iO98s2mM7SEBuIrnnSRD8seuPiSSovLZ
	SQ1UMBLw7ULZxSP0k/FSB/68Wr//l0QaCjBGASZuhCYcDLTTIN4IDGoI8KeVZcq0M9Su+fLVZQt
	Ra4PdA2eyj1OeaYrW+44IO5StgpqAmyP8SDPt1kItkHkHx/IAM8x85RTh37V1qHVanWh/AqoBM1
	OzrH4BPp7cjboo7WEFPxstTvJABd5gyi+bj7avpdOv5UdqMz/hGFQvncKBoMwOB2NZmw4b/TNHr
	qkwR9RGScYcxE+dkseMwY45a5hPSgDfQ4HkSSMHlwOxqB9tPERd0BHurPTwro3DqIObP0qevVDH
	j8x+pG8K9P7RG1iNXiPpuAMk8aopTFofkEP6lUNQyCca90CDzBFuva7YL6HM=
X-Received: by 2002:a17:903:3b8c:b0:2be:1db0:f166 with SMTP id d9443c01a7336-2beb0346484mr129305735ad.10.1779650777088;
        Sun, 24 May 2026 12:26:17 -0700 (PDT)
X-Received: by 2002:a17:903:3b8c:b0:2be:1db0:f166 with SMTP id d9443c01a7336-2beb0346484mr129305495ad.10.1779650776559;
        Sun, 24 May 2026 12:26:16 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56ce2cdsm75329945ad.29.2026.05.24.12.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:16 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Mon, 25 May 2026 00:55:50 +0530
Subject: [PATCH v9 3/5] mmc: sdhci-msm: Set ICE clk to TURBO at sdhci ICE
 init
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-enable-ice-clock-scaling-v9-3-c84613e9ce47@oss.qualcomm.com>
References: <20260525-enable-ice-clock-scaling-v9-0-c84613e9ce47@oss.qualcomm.com>
In-Reply-To: <20260525-enable-ice-clock-scaling-v9-0-c84613e9ce47@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: J7HK2gh4xMIi9TIcrzCuNX405Rf9DKC3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5NCBTYWx0ZWRfX/FwTe0JjImLE
 IgKi6BNpG2q9kHdx7wTUI/el//mnk9h3R9JpM5b2Lbh4Mg5z+MD+Oi7HOYn0HRYBcG09WVq0In1
 j1nMNTH63BhxPr5bpZU0OUVo6oU59+pmrdaV9/lGMxZDYdxqU4XtDIG8n1iggxN6xqmr5K75ZS9
 b6oGxGE4DukJ9nd15FcH7yf96lAd/5qayVwBcavIIksqzCUaGPxlhLHJBW3AxJSrijWyC7JN0Ip
 nLl9Z+/hPuuDrSZGgcAq4QBhdYEIEcCVSWMaJhpG8oYDMNn3BAIBLLMnsdvnr/N0myscpUnKIsu
 EDtd3lfYnSzHC8eVeEJo5u+UDesnINjAXY9T6L/DeLFG3P8hVzEcYxKhKcIRi9f6n3rIDIhSkq/
 vz4gHTTLLMr7oWW4XU3AUb17A8ARSyaHO/qAGvGbV5X7QI0cUntX72J7EPBtdzSpUxv1aX1XsoY
 PHZBj1yr8607m9mCDVw==
X-Proofpoint-GUID: J7HK2gh4xMIi9TIcrzCuNX405Rf9DKC3
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a1350d9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=PzEurhthzZq-M9kHIYIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240194

MMC controller lacks a clock scaling mechanism, unlike the UFS
controller. By default, the MMC controller is set to TURBO mode
during probe, but the ICE clock remains at XO frequency,
leading to read/write performance degradation on eMMC.

To address this, set the ICE clock to TURBO during sdhci_msm_ice_init
to align it with the controller clock. This ensures consistent
performance and avoids mismatches between the controller
and ICE clock frequencies.

For platforms where ICE is represented as a separate device,
use the OPP framework to vote for TURBO mode, maintaining
proper voltage and power domain constraints.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 drivers/mmc/host/sdhci-msm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 633462c0be5f43c06c497520faf9f6fa03fa652a..cabcb75ebbac392eb6dce7ac8c756724ef9e1b49 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1901,6 +1901,8 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 #ifdef CONFIG_MMC_CRYPTO
 
 static const struct blk_crypto_ll_ops sdhci_msm_crypto_ops; /* forward decl */
+static int sdhci_msm_ice_scale_clk(struct sdhci_msm_host *msm_host, unsigned long target_freq,
+				   bool round_ceil); /* forward decl */
 
 static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 			      struct cqhci_host *cq_host)
@@ -1959,6 +1961,11 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	}
 
 	mmc->caps2 |= MMC_CAP2_CRYPTO;
+
+	err = sdhci_msm_ice_scale_clk(msm_host, ULONG_MAX, false);
+	if (err && err != -EOPNOTSUPP)
+		dev_warn(dev, "Unable to boost ICE clock to TURBO\n");
+
 	return 0;
 }
 
@@ -1984,6 +1991,16 @@ static int sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
 	return 0;
 }
 
+static int sdhci_msm_ice_scale_clk(struct sdhci_msm_host *msm_host,
+				   unsigned long target_freq,
+				   bool round_ceil)
+{
+	if (msm_host->mmc->caps2 & MMC_CAP2_CRYPTO)
+		return qcom_ice_scale_clk(msm_host->ice, target_freq, round_ceil);
+
+	return 0;
+}
+
 static inline struct sdhci_msm_host *
 sdhci_msm_host_from_crypto_profile(struct blk_crypto_profile *profile)
 {
@@ -2149,6 +2166,13 @@ sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
 {
 	return 0;
 }
+
+static inline int
+sdhci_msm_ice_scale_clk(struct sdhci_msm_host *msm_host, unsigned long target_freq,
+			bool round_ceil)
+{
+	return 0;
+}
 #endif /* !CONFIG_MMC_CRYPTO */
 
 /*****************************************************************************\

-- 
2.34.1

