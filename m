Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F3E301001
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900104; cv=none; b=sgnp1iUYaSqWbCm+j6ObHOwNrWE4HS+aXdaQQAsd1+N1Xi0h0WE9DmRcuHwof9KagiwAK925KUcGlT17EgqBj4Tk7ZLweKsX9BbB2aC7L512SgCWp81ejlUhcfEfTLAJ+ZAOAX+cJYiLxV+jG2OhFWQB21Xbgp8xD0H6eBFGTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900104; c=relaxed/simple;
	bh=vgKvMK6y/VPKyttLGSjpHqgq/bQ7Y/dk0CJOwFyaiAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X45V1NzRFXiEQfWJGAvC0rcLNnoNxV+G0HyTtezO11np9xm3Jmuf/Uv0IvgL/oTe6D5gi5yupNWDm5pJ2lW3WEKU1ZqzLamPC6LdTQxAxE7XOk08KG5YzdoDXJbLMinATIN8yqXMfN+DI3O4ydhHdqIAxW73iIdZsgauvUN+Pb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Di6ovHwc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Di6ovHwc"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF17j002939
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 11:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mjZ3r1HUnM84qXtwvypQUlVDZydeq+NJjZUSJGbaimY=; b=Di6ovHwco6mWZuEN
	LZnaHk93AeeNNy227jX6WcjYLsCOyKRnXIZNIzi7eXNGVSIPkJSSQ3tAIkVXq16K
	w7AoikW9qQOCXH/cIfZm1TbaULKV5lrMzCy2CajBVwzrGqYBhE5FFCg/cHB7sS3k
	98zzsuVLcrvJ1wvDKEe7T18UIZsmgE4wVJ5bOGNXAd0a6sfET50G3mhCLeARVYmR
	vaEICHcsExrZR4bpvw2wMTKQsG9tpZnndI04PHFp5olYpZDCrn6hmU+xgqqOdRXh
	X+GAQsuuN+PI5zkrg4oLPf1FTmbYM8n7LRuh51M/fY2qJ1e1LaYLZpUyOWIW/vmZ
	MIfbDg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw03j2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 11:48:21 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47253319b8so5117226a12.3
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 04:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900100; x=1757504900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjZ3r1HUnM84qXtwvypQUlVDZydeq+NJjZUSJGbaimY=;
        b=b5E6n3nhAd/hJnjP8obvVyHgiSdd3ELRvcojQE96qHqc1LdWzK1Q4EM6aQqn6sW14i
         hJRRmMP2D7R9X5z/KOFKw8rp0n5LFpMI5uRY5V/xeiH9CzOqnIKQsSA+P5MEe4MDW7HF
         oiipsnnDpx90fxacKFjIOKVccEbJQZUuoTAXat7dcNnUoCdVFPnTaHM20aQsbFzlYRFU
         7j9IOVak63S/uPfZ/oqE5jfkeLCec5IoHIUnQIx11EkE6zZVpsEfVCXYTCYc+iuO+fQO
         4tMSUh6Oz4d7Bpsbvw9Ywa6CqhV4dAdQQiBAr1dDySfW2Frq0eQUI0JdIbZWbFFDj8KE
         ajgg==
X-Forwarded-Encrypted: i=1; AJvYcCUTXsjhQ9IxI9GmZo31p/mDbXkpbyuoRi3WDV4GWYJ6CEekfUqh28t1+Mq3hiwvWuR7A6aodWx5Mow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGunItgNXEK8V57cDX8tLhDNqhKg+7Qq5bn2HkuJl4VcVjjE6q
	wPc/RdQVpgwYxKaw47bMir2jMg+RcikXDMBuHwA3unAAKJRaRikWrL64kzg5wAXelnYEejLZ09Z
	RchQ0BChqJX3mBgoQLtuofLY1WMccbIYSDNA4C4mMOFtT9fUjasqaYfQrhspkViMxB18Iuvo=
X-Gm-Gg: ASbGncvY8iDJm12sbOY5cEI2YZ7BaT8a5h65DSGFaaAcCFshgWYhD+raVGsTbFXjmXW
	Ubkz0l49EXOd6tDTPzEk9AopbTWGB/cYvkDyYn+Q9+j+3rPOkn5XTVr9UqaHF+hT98ZJsPu60OS
	OVHX1oUP8yLSyNK6z1YA0p5WH+9rB8nTmPFBSaNnPgorkxng+A7RMYrFRxY6y/yeFZT4b2DW7/L
	gw/FVc8aEiDDKqkZaaeqDNUMbN3QK54SE/4A7PRi0SHqcVcXQD0zcRfnidlMfX97wMavErddrT2
	OpVzRphO/r+M3XJT7baqGUh4DU4oT6ayTFT5y07EkQ60/N6gWAVUB+7Jn2cdM9SCRO4h
X-Received: by 2002:a05:6a20:431a:b0:243:a682:9d1f with SMTP id adf61e73a8af0-243d6dff535mr20746134637.19.1756900100355;
        Wed, 03 Sep 2025 04:48:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKlZFAPXjo11ONNgyjTG4Em+10bWJ4qImiiRsEKou0DfbxCAQ12ZIlEmIHEIKkikQaarj5YA==
X-Received: by 2002:a05:6a20:431a:b0:243:a682:9d1f with SMTP id adf61e73a8af0-243d6dff535mr20746109637.19.1756900099859;
        Wed, 03 Sep 2025 04:48:19 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:19 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:11 +0530
Subject: [PATCH v2 10/13] arm64: dts: qcom: lemans-evk: Enable SDHCI for SD
 Card
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-10-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=2019;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=e4UGRGci1o4NHHD8fAyrLZlNVC7z+j0/9/IXHZK3Mrw=;
 b=ICtwKqzBUI8DnoAfdFtTbF6z6xI87ochkmdFtCaZRSqZ8SnbpmEpFlk+xVEDBMsw3mOSDvp0p
 oNtX60FlEzkCc1SQZqvnOPWma3bB5PuPmot87BngWv/hwS3Y3ThiO7X
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: Cq104y9dZcBd8kDt0Ysjt_QlqYXuV0Os
X-Proofpoint-ORIG-GUID: Cq104y9dZcBd8kDt0Ysjt_QlqYXuV0Os
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXzAe7TzwoPeh+
 6ITOMSXCnmhmamr/WjkRW8FQwZfZhXYEwwioZK2aYHNdrhpqOT/ASedVkFK9z/DmDBW4vxJV7ip
 UjAITmNu/a8Ws3PBMl0qQ4QirWzua/53T7o4eHxWOqXcSc1GUlftDVoqQsdoXkW78IgYob60qHo
 luZrlwCImjBHs6rIQFhJRQIQGKeYMDjHDkvePscbMkCfIFTHrtERhHJL0wTmZt6Ylt9BBXpJOIg
 RqWMQQg6zyE+ZrAyM+IEszgAYHAC7VqG9xWOrXJ04yyY3ITSjOV3rMuNi25Tzv4S908XggF+kiB
 ivfFQp8apZ2MxfFhMNaE9o7JEEZsyVm/Rwfeyqz7RAWzwZf9zsIUpf5VjoDV6M3kvzHenb2dDWF
 vflbWJYG
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b82b05 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=JaNxBooIv5ZhbLa6QxEA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

From: Monish Chunara <quic_mchunara@quicinc.com>

Enable the SD Host Controller Interface (SDHCI) on the lemans EVK board
to support SD card for storage. Also add the corresponding regulators.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index b67b909fb97f..c9e7977466b3 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -16,6 +16,7 @@ / {
 	compatible = "qcom,lemans-evk", "qcom,qcs9100", "qcom,sa8775p";
 
 	aliases {
+		mmc1 = &sdhc;
 		serial0 = &uart10;
 	};
 
@@ -46,6 +47,28 @@ edp1_connector_in: endpoint {
 			};
 		};
 	};
+
+	vmmc_sdc: regulator-vmmc-sdc {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vmmc_sdc";
+		regulator-min-microvolt = <2950000>;
+		regulator-max-microvolt = <2950000>;
+	};
+
+	vreg_sdc: regulator-vreg-sdc {
+		compatible = "regulator-gpio";
+
+		regulator-name = "vreg_sdc";
+		regulator-type = "voltage";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2950000>;
+
+		gpios = <&expander1 7 GPIO_ACTIVE_HIGH>;
+		states = <1800000 1>, <2950000 0>;
+
+		startup-delay-us = <100>;
+	};
 };
 
 &apps_rsc {
@@ -461,6 +484,20 @@ &remoteproc_gpdsp1 {
 	status = "okay";
 };
 
+&sdhc {
+	vmmc-supply = <&vmmc_sdc>;
+	vqmmc-supply = <&vreg_sdc>;
+
+	pinctrl-0 = <&sdc_default>, <&sd_cd>;
+	pinctrl-1 = <&sdc_sleep>, <&sd_cd>;
+	pinctrl-names = "default", "sleep";
+
+	bus-width = <4>;
+	cd-gpios = <&tlmm 36 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };
@@ -511,6 +548,12 @@ wake-pins {
 			bias-pull-up;
 		};
 	};
+
+	sd_cd: sd-cd-state {
+		pins = "gpio36";
+		function = "gpio";
+		bias-pull-up;
+	};
 };
 
 &uart10 {

-- 
2.51.0

