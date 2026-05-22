Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AE63672B5
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472965; cv=none; b=tMtMO/NPhL32K+K1DT1Q6CuQ22SMCt6gbK6BON0teg2CV9NYxq2+sO/5ESapqbSdxCAXC2VW+gLHER+78mucFUbNP5Qzjtz0pyXXVvZbq7TZkBpDM3sAxnbNbJ8ZjPgVNR2nrRp5Q11feYsUmnBsWkSaH0us47LMpVA1pkBoJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472965; c=relaxed/simple;
	bh=TnKOE7unCT/HQOtvafKdSU3ITE0Jp3sab/TyCby1k78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+vt42SDv5xaSLk2ynoRtJg7hzP4p/IEPALAoW//NunTKgX5tZoILPkkZMdS5CvbOOgeYvxb65FyLq1KoBX0pBJCAdTbj81vszGMeR6jy+uWvaVlrtt1cJ5N4cuEr8CdcLLV4U3o1+hBX0T3YQR8L8Km/mIe9nodFAkruwRx5ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L/vzTRd/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KEZ3AXxW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L/vzTRd/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KEZ3AXxW"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MHVHAG312836
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 18:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	64LpLRRJIlxMY+JNBOraanlo/l9X9GJFOflyXf+N9/E=; b=L/vzTRd/DLlC2VXj
	pp+P5XTwaLPjttc+nI5EG0GgjUHRWO2xtpXUjdFq4i4YfO3HwN/keSWwPZyiEhTi
	6HFtrMqi1DqF62BozVGzayX+2iXqemx4UbDvCKBr0m/JW2HNVxJXOhnc7ftYjO76
	BiAEmHeiTUeuZA1itw3pgKnDDqIWaBTQCuzJ8/fHitHT8+yx6HTeGO+lN9c295LM
	4ueaSmMAI9mv1pxK9rAEydcCRqCwCWw84DYSlrypeohLMP+nHXdOaRTqRdjKQmL9
	GtKyqlVRpNDmgwsOpVKWYUhfl79RVjxnGWXpc4MD77eirA8k8Sl/rH3Pzg6W43iG
	PBSsDA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea88353tk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 18:02:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bd00a65673so56939125ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779472960; x=1780077760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64LpLRRJIlxMY+JNBOraanlo/l9X9GJFOflyXf+N9/E=;
        b=KEZ3AXxWyf9C6xzeE5VdP1PjkDHnev7t1ThWHy2k+eFeaZcvrKHetguVJlwIcF2RpV
         bT6xVUteZmoqpR5U7qTchlpPDibO7QUwBO/3os9n5/mk4RLx7O+gVuPGoAccJ4TE6zcn
         TNnxJ/HVM7ISL4PxQqCLCXxuA+Z4eMHrHe0UJ4dkv85vZP8PX+mdYhu9mFTAXQ0dlcc8
         B9SYMj9OfLGZCA/fdsaJ2TiVG5kYp+y57Omkks2y7Mj+5AOcUVM5I7VINJf6uGXswNcy
         uELSp3AQqjXH0/jpYuG5jeEAdzCF0VRHhnzL4rgwUkw8SruQnzSMgXXPQnYi3lTvcLBH
         jWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779472960; x=1780077760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=64LpLRRJIlxMY+JNBOraanlo/l9X9GJFOflyXf+N9/E=;
        b=lEWoch+lZmaYPUMdC06F6/G+YkA5Fm24Aio4PG31z6NskGZKPl8mitpHbnkG1jTyJq
         JoBrtkUWDF9i3LYFd7r5RefB54ARZlSnatEoCrnX3I3ii4vlUiUzrIXWofw93rQ0SHA6
         qfA0hqk43BLgxXxLO4aKW3AoXplDruBiT+rWqu5f0pRBtgcl3HzaFeYblBVlefbPNUx/
         EwuteHtqH4m8z5X0FleZlIAW0CkS2X3+odm/EWQUs2s7FO/04jU5ZzCRbDJhZMdszGos
         /GhVMTg4/cZ9cLuesd07A3XyY3AQHGMcli4lUXgVohud3CJSgIyKCQX7if54JIQUmjq0
         VOpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8O8bQ0o7zczMv7mXbH48y9OCq+wOUxJ55QrwhsXCh+Jmygfo1PR25Je7lTPdxOAf/r78Fdy2Cd8So=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq08yZKUgFCQ8BkcKKit6bT1Ha+gApw7ayLq6G9mUIFjqR00w1
	OWtzQzNL62x13SSyoj/leTA8DvsrWPxBPuwLybhFW2ik1i/31OdpljkZ2VepvynGWWS8R43cSKY
	Q/o0RybT+QqNx5uK9uj3Zxadf/DEbFG7aED/l4nHCWTCROGsyWEHpBaPn7pc94Y4=
X-Gm-Gg: Acq92OHY4Rr8zxDYK+V1PVLHdmgHZvTbcO+QRfnU4li75hhYgoeVcoLNOnNq6te8k4R
	rQLz7J17r5DM5HNmkgXyqTzOmZQEr0toAmCSVoRKmR5Ib69/jYBLWgyLUrguNCm+kWn2dUySx25
	f1D9Ixi94bAPr/MZGOTs7OYD4VnOLM1554LvznJ6SdV7Yf8VaDRXgyzyMzqQZUvJAregBjfQWJQ
	+y9VKs/Lh80arnIksB2V1VhHvX6LqEMu6PgAhTQifWms3s95BM0F8cdxBrf1Q6a5VLCCVJrwLOc
	Ryar4RIK8JpOcKXO+pVrdQXmrA/hFF15QC5O9QAUJIgddR9hPZ2s3JO1t8CoRurZ+EQHtcSECvb
	oHUTe6AB+jpEhA2qhW5ABFS77wzU8MWpUCR4H
X-Received: by 2002:a17:902:e78e:b0:2bc:977b:846d with SMTP id d9443c01a7336-2beb07b5161mr33830435ad.5.1779472960536;
        Fri, 22 May 2026 11:02:40 -0700 (PDT)
X-Received: by 2002:a17:902:e78e:b0:2bc:977b:846d with SMTP id d9443c01a7336-2beb07b5161mr33830045ad.5.1779472959931;
        Fri, 22 May 2026 11:02:39 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58ff106sm21193645ad.74.2026.05.22.11.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:02:39 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Fri, 22 May 2026 23:32:24 +0530
Subject: [PATCH v3 1/5] dt-bindings: arm: qcom: Document Shikra and its EVK
 boards
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-shikra-dt-v3-1-80ffde8a3dc4@oss.qualcomm.com>
References: <20260522-shikra-dt-v3-0-80ffde8a3dc4@oss.qualcomm.com>
In-Reply-To: <20260522-shikra-dt-v3-0-80ffde8a3dc4@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779472947; l=1681;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=TnKOE7unCT/HQOtvafKdSU3ITE0Jp3sab/TyCby1k78=;
 b=lipHYk4WInft7+V0GCh+adx+B5S1zW0zaOQCUNgDx1cFqTwFKxvaTvPyDS1IpBJ4n2RGHCZUq
 DbSRO0zd0KqASjomeFsYUocpU55FNf6eUK8ZW6IDjIFp/wuCNEdpOU/
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4MCBTYWx0ZWRfXy00KfCKkWuWE
 eVQhC5in0gc1cgiCngrI7gctLkd/i7AV3meqyt+2rsUqtpHimKFemc83cLFEKnPoxfxxz0jm5QK
 rBLbiDtKJuwjEtsU7SsYo0fpGWMqNJa3E7+m0BimaMZVKtLQaWzM23obzeN7oAFJU1DP0LQ2Eas
 5saFPiiIYHZ9Umyjxg1ONeTBM6WPvQu4tayypp0WoHP1UeETk3l/Lf6YB3IJKRMPi1qbzPok8pN
 cjw7amUeigtHEEQzFt4BKCPli1UboLGMeyDECrPsvC2Oq5hIcn8kjxZ7MbeXk82u91hE+Y8rEAU
 Dm4q6YQeCeLr6Wo4ql+7DWO/o3vrbk6bKTw6UszqscNZqIKeKicZabPDuq1uy01UG6xQh+GVvTC
 o8HtJmmR8CH8/SvvWJgKHmvSC0Z2qfynSYzZBXveQBQ/Q0iKkheXvSdP+rN7PYyjONeuJoGBRkI
 VXy+ntbulBgI76oymdQ==
X-Proofpoint-GUID: tM3I5DmCOwRaZETXgcHk93rxftBZ8JF4
X-Proofpoint-ORIG-GUID: tM3I5DmCOwRaZETXgcHk93rxftBZ8JF4
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=6a109a41 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=nhUW8Zqzme2qF2hNOrkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220180

Shikra is a Qualcomm IoT SoC available in a System-on-Module (SoM)
form factor. The SoM integrates the Shikra SoC, PMICs, and essential
passives, and is designed to be mounted on carrier boards.

Three eSoM variant are introduced:
  - CQM: retail variant with integrated modem
  - CQS: retail variant without modem
  - IQS: industrial-grade variant without modem

Each SoM variant pairs with a common EVK carrier board provides debug
UART, USB, and other peripheral interfaces.

Add compatible strings for the CQ2390M, CQ2390S, IQ2390S SoM variant and its
corresponding EVK boards.

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

