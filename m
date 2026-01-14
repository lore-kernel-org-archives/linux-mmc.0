Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB31E5B7A
	for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2026 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384143; cv=none; b=sFcAgAFcdpjJakXtz1uMT4J+J9xod+H0AjhOeGmxOfvTlBgAkNzwIlCBfYXYW+/htt670/IammU3LLjmgbdfM9lxkXJgPWQlcUAicQhwgJs9s9khMmKYlq4rTz6xWLjGwOWRaIaA27LEmLzzII0yCROChehwzV9OhzCEVL4uyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384143; c=relaxed/simple;
	bh=Vcq9FnAh9K7hn41Ha3jBOE5GONHVn//e8Bc2QhDaSFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HnQo+hr0o1S2K4+u2NAP5yn8AXrRZ3bWXfzsxuJLdG5Sw6e26QcXLQGwR/P4CiEtzSILBD6FRDhcI9aF69swhXTejMf0nJ0pCBNGnid6UZc0p2cnhTA1N6zzXbx5fINsOfY2V41nT/RXlxr3iMKd22BwSPVKCPFdt4onWCkMwfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UmkR8cgX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hlXPL/px; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UmkR8cgX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hlXPL/px"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E9joi43296271
	for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2026 09:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KfqjC9EoK59
	1QloyQMxsU9S+rWY2Ha/8IPmBSa555rA=; b=UmkR8cgXzI2mlpCNy3cn8j/wngh
	ODux/RIctZ/7SJvC10RUkHO9wLjtSfJPl1rDFOY0UKRz6t/pXo/pfZGuGrtEyVlu
	ygAW18ScctkwVK0iKvGsbcIkGhSSZdKRW7hYY8B3rDCl2Se+nX5yNKgASqSsOTVQ
	56keMyiYAtZ6B1Su2WVXC/DVSjfaQP9+urKHinXviZP30QNzX+AQGB5iErTGDzcd
	FazwbLDwLlxBwW2PQQC6ajr9Junyw9tSHVHAUe2yYl6wD5DNYe1gzw4XUadqA3zF
	bax81Kj8Og+I1mg7REHQxK2UxQcfo0wGR+oDtoPf4o8nB7h9LljC44bQ5CQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp8t2r0np-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2026 09:49:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0fe4ade9eso80391865ad.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2026 01:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768384139; x=1768988939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfqjC9EoK591QloyQMxsU9S+rWY2Ha/8IPmBSa555rA=;
        b=hlXPL/px8+jvFc4xdQfELrX6dbJOWzGaUeXSfLUqLxhXSeK6M8GRcIlr/gxMLkZ4qB
         HdMQVUFRMvtET44BDN4dKPk5+/QJdcGAQ0x8EfDPuPkUvg24llVvfih5gWyJnklLDOQX
         ISBgpAcs3gEY58nKSIXdRKIxKbYdVgyyrIzVEfbR0uQN0xin06mUIlhkHnEfdiiNhhYe
         m8f7dHSVgTlqVzQbdQTf05NZwqlLocEFZFzWKEO23vCgP4XCrg/KQzNYoBeKpqggj7g1
         58mBAImDzJh6JcpBfUaEobD48ndG5DKrdWmHQaqUbLoWXHQEjlzA5pj2zXVN5/4NK/Nl
         th4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768384139; x=1768988939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KfqjC9EoK591QloyQMxsU9S+rWY2Ha/8IPmBSa555rA=;
        b=B5cs2/9L1kONMzNm17kj1RpXjJhvoJBUgsJtIFklAiQ5GJmYp03y4ByZTrYGwWD+yQ
         1KvXaj5rxupbAK6dnQieUB+nSToIkYQJSPEaUV/w0BTpTy37ZDtJh3xodvjeAmxhHxpZ
         KAdrdrkxVGxNQK4TdF9I2y2D8xbmKkhIFQg2zb8Z60noHtijvQRbqaTHfEpTHc4eJWfS
         DPa+A2bA57zTPX7p+5PPKVBBYvx73YpJcefZPp12G3qOU48p4LBgYfzaph/f7GA+CsQ4
         gs5uBT8tK8g2lWeqTI1dPkCbY9WfiuaJ9vP4gq7dOjVi31N5D5oeayR0LdcDl75RgQEX
         /muA==
X-Gm-Message-State: AOJu0YyQlJhhL3Imphgr13Wkhk76ILPyxB4H88D3yxWQYJMTjBOZVwzM
	mt+0rCxNxqwdGeag6mvI6q2SX6+//97JywwAtZ8ahp8ZvLl5+W6REYIBaisvysxIj7OzC8XfHv8
	tuTIpfRoiK+BBHNq1tayLUvFtBL72/Jtmkm6+fug/FWEimefRpv5e8OPd/1G25KE=
X-Gm-Gg: AY/fxX5E4vagG45vVnx4HglgneNbkmk3jcP/wrzuprFLWUBlxdJ3eIVs9VScsHjGsgW
	eGPLyuS/F0YV8Jt+fUZV38t9DA7TMS0ahjF/K++QZ507yzh4H6wcrpS+9dVYGSy64WY1bmelyc3
	1k5sgLUMb0/eY9EiWV5DEv4y4ymzwmr4Ga0LfzvQB9LAqZm2fSi7VYfpG8umHMRQ/AGWHfU4ulF
	sgXsQk2wt8l7+COS+McU5Bdky6OLN5aAUjkYjeFD04U+QZlSy+QKPBBKkEJ1+ns0r1p1aZWuIL8
	yoEp/ZcPnwHdNmsKi3GRXF20UXtjVWNC4tIuQOy1XSyPlQORbQhN6ddKxgfSqKdDTgYHCTxbVf6
	Cbx4wnbfxGFrL6rlNn+c5ynidVZFPKABQNtUI1QbL
X-Received: by 2002:a17:903:b0f:b0:2a0:d364:983b with SMTP id d9443c01a7336-2a599e5cb87mr17739515ad.60.1768384139516;
        Wed, 14 Jan 2026 01:48:59 -0800 (PST)
X-Received: by 2002:a17:903:b0f:b0:2a0:d364:983b with SMTP id d9443c01a7336-2a599e5cb87mr17739325ad.60.1768384138968;
        Wed, 14 Jan 2026 01:48:58 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2d93sm225335075ad.63.2026.01.14.01.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 01:48:58 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v2 2/2] arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC
Date: Wed, 14 Jan 2026 15:18:48 +0530
Message-Id: <20260114094848.3790487-3-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com>
References: <20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YPaSCBGx c=1 sm=1 tr=0 ts=6967668c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=w5lGHQi5D-TRKhmXJ3sA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA3OSBTYWx0ZWRfX5gSlrZvEaao8
 f5hMJRk6tPqncmgMJRHf6d/2R68mzvKPX8xnTCwgvjrQvkdH9IotL1QQbyq95NmqQYJ1Loyf/GA
 jNBYqI+ZZyDOdwtdiSGfb7loh/UU644Ws1kd1tiT4WvmCjJKK6vtbyzMXI0SEkQwcnwy6u4UxkX
 7yAvTfqOnJ3XLJIwhlTZVlWG/mlmr/XKPh+pInlX5LDhpiIqdqKFgOITut97hgICmGCqKeQ85Ln
 k/lA0Sg8qtFei4xRdQCVeJmgZwe5g67jDbilaf1XQrcuMvkZz6AETNBDtJZXWviIJ/uMxNrSXmo
 jnybpwJ9l5bKOEmYBa1chspvb/Y3Ai9bfHURR2bleTwsUhJamqwKqFsD/FGRu6Que0kuL3+mItu
 /BiZ8YMc7hRXA+56KNS+GLy/0PSfx1eGEZuHsaJQUN97OT0ceXhCACMzIVbg/75/HL0mamF/QSh
 j1dNdIB8ZuocN1QVDpQ==
X-Proofpoint-GUID: vCjp4dcLW-S1GHO7u5aJLDmU6RKdCIyd
X-Proofpoint-ORIG-GUID: vCjp4dcLW-S1GHO7u5aJLDmU6RKdCIyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140079

Add an ICE node to kodiak SoC description and enable it by adding a
phandle to the SDHC node.

Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index c2ccbb67f800..fb2a9c0ea0f5 100644
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
 
+		sdhc_ice: crypto@7C8000 {
+			compatible = "qcom,sc7280-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x007C8000 0x0 0x18000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>;
+		};
+
 		gpi_dma0: dma-controller@900000 {
 			#dma-cells = <3>;
 			compatible = "qcom,sc7280-gpi-dma", "qcom,sm6350-gpi-dma";
-- 
2.34.1

