Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC4353346
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034814; cv=none; b=vFi+45Lj4iFfgpoHb4fEFLzgirWyjuGiaCbsD/pPUkHvSt2SP3Oykd0m5hc5a4D1SWKXTR+lnpTcHUnNN7ULICe4vcu3x9+YfXMglm/aWG3Iek9PO8wDD+1S21o6+yojHGrCyH3YLUBugMYc55997d6uOni3Ckzr0fPZxPXP/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034814; c=relaxed/simple;
	bh=AeQJ+Mvvn8Zchtp2KXj5ziKvJddoHzFNlKss5ip7LDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/49Lxy0O9Gb/tnyzUkD79GxUww1mRNnGnACEiIPRrgrYoSbaUJiz6cemBZp//aoV1zxaJV2m1eVIRA0pUE2DmdnFSCM/dWEWZJYdFvoNGAGslk8jYEtcTLNuTujp5Q24fWoBcsa+mO0Ff5IjABNh/IO11J6h3qkZcvfMMcxveY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VrxxxJtX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VrxxxJtX"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9gcIe005281
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 15:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V05d+jNh/czCFv+YIOyVmfzj3aJzSMxM9iGXDQbdqsg=; b=VrxxxJtX3wb6uvTI
	RlmtyTUDMW4FctOt7ox81ZwBZgb8+PR9ljugdi/ATbfkr6eT6qL5v9EnVXs082wB
	G66UZbbh3CBNyee0ApvAJ6T8/oHweTFibb9GIV4rcr9gqGY+542egPuihmTPk9fm
	PdlZUtnMOIbnWHJzhUKP6GeQz+TRfIkueKzEwVTPtOJo0GdAWpJfZMaS+Ak7goWW
	LvLNTYpdiEQGR4noHOvPgjQAAXBeP53A9ym2FeQw/UrIq1xQE4CuR59456oDlqvl
	fbdI17TjfXspVlMmdi2JH1TFlHf3O/fWFYdBmmzFAsjtSv2/nybOT5cmpZUx2R8w
	LJ31Jw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n4x1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 15:00:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24ced7cfa07so58457985ad.1
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 08:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034810; x=1758639610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V05d+jNh/czCFv+YIOyVmfzj3aJzSMxM9iGXDQbdqsg=;
        b=FaUhLV9ezjR6iWmFMyP3r7ZLegXTeLFO/aUC/dpKNJ43cjvsVvWFfQWuhnrc2LKizX
         8MNWnRGqyfwCDS1k0n0uQAf37kEK+4WTmHe6ydROoQPM6NwIOdCtRFK5wZ50+YcpXAci
         A1p+UTxNh0J++kCkgBcNC5WyaE+74NKm2e2rCRHvmWuVW+3jwHG0yfXMp9sbyMfAo6fk
         kHsCJ4c5L01QHJPk6wBlB/FYlAijfVGo5V0XsxcH2wYdrNvxSkhr45n5KbpNDCqUx4k5
         8JqJZ+m+SjSJLmJxJr895p9+ToyYzzRCtXuw/uJ8o2t3B5JJIWMFq79WOKP0o3uyvAxB
         7EsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhSfReS9BvvfS7w/QK/ZX5dG4FPTLDiiW0Sytcngxf5XrmoNNJK1T/8zTKDEwtLYRDS+8l3LDtj4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTgWhh8nduF54g34gOOumqpNMpG4uLf64VSADan6HljuFW1h4n
	iEzYp8baYsJp6CMs28Kc3tENZRd3rnOhG5lamWugg40RauB6Ci0NBxkbwUvt8B4ty4Qyq2f6w/T
	6l2zufDpu+rfcz04C62kv6vRCc54evF2Cv9tZpf/6x7tBtvPuwrmBYKq53ZBy76s=
X-Gm-Gg: ASbGncvYUOHlySAH2bu4/1D1/YHNXXUvQ7Fl9AHoXVm+sZOYQSjsZ3Xcb5v1Mrl+yHo
	dx+JO+ykCIEkbgDDxmY4CAYbdYXQd0vOf2Ii0P/7Fy738/Vt9GbEI1oFtGKnYRcYwCU+ApjgUMo
	IAQbzSWikIB5TFmRByHoKqPzsah4XjR7KaddVPWfn2NRJjMyYvlg9b9YYjAHVxueYaM65NyAtoa
	VEn48MK4BlO6Bmj3OOgQUz8B+8bFvaoAY2QzesmXy6adDo46tP9+4EH4KvZHtiJPPYWqpwmhM31
	b82Vv2/V9DUmnCPVakCiD7O8lWGLPJ0op1y/tiSTDD3tPCH+yDq+tEar6UXEbXReGV4J
X-Received: by 2002:a17:903:4405:b0:267:b1d6:9605 with SMTP id d9443c01a7336-267b1d6a44emr61499285ad.10.1758034810096;
        Tue, 16 Sep 2025 08:00:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXXtzp40M+OnwRPHaBfUHcZY3UBeT0scukJXr7R5AGOJ3BP+3MpI6Pr++mKWkPkvNyQtbiOg==
X-Received: by 2002:a17:903:4405:b0:267:b1d6:9605 with SMTP id d9443c01a7336-267b1d6a44emr61498535ad.10.1758034809413;
        Tue, 16 Sep 2025 08:00:09 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm74232615ad.45.2025.09.16.08.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:00:09 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:29:28 +0530
Subject: [PATCH v6 06/10] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v6-6-62e6a9018df4@oss.qualcomm.com>
References: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758034770; l=1248;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=AeQJ+Mvvn8Zchtp2KXj5ziKvJddoHzFNlKss5ip7LDQ=;
 b=51Y+c1piLmdWjG+Oa/4O7vIYN1Ktuey9O6ZUx4ctB1uZetUtQKP/MyuV/a+F5d1pJO7w7XhXd
 +nqfT84i1GJAgBIWfF5jT6Royc2uMgA2cLMeKWtsu+5T7rzVdnXu+ke
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: cb_lR7S5SpPCkURbRXaoni_Dcchl2GJe
X-Proofpoint-ORIG-GUID: cb_lR7S5SpPCkURbRXaoni_Dcchl2GJe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfXx3LaOipieC9/
 +IRreDQ7BN2yWfDN590OfkEbmYgR/VX4viWb6AFe6FptrHqsT9f4mDVBhCKSBwgJmG2be2fzAD2
 N4l+Bz4qPAy4nwvgxlWdaa4esnQQ2urDjIdpJ5n6yl6WG9PDcIrNgJeiSYxo6bLGb4rXMdZmAXC
 4oyFjBSbJkgzwPsWpVPY7hkorU2a+WsQXw4YKVKDQGr+xARXOXQ2c653HOt1sUNhCy2mDFI9JMS
 er68xBZTZuW8XWkmIUnJKZ/32p6KSsG1lAHiHDxBJsyloKNu04cF4nqjsuIyQrzXHEBpJYeOIBi
 xHRr17DBhIXccxfCsdpAPxwspRTunJ8ZyWUxSjvzhArK/XhlJAcCZMcuY3ZRReABQGlta3kzy8e
 aCNaK95Z
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c97b7c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=uxRHuE6yrSyVtnA-QqAA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087

Enable remoteproc subsystems for supported DSPs such as Audio DSP,
Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
firmware.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 99400ff12cfd..d92c089eff39 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -477,6 +477,36 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/sa8775p/adsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp0 {
+	firmware-name = "qcom/sa8775p/cdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp1 {
+	firmware-name = "qcom/sa8775p/cdsp1.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp0 {
+	firmware-name = "qcom/sa8775p/gpdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp1 {
+	firmware-name = "qcom/sa8775p/gpdsp1.mbn";
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };

-- 
2.51.0

