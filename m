Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9522F3616
	for <linux-mmc@vger.kernel.org>; Mon,  8 Sep 2025 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319643; cv=none; b=VB7kjQIENvO5Irbdy4VLKKLYi1QCG7pJnDU1YJVAXR+EcyjNThZvFvgVrAxUe23TWJV81A+MU9Xwm/5AKkD7lBhMUaPrhkmEJ4Fr8Dl33qQBGuJcyMnoxo8I885wMB0IT7SUFKJmhjRxVRCGZvYUg4bkiMEy8chs0BOXko47gAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319643; c=relaxed/simple;
	bh=GtMkvJtKpN0l4S/TYqIWBJap6HQ5JYL7CkanzzfgJnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TD7LZix2WKj4+cBCL1kOOpg9E1YZYbAcmtABzat8qylNiu7PLmo9CFgp8Xnfkps1jeXiyvInGTKF9U2X0FfRGg9QcrxW84UHXGF7kj68ywLiz0w0o+LlpJki31ZYKp6Y6enu+8sIjR/sjjRz+KhIK86ksbEgWWt90eJL46e9asg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SC1xmNvQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SC1xmNvQ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587M032V030096
	for <linux-mmc@vger.kernel.org>; Mon, 8 Sep 2025 08:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EmVDnxU98TqnYzCFaSxLfvmX5Q/ll7vp8vhzU+iN+og=; b=SC1xmNvQPJOQXL+0
	KSFWtgUk+HOakDpWUhgtKeIQc1WWgPeoTD0DH8XVtGOsn6ZOKgJ3reo8fS9CGEaa
	MudiCDNRo0GDcVRBb5hDHDV5gNJxwzEQ70jGkWENpXcabvE4yeSWbecIN7Cf+ul2
	esivIyOlzlNmomMLmcjwhMOIN0pHargebHuA4S8mlDYJlb2ZtIDqj8y/SnpG4nWz
	vuRYTe8+ccToH9p8ECQh8XMXfqgizfTtBKUo4DlCd4PbbovKg85VsJ/lTxE1DKYR
	qavvradENblror0n/dCYyVuBrCkJG0/pB/DrOtKrwR65cAowq/0RbQanm7PpqiPy
	Kzb2cQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4kupsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 08:20:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24457f59889so39912575ad.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 01:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319641; x=1757924441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmVDnxU98TqnYzCFaSxLfvmX5Q/ll7vp8vhzU+iN+og=;
        b=gdOQHpPQrHQ4gEiYfFg5W7Mb4NGGlHX/kNW98O88z8N3lze+y6zonl7wkbJgoAEYdt
         z2zdx+3B+zfvqDTmS/MEJIrEE6Ns/5wj9TGwjwVhNLSkiqjOgCXl+3XaSIhcNi+rmXuZ
         fXtYWWdgK1Jo6it2So6p+OXJ0bfNixFyTFJTABonS79mVkGkGAxlhmWic+gv1yCsHySZ
         EIXhykrlaifvopzjs/ZnJz5PZKsnQA3b8CNCT740YNC9y4tGr8Zax1OfwcOJqSbTD8UD
         VagaiFjJ9P1HfVnrPhhHHnIHOd07cT3ktPZ5tx78QyEG1yYDxeXoO4Oz2d1dXTU0LdOI
         g5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUETtT5n+07Bbk/P9pyP5RFWf6gJe/5vFariWIAm6ld8AHWOcj00Z2eHwB9b1+HNH/nGkXX9lwUXKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3InhJzQKLLEPxdebX61DAT0Vy5qMn3jxlLj+OKOc6E7ThMpvX
	jiDHIrkTbZw1pYFobwbDHZyyZvCLPQWlQ8/HKMO5g11F/4NVblxB8zvBl4VNjOjH0aZ9JbC58vo
	/RD4kdztCjcQ7COJ9tyXSnkdoLD8RJfVLHfcltsZosp7oDIShcQ/5qafmagSV8mA=
X-Gm-Gg: ASbGncvLsBtXXXOxRMSmz/oyIRLsR9AUaKGX9OFfPCs90BuVFf92jruBdZwHjmlQeg7
	qQXfxsdmlZHJ9YvXaHBhPFN70xO8aNHi6M83rdjz0817eOR878Hvj7bALN/ZaZkgqS9SPXdpzKr
	QZMRmm5W2q4Flb/zyOicWIlbZF+EYbxNWnSfsDsOA9VufTO0YBl7poQ+mzJUho1vhBbtwo2GB4l
	i9aIx9uKv/laeTl966+XkCNKavjxBv0aXQVkpTmMVuzYHKS8bs3fjK8Ns1zMr8t/wmNmQjZzX6E
	Q+tQ/Z/CP6cjOgpD2a8P1i2PkTtra76YBwVRWSuikE9pXSDAJCiKO9zPmKLuIvsHJK+a
X-Received: by 2002:a17:902:d541:b0:24c:d717:71a8 with SMTP id d9443c01a7336-25172b49a1amr104521545ad.48.1757319640397;
        Mon, 08 Sep 2025 01:20:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnIkxO2hRnmTHM8DY8Yy8QL6Z8w8e2IIYZlJagoO9krVL6mQcBPeRZhU0urfOAZkEARU5PCw==
X-Received: by 2002:a17:902:d541:b0:24c:d717:71a8 with SMTP id d9443c01a7336-25172b49a1amr104521045ad.48.1757319639802;
        Mon, 08 Sep 2025 01:20:39 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:39 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:56 +0530
Subject: [PATCH v4 06/14] arm64: dts: qcom: lemans-evk: Add EEPROM and
 nvmem layout
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-6-5c319c696a7d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=1155;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=sXiH/sPxber/1Cxwi07raIsGtdfiI2L0RlmvNjYR4nE=;
 b=6ROCwfQG4lnnOWSQCa+v+ZMjsd41mzsfZOmBlGk/2/AadvqTkIzN/CxqN0DAlkXCADt4coT9l
 Zllg710W+kMD7f775FVbJZ3PLh2hrSa1tbx7YlHJ7SSXWuJZQFIj4Av
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX/mIQonz8tqZ0
 Ski1Mf5iRDlySNm0YNuPz5zRYCOvpYSiiODBx1kFibENq2Qz9/R90Wo5zVpNr6qNzEf6a2OhHRG
 JRT9smef3j2vLbvbC28YBMt/TvZmQ4oeqwd2RRUJQ7AZDBkiuFIuYOMtzELLgjsMA+tlAHJevUY
 Of2X4pX4WlCxsAxoz26wymXRjJXNNDVuTERzXPAYftqiXYum7T5d6zAvo+ER3qmP78APa5GAdkz
 2fXV0q6NoUC/iotxnjIxHtvQ8EaLqE1oxooiIH127ykXiBYfKazspjnhUJegwmw6xuGfKe4VCSe
 UlM/cjs2udwAdGTjKrU+LUF5WrotV8xIk1kUnQre3qWIgccj1g2CL12MZYiyoXCMEQgPpocQEzs
 edGdFtMn
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68be91d9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=cq19zQBcvAJi0RM8MkQA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: MJuzSM98GR2f-k4RhMzhTrxcgWlW_MeI
X-Proofpoint-ORIG-GUID: MJuzSM98GR2f-k4RhMzhTrxcgWlW_MeI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

From: Monish Chunara <quic_mchunara@quicinc.com>

Integrate the GT24C256C EEPROM via I2C to enable access to
board-specific non-volatile data.

Also, define an nvmem-layout to expose structured regions within the
EEPROM, allowing consumers to retrieve configuration data such as
Ethernet MAC addresses via the nvmem subsystem.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index c48cb4267b72..30c3e5bead07 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -319,6 +319,18 @@ expander3: gpio@3b {
 		#gpio-cells = <2>;
 		gpio-controller;
 	};
+
+	eeprom@50 {
+		compatible = "giantec,gt24c256c", "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
 };
 
 &mdss0 {

-- 
2.51.0

