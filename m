Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE4C37F01E
	for <linux-mmc@vger.kernel.org>; Fri,  8 May 2026 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778235356; cv=none; b=Kze7OlqhWNE5WZpNVgPSC2gfBvIGa5kVy/McK1aVUt9u8/Ed7LBRhPTnt/pw2FWawSrhuMnvpbTTZy2vLU+DuWIReRump6Bt0pr24YX47NMVlJgI9YgEgcJ7K5ZjedCUgAVLeVOScr6X3yP77r9mj3IubVWsCsYIZNOsg5hhpFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778235356; c=relaxed/simple;
	bh=d52kYPY7riwcxCdOUNif6NfCC7DvyhFIgjNFOTmZb4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L12AuuU3hCmc/A0CrGXH8cGl9yU2jqPWXuG1fhiIjAjluMNg+tOre0dbt9Vh+U/sh930yZVJI33uSIlAMoXkYtXuiKLJRqwgEg3ypczx9R8xwYElFczKz6R657kod6ZqnxRuInKMUD4rBbab1AoUdCTegwxA3Cf3wgcacEUZRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rhymcf1I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gmKqHm28; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rhymcf1I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gmKqHm28"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6486JPR34069498
	for <linux-mmc@vger.kernel.org>; Fri, 8 May 2026 10:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Y1RWpNCQojSnmNVIho5cFZodOfF1qEz2h52
	lqG2MqTI=; b=Rhymcf1I2bk3qWMSQUG0ZS0Vi9s8T/wxC0wrqhrjSTM+Z+qkU3L
	YpbwLmjq7E3qS3vfJJQCvHx2pvYFr3a1y0HBURH5BlBBiTsR+HDS6Xvchy7ONqK3
	VtcFSXV3wI6w91wANaTmWZuB/w7B1yura5ZmrbrgylHvpVT5AQop5vjaHIGn2Agl
	efLT7PUsuE5bjg0LegE9qLoc8XbnNS5yyH4FDtcVRsPnU6KWtXXmsqpq2mpJiCiC
	+5Yiw0b3SrCRCP0PMriy3+AA05GKIClyLowImI3t7bKMpd3jjG40Q1OF3/dYhivI
	h+x5FWabNkJXru/na7pFSNkH3NjOTZvQgEw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e12sp2f0a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 08 May 2026 10:15:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso20997955ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2026 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778235354; x=1778840154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1RWpNCQojSnmNVIho5cFZodOfF1qEz2h52lqG2MqTI=;
        b=gmKqHm28dq+HkFslPg1DcKu2cqGgpzyzNAzidumbb7nhgDnNyZ2vUAuGJQvmlvewuz
         bJZoVV7POXYUZzY6NdRcFw6VvqerZrCJli0jxgTYg3SK8TFM5vnQG0GuPde6h/0QEIpu
         4bDd36X4Mh9WcsurBFjtiiPIoAQrsF7Nu67G96hP6uSH0g2om0JVkwDt+THmyij07K2C
         6TSVC50/YkCRFhP2GLGtiWJW76mlJrMSxBmvDHATeN70/gLB5Tdg24E5NBLDSwalowBy
         yuV2r+OXjIKMi+pVeSY1gkw+W156nU//h67SzEujTNeOELG7Ge0WcmYKXsK+0XaUzNNZ
         GNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778235354; x=1778840154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1RWpNCQojSnmNVIho5cFZodOfF1qEz2h52lqG2MqTI=;
        b=UVtqKebxXAqA/cy/G+gC4UJTWA+d2iWjMyqD/G6l/uGhs//ZB4A7bN1exeDcyGzjbe
         5umjOOv0iesbm0yaEZuJbixpxHkEkXz65G7UeObB6x4hh6CpLJSEjyizA9WIPhg6bSqy
         5JuU/WKigS72Qj3PVH/5zaJTxe/FkNsjX83mgsbfRb42oPVcXYv8gphkFE51UIM8YZMN
         crO1MHRfOfAP3K4NQZIXOmL3/xf+RalzwKDIUyeIN3F9OvgPr+chRIu5eFis0T6SmYL7
         lTE7f/gRbVg1xxMC64FA8LmdocQCrW7NwoZJ9Vb/2B0GXN4QqN/5CZSGuMA4etADF+IQ
         dqYA==
X-Forwarded-Encrypted: i=1; AFNElJ8BNVpb8GsbgXmlU214VQosBVUUw7BEuIiLg1ZF46duAvbRKdSEE1q2beogRnZ115oOiX0auU5Ohcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx8M3dvAi/DYDgrHNkZJxxAVu/9DnDzJF0zbHuwXL61Z8tuAFH
	1itMl1QKdkN4Y6VIhpDhAZE9T5Q6yvdvxVMm6EWT44r4DThb+moUDa+10myd0iwNpCOqyH2tytz
	KErpexG5FPi6C+a0gaaE6FT+t96WQRfl5SRVZ4x4Q8muWNbZGWKuf+cyvkm1ziZ0=
X-Gm-Gg: Acq92OGetV2D4FRnIEDjpdUh8cRccto9URevtYshIeBUaQFRJJZWdtK1kzsaqfHhNQp
	dXJmQ8z4KL3F/O7qbbdUrorhF+PySvkJNLgqRBRTm/5ySmWABBKQqnL1FLXCHfm6lI/pe6ODMbq
	/14KFcjJsBGJIU2P6rlW+TQ6L8f3a1VKhP7arixinpAzhKBxdxZz9bKVcFrXO0kWU2tb3jHLOfn
	cPCuMqpoetADzoiCSPUFwcVidacNhwnu+tcnFFcj00vGYGbOmf+HWiRdCLrot6rxfkSnWk+wfS7
	1d6RDHOZkkD3AgwLmHBdQ3dwJsHRk/CcebseAcjGnBUfV8NiAq/GDW08cl/BM1cM2+djT6KQWM0
	nrhgA28EpOmOd8m2B4wa8RLbmGHmJ6KvuigN50IoXSfCw4rI1sTsynSS8
X-Received: by 2002:a17:903:32ce:b0:2ba:307:4577 with SMTP id d9443c01a7336-2ba79285e29mr127190455ad.2.1778235353779;
        Fri, 08 May 2026 03:15:53 -0700 (PDT)
X-Received: by 2002:a17:903:32ce:b0:2ba:307:4577 with SMTP id d9443c01a7336-2ba79285e29mr127189535ad.2.1778235352646;
        Fri, 08 May 2026 03:15:52 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e75fffsm16374185ad.59.2026.05.08.03.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:15:52 -0700 (PDT)
From: Monish Chunara <monish.chunara@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Monish Chunara <monish.chunara@oss.qualcomm.com>
Subject: [PATCH V2] dt-bindings: mmc: sdhci-msm: Document the Shikra compatible
Date: Fri,  8 May 2026 15:45:44 +0530
Message-Id: <20260508101544.736317-1-monish.chunara@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNiBTYWx0ZWRfX1J4lWUF07wBf
 5qejodHxxHGOnnGGCbJOAJLxdmKs327+qYmPiE8gTlF+lKTtPZEQv4FSNlT98FNzuojDJYS3/WA
 VDnbCrjK3MsXiruEo1OWsER1JwmBSaIABauVHfO82YE4qXP7M2htLlBKxVyQTFFIrK/bnvrZqS+
 PWFiOv/txuUE4g6enbkoBw8cf0Rumj+zVrO9IDUjgtFL1KsqahME9rAFZBuWwjJRM6RXXdB7eTc
 UZbsV71uRsjcN501aJcyYooH692GQoXeA805qDtWp4St6U3G9ZmaJk2NTC5rs/XnqMxXaRnB97k
 +SFaLuNIQNLTfkC3gm1EINeqavH4081L3BP8T2hpNjEDpyWu+z7z6rcKL6uTXPrkzDZfZi8IymN
 JEOALYGJpRkZXDgTlGFUY5nM6okxmtrxp9DZoJBvQTSrpT3A9GDo4EpibFIUWRi1VX95TeuITj2
 E8t76o5oDMVCabGh8oA==
X-Proofpoint-ORIG-GUID: zso2DvCdazH1pzVtms8Pjt2vR3Ar4hll
X-Authority-Analysis: v=2.4 cv=Wu4b99fv c=1 sm=1 tr=0 ts=69fdb7da cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=qygL5ZPXpCHcVOvnN3UA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: zso2DvCdazH1pzVtms8Pjt2vR3Ar4hll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080106

Document the Shikra-specific SDHCI compatible in the sdhci-msm binding.
Use "qcom,sdhci-msm-v5" as the fallback compatible for the MSM SDHCI v5
controller used on Shikra.

Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 695a95e8f35d..60dc6b0caa21 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -62,6 +62,7 @@ properties:
               - qcom,sdx55-sdhci
               - qcom,sdx65-sdhci
               - qcom,sdx75-sdhci
+              - qcom,shikra-sdhci
               - qcom,sm6115-sdhci
               - qcom,sm6125-sdhci
               - qcom,sm6350-sdhci
-- 
2.34.1

