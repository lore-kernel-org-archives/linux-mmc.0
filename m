Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA03A2FB624
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003989; cv=none; b=bNhMiStSXmMxmy3/60Ge9sBYmhWZzIn87r84Pozw67TnsTzq7ifhI2vmiPAk88MNYpw1a4RY/Demx09nBdgoKT9rAhF6feGNy2hxIXFMeEVuVezN2D7UwmOHIAGs9uQhWqD5dWYIyCCNEc+py+Afoc11vEsO9pp2fjCuU6UgAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003989; c=relaxed/simple;
	bh=HhL7R2sKeXiIqlZtecSPlVNqig495+ove8KywGSPyYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZTZvPooJ7NZqeUUZ3Hc71LP0buXhFeeFXksySnVC9zEPWgCEy5AfBAZDM6BUOp/DKiY3PdmYBpuKZ2XSlB0DplYirJTfmoAw8AgaUUqUoZLoEiOmWuSZuNvmZOp4zmIMblXqNYYBUcNhN+yFDnVb9J/kUsvcyIYgJwEtOsup1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dPrOq2X3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dPrOq2X3"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584GUtsF018505
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 16:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uKDDTZaIKoToqk8fUCVl9/PoEAVOsBabIY9X0ZzII60=; b=dPrOq2X30vuUjcqA
	qdDU5SBWGN61IJcp1GcTxGrJrHDKbP6MOFgss63MYZeZ8rrALkf/KhDPmwKE+3Yh
	AtPm1SlOx5XQhnSm30J60csq8lbT5MLJrfC4R3GuZHxqPD4k46HRuyD2zRhjT/Bg
	hfg089DB7yhUoBn4Y01T0SqPe6gsanl21ZNXCYqsq+1/QWa8UH0/biBhFqKEEIgM
	ClWfKbAQzX6scc0A+49oUPLSQH0iy8BM4lSQpQsGDgs2POXije92ocGphCeoPnfm
	vXz6UPwEkj38w2BYnKbxzluW1x5kFUy0yH9vrcEESWn451gi3D2vrwXU0v+KfRwG
	OvvCVw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebur14x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 16:39:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3234811cab3so1426758a91.3
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 09:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003985; x=1757608785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKDDTZaIKoToqk8fUCVl9/PoEAVOsBabIY9X0ZzII60=;
        b=ClQh0atPZPw/knItybFtD5b1r/2X1SpLUJCx/yXMV80R8aRzFnIAxltpHGtXxFeodl
         O0oUTZAfv9XX/HXhc9u55mVMkBg3W+s3obaNYPPz+mwNa4AbyL0XA3aACR5j7I/6iZEP
         Tur0EYFZwMu/kd/kMhsuPUDU7C+g3xgs3jquCtE9U9zJ3MLh60VEbKoc33GExPIP6Om1
         /4CM/izVeHzCcfmSJo/GB/ZcQD+GJBoQ491a8TOJeP+67Bx5Pyi7Na1ZVoFuLBhG/rS+
         /flWx9yXj6qI6Xa2k1M2ieXcQRW6wHUREHU1NxahslqL2H9MpF+nTVoxZJZVOWU5SJSZ
         8Y2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1Sijot09Qw8u6Y1UyX6+B6oxz8FW1217zkLPRSh0+3AsjceJUbV2M9DL2C27oSijUDeX2uN8Dj+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4TRMy/bavfmL51/dN2U9O2D6fJm6uUn1zQQgWSoe6celaOJNs
	RzbY84VhO1GGJn0Pl4vMy22+ywTiikM2BtY1B89vwkJw2Zpol4qZWK1vqr+cfiRJFm/l3OQuQe3
	AxLn8iz7NYCLyiN9orPojEMi3zOzKLBSYwZxC6xHKRw8xEFcl670emahE2/CcZ1M=
X-Gm-Gg: ASbGncv+KKTxvHknpjaAtWYTr7HzOgC+FrWvMypBDKIJdU0Ew9IBGJyzI3WwrI7GrUV
	+ZJhv39COoyI84LbfdP1Q4kiWpdNO6K5+5Q69016weqLlUOPHMsTevMgy9uqNMMFHa2RKenPoFH
	+6HVGlRrFNrZg/iWQhnW7fqpA7vWeBPE5JWDNHZ4ohWOSCf6yLsDWmrVZ+j4NWAq7qMsM+REM7i
	FzKw17SLmxCz/tQ4EOt5WIDvuwsxBJW9AvHv/sZ+4JudVCdkirEpkmMmRDvpupEWMAR5vQE78sv
	kGR63WRommWE1/wuaKHwEgo5sGokQlzmxj3ibgsMwgcF8dE79LFQiB1s71Ux/OeLyO6e
X-Received: by 2002:a17:90b:3c91:b0:32b:6223:259 with SMTP id 98e67ed59e1d1-32b62230456mr7502192a91.13.1757003985494;
        Thu, 04 Sep 2025 09:39:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcJGB1HfigKhlcseZuGD2dtBOZEFUdCtR1Qdkw0I+kOZzDpeSQstZ3kbfO4q41mt5kED78NA==
X-Received: by 2002:a17:90b:3c91:b0:32b:6223:259 with SMTP id 98e67ed59e1d1-32b62230456mr7502162a91.13.1757003985074;
        Thu, 04 Sep 2025 09:39:45 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:39:44 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:01 +0530
Subject: [PATCH v3 05/14] dt-bindings: eeprom: at24: Add compatible for
 Giantec GT24C256C
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-5-8bbaac1f25e8@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=724;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=HhL7R2sKeXiIqlZtecSPlVNqig495+ove8KywGSPyYM=;
 b=bgkk/VscrfaA2/hD0MOxPzz3j6BO3GCVxc+5R4gTrIIsO0E6coSAdgcyTz97r1uWzih4pZ74O
 0uVXMCw3Y02AEkF2PrgKKFK5vv/0lgO26zSG7N4OT1QRJWv4W77TVKT
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: AblLaAaj_Wr5yQerwmS3FJfS0u6KKxN8
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68b9c0d2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Yg4z3stHfqcsaZAJ4NoA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfX8kl5IGjd0GXc
 XJbR53AuyD3xutm3kczo/hgoAkAvJ0YYTzicI8KkxjAuf7cL4M3uq//zBugU1zyZqRXbJD0C1pV
 YPkkfAfB5NEefaYVHFTYRPkf/xYHr38stVWUf86VVoh+1wSmEb229SZcy9xKYJWuoZEdI8g+yiW
 yALHdNo0h9XmQYMcsia/shcaUeyBjSqToUMJfrpnJRfeXTZQpTunigOb8fCNCgLpuqBcDonJc6e
 GxraMLPzbAd9Ludr+JrZkBY1O5CJj+kGPuo8p2z5kPmuDMV4i161yX/jI/Kr507AR+XYYsY1GfO
 jYlhavPND4QVV1hc+zEtudFlIIksC//wCu8M5ZT1ZIhu8WNN/rPEL3Lkd7ObXj1pj/kDg3izE5E
 aqf1RGA8
X-Proofpoint-ORIG-GUID: AblLaAaj_Wr5yQerwmS3FJfS0u6KKxN8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163

Add the compatible for 256Kb EEPROM from Giantec.

Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/eeprom/at24.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
index 0ac68646c077..50af7ccf6e21 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
@@ -143,6 +143,7 @@ properties:
           - const: atmel,24c128
       - items:
           - enum:
+              - giantec,gt24c256c
               - puya,p24c256c
           - const: atmel,24c256
       - items:

-- 
2.51.0

