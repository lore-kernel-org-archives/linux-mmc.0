Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E484963B6
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779189720; cv=none; b=ho9k5Fkae7VTxxPWL/noqDuJlz6E/0WdWmitF7CjtWI/ndbDoQ6VAIhxUA+T0Eih5xDu9kk/kF0/nZKhuK7lvM/T21rR3je2Jt3Vqy0rEMnW+gM2Ux0ieRFFGAkhUpgKSs65LcNDwy9kTH6qLvWCLzJ4aSUicuzdkbNDsbgEpm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779189720; c=relaxed/simple;
	bh=/0gH2RBKVFdECZHy2OYb/vQdn0W3A3ypRR06Nb2Te8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UFqI3KvYt0akqAi9+hhRjHksOoUhLX2vD/iM8pxbXjkNQu0ScZk5itG1xoeRcbDvIrY8shmfy/2W1f2dR55OwHtxoTmLg4+10DHLjQM5H+UDEf53G/ChPXJuMwboLRUaxjfeXTx3U2FPvUfZ4hAmiWzY8vl19CTIJXlpah9SqO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HMvil/hN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZI17VQfJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HMvil/hN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZI17VQfJ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J8ESVn3612609
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 11:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5rZhel/ZfqNBkxZ73MGg6Xy1kCPJPWKFenIAB/a5RyI=; b=HMvil/hN1BBRUAR8
	oqc+IZxzY3iqmsWqxZBRrDVcknoA8poa1f0jhWVnaGAxlxkJBdFEsVJqaVAB1fDF
	klE80MHM7rCWV+GK2H3dGAOuDB58XnjcXiowPKxqLDy/gahuMj49IfWILauTOY8x
	uiLgZvZTG+EWU0YxOZcVbV3OHYeEGYY/5FTR8tOAqHJDhDpXclOX4eGkHvzFs8Ds
	bs9L0M4TaPM5mF3VWva+c2CQC3pECmrdXv84rhxv3Y7A5FGqzT7K0/CY0NLOjchv
	sr9CdjY0b6UHlSh3hzk03JOy6g73ZJwp90UTa/Vd1PCfzAuudDuRxcQxlXmZX6Ap
	a/fz/g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8m64rsab-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 11:21:57 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd6aeb3637so87997445ad.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 04:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779189717; x=1779794517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rZhel/ZfqNBkxZ73MGg6Xy1kCPJPWKFenIAB/a5RyI=;
        b=ZI17VQfJoDa9EslxqhTBDiRFMKC9a+Ku3VQFn5tNyP6V4hhn1c7yXAS9/yeUuA1MTX
         +hzfqzWnjRFOofN4ULvaFjiDOFSLAKvWbqYKAq08c+jL66Zj7H4+tGehbhqvI1LzqlYk
         CbqRSri+ICPNcRhmICMlR+TNpegfA+H2xrjZLC7xDIeTImC6E0PWvXtEYknEBcCdW2lQ
         bUBugyN8fRhTbzhL52bmhb4yhglHlK6gPIPu4SAlwQiWifgE7pIPzCfaNjvUHbOsz4cy
         tICv8KtwLBRRYIicWTvbO9YYDVpUBUarjtF6O28ffcs3/29rCBWgeOPKWyuQ6nKiXgid
         Beew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779189717; x=1779794517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5rZhel/ZfqNBkxZ73MGg6Xy1kCPJPWKFenIAB/a5RyI=;
        b=HqYw5Mg9Cwwe/QkoblkFof3pF0DAB+gWju2/hrsZk6uGf4wkldfl7wDG2Q3QjP1xUF
         8eXY2zz7ADOIVwgdzNi51JkZEuFQ+O1qgtu5I4lOPQTg18ULvnhOdfcB2sVRbmcHXNQl
         DAGntwGZBF/Bue0hh0CNH4aULGhl3QRnhSp0MFD01MIkvFnFj4bik1qmjzJIPA8Z8i0X
         Kbf/+JL2+7I3M7ndaBawWAVdz5ycXc6nNEi7mjZxHGkw+8E/XWb6G55eeA2+5QsBekTj
         2upXWDG224BETQGn86WsSSkvM/gJdfxmkePeNpyFH17PTMEQWnTDo9F0Pm48zLose+3x
         TYBg==
X-Forwarded-Encrypted: i=1; AFNElJ+zRJLh7eYm9rpf1mY/o/Sv+Nn1kWhWoAy5fC8M6HgzrqasRmtYw6iX92FvcIUrKgkILUUg8GpMzEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg/NKO6YlmeFdMynRA00dwdWG/D1YAHCA1pDiVHVOjA6i4CpbR
	8AogDhzF+6XppF7Cq2Wa3/qLI0WLMNWJE5R53F1wy+oeoY8Yc7Pg4kivjAoTkGuFXRktRQhMxDu
	lsTKk3/gTGr+b+N7mzBi04nei1ecm1G+81q79TAjMOVRuk/vxu/LK1GMhm5zZqug=
X-Gm-Gg: Acq92OEpCIKfo94VLhD+EMSjzos+foq45niG4CDU+HyCaHikBW5whY4D8guLYO4Uo1U
	7v7WbYe5MULsg+xlcpKrD4u4/ybuwURtdahh+fNU0lspIw8MiXll4Tf5hn8mrbvisMZzu5YYL6f
	342/eHg1NrM/TqVv32IxbpYfJgLT/y1c8uyP5X+PlZOPnMyPRnJ9PQ0xJ6g8CC56g25J2JYQuwf
	h75+JDOjb/3nSzuzXGBev4KrefwKmqHtLPm9ubyc+goQvhZdeKdi2u8Q4bhwTsqy0tQqGaJzeZR
	D4M7dbMqo8lQKv+K7Aqbm4Wz/axBanS0ZoOBSQcXBw8roGFUET1iVUhViVhUtedvQHzxqlWIR3L
	gUXSPI0DLlinY6mFQstvNCElWEEJJonPeApiMCT5Lwc4Z7Dg=
X-Received: by 2002:a17:903:f8c:b0:2b9:ff02:a14d with SMTP id d9443c01a7336-2bd7e8057ccmr209580775ad.18.1779189716770;
        Tue, 19 May 2026 04:21:56 -0700 (PDT)
X-Received: by 2002:a17:903:f8c:b0:2b9:ff02:a14d with SMTP id d9443c01a7336-2bd7e8057ccmr209580425ad.18.1779189716295;
        Tue, 19 May 2026 04:21:56 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe78b9sm192743605ad.43.2026.05.19.04.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:21:55 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 19 May 2026 16:51:21 +0530
Subject: [PATCH v2 1/5] dt-bindings: arm: qcom: Document Shikra and its EVK
 boards
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-shikra-dt-v2-1-c01b90fb4395@oss.qualcomm.com>
References: <20260519-shikra-dt-v2-0-c01b90fb4395@oss.qualcomm.com>
In-Reply-To: <20260519-shikra-dt-v2-0-c01b90fb4395@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779189702; l=1683;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=/0gH2RBKVFdECZHy2OYb/vQdn0W3A3ypRR06Nb2Te8U=;
 b=PeZo0W2eoXZTAKaQ7d3CH96/n9YjlCZSu4624vjdkgZ/G37ljAl03mfE6/LXplfr83jlvOKKM
 nx25Y4zpbIPDL64JQ3xSTflLvSFIXhnySbIgsVgRVUC8kQV7HnIv99X
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDExMiBTYWx0ZWRfX9aCwFD75Tbte
 73PVM542GUITkHOstgjz4tx91GRksPXW40+igl7QQ3qyh9OqiT+wF4A8nWC5r8gZm8i4NlCH0MI
 a33LPE4Ns9c5cYyDsSpBDYGCP5JkNjLtXOOevxWIZxxGC7xvsbt3XWbbKc7q4+X9QGzVxDpAwpd
 szsSd/577gztc5fcICzZVSDO9zNHYklcA6nbZTpvQz83guvK4xPVsq31JprClinht5OMsPygOL4
 Gzhsw1mKu5lqFfh4x1L6BX6nXCp7dmHTWq3IsJYczKoAClr7KUgGEbQfKPTtRHMYBcazq4OFrDM
 fAQ2dU1rJ6/CQd4X9E398CNMt4yB+Ga5aKLZQQn/9bsvaK96a4qcvD9SwhtM3rsLdwhLyAcPWb2
 keJI4XVY6EfJ4xH4N8yGzkJ/4qm/gIMSFeDAAZVFriDTI4spxmeWstmFl6vphud+jIMvNbNlNU9
 H7kTUEqtDi+KPVumO9Q==
X-Proofpoint-GUID: oyaC49HIYWh_cvGydd_T8Z8F8Y8LcfOa
X-Proofpoint-ORIG-GUID: oyaC49HIYWh_cvGydd_T8Z8F8Y8LcfOa
X-Authority-Analysis: v=2.4 cv=J8aaKgnS c=1 sm=1 tr=0 ts=6a0c47d5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=nhUW8Zqzme2qF2hNOrkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190112

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
index af266d584fae..7c5c5f4fc30f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -968,6 +968,24 @@ properties:
           - const: qcom,qcs9100
           - const: qcom,sa8775p
 
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
               - google,blueline

-- 
2.34.1

