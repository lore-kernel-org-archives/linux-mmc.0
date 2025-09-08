Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E162F069B
	for <linux-mmc@vger.kernel.org>; Mon,  8 Sep 2025 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319639; cv=none; b=rUgvh7fb+TuCPnQ8bLmWHJ98gyPPYC7fq9uVJbvwCTeFzdu+/jsJkqb9BEIvMiq8pW+gxeoPRssY2/jBFiXZnm2w0UCa/fF4XaSo4u4zo1oTm1G4AXvxzaRshqtQrB+Z88gGyDvGiN2UMOc3wWclFPBFWRt/5cjmltNHxmJK580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319639; c=relaxed/simple;
	bh=uCabQVoOFgq1iT3EqXI3YF5nGk8yhaFHTlv/+rDaZ34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtVwcqrzTIZ/qMPG8yFdPIuRu/Hg479f5cAXu/hn8SQ4elKiLUU6vqmy8mK/VREEUVE80+G6QOsP7C17XyfQeIS15VPlg6anXUfAi09ZG+yexFhq8ricc9s+CcCAb1itHab/i81auYtdN4ooKjbWqOmBPyc9VYVA8/a+U80bcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=laV/wtme; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="laV/wtme"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5880020G012376
	for <linux-mmc@vger.kernel.org>; Mon, 8 Sep 2025 08:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/fYjgV0Vl5rUIq58+6skm/bOKinBzNn1z6h0/KEQ/Qc=; b=laV/wtmejxmrY2Yu
	PMgJUVmdOJlKq3MgpznXRTu54pF/ltxlNQYsfeJXsYDhOv8aP57vBuAUkFBlgKQI
	9r0vdzrPD2ParOsdSMfhT1NmG9+fdGDYoOf0MIaTX5mOEetwtLGVe57FjO2JRb27
	GevzX1txTbu1YUZI7w5hUipCwIC3ds1rZ7lbFQ9vzwaYItpTciMMUKEdRey0va1M
	3tsvptHLW7cpKxjRKT6Qgk4eccmRbOg+KHRWq2SsoPhKtQqYPs5ktz3DmYCUgdj8
	nSlPCyNhABGnlcB5LFouHD0kr7hbnkdPrwhd/uHflhsJ8Xo4TFyjIW7LdPOQonUK
	kN3Iwg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0ktc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 08:20:36 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24ced7cfa07so38137315ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 01:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319635; x=1757924435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fYjgV0Vl5rUIq58+6skm/bOKinBzNn1z6h0/KEQ/Qc=;
        b=an1oWw/2iKOAkitxC1bBGl4uY5Z+SN2rDgRTUaUDSC9PQci5lklkfivavSmXRE1ftJ
         YdFOgpDWHMYhlk9Q7NzEVdJpdPdgZwFZhymuwbKH3A4vrpLqYTVCxditpqGl11i8qWsk
         QWb6rFORMUHPJcBKyd4nvV2UYQ82aiRqKdWd+l3AzTOOKf/5753BOx+kax+vLlMaaXQx
         LUtzGEsfJsXFHOKnSVh+A7JCBm2vLs0HCBn+dBsVesUXMRuBl76ecCiJIf3L6m1vf9Vd
         Mx5ugRDABaFfGfNHnNISVDwf4olNW1spPRD0MSc++Mq3EgPMRJoS14zQ7boNMXxCASoJ
         O1YA==
X-Forwarded-Encrypted: i=1; AJvYcCV9PzzGWUgZbcuFL+NKk89wqVsKLEWtVhrlIDWTFaKydbxaQH2sOn5Oe9CsyB/aw/Q7C63tQtqKckc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyigP+WB92+0YraVZije26SBKRfoPD/Tp52Wtz542Vh7IHwnW6M
	Zpk7M9Ijjbqi6/ojJFMK0IO+hjMwlzCzf8j4hRH7g2XwJa6O21M+5IZLzWGHScFYx9kz3OX+1o/
	pMRtJTT+9RDVa85Aio389sHcM+/lRYOU6c64KCQK87dY1/ctJeXStvUnBZm17dL8=
X-Gm-Gg: ASbGncuqr/dQj+gn6KovVy7zh1naPpif0TdElXTvf1z/RXSiLlkfW18Pn1akMrYCc5b
	Tkj5An4C9VIRMX4mFbju/LXC+BLY7Od1+swSjvEPOIY+Aap1m4R4cmuccBr9nxZXxbhwt8drEK3
	erdnUR7gUdUqqmmfXtHZVulXkLgRKSowSJWHTm3s5bYfNblGqjHMU3+yYpJPgGvhw0pda/PpYTL
	I/aHHyKd+9VdXAb4WEc8JhOEHgG+GCHv67ChQ4ir9r8WXsQX6HDIVeAPbGlanimTSZ6ejsnBusi
	pPJFZq1tmt9fzsj0aRoK+1sKizKQTOgU1pfK4xxN2cFQidyaBTG3BeH8cqJL0oameZuc
X-Received: by 2002:a17:902:f68a:b0:24c:9c5c:30b7 with SMTP id d9443c01a7336-251736df08emr101411295ad.47.1757319635293;
        Mon, 08 Sep 2025 01:20:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKrtFSazAkcLdqZ1WPZZaD95ov6pQ8rl95v1Iw+xmoRmwhbaj9ZEWSRTt6f3p2ZxSAOucybw==
X-Received: by 2002:a17:902:f68a:b0:24c:9c5c:30b7 with SMTP id d9443c01a7336-251736df08emr101410865ad.47.1757319634799;
        Mon, 08 Sep 2025 01:20:34 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:34 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:55 +0530
Subject: [PATCH v4 05/14] dt-bindings: eeprom: at24: Add compatible for
 Giantec GT24C256C
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-5-5c319c696a7d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=988;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=uCabQVoOFgq1iT3EqXI3YF5nGk8yhaFHTlv/+rDaZ34=;
 b=IhpJ+58y31LYj7Hpt5kOaw/sdFIzhsHjVVE8uCnp9wndKJancFej1ClINAR6Q9BToUuPIreGg
 yJhq6NN1fIjAWfT8LoDh78/Y90MXDnxM4pV1qiyr2xupVu5h3bPa2PO
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: 8opoypcw20xgH65vojhvIyamJJxdCtX_
X-Proofpoint-GUID: 8opoypcw20xgH65vojhvIyamJJxdCtX_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfXxEV6Pg83XMcz
 SxCeODJpGCGghg/RDVq0STJK9hGLOkruhwdjou6Wqv1ooE62z9QQNXU7aofoS4WrktMoKSRZdJY
 wej2ddJP+SfcHaI5S9xcVd2oMgFQOUo7Jx+nFew3TtkBn6bPdY5P2YjV7kK3+EH+CZlX/jiT5UU
 lSW8B0oeNIGnKezcIC0qfN0VPfBUnrAvb5+d2NCsLZYG2M04f+/O5M+azgVGDORqZknB2VrU9A7
 By1kHtUg3DFt+mmLMfJQeSW1tED79YdFhvd/VDS8V3JM+xMGWPXOpQ1N2cHarGHCC1s/ALncAwx
 M5WJlc+rMoVXl57tyS829XTdL+vHH3NqS5mUX4Oa90cpJCkmMTm6kKJI+KTgynLpcv6V1BRvBJ5
 L48McBcr
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68be91d4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=phLo9lBTfqDeDZSmmEMA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

The gt24c256c is another 24c256 compatible EEPROM, and does not
follow the generic name matching, so add a separate compatible for it.
This ensures accurate device-tree representation and enables proper
kernel support for systems using this part.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

