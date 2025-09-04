Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C901C5486
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003983; cv=none; b=VdMqIp/lu3V6TYyiZqq92Ds4LKKf0vkYV66ZGzv5vckiFtaAhyHM9L+d1FzUkwfaxz/jJ+OoP7Ts+NA0UkIpVTxLrwTUnVXdKAiiKtTnHN/UQgINkKCPBposZ6dCbxvf/S1EN5XRRogXOQFym3Tkq2aHcmG3YMKD3ikFJ1FNvNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003983; c=relaxed/simple;
	bh=E1O6rOzv0lZ191I1uujSCw4U/Q2xdbO4Vs5JwqnUhcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YEtDC9iVgsGF2X6K5C4Dezd1AAQMrUrhPgc45mSzEmdpDPGlnNdniIeaqlVeYKP6uQh6KgM60HRDbtwZCpC8aFXkJzYllhXIC0mmeZkV4IIgxBg/lkmxvz91RiU+nct72I+SqjpPmrfm3Ov5MYvKnqotIcLL6NpCRO5ZIKiMiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Omn7tnLf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Omn7tnLf"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X7wE012042
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 16:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CDpMGCSL5nkDXYqAdlOX/gM6pgktfLiD45yNmYWQxcg=; b=Omn7tnLf2fBYQ4qE
	OKmXW1LUnidhR3J+UQ25TvaidI8FZfGn4L4VeoUpxFcJJx0Gj+jLKm6SOleCHj7+
	TuL/7owoEtaVqFMuHssLoF+mrlNQmsQ/gszgSkqaFzjf4N0t7lPSeiIA6AtbZz1U
	fsbLPRd7tqymq1KyKD5pIPGwXU9Es773o+tjgacJqpRxodSMJhM/fYCSnYIgyobk
	EQWQofV8a5fqqiHRaUpNs7/9M4VAH2jssGfQNVRr3wG+mRXpNX573gICmxBqNRlV
	0vXqH0QC1LBkpq8yspe4M83Mm8b+IaTpHjLGchiHe6Jn0k7SlTwBiS53jwqQh9P7
	vTukVQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj4ns4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 16:39:41 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4d7b23ad44so828849a12.0
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 09:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003981; x=1757608781;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDpMGCSL5nkDXYqAdlOX/gM6pgktfLiD45yNmYWQxcg=;
        b=omHJ++ISE+LfxyPRHfAoyUDM9YQMnHMhtB66Mj1uQ5kFwyP4ym0q66FKHZjxvAHLKB
         eJaHOO6ZWge6BDGuQvv70oPm7TM02Ydws44t1xAJeEE6e0qpAFtcL5/AWYXytxdID/Vn
         LDgUtNnwoQDP6rHZ0lMk8FK+UkTE70YfUJfDJJp33pNWe4C43ZVGH72C2LxODOoUkvIj
         lgazF8hOi2cny46hUN1NfNci3wZw7AEB9vffoSfWGOobStrLh4vbkteMLQSxY3m2+biz
         j8BD8pkDMoSA6WFZahDi+1unw7G5IrN8JsVCNGP5TuyvR81CzbbX0ftMBMDVjCkuo87V
         /QfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjPOHWMxcatslGgqWs1LMy4Aothv81PCBq8lOELwoudmxfB6lli5OxfEITkFxKdiUoGSf22Kk8hJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfrVmHwk+ZOHir+naaUkVSTdcsHhvS2HZx9HOSwBX95IznGBcW
	KkmtbvPTMA9TBVfdngd4ogIoxo1QOelUyWciVjozY+ALGeDQjhQ4igjgaqWkmAxFyyuYa2Al2BW
	e5lAKN830BUj2f320zy8mBX70O1wnTQ5je3FqcY/wlX1mOEJiE6ozR+6EImsoW/g=
X-Gm-Gg: ASbGncuexb2YVtpOwzT21B+aC18CEESJPuZyJZZOf5N/26sxKFg3w1rZJKgobPYzLCE
	8HmmCwhiBSatz3oAiEXYAVAEaO2FRKvfi8DVg1CHufm9jfry4UbBh2pKAATPghyFpLxtPO0m6yM
	F/cG6b3v2+CjTv9hFFKArgTYat6vFSz2R5bIvJ/NtWup1/CiKTzRUwV2dLD0Eh0pWGSzaMcLxmt
	CbvvDh5xgyZ88q4RsGjyuQbgJ48Vgj7ri8b70/OVNBzOhdqrPTE7ubGBrwKRErpc5DvS2aZ/mwj
	hoCsWEo+MFwhUvwkVsa/W47hoAddKhEd+hC82HeNo+KiID+yBkxPouDJL0LQ8/Ba01E5
X-Received: by 2002:a05:6a21:9990:b0:24c:a32b:3235 with SMTP id adf61e73a8af0-24ca32b3545mr2764106637.47.1757003980502;
        Thu, 04 Sep 2025 09:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPha85n2iNFgSPsnAlm8leQ1tQQ/9MzM1wGVWoNdLxC6N6B3n1oZzAjUru6wb3vf1yNeqJTQ==
X-Received: by 2002:a05:6a21:9990:b0:24c:a32b:3235 with SMTP id adf61e73a8af0-24ca32b3545mr2764060637.47.1757003979995;
        Thu, 04 Sep 2025 09:39:39 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:39:39 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:00 +0530
Subject: [PATCH v3 04/14] arm64: dts: qcom: lemans-evk: Add TCA9534 I/O
 expander
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-4-8bbaac1f25e8@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=1246;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=KCMCr6yvyYTCxPTT039B/teImKPmXb9UNZkMYvy7EJk=;
 b=JpY4zDHyUFQo5X8IN54NMq0eLmnWrs5hwlmxAS3hLkb6nKOEniF9NgXSufodHaO0Qsu2vQrG6
 OqsYrSskXMHCf/9/DYP8Ug30KwWOixpZfJwIzxOa2WJHEDtTgg2vwUx
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfXwpKv4cGItjHG
 TIULUuM7kbMDzFFthR+TX2JrdYq4kedvnhMCRNb+dccCTAS4R8EzqGwZ+4ELfjbhgEe+YmTbIhP
 ohCXOGOgjIOhNujqbrVl9qDxP7bPaKBini9IOrJPBJdEGtdkERyvqMHFAH79Vuq2ROBEDfs7RDx
 LhAiKp52u+Q4YmoER2EM9OxcvvKz38baJEdjb+1QXI0S/hRHNhOx402ih0K2RzJ4g8dFNYGExOI
 YqloF1OBwNG6zq6yao73KuOnnqQVmp/LVmWzUKdRjeq+AyZtzUwSQ9+zLSlTt952/aAV/lve4GL
 NJ9Q8qvPNfQajVMLef0TsZl8repbs6OTguPO+rJk/M/XRZcOVRLiAyky7PrLpkGBYKJAihRwbar
 NfFizq9P
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b9c0cd cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=itmwO_cg3X_j9a1xKB8A:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: wi9kE5YgLD5bWqD0hgPqLoe5NYeUPJ73
X-Proofpoint-ORIG-GUID: wi9kE5YgLD5bWqD0hgPqLoe5NYeUPJ73
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

From: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>

Integrate the TCA9534 I/O expander via I2C to provide 8 additional
GPIO lines for extended I/O functionality.

Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 56aaad39bb59..c48cb4267b72 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -289,6 +289,38 @@ &gpi_dma2 {
 	status = "okay";
 };
 
+&i2c18 {
+	status = "okay";
+
+	expander0: gpio@38 {
+		compatible = "ti,tca9538";
+		reg = <0x38>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander1: gpio@39 {
+		compatible = "ti,tca9538";
+		reg = <0x39>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander2: gpio@3a {
+		compatible = "ti,tca9538";
+		reg = <0x3a>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander3: gpio@3b {
+		compatible = "ti,tca9538";
+		reg = <0x3b>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+};
+
 &mdss0 {
 	status = "okay";
 };

-- 
2.51.0

