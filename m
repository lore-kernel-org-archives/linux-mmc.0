Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7843DA5E
	for <linux-mmc@vger.kernel.org>; Wed,  8 Jul 2026 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513074; cv=none; b=PChldAP0OZ5+0mns0vRcT6nvF7x6EpfoejhTIFmChcrHPkJVSUskIm/96fDmyefzgYpl1e9Gt/OftJhJ2F9CU6wH2aJ3AQJrSfGpE6UWRJ3Ik7OIZcFtYwePSXJ7klQrmv3rDVKqUB4pExNCzwOGu/vPymYHWwGMCXoyEPRosDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513074; c=relaxed/simple;
	bh=j9LrC7SvwrGJ5R59Zyt5T1ZwERBRq1xpSs/MEllIWkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8bTly4pON7pAiLKz6tHwVZ2m9DEYABCBp3WFcOakrapzmXTNjKbQsgJB2qRGHicdBQeu+PRpzd9gGAmjeogDSVAkDikPXu5kOIKaQP73tU1bbJWDkJvkLWF2DTObMqqA2FX9PqUO7buZghVaRZn12KB6WXf3nnVRKchIRbzUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i4I64sio; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LUK5wHUo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i4I64sio";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LUK5wHUo"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C43s62716500
	for <linux-mmc@vger.kernel.org>; Wed, 8 Jul 2026 12:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TwHspNqOIQ2ut6o0aX2sCzUdxZPsOJPL71oa2C3iLow=; b=i4I64sioWZOCeMal
	et6+no9jQvaQcNXS9yQNIheX6TR9D6kGiwANF2fgbKmJstJdUA0Kne2f4t0wQ6Ig
	URL2uKbXlUgycjY6PwcLOSSNyq+inlHAYKoApcH9pnGTwZg/EfgtoBijWndfbdgJ
	CCrem6FbaSWWpQG/LNrpuFeYpbHd0HWNJe/2aR8RpkKrA4Nx67FJYlM5YG8GsvGz
	MJsjH0NKE5jw+KzmMYLz6YunCZYp9qIFflFhXRFE758U3digXyundAP7vnjIyLtr
	/u97UMDxBLL3AtGomRf9CrupJPg5hVotu0B9I9NLGOsmTUZXs0QwhhMPM4QFDM0o
	EZVy2A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd4bs7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 08 Jul 2026 12:17:52 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848452dd146so1628291b3a.2
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jul 2026 05:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783513071; x=1784117871; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TwHspNqOIQ2ut6o0aX2sCzUdxZPsOJPL71oa2C3iLow=;
        b=LUK5wHUoURI2zonkc67HtNXyGZClmw7N8WV4eRcQN480DvcQxSBBAhrqY5wuAvn/Ur
         vHPE2UswtEG/OOTSA/6RcPwL3e7x+b1xKpMokQamtbTOQFxTzLQEw3gFaAt9N3qenPlE
         z2aiL+J5AbMBgaQBiILmgNTDIVHAwz9kEpUUhma5YLsRBCct03OpiZE/PFSfEux75l+v
         Q7rddaovSlcEIr3urYAOpvsKvM+0EXph/YBrd7UIEt+MkskKV7Jn1a92Q3sPvwuDud6v
         uFWZplrvnCnK2ydXqBt1C5PzxyHarHrYki99ItFhh3Mtu4z3Rgu+lebJxMVpHM6sqs36
         57FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783513071; x=1784117871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TwHspNqOIQ2ut6o0aX2sCzUdxZPsOJPL71oa2C3iLow=;
        b=YgVwnixZ3DswJnc+KdI5JMICTsHLXxeBL9X4Mawmo+IxQWz25SvEU+ylj3kfYiEqwa
         a+7Af9DTUXYnZCZcUioIRVQzTQ5aKH/JFQq+pdBLCxdA0XMb9I/2JQUi6O+b/vle9C+G
         90Sn1XgyfiK1Rg3dE5uBpIn1ipmsdhNF/NvGtQfC+dRsv27CG0HMUQvswThAJE4IhE5A
         KN4U9iJ9/BZYDPgQT5ekis3P1LuCSVyamLKOb9CgePt1OfYqCKvZBJn29Lg4jSfzRUec
         RYO+WBkyLgQZ53tShiHrfHEJFXNtONTwEG/G9+dksqVlXvo68cCADhc1881Dp5ed/bCq
         8qWw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4rwOfmZ7UJZHK4JEogWBss1QpSLrTsTU1fHeH3RoVbNq33hWtSDw6cLzeBw/sBr6XiZFMFh0krAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZxMuO97BhEfDPBfSIT8rwXmP47GEVGNfc961Ku74GWxkCRhQI
	HvU2fdN/LXJxGguldEM5vn5xV+CxUCpqzXk40bvGq1VQipzgYI3rcv3d4M2MHyYEQm9zhruSxio
	ochdzqXzcNgB5G4qzDbOcqKwOvnvz6Zte3/HwQXbopR/b1rHKZc3nyMWg5vxESnZ9S4ktEYw=
X-Gm-Gg: AfdE7clLLfTwFWJ0Xt15NehzPqwIp+Xjf1TP/vfZmeDZ9QpKNiXuLzVy66odKGuXvXI
	HEjcgXfsOR4w7mIr6RABMgqdl7CeMtzbET+mzZcmXl0Nh5XVINungIzOFvF7WXbmh3famt3VeiZ
	Mlclk3LNN+HpZ4wBrIXA1MMijvPALlm92eIQPo3AngRteTME8q5OBS7THMW/+UPJyZ1Moj4nzk5
	u69KCmpMm1Y/OtzqpM73ZmIe/TDjqdmidoviQz3DdrKQmROYjQonDeLenIXlvYDjLgNlKmHZwXF
	qtk4B4AsM7oE31IUL2AlUFOQ+vODgEY1kUb+fjlamMR36322xKWkpnCV1c7V0A5xgEpUeQ95nte
	9VKqQ+L+1YZoohxHMGOq6sKfGwA==
X-Received: by 2002:a05:6a00:a1b:b0:847:9656:4f6b with SMTP id d2e1a72fcca58-8484323d2c9mr2566207b3a.4.1783513071358;
        Wed, 08 Jul 2026 05:17:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:a1b:b0:847:9656:4f6b with SMTP id d2e1a72fcca58-8484323d2c9mr2566160b3a.4.1783513070836;
        Wed, 08 Jul 2026 05:17:50 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-848337d12ccsm2367474b3a.48.2026.07.08.05.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 05:17:50 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 17:47:30 +0530
Subject: [PATCH v7 1/5] dt-bindings: arm: qcom: Document Shikra and its EVK
 boards
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-shikra-dt-v7-1-977b65a300c1@oss.qualcomm.com>
References: <20260708-shikra-dt-v7-0-977b65a300c1@oss.qualcomm.com>
In-Reply-To: <20260708-shikra-dt-v7-0-977b65a300c1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783513058; l=1817;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=j9LrC7SvwrGJ5R59Zyt5T1ZwERBRq1xpSs/MEllIWkY=;
 b=L91IVVTTuBYVFSxkhdCViQAlausBGaigd1YeYtRCdEVL0Qlvkzr0oSZhr3a0/rR32ZEiJ0IC3
 cPjcr1Om0yLCDq7vHAqa+hj/7o6O1EaCtstqPKhTmz5zoFuL06+nPbn
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDExOSBTYWx0ZWRfXx12Bn9mBHZGO
 tauHwB6dq+GbJSt1qVsx/DGt9YkGVOoQRPIUOapKgMN0CpGZiuw/zylT9c+KiUjhlHOF72IfB1l
 xvfTM0sVqyA1mReJBWpdMLjszSun6CyquQ5ZZmrB0lRgPB3oZ/6i9Lm6fUwAP7Pea/oH0HmgvkI
 eU16+pTsUvWm5b/B0FI6PrUE6GuPiOrE+ibl6/FdUow0gTUGxdWRrITWPSelwBRSq0awbGmYKnc
 S972VHcYBqHCgh8RI4XfJSx+gO6e0nsYKsopnoYcPhdJVGeQTsCwTwf/EYa4tZaSuGSk3brdoYz
 P7j8FvMmC87sOv85DgLGtMlOtKfxzeuaRQ7URgRfI/yDNugas2zBtzloG0FjbtYvBmchxR3DlcZ
 kXFdq1pfPajsDMv9SFFuE28Y/RgEtG+pNUpTqltILIu9nH5i6YMfxR23jfKscBc4PBZI0pBh/ge
 cJ8GtDSrZXv6bbAuZoQ==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4e3ff0 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=nhUW8Zqzme2qF2hNOrkA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: n5qYLVFPVwdlpnx7WqN7ht3v52fqgHME
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDExOSBTYWx0ZWRfX1BSdzdwSjJaz
 IZfChszJr9Nas4tTKbmfLu+B1t2p0b/ChB2Vod0yabjoyVcf9fXz8+H+UypRxVqGR3I1zuqtan3
 kS79qGCmvnUe3mEp7Uew5G438dxqrlE=
X-Proofpoint-GUID: n5qYLVFPVwdlpnx7WqN7ht3v52fqgHME
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080119

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
index 9df4074bb582..b91eea5a0f91 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -982,6 +982,24 @@ properties:
               - qcom,sdx75-idp
           - const: qcom,sdx75
 
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

