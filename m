Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204AD403E95
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781285277; cv=none; b=fe4ytN02avLYJPT5RG6oBb6RW3mwwuPvPSb+QrA7sOTxupq31tDjrJUzDeg5Xwc47HkD/xoe9dYqVMGEtQdVYLcKc6ZtGJKVgTEtdRDwEr0rJJ8f1ZflzokvxcXI45vy6sni5zu8wvRfo3wccgHHCi+/oGCSXGVnxkpzryoyCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781285277; c=relaxed/simple;
	bh=7BvGgsMzIym3cFm938zERz/XKsgQcAutut856Vu3XHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pHfwbT+VgLS+Rc0RvVJaKAi0ebzDIkF/2DASNMgcXc/bc+XKxJ1DSNnP+GIwEnXxSDaGbBb7ScmAipYD04g5ekkXEoQH/gFupnjOY169j6+s2tcTopkCda6hVTOnp8AaM212nJ3dB0FjuOPKXLHQYSZSSWUML5BinBFoaUaoFJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S8i5Wr47; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M+BRGMG2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S8i5Wr47";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M+BRGMG2"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CGWDU4019980
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 17:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0B3aL8wANNFMcgo2EUByGJXGvJUE1R3H+briV1PRdNw=; b=S8i5Wr47700KpzIG
	cp/cdtfK0IUskhEYqG4UEm4ShwaFYiJIFzMfif06v/xIx8d9evwFsWeNGlnckidX
	VRsZXxmOcpVKoI8GJP1iRhCNCKqSrVlqZc/Nzpi5Irpvf1C99Ff9ixoRduVGIgrG
	wSP0H4Zs2jDvMFeL2VlyHTKdPf+6S6ftDEjaAOxO6DwbLcgg5/dN5YfnUtmr8RET
	+zDJUmLZKfQKK0j12mvbbkTmC3eAG7RHVpFlacZzOqnymgUEjph3W2z2yhqKyx9R
	iGwqKblizRlawLJTCOXKqLmpLr+q9rEnUPiqfSvL2NHwwdoVAUb0PUHBywgLehcJ
	edkYbA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1cbmau5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 17:27:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c2d65d9792so7411355ad.0
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781285274; x=1781890074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0B3aL8wANNFMcgo2EUByGJXGvJUE1R3H+briV1PRdNw=;
        b=M+BRGMG2iWWBfaYCffMrA3FHhVpQ29ET3tPu6jWj1wr0U4eBHeCxWGpbOhyob9P7k7
         yFXjrMzR0wn/izneYspDY/isYEtH0oWkBA1yPC/KpWWhZjAMCdBktBMy2xeohzvIyBnE
         sI1142H5F2aBsLE5iC2RKnPuUAsXJc/qbQKhq+lg5rRGCLo3tLNxzGF3L+J8QfqWrhSX
         /SNHH25XWn7520iRsZ+C0DimZBmnpoLuauKrh6E6+r5hJ5u+LvtTO5evhDhayAtaUpmJ
         dty+Kgi+CgXF2xdtvjlHLWpIbIFwEum3oRybv8zEx0PMwbwVKNcB3Nz0nGcCrUgl3SmF
         vCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781285274; x=1781890074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0B3aL8wANNFMcgo2EUByGJXGvJUE1R3H+briV1PRdNw=;
        b=MwqMMlbSQzJGLApPC7CEuwA2/kwC9O26bVngRLQmZW5S35WXuJ8/pXZdBK4D5+JmBg
         P5OvnYe2LqAPV9OSOVHeVBFC64Orom0UbsuKjedL18AgdwkrqdcZ4nUd3srBk6TyQfC1
         OX9FX7lO5W0+ZdUG98XwkySxYClj7FEsTwZan26YxH7nuUDvlpN25oQ1qJYFiBBvcMTR
         DIFQOmn8dK8fzgNDiKAZXl6rlnE+j54boDTTu98fMb8yz0yJt+n3Q1hcEJICGRR78j1V
         ZNafGxQo3u7hdrvYVP8APJFGFD7VLXbvg8wXlgm/6TZtSJAxt3PMlRRUKdDf9VaLOs5V
         CvuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/RcdJKdQrZeubdyH1Ucv/ACE4iLyJ1V1YeRDOxcJeqyjLn2dQaoU08P0PaljpAic2mX6V8m0f7ivw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxluaUGiNRDZMboeebQVagMDHG1Ix7C/9pckPhrxb+2ZPEXUq5
	N9VVNGfjObfw2PZIw17vB3Yl0tcQNT3+FDG/Givmn4+XQDmVHQCoLJ07ASfashJdqs5p5tzDZJj
	btw5JomgXQCbrSXWXkP/HCe01EMNZZiM2EQUVng5nQOsJ6Dm6Aigb0Qmg5l45fds=
X-Gm-Gg: Acq92OHLiMGcmfuoL0hYuUCK6dTB7xOOx+deiLBKKsIMIGve9V9FxTApM0oBdmgNsfY
	zXiOBfVQmVdLea9hsm9+xoNG1Y2aIabyXWpFr8PYOsu5tEwhK1xc88M+alxBZZzjlZkf8q2Z04R
	S7qCXfvLtbQUmJmbyGs1m2S9z1yPpzEVDHL1xewlHuwu+STB1f2jaweWEzpC2H4GyOcIQ05ylxx
	/xITMxepipC8xPsYqZ8F+eAGQKnjvF/z0/hOZEm3uHkJS/CEF/SHUDPUcR4cKf7dxM5lTNOKAJ/
	RUlGPknJxWUaO+GFN5f9u6VlM1MVUZZBwUNbF5lsCg5QoThalf+Ph7sSxv7TZeii0kZT5VyiaXs
	MMXbPCZkaOBs+xQLaKl4i7apgxaFiiAExXzUh
X-Received: by 2002:a17:903:2341:b0:2c0:af09:f3d9 with SMTP id d9443c01a7336-2c4136e38dbmr45137815ad.36.1781285274048;
        Fri, 12 Jun 2026 10:27:54 -0700 (PDT)
X-Received: by 2002:a17:903:2341:b0:2c0:af09:f3d9 with SMTP id d9443c01a7336-2c4136e38dbmr45137545ad.36.1781285273578;
        Fri, 12 Jun 2026 10:27:53 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327acae2sm24278105ad.52.2026.06.12.10.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:27:53 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 22:57:37 +0530
Subject: [PATCH v6 1/5] dt-bindings: arm: qcom: Document Shikra and its EVK
 boards
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-shikra-dt-v6-1-6b6cb58db477@oss.qualcomm.com>
References: <20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com>
In-Reply-To: <20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781285260; l=1818;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=7BvGgsMzIym3cFm938zERz/XKsgQcAutut856Vu3XHQ=;
 b=u6nbiWUBsu6TxrfPJwAk9JiZJQBGrhvswgZqlmEjggQJYKOmEHyj3ViLkUguSgSupnYFN8aAH
 qeOF8AtuGgiD5LTNhnnXgqdnaNJwvJfgXSSnPjzLd6adzxtvOMhZrA6
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: Gj3b2z-suIO3lyQg1WpZdayOoaua88XQ
X-Proofpoint-ORIG-GUID: Gj3b2z-suIO3lyQg1WpZdayOoaua88XQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE2MiBTYWx0ZWRfX4DSRSfVZewkd
 9KWuHIXaXoB3UZxARsQ6asHf3I5em8TvZk8ZKyWwgdHQ18OM6q9khps2B6KQvN9TMp5SUlueQu1
 p9yzDOxbv41q149B/M4Eq6lDMpJ/+g8=
X-Authority-Analysis: v=2.4 cv=S57pBosP c=1 sm=1 tr=0 ts=6a2c419b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=nhUW8Zqzme2qF2hNOrkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE2MiBTYWx0ZWRfXxj5h4M79p+Gz
 hkm3LiRb5l14uCdtWGx0LeuaeERJ5KeTOl6UygTp319ba45CFN1qri53YgoYaGjhPnRWb7KnhWY
 k2Pj+wRglI989tIub19Mlob5EPnKEkTQm3HqFnc5ZByHinfggybX7yudQ+r8JqLauXvDZMaPbe7
 KdVKh/dNelRjcnXGN+dI8jlGZkfzKmNP7hTmXVvnx/STUiQ0saC6yIaNegTZWLmldku02BPeWIZ
 TeBFvPQuEbZBru+V77dVeEhulZ6U/A1k33tAQWjYQFt92N3PpJlSeDIsqiZkz4/kZVcO637Yf6p
 kmr94wW6huCAYRvvOcZC6NcXn8uLfyo4qVW9yaZoteZ3lQ6Szx6Y4bL3pxEJ2eiPfu9DseK/WGg
 gl5PVN9bpaU44LMfruO03U5nrwLPfF5sL7Yg+zxnjRf+tqVV+WDf+RbfZssLWqwRzhRGJ5wX1ay
 VNfa5UZ6SFluAZYiivw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120162

Shikra is a Qualcomm IoT SoC available in a System-on-Module (SoM)
form factor. The SoM integrates the Shikra SoC, PMICs, and essential
passives, and is designed to be mounted on carrier boards.

Three eSoM variant are introduced:
  - CQM: retail variant with integrated modem (PM4125 and PM8005 PMIC)
  - CQS: retail variant without modem (PM4125 and PM8005 PMIC)
  - IQS: industrial-grade variant without modem (PM8150 PMIC)

Each SoM variant pairs with a common EVK carrier board provides debug
UART, USB, and other peripheral interfaces.

Add compatible strings for the CQ2390M, CQ2390S, IQ2390S SoM variant and
its corresponding EVK boards.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 50cc18a6ec5e..cf7d241f8107 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -989,6 +989,24 @@ properties:
               - xiaomi,polaris
           - const: qcom,sdm845
 
+      - items:
+          - enum:
+              - qcom,shikra-cqm-evk
+          - const: qcom,shikra-cqm-som
+          - const: qcom,shikra
+
+      - items:
+          - enum:
+              - qcom,shikra-cqs-evk
+          - const: qcom,shikra-cqs-som
+          - const: qcom,shikra
+
+      - items:
+          - enum:
+              - qcom,shikra-iqs-evk
+          - const: qcom,shikra-iqs-som
+          - const: qcom,shikra
+
       - items:
           - enum:
               - oneplus,billie2

-- 
2.34.1

