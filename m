Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D9D30E0E4
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219009; cv=none; b=hHXw8DRlZzlbBvqOut3IU/TT6e4mtX49SxgDBpY+dIvonHbHPv1aT4uS1NI65qhYczFsbuBhqI8kigTrqsdAIILgAmly0S469401K6lVcMgXuARlcBS85OxLp4daXZa6V+cGrC/AHmhvWprqqT/d/1vmip3Bk6hCA64UuX+y4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219009; c=relaxed/simple;
	bh=Z3ZKjce1eNa7cruDaoLFpBeJDrv3LxfBcxi/KFd0kkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3PhkxFBMfiL5S3gfUP23C/TA8kaPYxlH/FYeU5VQnz+VnahXy0H2x9L/USVhGcXi4c0uC6e3OzmlqePwc5ym/kTKcv/+oitIEJk49uiA0Z+0Mwd+brqxHYt211QJ01zy3ZmjhFFLtvw5wO2XxT89s5lxsyV8ESsLMRdZLORGvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GeDdOsXZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GeDdOsXZ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7hc25026326
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 11:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=b8+bYrK48YE
	QxTGw52Zzv2+zkKybAeDpreZ+tSe6PU8=; b=GeDdOsXZ0bWN6rptcPdawZeuklj
	/d4Us3XQAZWF6toxbu7X2EV+U4avFCqt7Q9shrvi7UtvABjqoMdrLtY0t45koKdW
	FAWyZDtJujBd751D0evAXHLXwiuESAaWIlNd0hsttPoYK4GbztFYSFt7RtrHCoyL
	gCGb5CkS1zdNBLngdO1mUSE3DZpO6EBMnbEz5ANYP2IJEmPXO39wI6idTaYx35ec
	DMDej3wAVUMhejyLd+5ISe+1Lvq4bK4EpTrDStMtgbcdu5dSaPYh8roK4eQ2EAFP
	w3YdL4AdymWkR0NQsTLba6bwNdnM/t+f57iD392LSbPP6XFpRUAmJkjZkdQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8ja3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 11:30:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28eb07797f9so2757055ad.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 04:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219005; x=1761823805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8+bYrK48YEQxTGw52Zzv2+zkKybAeDpreZ+tSe6PU8=;
        b=d1lYwBddS7g5cAodNVR54cuPOmVxK+s33/z9XNZne3DfXOAg+BhHGLjtzxfnU7n0mX
         kYkd5b7LydT/8MsMFT68E/g6+RpLJ+S1Dv9wiOw2L8Oc4Jie49Wziryw2PqqiWi+pIJq
         05V3wAbhPgHPm6lJ6DXttzT7FCLem87WWmDj9AhKnZVSvXKN6wwIFkf+M6Jwx+Hb9yQ6
         o692qs4CA1EQOQEazGPTg5zptX2lNZQL1BJEmxrS4F37UUC2nuMO4Vaz/Dn+yU3ZCbT+
         /nVuCFD5MnCytZ440kZtzvjmOGXjeQSDbtaqKvHPVOef0ov0Xku1Zs21+y/HVeEoHCx4
         Ok3A==
X-Gm-Message-State: AOJu0YyVAMsmPCiiVgzl2DL49sfKjk6gtnPLh+JnooDFSMmWcdXu0Mrv
	qgU+a0qrCQygdo+x4mdf9KViQ7jyzRgcSd+ACBg6tS0ry0wNxAkU5qGJ4dDZxsjmNSf9GadCvfp
	Ot+/bs4aNwN4juu946sIEQRQ2j0nOd3Xttpmmh7XXC85rvvv6+KgQ13o8TaF6fA==
X-Gm-Gg: ASbGncvmuYOGk1mzmG7TkmVxnVSsFhUksAnvqYM75Hfjgk4eS1EsxCZV3RXNO1iWUP7
	b+r5iIq3LxRXSeuOV2LkEtA7WvFD4R6OylFugt2mqcOVTMu1lUjy1PvRbVQeuGlspTZmT2gQbv/
	PE+RtVUyogTOn6wrLA83aJfC2ZrS/9GVuTE4X1XfCtutMOCdHA3TcG/by4562N9QKyc94CWBVDz
	FK+irE2rOgLpuedI6sY1YUTuc1GUuPMKtgiOnCGmlINUo2sRRorxOWkJBM770Q1CaTUgugLLUeS
	uIt/x2FV15+7gMytdUMXLeVyTI2LpTOrzjJiEZx4HelOtbJjfPlHnZGGY0UdjeHqo+fS4FU+m4X
	uO6zUM15E7h/T1ZyzqaEVfpgRvyxF5g==
X-Received: by 2002:a17:903:46c4:b0:290:ad79:c617 with SMTP id d9443c01a7336-292d3e50ee5mr68938465ad.1.1761219005539;
        Thu, 23 Oct 2025 04:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMBrkCvTO1nWUE4UYg/s8tYpYtZ7BQ/m0qwKJKLmXmKfeqgrsKE3F73O+O9t1ICmCNO90HOg==
X-Received: by 2002:a17:903:46c4:b0:290:ad79:c617 with SMTP id d9443c01a7336-292d3e50ee5mr68938145ad.1.1761219005069;
        Thu, 23 Oct 2025 04:30:05 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e1231b0sm20438815ad.97.2025.10.23.04.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:30:04 -0700 (PDT)
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
Subject: [PATCH V2 4/4] arm64: dts: qcom: sm8750-qrd: Add SDC2 node for sm8750 qrd board
Date: Thu, 23 Oct 2025 16:59:24 +0530
Message-Id: <20251023112924.1073811-5-sarthak.garg@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: mYSJzk6BBiEV8YQfRioLMJzQ-lU5J-B_
X-Proofpoint-GUID: mYSJzk6BBiEV8YQfRioLMJzQ-lU5J-B_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfX05SnC2yYX65n
 eDjDcw/5qE4rHEEYMnR1u6egflPPJRw89wuQNzaND6OQvBF6lhA7rY3kNfujkpK7+uG+K0eKGMb
 oXeXqozlggN1FRefYE1tuOU8s97PK5JTdt2WgpXxurn8pdIhgZ6mQMBH1OdiCYfn7glpHO29buX
 rmd0wfmquRcbHMdQGjcaNSsw8rboNjj3bQZuXVPqk6TTYQIh3Vmt1UB9hx1SPxYFG9udHt3PEM7
 gTjYJY9ka4pvu2WjCaEPLQgHWTLauS+RiN2piA+I0+bWwylgJ7mEI2EdVAfEKZmeL+bZDH0Zihi
 dQ0Emg7hYSdJvCYWlqd1b8OIprsZY5/jQdfUC8yMWnY4etiKfhr2FJ6sFdTYA4EGxFEEM7bPzvu
 cf41zTDMmfiOqYWrHliZXF+iKD/p9Q==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68fa11be cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=53gy1XDxZ6suxgqcjVYA:9 a=zgiPjhLxNE0A:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164

Enable SD Card host controller for sm8750 qrd board.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 13c7b9664c89..8d018eef44da 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -916,6 +916,22 @@ &remoteproc_mpss {
 	status = "okay";
 };
 
+&sdhc_2 {
+	cd-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
+
+	vmmc-supply = <&vreg_l9b_2p9>;
+	vqmmc-supply = <&vreg_l8b_1p8>;
+
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default>;
+	pinctrl-1 = <&sdc2_sleep>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+};
+
 &swr0 {
 	status = "okay";
 
-- 
2.34.1

