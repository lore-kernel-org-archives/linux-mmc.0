Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982CC36CC7A
	for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756232492; cv=none; b=J2TYp1UkHLuB4XF07OWtwzCFwrdGfKLoGYZ5run8NKfID3KjMBdN66/mIsNkGqWTuFjhk+zCY2KN5cUkPrmZpa7I31JHMkTC6XxZ0/LGljbDQMsgxemUDI1s4KV9o3eNmGwml8eEoZn0POZV421FrQkeW44gQTqRHRKJEXdAD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756232492; c=relaxed/simple;
	bh=JxYcgKcmhaQur96n/POTBQUFznkRKuR1GNH5Rn9msRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0gtKl1Fn88jjUOhWaPqYCQ5OwKBoZ1Xx3wSXb3A2+ucK5vj7zBYeHRj4JphjDCzfZSQhxBtN6tvep8BMCntgMSuyfDG+p34sN0H9ysuABkifiljWLlovW7RQdgACI73PlQhftJT8sZjGRzAeXXhzcCzT/5FjpgaB/+OIuUWT0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=auS89GN1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="auS89GN1"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QDBIjX027928
	for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eL0QgrgRy3cWfotIYWgvsMBQYI7kvhF7uQsBTion3yA=; b=auS89GN1MxwKhY5Y
	eyute2YrIR2oGMQkEgnhXLr349CrCx2PQv7B//8ltmJTQaDC0MBQ0C9hNLDX6aDC
	r92r6tipLqBldJHRVt+fG5WqwOS4HIrJ8UWtdo8Qkp1IWNVQ/WZq9NF0K1w/OsPi
	g8JOoNmFfyBx0DWHh297CVA2vMkWcVx3i7k89KC8jz09tOY6Hpp0evY9vbWbtXco
	xfGvVToEDb7/5QCKhASJvgtIvhlr18z1mpQvgyJBcEdt1sGVKGVGsaFpy/CCP3t/
	BkFSKCRYLCl3BuHc1/QKqopukyWVdrzZGxbzOYUQMP1YEXISMnjrKLkBOzvZdkg4
	Xgf18A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we1t80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:21:29 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e395107e2so5535618b3a.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 11:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756232488; x=1756837288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eL0QgrgRy3cWfotIYWgvsMBQYI7kvhF7uQsBTion3yA=;
        b=dusEvM7eZcHkOZctSfDxPgSGKg0EsLE1jIMjdYzTkeNZ2jU6P3I2hzAAVos4JoYSuR
         RdYs0zttsBlc6NISElXw4kBB2Y1fBH/CvJrELASbesumBHz9PVaCG6RBsTZpMUScAER/
         zKHLN8YsSk35ZLZ9KLnpoXmpgJb9D07SaUiAdMzjF4FNP6MnJotS3NVQ1lcZyYKqkXlI
         XhriIme0OoQMMBfBiuOzCk33Knn7OPPLIMqwofoGOdMoIw4sXUum9OprBLEehUjTZIH6
         dSOyoE7WsYx201XtMWtcJE1h/wI7Q8WDl15vml/yJPjeonJxhI5xg3I66fjyjB7LAJTX
         mY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwd5pl1yk2Xy+SmlLZ+yWJfntK1E3owyMQWae9ZiQ64lOi5OIWtjvN1g/xhP/kg1U61lRSiyB1f8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWxwP1cXXQI7CKMVORpkkCsNAqtt7wWRykzjyJingrWcWfqjeS
	AUNxBKXX9coDxUJAbdK5AbCXDfWfbj5oTqDgsiLAkYISjDswOMDXgNWYJ2DCpcMnr2DcdLsBY7A
	PNOsbhKsXll/S92MaIbUOrjJmNcA5UVxqmgaTs1WBOpqYbJ7tRuO/S/HI4AHMcIg=
X-Gm-Gg: ASbGncshIHFZy76EXSYjgyAHgaF/KYOVypy//V43opuBt3sSm/0ptyu2opFPaZzIDBc
	Y5o/kEKoT2sywfAFH+OW3d113sSekGuxZNGLblJblb533Mv2p1izJHAJTfgC6HM4SlsT8GR96Y0
	I3BrTr6CenrqP2lzACltKMB7N8oabEhUQpN/+T03B00ehyw674l3ioSeeq8HDq97WLyb9sGHQU/
	EaciDd2OWK1J4MFbr9P0oEebSbQDQUKrBqJNiYQTqr+ejlUhZRcPpjIkU8/kKj+Eiho9hS/Y6pt
	NjIjYvnkyFmHTBT1Z0/Qry6dwbn8tz1uTbxwZisoKbKwXa95fDAw/N1lWZIo4sZ3N6hy
X-Received: by 2002:a05:6a00:14c7:b0:770:5987:5b3a with SMTP id d2e1a72fcca58-77059879144mr10408752b3a.16.1756232488290;
        Tue, 26 Aug 2025 11:21:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdbni7xGAlaDwJvZNQie+3PflKT30+F6qVX4DcxiW8gpRJHQkgNR9tu1A3N7ospcq9hZ+02g==
X-Received: by 2002:a05:6a00:14c7:b0:770:5987:5b3a with SMTP id d2e1a72fcca58-77059879144mr10408719b3a.16.1756232487815;
        Tue, 26 Aug 2025 11:21:27 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77048989fe6sm9881803b3a.51.2025.08.26.11.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 11:21:27 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 23:51:00 +0530
Subject: [PATCH 1/5] dt-bindings: mmc: sdhci-msm: Document the Lemans
 compatible
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-lemans-evk-bu-v1-1-08016e0d3ce5@oss.qualcomm.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
In-Reply-To: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756232476; l=1192;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=vYOX3rphXNqw4BaZtF1OQs+qVbxZRa6V2tNPd8V2s/o=;
 b=d02cyucfOmtC1y0r5qc+700gCtMeGv1Xx4u39k3ipECsmsgdJU/b+YdquOEEBuIb8Ab8VQ6ha
 UCtR4syOGZqCio2iFgsKBjK6ubiSLuHnl4u9Rq4tQRTIQi0rS8U9uTY
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: U6q0ISTmoCZptDbCpI5AdGrzXn-1-uTb
X-Proofpoint-ORIG-GUID: U6q0ISTmoCZptDbCpI5AdGrzXn-1-uTb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX3mGg1mZ3CAs/
 I3b9vCy1QUUET2WQ+2nRKfGx8pbEe6/Rtj6rJdLo15d/yxqvtmmOdWaQJDnmqc7kJFzbQNY6mHY
 K9CzrMffrkJKFqE/j0pi0r40CKDR0R9szyrQn+ylWT40SdEaDdC7aeGH+WkWNpW733deIAri3pX
 OI0CdtGEDveDAhBQ2n2kAMPWM14UAXZUS6FCd8NN94l8lc6sufI7QsJhuin2P+w8y3KqXdfmrN3
 8etoQG508P+bAU2ECpcT7Y6jPqAYUmFXQcmuvV9sU/1mViWArzi/o6caEcvxKUNgLXuhFxzEDvk
 Gz4CFfEHG4g9lXi4qk9kfQVRvVfVN03x3ssHDOm6Jlw/BDCJXQY/PBJ02DuPRtahLHTb6Qt94z/
 SWGPlZdz
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68adfb29 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=h4M2rFpPKqSdi5wqdTYA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

From: Monish Chunara <quic_mchunara@quicinc.com>

Add the MSM SDHCI compatible name to support both eMMC and SD card for
Lemans, which uses 'sa8775p' as the fallback SoC. Ensure the new
compatible string matches existing Lemans-compatible formats without
introducing a new naming convention.

The SDHCI controller on Lemans is based on MSM SDHCI v5 IP. Hence,
document the compatible with "qcom,sdhci-msm-v5" as the fallback.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 22d1f50c3fd1..fac5d21abb94 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -49,6 +49,7 @@ properties:
               - qcom,qcs8300-sdhci
               - qcom,qdu1000-sdhci
               - qcom,sar2130p-sdhci
+              - qcom,sa8775p-sdhci
               - qcom,sc7180-sdhci
               - qcom,sc7280-sdhci
               - qcom,sc8280xp-sdhci

-- 
2.51.0

