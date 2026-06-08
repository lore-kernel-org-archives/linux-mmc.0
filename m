Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119334E75E
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 04:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780892233; cv=none; b=mZJobiVkdTsIlgPBhx4TV5eIjPV3PvrOi2G121e7sw+olZEuehre+JwvYrWm837uZHJ/2lg6p/0ZCs8xI+X87B62fM2IgPYkkShyhh/xPpaA9Rc5+ekSNrama/pWt5+iKW3zUiLk02ScEahUxWDJ9oXvPSy36YcmxzSS0xNC/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780892233; c=relaxed/simple;
	bh=GRIOiJQUe51hUrm6I0PO4qQaSoiSaOQxHQJG0J3XcOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eY83KLjD7iUPgHa9rR3KDkZnHzRoFWccKBwOWr30AfWP0ADMLwxTYUtJperSguKeN35M8VDtbyyXH7xlYRrFzEBcJFOzZc12t17plptcLBpF5VjM08m5jobPoT1tBBU+IBPLCU5yvO2TmQpv3i9xa7XDyGNjUO6XEVFuzF73oOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I70W4owd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DjBBbVBi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I70W4owd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DjBBbVBi"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580GB6I2005601
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 04:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=D7J1z37mYf1
	RCx8HKQE7hAtdFkQc6VU7eOJptUt/pJE=; b=I70W4owdFdTL6F18sXhx5Bv8t29
	iyByATsfPrG/wifAuosB40OhcGHeALmxw3wz3nykjpThbT/+YkiIqTt6sKa1Q98w
	oouWGIsZU5kFxNzOJ21AQH5zjvxVLIyUlL1dPLC93Ok4Upe5nwhUKfrQ2+TIYxAa
	E0d+ZoA+FQzL5Kphb+EclRPdkXCYHxnPHpNx2y7t0fcSqAWIkAEi6AXjF2fpiDZH
	PNgJIck9oo52BsUuZ02Hkpv5csJ8vUGQa74f8X5oFPx9MhmS6n7g0/AdKY5PTjg2
	pecRpQvhcOa4vd4r8CL8j8EtkHR0ISAUHCVQwd6G0F2Gvppn1zZL5x4LRYw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w5u1p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 04:17:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0b35fa876so48920105ad.1
        for <linux-mmc@vger.kernel.org>; Sun, 07 Jun 2026 21:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780892229; x=1781497029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7J1z37mYf1RCx8HKQE7hAtdFkQc6VU7eOJptUt/pJE=;
        b=DjBBbVBiapySy9E/1OFP0pvOaAIetNB+toPrYbkvmcdGFI6T7Ol8NamkURJduOcYBR
         v1ck8h/sCgrIJIgsgYgCf1KdAVB9FPARElMRC8UxifOg6AkkP3z9pqS1p3G1oBHZDBeb
         MPD+d0EU6zpeUffsyFGEDd8Pdvq4jCOyMeUUbN5Ywvlzzv59DnG5DDjNIKA4oSCMDUTJ
         J+vrKF6YtrESr5QWgcwu0QsiQ8+WiQMMwWmc28TPGuMNfoouHMX/NkLdL1xkMDU4zFA2
         /xgkjZKP3yWjpgBDlLH3AzJPhxch9SdPrvIo+YPfOLud/S+oc/NDRxzKw2BN5jPFMAbF
         KG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780892229; x=1781497029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D7J1z37mYf1RCx8HKQE7hAtdFkQc6VU7eOJptUt/pJE=;
        b=UrIMH1avNcffXyFbQr0N+pZi/koilONslMtDUajRH3N5z0ec6VL4OUIUZ5N3Qgmv2W
         i7MSYIyn0csNvY0gopYsw0UWR0MWo4H6rCFf27N8AEJqTr4yNuakA9QxAHEtey0RnUNR
         zhEaaFPvROKlJksTixFNUAGKL6I8gh7u/AOXQWfo/NdVkQu53lzuQl/avl0TGmWeLA2D
         KMJshYugqBtsijCPQMhf1KmRvQ90T5HIWnIMpP39wM3QNhHfRAbUEpCn574u+srNVAxn
         DXv2/TtSiaLfr7x5kwOupSfaNGotXrAPeStBRYf2ahlfSKhSwQQ7CXh7RsK6OzPQxMbU
         KgNg==
X-Gm-Message-State: AOJu0YxfMgs8fTKqU0QpmhcEnEiP0wC+rCOEgtuf1+A++uivxY6ZBwKD
	YfSs/mXf4I8QJGpNbLUXeiinWLPVwFFrcYY1JxhhWRFMLZHOY+Gau59PuMK90EEjacE4oG7+/+x
	ivbxl9UR8lhy13Z/j318QgpkX8FZg1BSuS0vFrGioGYpaFDftnxB8QwQPmPPiQ/w=
X-Gm-Gg: Acq92OGM36gVNOjdcLHC6n/mwu78XUOGwE2dsWt4WTeip5mwknBjAyQGo3owqp83jKs
	U7IKNGjXW69nSU8+r4baK4Dz2FBfXS/FtnpHFEE/rlLsOGRepkof3ZgLBi/IUcyYI2zqU6yFxgS
	UIhd2rYnyktDPlCZT26j+8G+icxUMJW6JTyEkdZnbSbYR+xm2XEShOU8XmAwye8GaRDVN4Xx+De
	IzZmiSruZMvIAkzHijo7HlrqlYb70DnHQLeCJdE4b+/Qq+O5c/sh3Z5xaDjwfiIV741GsFim1vP
	hBjimeY4OmS0b4WTwlg16pnchfeSHyGPEN4KQcNR+dakxkDdn1gq4pvt422Zj8HFtGfM5JuzYI+
	oirtIO6kylTC8ijvigm+M8obhKyg5Jx+GRdOoypHS76og80c42HhzOttRgj7UPRo=
X-Received: by 2002:a17:903:1252:b0:2c0:c625:4010 with SMTP id d9443c01a7336-2c1e8102377mr151042675ad.32.1780892229324;
        Sun, 07 Jun 2026 21:17:09 -0700 (PDT)
X-Received: by 2002:a17:903:1252:b0:2c0:c625:4010 with SMTP id d9443c01a7336-2c1e8102377mr151042165ad.32.1780892228841;
        Sun, 07 Jun 2026 21:17:08 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649fcdfsm209392525ad.78.2026.06.07.21.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 21:17:08 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH v7 3/3] arm64: dts: qcom: monaco: enable the inline crypto engine for SDHC
Date: Mon,  8 Jun 2026 09:46:50 +0530
Message-Id: <20260608041650.541502-4-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608041650.541502-1-neeraj.soni@oss.qualcomm.com>
References: <20260608041650.541502-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sqQa8T8DTR8s4DOrcvdn1aUOmq6eUUBW
X-Proofpoint-GUID: sqQa8T8DTR8s4DOrcvdn1aUOmq6eUUBW
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a264246 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=fZTdKWQFAU_LetDfPdsA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAzNCBTYWx0ZWRfX7xpuKx6f9cvq
 jcmQ/y4AcTY6Tj/in0weYUT5gh/xFJb1A1cf6xknXCf6KqFkswgDW1iO34O/9K+c6uNCFb1sH79
 E2asDpwqGgl8zltIP3Mj9bsut2rVgEVfSMTNtlQc8nj+iJR/E3sGMPR3+hO0kGW+AEa+Z0rItyF
 OUos0QFwPJuxfi3It4ey+ZAszNhIXunvtEruVJ3Jo+Z+9fPtGVKmAktzfm0pkRvpzQHEWO0rhxd
 NBVCAuUPTjl090evsjy7hMcpCQUyqWBPjxCbOqGV1ZzfoD8G7bhAwm/vNDb7eaGmKZcbMEoNgI+
 DLkKIXoGr07V46vibLK5herhuubgN/TKSCc04uQ4h5KMoiFd7428ZPfHE2IqYv+/caF8gScEK6r
 GxslmdC00hDghxBvZ728fy7T+OHzv2xnabi2zjXpUZEjpSdcog2V0Y5he/kA83wQweBiEAIVq06
 +P9gEAk3nG130jVynOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080034

Add an ICE node to monaco SoC description and enable it by adding a
phandle to the SDHC node.

Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260310113557.348502-4-neeraj.soni@oss.qualcomm.com
Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index e4c8466f941b..06ed34dfe135 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -4835,6 +4835,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			supports-cqe;
 			dma-coherent;
 
+			qcom,ice = <&sdhc_ice>;
+
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
 			mmc-hs400-1_8v;
@@ -4867,6 +4869,13 @@ opp-384000000 {
 			};
 		};
 
+		sdhc_ice: crypto@87c8000 {
+			compatible = "qcom,qcs8300-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x087c8000 0x0 0x18000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>;
+		};
+
 		usb_1_hsphy: phy@8904000 {
 			compatible = "qcom,qcs8300-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";
-- 
2.34.1

