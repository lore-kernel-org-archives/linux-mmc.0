Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA072F6567
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019659; cv=none; b=KucSLYCxvy/st7kFwmNYT3zxnqeNR/vtNZqli33aaeWaOOVNdZeWphzjUB0uQRN3E80CJa0QBQLRIggdexdXMADIh4e3+q5uTaphLgb6X2QuDZ9gATOHQxV6ibOjpSA8a2PV4znPEE4z54Jeqx7aJo5i0g9MO+Z9fnr5r2zYLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019659; c=relaxed/simple;
	bh=4P8QCd/n/ZqO2buNEe5zudr2yiiS2jbmzUv446VsYlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a/UJeKTXeqpu8FYpOKXyX+euWfZSzB/aKf8/qtjFuWCDugbovGkjcfEF8rz6+Voq0rfesF8pr0+nUoRTJMDRS+tkUloEQlzN+3DaxILNKugrR547ffX4tA/Qhnvipbrm8lA/XjDhG+Fx/m7vctsNKVWvVJmd4X1R0lHKuce1nOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nUi2RVSr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nUi2RVSr"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAFq68013214
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g92mvLPAHTfK0GHE2rBP5dPtjDIp5DrITeUuEUqxuV4=; b=nUi2RVSrUDeYEZBq
	srsbUBATxr6Pi6QLNsTFFb1wHt6GQ0aELaCORa78Cmn3RfIQXnSoAt9eKmu+OXXb
	4Fx0c4dSEcwW65jtU3ZiaFqV/NgeWkFvmTeabUnEgeT6vKGV6+VF++a17pB/BwRc
	y5q3m81SqdwIL96CFALQtBRuw1mnBKuQq8P4umKUSpeQwaOa/vXbqRcNv4hoTLNV
	HI3wAwTA1NY5NpZTPg59pwpsraaa/0PYgT5bZYAFtPldh6aAt9QSxW4Y9vNsdq7Z
	KqI5p/y6ljhDIPf+6xoNcKIow/V5KtHniDg7EFuAT1HYS05N8EiqyGNQbSGJiwyx
	OCyBYw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072rjdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:47:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-26076dd11d1so35895525ad.0
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 03:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019655; x=1758624455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g92mvLPAHTfK0GHE2rBP5dPtjDIp5DrITeUuEUqxuV4=;
        b=Q3f7DZDvL6ahZ5TfY98lpvhdNCFfNqwLi14Z4tUsBorhG5XJWrTi+ZKY7bJfkgY/p4
         tUjS0D6SA61xO2UdnKEyFRHKhZG1JDuK5tJc47pL27eZYVk+pjm2pSsaVHh+ZqZVFY4C
         fveBQOxj1T/TtoS8aAyryZReNeSIw37ODJuylcXcxB7Ctsib3Bo/2FploQ1m0eUIBUmg
         bZJjlgOzRkOTAGKZmmjJUouGfkiH7k1APWNNupapytX6oyOh6nnE6XsCu/jMmzlC4RZ7
         FRzEw+vGZ1Vp3JJwbotuuGGC1dglKoN6+0uzZ5FrrJLj2ij/yUNBPX3tF8Xe+7x8BvdA
         3Dtw==
X-Forwarded-Encrypted: i=1; AJvYcCW4GT7Z9VgWWTVHZTrI8ZgrzS+2bzTa9Uug8ZyVPqaGSQSxUGfZK4FXX/rBQYFQzbS9LyA1PmoyDFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8WX9a+FeiDrzebkkQLZKPCLvK4JpqIwtI+sEt0+qD3HSyXkqf
	8w1YefDzCI7r0v/YVKwX1sfS2KoHPVkzFVX3vPhVSS8zkAt2yBuBXQqh3MOK+xK4XbipT/JFmx5
	SPDX5Zi2urzpoZW2aKTk8yXzcE0waW23OKW05B8+hyPib4iOBZFGV5wclhUzQCA0=
X-Gm-Gg: ASbGncuQYwPgQ6dEvw3n8x4TUNR6wOckzarOJAl0Ojxwj7ig/aXNXiYUr2Da3Col0v0
	IjlAujwvFfN3SAYkGoitx2iBQ17bKQNJrndB6a6mtb0ibZKWvmkVeV/U7OHiY5QYq5Z6Uc/NOoE
	011CBuzHzxLkZrhNoxDkHpMPAQvxYjMk0M0ycYArJ8IycsIbHanfVd/JuXHKQK9WiorPtUzQnBz
	qffUgGvcGkkqU8CT8WAYTSha83ZWCkkcTRwJ0JvplSpMjNRgzSPqu1+7eq4YGmBks8L/2Y6WfQY
	K+DRc5vj+EIpnb0x7EJP/I6ffUBRePdVI0X6FpAZBgtKq3pj4/myXFhigXJTKbZFFAJ+
X-Received: by 2002:a17:903:440f:b0:267:e3af:ae38 with SMTP id d9443c01a7336-267e3afb733mr9406075ad.24.1758019654736;
        Tue, 16 Sep 2025 03:47:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbJG6nTE6O2cj/fl3n59kEcF7DRIKhZbTpZk6iIqHnX3yzWoLTDnuV/95CZtfeT5l+NDyoZA==
X-Received: by 2002:a17:903:440f:b0:267:e3af:ae38 with SMTP id d9443c01a7336-267e3afb733mr9405865ad.24.1758019654262;
        Tue, 16 Sep 2025 03:47:34 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267b2246d32sm33122355ad.143.2025.09.16.03.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:47:33 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 16:16:54 +0530
Subject: [PATCH v5 06/10] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v5-6-53d7d206669d@oss.qualcomm.com>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758019616; l=1181;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=4P8QCd/n/ZqO2buNEe5zudr2yiiS2jbmzUv446VsYlc=;
 b=9NtiX7RWLRnOJ7HMyisKjOM4oeKmHri0xKtCRW9AeoVxJ4IyFPdh+8hPymFtnppltKd5s01k/
 FCpNljGTwJuCaByTFF7Mso2ZLPd7YqcC2uz+gQDc0ZmzHtu1jQDcmj6
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX7+RcfW2yp2TY
 e2vLj9V3zrPv6VAWMLDFaCJPZ1hSM9OuKLa3j1WXxoEcfcJrMvZsDcfL/LeX05wEHJhoNcbzoXO
 XE3VIDWY8Wi+qzBWSOhwCRI0hXmkeOW5DFhnOBsCplvI6DDm2/LtYov48zmYMTWJ+6Pf4IuSOhh
 AuVYrC32m0n1XcEFkK6RlyqDYdgGG72Gg7Ax9kiuPVbCpSMawqfj2B+EpXfLrbfpSVG3VoxWpob
 ta406e6HEZUjIHZQ8HONPlqT25hPrtbQSst0Z2lyLeMAw6p5Eup0VQoQWvd3Ta9/rrQAQIzyBYi
 ZBBGYdN6qhLhkQLYYmMA+rYX6of5GrdtGopMeyKv9d92PhoZVjLsYzGeQrAxM1nhgiooUl9uTRK
 mNHpfsjJ
X-Proofpoint-GUID: AGrXfK5gGtof3O2kqHimL3HPqAWrFX3r
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c94048 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=08pr6S3s0jzPFaFj3AwA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: AGrXfK5gGtof3O2kqHimL3HPqAWrFX3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

Enable remoteproc subsystems for supported DSPs such as Audio DSP,
Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
firmware.

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

