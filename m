Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D022FD1D9
	for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983171; cv=none; b=aGBh18aDvt8TmXMZs/82NPm2I1pH2AItRxrGH7avU+mvbnlwHLKMwLQga+o3I2R8txzsecNAG/rMtkBUUrrpx2lo3GHk0FxpU9KVg9+m9EWG2oPnLGpS21ytA2iDWMN5xpLpYSNC9y1W88BZBtha90lg5/dcDj/Qns4LIxQ32o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983171; c=relaxed/simple;
	bh=HOd/CGT6IV7yZ7CScMNCvz/ZYsgfNxfiuz0/zi6vJdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JS+mTG0wEB49wJp1njfJ/yqeJGKtiIsc7+rNn/GillXBr1HL0fh9jhS5rK9pu29dKD9e7Y27TDO6G3mqYRyKpNpxuRJ3AqoEVdeBK3Etz8VC6UpHZFWJlzQqrD0MCrK5ZXCH+nuwRoBHFkeXnnSPmSmwVMEYPCtp2XvNUoFn+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pDcHebMt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bJf1bB8c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pDcHebMt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bJf1bB8c"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO7k27V2538264
	for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 11:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nM/cUQBdlkS
	XjNkdnEuIGtPatcgwPnEYp+J4ryGqAiE=; b=pDcHebMt6wLVd/+joPOpCTUDzin
	cD9skHHJwS8UBrwiI0SQRSMQgsSUe+o/ySYIYPsZD5bYcFMR+EkyqimFAudQQqvX
	q7L1UroFqXIz3RBm7HuQkBeUgMUa+w5rOY7IBeyvuQ/NSrqn3v282vzO8N26CGvW
	yUHJ0bCdSEOp++OZbZ+MR79hjLfp3YqPOMObKEJuHDGLn9sUA6QaxmHJReH+z5vW
	P3ff4HJzRqhAzbaN9RUu0Zvbx2Cwd3RW2QUSHa67h0aq+mVZblIQ84TmQVUwSItu
	mFMx//VYjYBc7kKTnVkWUnPhFlPYZ94KDXOtYuOzFFPGlgcQf5Kpcxa86aQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak6cdvrhj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 11:19:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-295fbc7d4abso65070635ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 03:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763983167; x=1764587967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nM/cUQBdlkSXjNkdnEuIGtPatcgwPnEYp+J4ryGqAiE=;
        b=bJf1bB8cR0bfJOKUfaZXm7uXs06rYPllEneXlq391VVF/YdXWTw5SGYIBRhGdb0dAT
         y4pearGGsOdgUQFXRkWQfbfcSaXMVmn75ziMnoP5zgcCNJwm6HEdldiaJmOJKq9Jfkwb
         DcPu9VgMj4B2Z47xWGmlvIpmSpM1GWBSBRs0QjArW3BvEK88mibXnmNdblTVdLX1uxP1
         zYOTrqeRIt09H1Ggkzhywl3Gbw31MQiwCWAqKZrUerSC85hireK8WeGJ+ZNy0CFtfUF2
         D9Wxbrbz5NQDS2Erbm7YERDUtCi01x2hHgQcNYsEjlaDXC00/vv002n6cP52aBIvSLj7
         95Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763983167; x=1764587967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nM/cUQBdlkSXjNkdnEuIGtPatcgwPnEYp+J4ryGqAiE=;
        b=v2FPa7VtRBtFq5dAwI9BVyPJXaTlTUNv5v03XqN4IezHnNzVg+GHbaX0Ts20XkjLmz
         dqJsbPR5d2T9vMIrFao+4icZn7VF9TIQnommwyIDGVlviw4xdWiw4KoAGpUGHinWKFQ/
         jbi/Ny8zt5xNQ/OERcoCUNrrgj3ouHGwE2/le8v1Xp/vobbsEkF1L6zay85AjCswPgdj
         FZwjfyy9qVow+fGorspiv5idXZu87RSp26EdVQhLntqwPl1EMyCm0INabtHprS73j95A
         OJaLtRZhNZatMo41vIFCrXrmjBBBgTmj4J+ZqnuJgyoW3Wo6F541QO5ZzH4xFVxSN1F6
         guSA==
X-Gm-Message-State: AOJu0YydTKSXZm7wjM+qt7X4PulPtxlKDvH1Tg91b/OS7gQW9uTlizVq
	WAZ0UF6kfqj1ANm2A/gO4CDKVn8nD2gavuarj50dB5e1ZB/we2qB/l+63jJK3XTF9dvBp2EFv2v
	Fr+/QTy6EF1FLuX3VmPFpnitIFhYTDUV8hDwmEFWFrG4fLYWlNw4c3+dTngCglow=
X-Gm-Gg: ASbGncvDodTJV70rY5/0zyapIBlTvCkTDBKar+vBFx68Y6aqfETLzG3rQzT6YrtzXf+
	v4/dza/d0XFP9Uh4Ky1P7CCucMejdbKwoxizE4zq+oOhQnOVTiZJsrBixRchDrnCIlAyA+PYxM4
	3FSuHwBtfUFp1DgSCK6tEJHh9KPADfpOhizGnJ9juebc3qWbvdrP09roPtHW5lS338VbX1hHi8o
	osvB2vcL2JWSwCyOm7Kq9Qrvese9ZdtLRLQvWUhbfYaNUpfkEoSCnPsn0QrD3qJH1zMP73sqlyM
	RvUdfADSNrMYAjcvghQ7jhz2sRsD8sEsvIta/2x018OIGRlQEfUe+75bKpc514Hnw5yqBWYgHZ3
	ZUFjHPvh7da1NcT/m9b/ZxWkWgm6fKvyfKr0VWq2Q
X-Received: by 2002:a17:903:1a2e:b0:295:8a2a:9595 with SMTP id d9443c01a7336-29b6bf3bc92mr136115675ad.39.1763983167017;
        Mon, 24 Nov 2025 03:19:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8Afj+nuDtN9gljW4vPRnmLS9clcctFJoqMFnMwxgMmJK9hIWivYBzVl3/RJuP1PpUeohs3g==
X-Received: by 2002:a17:903:1a2e:b0:295:8a2a:9595 with SMTP id d9443c01a7336-29b6bf3bc92mr136115425ad.39.1763983166531;
        Mon, 24 Nov 2025 03:19:26 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b15b851sm130313165ad.43.2025.11.24.03.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:19:26 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH 2/2] arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC
Date: Mon, 24 Nov 2025 16:49:14 +0530
Message-Id: <20251124111914.3187803-3-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251124111914.3187803-1-neeraj.soni@oss.qualcomm.com>
References: <20251124111914.3187803-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bsdBxUai c=1 sm=1 tr=0 ts=69243f3f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=DKEB3zaR7M0RML_3R4gA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: C-XIwee_XoWMy0HlBSr7bJhRwYbcotMY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEwMCBTYWx0ZWRfX0+zgQrs2zSRJ
 4XVsm3LwjyJB8x8HMttcDTlh+5jFq1ekclzGK/Jrt55astZQ/WKs8erRiSc/esKlgOUeTRU6322
 zVw41msgMiCb6Xs+Yw71aFdr6GzEnsWKXcsyTzn7Bv98uuEdUQKgSRZz3xboElMlpkL4hyFXsce
 vJ4pfhpNs5U2eWMHyr4dGF7xc5RSZ+15vbtxsaId4Z+GQnEK16RTXsxFuGvdg/8g3LLpvS0c3cq
 H1wgbheN1fwHczT+2wsi50Sic9un+enbrxFcqc75WyyF+lHBr1Lr/hlJll/SlHnK/1nl8RFpdi6
 Zr/ZE6TDrAtNSsMIFU2/QYccyokSyduHvcY/OE4KtsfD+oKw3Ncwy0KeYEcYspD368DkJRdhMPf
 6sDWndRBnj7sT/Lyr96eptViL8yJAw==
X-Proofpoint-GUID: C-XIwee_XoWMy0HlBSr7bJhRwYbcotMY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240100

Add an ICE node to kodiak SoC description and enable it by adding a
phandle to the SDHC node.

Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index c2ccbb67f800..9d2029a906ce 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -1069,6 +1069,15 @@ opp-384000000 {
 					opp-avg-kBps = <390000 0>;
 				};
 			};
+
+			qcom,ice = <&sdhc_ice>;
+		};
+
+		sdhc_ice: crypto@7C8000 {
+			compatible = "qcom,sc7280-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x007C8000 0x0 0x18000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>;
 		};
 
 		gpi_dma0: dma-controller@900000 {
-- 
2.34.1

