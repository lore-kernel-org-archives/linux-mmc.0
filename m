Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD6F3C3447
	for <linux-mmc@vger.kernel.org>; Thu,  9 Apr 2026 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735102; cv=none; b=bx6PeOq0h1716LybpXcYhly2/0XIqCh3e8B4ZQpNhQMxBwKBbM74cylu8B9oAhdwVMNHTXXuXgLD/NnDQQ14artu588ekEjaq40UkVqqu6FYVKVwKnCwLLk4xrAqX+Oy6bizwNU85ki5ahWC6dsri8pJ5sSIPLfpqkH8REMXdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735102; c=relaxed/simple;
	bh=mqwO6vhHa/WasNF61nJHaYRSrbFR2Z3ArE3JxzJ07ik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GwuqnKK/y2hcUILwke9A29B9lUvoDnjYLa0npQ+7nmuqewPAxYE/5GmR9AQXQi830+b+/n1ZTPStV3zIQifT0KBZON7XyaVhexxr8rwMxOufbceiD396PT2Vb8GDWvDdBMOKXcMVVJxhEAc8AotjDmIX366o9g2Mntb+u+goaKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L8+jmh/x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AV0RI0Dd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L8+jmh/x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AV0RI0Dd"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639AKW711727226
	for <linux-mmc@vger.kernel.org>; Thu, 9 Apr 2026 11:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cZvb5TNGnSRnh7Yw6ww/CSSTnFHggTtfN6hnf4UNCVs=; b=L8+jmh/xUqy/HsMy
	Xwj1VWwP0uhmM7RTLUoV3ZMdvF7aRVlqOTG8DMt456d9/fsG/7gW9vjdT8ytwtL6
	JzcnE4ybvjixeGKH/sYzRIcK+XT8ixmgDL4xiarrwouNjcqyq9aS5eHgldKULNqU
	UyRJcGbC/c6vuZbf5tHLi18qB1xU6RkzJ+De387I5PXFxtBqF9U9GMqa1ocLl+8A
	ijcncpHo7Vnz8g5IOCdquQoaoIwdX1Crc9KonHgSjaE2QfZyc93vfu2xgoRjvFoz
	P6QND+4DW30s8y8WF1JRX6KMzi5duu+YD85SlHo84edhFLL7PfJsnHC1e2C176sz
	ZA4z6A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddwcru165-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2026 11:44:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b24305cb3cso8643315ad.2
        for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2026 04:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775735098; x=1776339898; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZvb5TNGnSRnh7Yw6ww/CSSTnFHggTtfN6hnf4UNCVs=;
        b=AV0RI0DdE51ydyuHtIxVJRRZBSU2dWNxekjwRXqvJtzzTP9taJDustR9/PrVoVHlwr
         BVDX7pgz3fIL94RwclI2yWj3G+e4vHMu5axYcSWpuSwZtp368Zx7tQ9bZGCouXJe4/ye
         zbp//8zg+IZmmFw7qCNwrB1/pQSWQhpWSZqnsLVPGixjFciipu9fnrjmycuI2QKsQfgu
         aGe4OLy6MS7ALWu9bUsmkvrmTStNxGwE9IxMCuJvc6Y9PYISW4JLadJR4IUnxC+r2MiT
         5GxFYwGEe+pCXUwEVx7cT0P+lcybZair/lxdKwdMfOja2ebZ8X3QM6EP9Py5ie0rShV1
         /7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775735098; x=1776339898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cZvb5TNGnSRnh7Yw6ww/CSSTnFHggTtfN6hnf4UNCVs=;
        b=eBAkWu+u5Of29VmWwf1GfrcymGF1axjh6xf24mLvwpWJUGow5J/7H/nATijV4UzHiF
         MsXGy92pX2LnIp39tTDKUYlMHBHEAyMQmw5+3uBpw2bjnZ7x7TmedMjM0q9sSkE+gyCp
         N+n3Ae62zxcW6ERa1LYoA4BVvc/9XQJJEM1RSMSuj8Wp3oxqVxBR8xO6Jno1tBAYED2+
         s2OKTUusY1Mt7WJub93OKNczz0prf5gsLj382Y/WxzR0RKPR0Xpm6jqXa9nBybaOsYY8
         UguDfns7gRgUrtP1T47/7Cz2qKniEm49tJQxCG4K+bWd6eRWLQczv1k4anPJSZJiPYPl
         umVA==
X-Forwarded-Encrypted: i=1; AJvYcCUnC5+IVH5Ga592rZ60Lp0G2ROyo6v1ccg3SekwMXMm451UnCjlniD60QJCaXp/TfFwNc/Lnh2jh9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMbx0DUL6TzhOwPsoTQwfpV0lg7+EWAHfD87P7PevRR1eFHa2o
	wMLNZ1zCbsNxYRhABI39cGZ/FmQgzKWSjT5IOE21opFX2lp1guZEjcNgbk25A9eSxo5kLHOdWNw
	wZrjMerVcu30zyAhj3IQKSUwqMDnV8jhtqpLApmxU5beEVc9/FJ7H6MoSmlaApkY=
X-Gm-Gg: AeBDiesVuTROYy2qXqV8tem9zVCc2TMxWReKRtLNdQprge9tw+0R6fvwkMdL5c8Oh4H
	cwcHZswrvLu0gIViSlFWK2VhPoiv8KuDQ2OMyvINPxB6sVbLF+Gc9qXB7YYBcJXjllGck2WHrqY
	K4SDl4IxtpddUvEP8GVvnyjmTbGIyimFI50DjozYG3vzsAPalZMvOROlQU6Mhx1LkCYcjXz6SyQ
	dg4VyEKFzpnqArRbzYoaCL1fj6DRgHjbFWzXl2rOOZgzkk9JWy2eSnApTo4JSlFIQIK5To6x5fS
	NBE1mubLamBeorxJJ1V6NjrSxS14jyTwWFizbT6UilDexd0cklhjE4noHjOuiwz1CNhT9l6tbPH
	vRawHK+/C7lLzRm1LCliZrNlkRPkTOsBcugw+OFSDRSMkaKipp5ZhvMjoYJ4=
X-Received: by 2002:a17:902:f70f:b0:2b0:61c2:8e7a with SMTP id d9443c01a7336-2b28178afb9mr277907765ad.25.1775735098376;
        Thu, 09 Apr 2026 04:44:58 -0700 (PDT)
X-Received: by 2002:a17:902:f70f:b0:2b0:61c2:8e7a with SMTP id d9443c01a7336-2b28178afb9mr277907515ad.25.1775735097871;
        Thu, 09 Apr 2026 04:44:57 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd9fsm230957355ad.75.2026.04.09.04.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 04:44:57 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 17:14:10 +0530
Subject: [PATCH v8 3/5] mmc: sdhci-msm: Set ICE clk to TURBO at sdhci ICE
 init
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-enable-ice-clock-scaling-v8-3-ca1129798606@oss.qualcomm.com>
References: <20260409-enable-ice-clock-scaling-v8-0-ca1129798606@oss.qualcomm.com>
In-Reply-To: <20260409-enable-ice-clock-scaling-v8-0-ca1129798606@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEwNSBTYWx0ZWRfXzWYcAPBFYxMj
 I0cn6XO2ZLy5ZUBQqOlaxh7gr1BrbEEQ+McObqb2DEpfXEhaiElyyD7eTIKb/FmJg6z/LPLZOwg
 9RR6v6iwTdjGmixBzuA9XXu9dcatHfpOtOWEqefZCJ0lqMqoQ4PRxlylxkYDmirCXIes8majAzu
 QiysBQ07msTuWo7PdyUVqb1MfStfkLhT3eOfY+p6WVfFeh8osHEDaKd7dHoL0fKb7MY538+SJhu
 7lDxNFMn0bDmFiGdRFgm+zenGiqUC1xs9EB/gwXB367lKp3jzTlWq0jrdvP0xHfTRtyWNzxGZjQ
 CAXN01+/hY/L+CmreqBetFkKrPD8U9ZPBoiHXZEVFU76SbM0o+kIJmxsLcID3boP2zv35hNdZ3I
 q4yM+HSnUQ8YJTteDIhzS4yaL9iKaVPWyFhmEhtODw1z4DGYTOVn2FGO372HCfpR1Z7MKnvqvo3
 l+0ua7NBZvra+A6Q41Q==
X-Authority-Analysis: v=2.4 cv=SsWgLvO0 c=1 sm=1 tr=0 ts=69d7913b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=PzEurhthzZq-M9kHIYIA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: l8Axhk8-BwbtBYGlrj-OSD1YKUE15iPT
X-Proofpoint-ORIG-GUID: l8Axhk8-BwbtBYGlrj-OSD1YKUE15iPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090105

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
Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 drivers/mmc/host/sdhci-msm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index da356627d9de6a11ed5779bf057fa8eb23c38bc0..32e3f37fe425f66c00290a373e06e8ab6257824e 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1901,6 +1901,8 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 #ifdef CONFIG_MMC_CRYPTO
 
 static const struct blk_crypto_ll_ops sdhci_msm_crypto_ops; /* forward decl */
+static int sdhci_msm_ice_scale_clk(struct sdhci_msm_host *msm_host, unsigned long target_freq,
+				   bool round_ceil); /* forward decl */
 
 static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 			      struct cqhci_host *cq_host)
@@ -1964,6 +1966,11 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	}
 
 	mmc->caps2 |= MMC_CAP2_CRYPTO;
+
+	err = sdhci_msm_ice_scale_clk(msm_host, INT_MAX, false);
+	if (err && err != -EOPNOTSUPP)
+		dev_warn(dev, "Unable to boost ICE clock to TURBO\n");
+
 	return 0;
 }
 
@@ -1989,6 +1996,16 @@ static int sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
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
@@ -2114,6 +2131,13 @@ sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
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

