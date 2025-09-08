Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DE72EAD1C
	for <linux-mmc@vger.kernel.org>; Mon,  8 Sep 2025 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319622; cv=none; b=SVqt43f7pxbCTYNArE1IHNLFmtazkdjIHJe95g3Fte9BKItAK8Lw99dDqhJW7E5na6hkQKvAXuDsMQpYZ+1mzIWrFzmC/M+xo6aZWs+emL0CxkRTVc8sIQzKOUdHbcQXSYBEEb73u3ozBRBQOmSYt2ABKR2C/u9qG78EpXQMWt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319622; c=relaxed/simple;
	bh=orOKlPtQLn5AGPhNEQlHkVZYfkJ9hhPyxvhObhS2CkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/FXRC2VxenQEyeVSZMS8BCS94UnezhVIIYU2lqyx39QaH7/uqH3qKjAP5vYluSQo88QDT2lcAbNoWwJlwPliniwHvaAm1jGljeJT9qhz36l8r4AiwnzRwlJII64ARIX5XE/tH5WchX/n5t/TeqwbV5M/sA07BeTnUHdIntnZzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hz7rxv8m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hz7rxv8m"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587LnPSQ028663
	for <linux-mmc@vger.kernel.org>; Mon, 8 Sep 2025 08:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uiQp9Gtm65Pdl4W6k0WxVxnFve96qzLdksXdOVeH1VU=; b=Hz7rxv8mmA3JvVJV
	CS3ADwafbY16xoZwLnciGXlSLw+pIRijKLqJ824/Cu2xMrLwLTsAh3PUAUqg2V/S
	r0uC3UEkkYOc9Lr77+YbRnzyAOCTAKHQgTPboFwUUpa3eI8errnpSXlIkv5KjnEv
	LtTkq4sbyTvIigTM+RJeMlOaIIGFkF43z43iA+Z7viP/3PWufYo21sV3Fcy9YPgA
	fEgXoNrgoa47Qoh7/NnOWPnNc+0jL78ZcRtkWorA9wcVIYwjCamN0pDe0wh+JRjN
	Ou4tWX4YKhdqKGQYeOVCKJ9Oh9ys9wuEFuBzDyWSV9IkG6yKKn80rgOu2odBp+R2
	yKvv+w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j3umk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 08:20:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445803f0cfso59310225ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 01:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319615; x=1757924415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiQp9Gtm65Pdl4W6k0WxVxnFve96qzLdksXdOVeH1VU=;
        b=dPttemvwy+SDW49zU7HdKARcH6u5e7SJ9KnvB/dm3OHiOKOTPTCY9CLErhVZoJfPRx
         r6WDFWsFs9tG0yU/Qlh4KZK0djs3n5eN68qQNqlEZEHqXbJVXjngzBph9iW455EGY0AD
         K/LHPvtzI8AnR+FV6L5xWQHl4WqZNrklnJ6qQobQZ5TbXQfWbsRg4MNUse5Rkox8kdJX
         4CBMrdjj5u5DDbagbAU8Iinsgw8DXK7HFMdqqG0zFwbEHQfbCOp7bZSPE6GW9EZX5c6M
         cOZ5ndRGlmDbbacmOTRYAsMgQ1C1BpknFgY62LoxClFNfERt65fjzkF+lRBwKZb0uRrR
         sGbA==
X-Forwarded-Encrypted: i=1; AJvYcCXCIVDEfl5IZuCxBlVrZaBn5wYScoBKrVdmKzw3014OI+HcTPMpAgd227Z+JumpxllVK/GAj30vjsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL76kRzATJDsmW8gSm+8yDZotjCAtxVjQZz5yCMggsYICOWf2N
	KiCpsL5TufLuVLvA2Ka2MWQw1Hmd4ucsPyx2AtDfrrkW4Q7hT0rBW2VTePMY4ECb/jyFZ7rE+fb
	JwpoX+O95k5E24rG8bfveLWGOuCKMPMsO3/I2MnYZMGQ30IoWUt8YwWqRH9tdJWDQalITQBA=
X-Gm-Gg: ASbGncsQciP0N80R4wwMblRuv/+wkeCEO849xDIcSKqi1tMAQNc84LvWHpBzED4nUZk
	7IaDw1IRqELLrlsVnihXG9TNdwLl/FFpx9DulSMSq/60yS3VQ8YQ2Lbyn7ZKojgmn3E/zpmBySW
	Aoi92NL4gzVO+5H2PQ6KFk8TIMFOES7PvIB6hf+Chi6eEBNXkTX2WdKfzQlaLf+oK6fAgEcCgMX
	EDXe9cVU0tlOdFrmc0d7X9W3QgwGmBI5cpv3pHgSAEL5OiITslJdf+VTt+/GAdg4BGoHz6hBmpP
	ofX/p9MVbPjyXlYiUaUalQPaxB1oM3e8TVhIE5iaL0Jku1yelLiB3PE2d1c/+zVsD9we
X-Received: by 2002:a17:902:eccf:b0:24e:47ea:9519 with SMTP id d9443c01a7336-251718ddac9mr98887245ad.47.1757319614666;
        Mon, 08 Sep 2025 01:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1vovZ9gkQhZX2rd/L1KkPL3qlKIyszAECpRN309/lL9U00EjRsbkgJQyBobjrCkcpgK0uuA==
X-Received: by 2002:a17:902:eccf:b0:24e:47ea:9519 with SMTP id d9443c01a7336-251718ddac9mr98886925ad.47.1757319614225;
        Mon, 08 Sep 2025 01:20:14 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:14 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:51 +0530
Subject: [PATCH v4 01/14] dt-bindings: mmc: sdhci-msm: Document the Lemans
 compatible
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-1-5c319c696a7d@oss.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=1254;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=v81wxg2XnsrITbgpwYn82teoXJQ/l0LPAItmU3R1jlg=;
 b=+5W9XDqLZ3HvskV0J+JhX/1XQy4z2UoMFE1DFgGDiojtHaS1/WyS2D/FlKi2vbAuaFXMThdCo
 qIZCasUOKXmAzeHCr4KNp9eFh0u7hWlbVQvGhT57cjHSkNuYspnI91N
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX8hCe86P5gMk9
 cX25A7ko7YGQkHbBmoIXkIyZd6kanUmwPnidsjvfY2hkQstPJBObt6eB/BJ9Ll9rjfsBIOzdU0B
 3Vcqxy9/xds7OGv6PreHyfkVVmOkJQrxsMwIO0Zb++Xg5nxEFLnvpTMSQrgkOBh1FLvJ+cZpzV/
 TanjUudpVln1oYRnKgK6EoYbCFe2f/2xojE+6GlljDG0RClQXVAvAfH0jZa/M3TdbO8ApJzz70J
 VxwhMk1bN+1Ya01DSxO2w6owA5VjMyde7GDZGlEWGZzGp5rB0kdz5xwf8vtkHRUJI6sqw+WfkHL
 tWJswgNf5U01ygdxnvpu8UkhIF2pogY/Dqo2IyBa6E6+JHGFgUiNHZ3hcnx3406qxeZT+74ECpY
 5QA9xEjE
X-Proofpoint-ORIG-GUID: qHvlrG9FuXnD-ShKjUfVzlKHDWCKoUfk
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68be91c3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=oyqPBBxx3V5-Y59TF94A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: qHvlrG9FuXnD-ShKjUfVzlKHDWCKoUfk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

From: Monish Chunara <quic_mchunara@quicinc.com>

Add the MSM SDHCI compatible name to support both eMMC and SD card for
Lemans, which uses 'sa8775p' as the fallback SoC. Ensure the new
compatible string matches existing Lemans-compatible formats without
introducing a new naming convention.

The SDHCI controller on Lemans is based on MSM SDHCI v5 IP. Hence,
document the compatible with "qcom,sdhci-msm-v5" as the fallback.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 22d1f50c3fd1..594bd174ff21 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -48,6 +48,7 @@ properties:
               - qcom,qcs615-sdhci
               - qcom,qcs8300-sdhci
               - qcom,qdu1000-sdhci
+              - qcom,sa8775p-sdhci
               - qcom,sar2130p-sdhci
               - qcom,sc7180-sdhci
               - qcom,sc7280-sdhci

-- 
2.51.0

