Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50412DECB1
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218983; cv=none; b=fBrlsh5EIa6ud47R7jrtg3wYubO6c8DDHvpKY0IcDDth/rLG7rKgzRjPt4zxVsDuJ0/omTqXSd5OW+cu8xyt3eUNBsVPkjHoIC7ac0K22Ekb4nFYC+Mv7neVBjgXDXXrrdWLmGD+E16q6vSPXa/8035tS+RQObUUh23QO6V5Zk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218983; c=relaxed/simple;
	bh=O7f0ov9vTfLRbLjUh2RSJGZyEQmlwikWpzB+7BwXE+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tererVOOeo4s1O7DQtQKkMMYsUGzrFwucOqR/MjS5LBgywBuwNJ96kN1lnQORPqycZQTrIjFbM10drk3Gdcwplv5IGJz+cMh2CD5GE2oueuN/x0jsfjTmzkbayJ+avxCBK0TnA9uYvhpJ/o3d2s9hmvLNrEqC4gVox0UF1iFCyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iWxNJYC7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iWxNJYC7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6mdS2030315
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 11:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=P8mfvs0DoXJ
	oaXO7wXqvtVIblGXbDsNop1/adqmTvLc=; b=iWxNJYC7tTJa9YL70ViGzWRPjKS
	X7PSdZTHZ6QZBwAs3ivHwJmHr+qxTsiaqCTWfivPGf55lqubw4qbxJmC6vWshHCj
	QpCmlqLze47BCy/y4m3XJB1uq7y4seAw6sp0FXrTB0pdeBjzMPGPUgVDFaHGfAKQ
	gVy6pGupVxvV9Ob6SKoVD6ogpN/PwxGuBX3q3kzLkrcQW+PW/xADfQ0UG+T9blwd
	yurVWYwTkLv9JQqxRlKe2wfBsPSOIe5QZ8pplVf7bxJDlGzWWeh7DUkAY0F4MMKH
	vHGtCefgVE9g6MwgjI9N4m9F5q20/qc2qjG8Ej5KC7Bi4ailQAubTOqxCEg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge864y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 11:29:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28e970be282so2329735ad.1
        for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 04:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218979; x=1761823779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8mfvs0DoXJoaXO7wXqvtVIblGXbDsNop1/adqmTvLc=;
        b=A0X8YWjFizZqFSTUex3hyFaoU/t9WRclXIE5eZ5a+OAXl8iqUmb46q+zJ4tl6UesTq
         uxtXEjNnf+QcZw0xuLglXNINy03amCy2/Jvr22JgVNBn0/oYhZJBc6lWb5gTtfKbwNEy
         6hLBcrq0Mpi4wVWkqtBFRpFswSnyz8HlWIe6tEBh0+21+95XsMBeP2qkxKut1/9QOOwG
         NnOAl124v0y0oua2TPWshp183i6qez94nbhrrqkQ2AyMHLRbd7hyuRPAmEJP2kSpVZM0
         eJ5NHV98Vsmfw4O50L4uRj2R1p4J/2eGCzsTBxUuXSM+fZCbv4P7zyefY6Qnl4n7Z2Z5
         PN7Q==
X-Gm-Message-State: AOJu0YzTgu0B8fGK6iDaEq9ruivz+KCL8q3BxBycRFljr6HROG9WE5Dw
	FTYxAcpvSCppyfzy8jnireTJUF2WhtjYkzG91O+pZ2dH5Hi0QO5q21G3sCSriMX0+9lr6ALFA4a
	NSV4XNWP19CS626otmLOvYPzQHplhvJhAfgRO+FeVh/Ra6FAtxbiU3BIMHJGjBg==
X-Gm-Gg: ASbGncsaCebeOrYTXsvYgOTrslHz2Aw/tM4ft0WisSQ8qnZybPV/dOZBSyroHwHjDJV
	ZSOxuHk1uyJd/PsRkJMrY9RDtJqL2XjSYtuceSZxYlPb6dqZdZdg8MWmPv1lFAp30LqlWFY5nE9
	wvHSjg+OEGzHaR/jcU452otsarb+I2+n8r3thJFu8e5q4YsZmfyx7kS/4llqifjm/Dk12lqMKad
	iaos2pvd091M+6P6t7PpSkVRhpLu7+5+qwyL4eMECN2feY+HGSJBof23Tv0yN5/ToPphpZNXI9S
	EwLUAfHasovVImffEE8E/YpzP7PxH2YfMwyaVxaFgarc41DsasbwlwKBG+YfbgJ4EpuW19Fw+s7
	az/q6UGcHtuE6NNyqzFt3gVeu0fKARQ==
X-Received: by 2002:a17:903:3d0f:b0:274:944f:9d84 with SMTP id d9443c01a7336-290ccaccc47mr153641945ad.11.1761218979213;
        Thu, 23 Oct 2025 04:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUBXBV4AbrVjLdhmtE5JO/g8t7ggle1PnMzliYfuhA5RdGXlFMPcTHhQSuRUhryEqPpDsL1g==
X-Received: by 2002:a17:903:3d0f:b0:274:944f:9d84 with SMTP id d9443c01a7336-290ccaccc47mr153641715ad.11.1761218978805;
        Thu, 23 Oct 2025 04:29:38 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e1231b0sm20438815ad.97.2025.10.23.04.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:29:38 -0700 (PDT)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V2 1/4] dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
Date: Thu, 23 Oct 2025 16:59:21 +0530
Message-Id: <20251023112924.1073811-2-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
References: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX71TyVPdGgtu2
 1Lqr1Z8ylz22dwu4pdacUl0x/QoAFpd0r9buVQTdWDvUp6tDn/MX8ZnHNR8YP3vIGQp6EqO6S9M
 COscklOhvRNiuMj09k6HU2IBz2oNH/+KpKAmqIHnBj7FgMK4UVsygotv1U4V5PVqCabXgtmo+sr
 NdON5j/FXyMf/6N/Er0kgXKIjWVYvvbmTA1nsGL//+cpK/scMMbhdfxHh9PxLcsKPezz1lRXTXT
 wa/DEO1dIBW4YZXdpNr9u2oeFfC0+1kuKyLKcWVSCnai5GdMjQ6Nv9C0SAOA5JwgnWa3r7WxQFq
 BcmGF3duEY3gROun2EpN6ue0d1oeOAqIqOA5zCPB4+4d2h+4mqtVfM83SBHVVrHeXKPCpeTjKyk
 8Mk4roEvbZmsUHB9moEhmDGDXuKdUA==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68fa11a4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=yU21l3sC3bVkzOeoNhsA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: goqdcNL-2PxSMHqhXHBUqzMTF8NoAgcS
X-Proofpoint-ORIG-GUID: goqdcNL-2PxSMHqhXHBUqzMTF8NoAgcS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

Document the compatible string for the SDHCI controller on the
sm8750 platform.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 594bd174ff21..027011223368 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -70,6 +70,7 @@ properties:
               - qcom,sm8450-sdhci
               - qcom,sm8550-sdhci
               - qcom,sm8650-sdhci
+              - qcom,sm8750-sdhci
               - qcom,x1e80100-sdhci
           - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
 
-- 
2.34.1

