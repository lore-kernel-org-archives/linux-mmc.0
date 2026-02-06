Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6939B4AA
	for <linux-mmc@vger.kernel.org>; Fri,  6 Feb 2026 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770376869; cv=none; b=s4KyO1QSqGpaaDz6HALKQlaQ6yPYjRTeeMYr0+vjkxnRYYt2KnJSxDhsYsVob/MxR/NMQEGEddhY79TvUFR1/0xIHcEs3C5JUAcbUv5mUM7QntGXMI0Kz5+h2VGLKKeKCVMjayT4w9k2bRGYMQrDgamsge8bpFplc0AC2nOcBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770376869; c=relaxed/simple;
	bh=8ebMs7i13WqPF0zC4w+oVAIdgnjTx2rCxck2UIJoxuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AE94UcI4/NQX+8FDq7pglGGdAWzZSV9rZUCdjtUoEAMW8vUVkQhaeYAP07EqH+adbl9/sc35wHAPtek+uEQbKmJhCla9BZ1DjlpdvaJnFGNjFzPjoy49qcFigpEhzn6+WTDvIBsVITivq8sq6rjmw6Prh9+NBDVWYRdrj2YMTQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NDDu/gZj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZwmYPTst; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NDDu/gZj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZwmYPTst"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61655WNT3012579
	for <linux-mmc@vger.kernel.org>; Fri, 6 Feb 2026 11:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=prNokE296Cy
	f7UgIGcapomuvXdqfCedaVm3IT2o8IjI=; b=NDDu/gZj9wRT/fBO8hk5DwZZ0Ix
	wxrVs8+dFnmbmFKlQNcxj56JbzUu/q4nL7JYBWuHXP4TM+PsecDcE+PJXek5wP+J
	WsIBsXX3X881gnmMN4gQhqU1WXRY2hfNTl6zH8cf4NQLMQ31jYq0O705wSYey8ma
	4W0GTivWfY32+h26IzU+QtOAmOHDgnRpGfJYser3bCBhPV1IQqG9Voaoyi3mvo7f
	PQoGqqDjoVdahIBJRf73P2SpJ91UpcuVtCqGII/27VkvrHih2jbx0Oaotr4/60k1
	x2CG2+sia1S5m1fHcj4bP++s5HLF8836PTNsIpkdozF2DHLCJkzCQogM0Ag==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c59ukh5rc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 06 Feb 2026 11:21:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a90510a6d1so17807245ad.0
        for <linux-mmc@vger.kernel.org>; Fri, 06 Feb 2026 03:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770376866; x=1770981666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prNokE296Cyf7UgIGcapomuvXdqfCedaVm3IT2o8IjI=;
        b=ZwmYPTsttuoyHp26aGZsp6wwaBPQT9A/3needSu2XTdDaDX1CIQAx0UH7oSZfa2CpH
         0pANU4fpsEIZwwqIlbKwl6rhFeTK1eVxZnHv5JshRGupGaQ/uvKrCAnKoW1mbLIJ+f4C
         ZsOi5sCugoxyD5vlpbCPix/0JU0HXkhDHEaFMZuivpGQw3tkHCLdS8kBot4a0NdKE2TN
         71aCPcqhAzjqdST/Pr/T4w8Qk42CFmIs/wWlT9fvdEprqJPfkF4dgMHrS8P3nkoSgC7W
         BRovYONevAN2ZeRzLtYcZRBYjreQvVOHFkbVYUCRhtEEPmxVMsZ1S9iFVcZMlH8s1df5
         Icig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770376866; x=1770981666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=prNokE296Cyf7UgIGcapomuvXdqfCedaVm3IT2o8IjI=;
        b=pNpwN096M6bT5ZIpPZ4jQ/sovupeyT5p9C3mjBf4S/L3q86rFn8hgXLF1dvjdKf6Er
         Nt0A/0dqB/iU+01NA0inGgMs/5y8Lr9ouDtH+f426VL9+HWPleq0I1h4I/9wcFTf2x54
         JSXDri7eCBAhnkitW+vETtvYVkWtM/8ul26Y2vekFZsLkeCyyEjwJ9nnt2UjPGOVzB53
         SzFJY5fbnYINcUX8P+bazi65cQRIdW8jBdhnTt/oWYoTwvKYnnokvfFJyW6vk5W3keEv
         zYj5TQIGRjyeuvi+crmin/WBfzfmzKQwJ9rRHkm56+xaXp0Go6At0RdYhXZ0lSIY8pLB
         f9QQ==
X-Gm-Message-State: AOJu0YzplpDaaAmUVnhO20iaZD2m6n30L/2qB3fmg5hQ8CKGq6EilXr1
	PSFUjGvYDu4/4/G1xujXfegRf44R948dsM06bWEy2O5bzQkLlaTRea7W/k5k+7u7ZMkz+siRjt7
	Gz3CbMLcJ1iGWBL6DVnm8lL5q7MPWYx1Nd20WMq+81bCPS/8OMpKK0IUXhyur14kQrg3brrw=
X-Gm-Gg: AZuq6aJDkLi/DiXH94koLZgZXZ0dmvDWgTIaoK9HI9OyTphXIAG/u9jEiXfvZk7pRXN
	WK/7infocxIqeRl4FmpKYQLa5V7Gf53lQXtNchm6SStYFdnLucM7mEbv7Hc/jCEXq8AsKs76SNE
	39xywmv2HWHgzkuD91uRLcS/V7L70OzbJnEw0dz/CLN3rgTlifU5ZkMDAJW2oUQiJA9qgWs6TVF
	YQhvAA1QZDBmTbpMkVyZmMZ4mtKnb5lG3C2o286GBwOy7O7Lv0Lhv5Fe5yVI1w9VkAjxmBVY8P4
	tPLElb59WMKgset+Fs+i+kCAfD19g5tefj0w8sNNPl7IthKoIPxrzAAFMEYEVNNhQ6L29G9Y+Kb
	EZVrubPf248sC+lUdY4lBoulZ0+JUs/7hLkcyfGDD
X-Received: by 2002:a17:903:41c2:b0:298:639b:a64f with SMTP id d9443c01a7336-2a9516a9e79mr26890415ad.6.1770376866496;
        Fri, 06 Feb 2026 03:21:06 -0800 (PST)
X-Received: by 2002:a17:903:41c2:b0:298:639b:a64f with SMTP id d9443c01a7336-2a9516a9e79mr26890235ad.6.1770376866024;
        Fri, 06 Feb 2026 03:21:06 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c50211sm21675905ad.5.2026.02.06.03.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 03:21:05 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v3 2/2] arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC
Date: Fri,  6 Feb 2026 16:50:53 +0530
Message-Id: <20260206112053.3287756-3-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206112053.3287756-1-neeraj.soni@oss.qualcomm.com>
References: <20260206112053.3287756-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OM0qHCaB c=1 sm=1 tr=0 ts=6985cea3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=w5lGHQi5D-TRKhmXJ3sA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA3OSBTYWx0ZWRfX2FEg5bFSLKMU
 G/mdI8pdUcN3M+TgLBH9GKTac06TUeohQ+ZZzelMRGtIZAHuBMHiWyjlVQQE4kH3igy+/DWxz6m
 N1gkINM8ZperfwfR7oWdSmj77sc5uCjSwXqrMJ37gOj3Gt+kSyHwbqIHSJ6cKUp/bgr1KaFA6Xh
 L9X2WFAg8IMtyFw/n/keExBuVlgyU3HkQCE+OmfpFheszN7rHIkbPGd1cNF21OYcS1SDmv3ZovI
 V1BEU0WGovl3YoGMgpDgPefyQLkDH8UJBJZ2XcRRZMDyJD11Sn6A3HhmsuypYUUCk/gBKnicgfN
 UVe6gwCsRibi91UV7/gM1GvN/Gm7OZebW5sUO6pGtU+7ToxVxTiAKfsjtpn5oZP26mcbYMqva98
 TB01nwu8gqZwXTe6EorMQKxGpouncwLwqr8flpcgFK5DiFDJJvPJipvapkGHuTfA9IVcMotJCxT
 hYQTQgXioyU6E4qTG8g==
X-Proofpoint-ORIG-GUID: HpRl_jt_U-XNSEDxasY6S8THKSeAXRkY
X-Proofpoint-GUID: HpRl_jt_U-XNSEDxasY6S8THKSeAXRkY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060079

Add an ICE node to kodiak SoC description and enable it by adding a
phandle to the SDHC node.

Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index c2ccbb67f800..de01a6669522 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -1045,6 +1045,8 @@ sdhc_1: mmc@7c4000 {
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
 
+			qcom,ice = <&sdhc_ice>;
+
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
 			mmc-hs400-1_8v;
@@ -1071,6 +1073,13 @@ opp-384000000 {
 			};
 		};
 
+		sdhc_ice: crypto@7c8000 {
+			compatible = "qcom,sc7280-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x007c8000 0x0 0x18000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>;
+		};
+
 		gpi_dma0: dma-controller@900000 {
 			#dma-cells = <3>;
 			compatible = "qcom,sc7280-gpi-dma", "qcom,sm6350-gpi-dma";
-- 
2.34.1

