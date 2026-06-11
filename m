Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94E13C988D
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172629; cv=none; b=KNq/1uWXS+YmzjMwtmackLyqtp9PKxHyTkPaYn6EAViHQRu9XQJD6DYyYZJR2AMULAhAZvTbfOw5vAlQXAG0KEnFNI4F0wogu8CpqIXUq3JMRWY6OcrvIgtIlFa+ZoMYcdYO4v0W2vQk+KFBqqhgp6W+HCRtIOBisWYsAl85k88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172629; c=relaxed/simple;
	bh=O4cVCaQ46n8Ms5D3Bco+aQwbzl8/UIR3ClZEnBlY0Qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MXWkg6ECq1W03JOF+4NHEZ/IUUUihfdGeKYX/cZMYe5PB3xvMkS6DV/n+tW9Ztgf4DZUR9EfDZ9NjHnHvzAjPfbdBrCzOKboWCbpZeH0qLhmybn11UuUyU5O3IbF1zoHE/wbgh1cxL3i1T/F+Kq1REJn3T9ZBR6H6VcMQtR0dFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VNnGPWqS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JRg5RxPy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VNnGPWqS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JRg5RxPy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B9x6tJ267510
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 10:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MzoIeP/9RJB+tfcp0der6+uQoAklbzCN/nK9ht7zzAc=; b=VNnGPWqSy2JqD61F
	nL9FmVZiSw8cnXvlt5+f/tGowXcrNXRrXzS8QrqV+kxFvcoWwhZDq2Dy0OREh5Th
	6MasMh3ZE5vU7yunP91NhVwMKfwbDxRYDDlv/KwF93OeUHSLfrJ+VwOco8vEd7DD
	ASeg1yWhEkWv2re48LbtJpd2R5qA9dJBcWioD1fIr41aPx6wnI/+UuBHOErAGCYm
	DE6KwoMv1E5KRfObXatGvrLDkDaXjSau8jhSfIAtQl5JQJ90d7tAlzHirSq8qIFv
	5MKEJO8AOE/1M9v+D4PGP5KXF2g/fOnx7w4FtWaxrG51J2FnvdMaRUnNMfcOen4v
	K4rYrw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u2uxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 10:10:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36b934a336eso5724079a91.2
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 03:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781172626; x=1781777426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzoIeP/9RJB+tfcp0der6+uQoAklbzCN/nK9ht7zzAc=;
        b=JRg5RxPylTJFkbPCkxWgzobhfo9Da9H5YvGG8yLlcEJfH+otXzL9EPLAYVSvNZYVJ7
         65hog6Ggatb34G/RTZzLTNsVxOMQeF6Kkm50LVGZbM4S0xoU7OT2igp7U4gX6CXM4Sb1
         kcflSie7Nc+MFYu10hLZM3lYHDXVgarahfLxgp/JOaVDgwtaX5v8Y7Hcp+fy96Xu8nry
         s5EFJ7kiZ8WSEvDZbkrWyx/EJl7PYFpKz4GA04eV7jJJXnDgZnkRbogE/tFA6H3tKQel
         R47150qhsTX24s2zP3pGwhvV+qUftNq/W48XYKNS4mqcGNh4AwpLq/MC3mP6xw3NHQZI
         asZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172626; x=1781777426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MzoIeP/9RJB+tfcp0der6+uQoAklbzCN/nK9ht7zzAc=;
        b=eiL5SMBKzjYM0wHCpf5lBBO2r5p299VKK2LKW9hnuOvJhkWpwXpYu+Js1joq0rRiab
         7a/MFZHNJeYFP8I9SdOJ6HGG5TsbjveqG9L09AXfHxjG2z6Ms9aldeUYK4VQ9kv4ekmW
         L/ZFJsuZ61by/q55BqnEPmyxlL8oshkh8KG7qa05ivVoCIyGYtrhGQxsDBcb+1ZK48s6
         h/PxzjOt6V+NDcTUj3TnPSWfzMByATEo2sVgKcRvJaORe20GHiJydWKz69VE8PsT2PA0
         3QZZUDxuf8DEI32KDucHkutYemT4DdM/Ofcs3Xq2PjHgV6uNe8mLJvQkAZ4+9LioEW/l
         EnnQ==
X-Forwarded-Encrypted: i=1; AFNElJ8axD9SXbCIvps40B6xk0XU45JIWXqnMJlyglYRMACxokwkMq3n91/IwgDxUARDKPDPl5xXb0trSJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymGh3SEGCXGcDTGrnAjS4Dmh6G2t982a8cDdR/YwDNSVI3kAzI
	hCeLr7adJN4Cng1sMvVfydPMSngv/mbnrbtPRwIFbXiue/awj94MgK7Te8Qiwq1bCohzj93B2da
	ZNGd325S4E5Rjc5iyuFT8S1i1i//e3BHotOSS42YnxULqx/bjXykULvFQdZNhzp8=
X-Gm-Gg: Acq92OHSVftENBxA65fxFhalsQJH2li/45atLxUN87SlYWYqYzbBZF56/wwTDOr3JvM
	CJOskYTBXJ+8I2EySL6dhgj5hQuQdZn69qP5DARaSIhi7RFNOx7CX3I5e0oSiz6ry+18OKX8RTB
	n6Wornh2/wO5yhaAYop03vfekpwseRSBoPCA9wDlu6LjgtuIPPP6UkoyA4esdPxuipwNNKzt7og
	fQ+VQTaRc5McPZTuX1qtFO0V9/M9Vlvpw4GvmyfMQ0OxyT6qzpO1ZL8hJrL0tSMywTuQ0FFLy9I
	TctbbGCPibfJjpTlq0bokrIFd61j0kW/Mt/BONrvgTe4HKi7W14vD+K/y1RAsS10TzLMXn19UNE
	C4vfFm1bvvpvNnqwyo0pALmKjx/dN/4RnJk9vlw271NjctN0=
X-Received: by 2002:a05:6a20:7488:b0:3b4:85db:1bd0 with SMTP id adf61e73a8af0-3b5e31ec58fmr2473843637.12.1781172626237;
        Thu, 11 Jun 2026 03:10:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:7488:b0:3b4:85db:1bd0 with SMTP id adf61e73a8af0-3b5e31ec58fmr2473810637.12.1781172625795;
        Thu, 11 Jun 2026 03:10:25 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c865860f3d4sm1279646a12.19.2026.06.11.03.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:10:25 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 15:40:08 +0530
Subject: [PATCH v5 1/5] dt-bindings: arm: qcom: Document Shikra and its EVK
 boards
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-shikra-dt-v5-1-103ed26a8529@oss.qualcomm.com>
References: <20260611-shikra-dt-v5-0-103ed26a8529@oss.qualcomm.com>
In-Reply-To: <20260611-shikra-dt-v5-0-103ed26a8529@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781172612; l=1745;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=O4cVCaQ46n8Ms5D3Bco+aQwbzl8/UIR3ClZEnBlY0Qg=;
 b=wMdHmwjR+KCtwb/q9yjz1Y+EYFPfFw5vp82h6JtumrrfVeOIJGfb/Ulu9woGwL7HiLYyLVMjR
 7WnMQ1xz5mnAXq7G4Y9gpRi2oJa9p4rPEMrfIw4IWuzabkk7ublBhUc
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: j6Fz_fhjSZnh2xbIh1J0IQzQ6uDTGmP7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwMSBTYWx0ZWRfXz5pA1pd6b/E8
 5C8KHwvM53zc+ut8utZOCRNwhoYo6FLZ2RNUGFyoRfQQWQebOYibAexlSR8ZxiNqp8G5jPoPgFP
 UOsjCHgev5hmiPr7ZPNQu7RvRue4Vcg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwMSBTYWx0ZWRfX6EdldoWe2j04
 jp/INsmGsIcCWLWn1vosf9/fDJpp9x4y4YOGrqg8IMcuF17FB62ea/0eH6g5lVzPk+1OoIG9B9a
 HR+3kgiEVLo5gK/c1BR4i7HkArbj1vph6tEVZ1uanFEobL/6j9/+E2QcxLdAy1iEU2Y4PmTs6dE
 drusevLsSx1k1ZlUnMFkzpN/fjsRg2H9w0hgU6NQ+S3IXmCyKmjKH/MQ0VyuxVA9275fn6PH+dM
 hu3Yv3ZTkrTJemRjrpHnENjoTbJmXvzykgNFDPobckyY0YfSl3thpQkRPtOoQ27p+Em0OK3ZDoG
 nnsV6w6blMeZbSPjjJdZVdl7Jl1SrOMt9e+JCli/uxbxtwjF++Pl0eM7sliU3ZheNFXoH3hoKa5
 H4nM3n+/mvn8cA+QjC4dyEHaUl3IxccNaJ3jp0BP0qnT5PDtA0eh1DEpb2VHeI/2ji0PKBDzbNI
 v0PyvUy4vm0RH8X32dg==
X-Authority-Analysis: v=2.4 cv=F5lnsKhN c=1 sm=1 tr=0 ts=6a2a8992 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=nhUW8Zqzme2qF2hNOrkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: j6Fz_fhjSZnh2xbIh1J0IQzQ6uDTGmP7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110101

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

