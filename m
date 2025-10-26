Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985D26E719
	for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761477493; cv=none; b=BkuBZ5w+bTfycj93MRFwK2I6dlEihDqdWOD+A4fLnGErQlSungoMr+XZzmeVnSANio8e6OfmWqGv2mwbpl11k03+/MiXleWHxv5wDq1psl64zCoc5WSGRyXwthR6eeN6DcEJRczikn8znWEkosKdNPROjIpakcmVIdDW+8DF5hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761477493; c=relaxed/simple;
	bh=O7f0ov9vTfLRbLjUh2RSJGZyEQmlwikWpzB+7BwXE+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IXaAC93cWLO6T0s4ZPV9dviTgYYYnI5Pf38TtsDXifnNdqkDN60gaqu0hE0qtp0TKly90BScOwBz9MrFExMoZLQhec4d2aBvVyuLFvkXdk4DUYCurmCsEvbOUrnp5pyRjbr8gEgE74R3mBPVxCbfVxDaXBHv5UQrRyK/KeMKhkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DKi4clLe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DKi4clLe"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59Q9SdWG3592657
	for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 11:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=P8mfvs0DoXJ
	oaXO7wXqvtVIblGXbDsNop1/adqmTvLc=; b=DKi4clLeZbGVVdYeKpTPwJILIqt
	xLkAk834FJrryVerh7Mrl6cAvai+/JKisHDxLO0fsZWJGN6WKGwc+HP8wlz7kAkB
	bM6kkwgQ2uL4CH6c2wms8dngs/lV+uKZWFlNh0R6iVQFNvKeYr6EHhnhyvds37Ni
	xqgqnZnmx6maHmFuHdn1qr/M0YryCq7ZwndSGaWt7EHuZcRn4CIKA0C51qcwOLRV
	2DrNq1ayIAvMKTEXQciW6IY9r4GVxlFuBAtsicApE6vE0KrB+dYZOpIgetKkWKx1
	MaD90haXUfCfiskvUhIEjqMSaqu7nZEIhwqKUTeadvuxOPS7fIjpNVC5lgg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p4w9yd3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 11:18:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290baa27f53so14536575ad.2
        for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 04:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761477490; x=1762082290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8mfvs0DoXJoaXO7wXqvtVIblGXbDsNop1/adqmTvLc=;
        b=UoalnoPIwa8qT+MF2+RYWV0MywyOGw05fjE2OtFAmXwMINDNdrkkfZGvQTVT/l3kwJ
         5R62tIXukqIFARrIQ0ImydEFaGrWw/crFliiO5T8c+dFR7IWGZhJbI2M9WFBMnvhQMFF
         IObKPGDnD1RNC4yNkwp3/7zLI2Ytpu99WztJDhgbKSmTQ0c84WH1uDO7qsEcjlT18O7w
         +tYcm14TCrS9TVTMwFjUXrMsOFnqanym9c4ifyhUBCJmFqrFql9eC2gdZlXubqRso4sO
         r95ozWjfv8SMlV2WyeV7ajuEzmIGLCWl/ScSPMlRGSTJtxb/rGarn9AbhKwWeMvPfrOX
         RWlw==
X-Gm-Message-State: AOJu0YzDpO5S0jRHyteUW4DL3NpB0yFa0qSdi34NuJYNTrq2DqO5cLu4
	7YKEEwKMf31q7P1GajSzQn4HU4xfw4sjgW1jnUw7bqMBwPF/b8GUZwI5l6JZppSwzUqItU/yAKM
	keKI42FT/OOT6BCdljVRZmgEj5yOuD+SRaWnoSTgu5xP0SPiQVuJQlW4VBUWskA==
X-Gm-Gg: ASbGncuzj/UFo3d+RIrisUHg/s1I3xiZ9Za13jfWEVXMz+xWeWe454dYqqjekc7lc0K
	4JUKYeB21ehAF609/PBJ0lIPnSjWdsJguOvfZP4dlY0ZxskZWa9jpGxW+s4U+K379u0L5Wjq12i
	P1qrAEZqUMA//NWJ0nzuPRk1+3+5ZylsGwIuZEaUZUe2bcCDYT0uY6xbKmYpLXuLl3F/3JMWtI/
	Epg+WUBA2tApp28jZP5MiPkWn4SDc514bMj/8fDBREsPIovBvPNn+Mv7Fw5392/zEDuazCUGRuo
	PnxUp+ykaN2MIwDwwTLQdaCb90SSDnMVMfc7QROKljDqWXJecu9aKRXNUF6+DMIZ5HokgIUK/Lh
	UVclr5hhakVe6k03m2qelzYmGFirL+A==
X-Received: by 2002:a05:6a00:2395:b0:781:1f5e:8bc4 with SMTP id d2e1a72fcca58-7a220aaf4d1mr21273900b3a.6.1761477490507;
        Sun, 26 Oct 2025 04:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNQ6EVFYhzFH0yOaaPaFygjEcZd5WgQfQ13uWqgn/4cx6r/RKDbAVe0Xx5/gvvysn+ksiu/Q==
X-Received: by 2002:a05:6a00:2395:b0:781:1f5e:8bc4 with SMTP id d2e1a72fcca58-7a220aaf4d1mr21273880b3a.6.1761477490059;
        Sun, 26 Oct 2025 04:18:10 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140301f7sm4707829b3a.19.2025.10.26.04.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 04:18:09 -0700 (PDT)
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
Subject: [PATCH V3 1/4] dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
Date: Sun, 26 Oct 2025 16:47:43 +0530
Message-Id: <20251026111746.3195861-2-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
References: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QeEaIiFUoJBeTCNoftTlXLrq2xVexsFt
X-Proofpoint-GUID: QeEaIiFUoJBeTCNoftTlXLrq2xVexsFt
X-Authority-Analysis: v=2.4 cv=NobcssdJ c=1 sm=1 tr=0 ts=68fe0373 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=yU21l3sC3bVkzOeoNhsA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI2MDEwNyBTYWx0ZWRfXzfK2c7EmfjFK
 nF9EtrGSQDpUlvhyo8B+2AxBaBjozCVaDK1Uf3Q/93A5D72ciULxNz61BAy1FP2ElhzbsKqpf6x
 MOhk33PVg4p+qr8NO945XsnH+g6o1TnDUyNb6rxMa7/WLQyEpLf062h0yeQzDn0OAK2f3qY530o
 52SL1xPxKYQCjANSnBh9rOC4eCZQCch4CRGszCvVqdIm+nONl4SIpXYQ07D2o/yuvhNBDuJAFHE
 V1+0xnHPE3li/iQUBuqapaolVSQ3X0n0e+c+QePly5LvAbVpocTATccCxQayic/fCgkuTScTNcN
 ubdivetvhwHY6k/74537CJMdhWDaybPmb3VB/mB+3LOA60xL3yFKgkOnruExf3ULF4tkdAYMN7T
 NFmAlkrrN0Icuk2WZmzhz2TpyfSrsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-26_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510260107

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

