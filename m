Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C453074A9
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004017; cv=none; b=PRzrv2G3TLaTCAwFmMvLAa+3P2EGcG2RruWkGKoStIOBkttXbJEZcvroR0XUj8YpQr8ak4mNuKraq1c3BLNhpbsugcrqeu/+V61UdgXUhSbOKTjnSH2X6kHAIxus859GNUgEuNTIuAL0nSQG2dKgRJGaDr3CYA8Zhuzet0DmQEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004017; c=relaxed/simple;
	bh=EsjGsugzkFOlqzSq2/WF00KrTeKmgk9inDCb0jMdM24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NZ0Zth7pTDUPXgFHw9nDMm94p5O3n0QpFHKuoEQVaCdDIn5XsX40E10hzDMl0iWuiQsD2mh+gemSuwq/jrqR7z8OSKEReh2KcxZxuCUbsVGBQ/VR8W2sb3jH9l6ohDjhh+KHbFh0dPczgc4p8CLHYcoAuQTyTx1m6+BNDHsBYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TCx7V6rg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TCx7V6rg"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X9AZ007609
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 16:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q4jUPc7Dj/QW/Q1xVXbfjBdmzCMyLfsRaqR2VFgydzk=; b=TCx7V6rgR/YDf4Nz
	4p2/pkgm38LUAZBv4JqAixInOh7h29aBMD/l2bm5Sc8vO4/UliOZtBTyvplLeKMu
	5mPtFvt3eL0QuQWvBMn4AmKD2i8g4W5gLu6VLhVTN6ve5jxvf+1vRdQwQ85DKIau
	jvGOHi16IShP20YLAAPe66EjAbz9gk/t81X2VOgy9Go7FVbKQwdWRVSFrZqEMTYR
	8qYJM95Qb08Jvzcc6cZ0yGdzZ27gp7wC+TGiCL2qblLB5gi7GiffPTMqvvfM0vA8
	eDZkhOdtOeuW/4gnmqkNK0YG5vHvt4YJYGvMaN4bvBFPU6WLKcDmjHeVl7qljUdL
	My5E2w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura90428-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 16:40:13 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7723aca1cbcso1194744b3a.2
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 09:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004013; x=1757608813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4jUPc7Dj/QW/Q1xVXbfjBdmzCMyLfsRaqR2VFgydzk=;
        b=hW9wXh5CIENXv6rBNMf/bNm2PhhgaJkI2ylviH1vAuacZ52hHtJ/S/GHhhzNAScjGe
         SqmjHrrfMpkE70VYcuY5A2bWaZqPhtUxCmzuxVeVqjberWzDURnYWAPBVd62iCTizN+9
         ZtchPhaRGnpP2rparmre7tWPbdrCn8wKr3Dg5sSHv1L7d8s9F5dTGTFln/7Qjs5LwnnB
         DjDtN/SFfsu9dUIkOD2TDxwi8s50r9GIFSzyznGV402v18OUyN7IcOFR5MMYx43OOs44
         Mz9Nz6KhuRdfCaDMkPy7DR1C1LJCYkYn67aGlf+B9aMapiyc4/K4181TUzYOKfYZcJzC
         LE9w==
X-Forwarded-Encrypted: i=1; AJvYcCWWBpW6a1Ns8NqAYN2MA1E1BVzK2HLl/Rl9YTrYVYq5Lr5Tl1Wy6clcJaIqjXqb/8lnvP+f18A948Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU2+Weahq4acswH6PsjR6ZUtXM+82d7zhTIcwUr2mMeA9bb/HV
	R+fAIZEk9jw6U/3A30mFnrJkktlGuInXgS6kmL3J6zNM1++/DMpdHhgCRpN4QqadZFqNdpC1g6K
	A7QldI2Di/NRhM6medf7mVMWqApff2EQTTV6gVh9WoBD3/q+jMlhn9gWDaqiASWU=
X-Gm-Gg: ASbGncuKaItJ+FIiIBOQFThnFQVwaiBJbF2toO52hGmrvPtaUxUwefPFop0AFG9w/8q
	m17IoCOolyrKmRbbNv+iBN1cxGiKjww1DQ0p1lQoNA9fmggtKZ2Fg2zDKh6Bger7swekaqxMlR5
	mEwCyhuyv/vMXPmpR6in2vXZ3yaUoFnP57iMLWWW0ppHJz4NP0qbYtBXRtN0bJpthACkeVzjHKf
	ZONKar1bE/7S0mmaNw/Kw71DZxiaRPgcF2jv46vEuEOREnIAn6CqB9uuBxeKk4SLvZm910SF0mJ
	RfasyPB2gmky7QtNxQ9nPt5Gw9xsQqFHeHxrfQ/DeY+tr48YmJ95wbrYFCWM86fnKcCm
X-Received: by 2002:a05:6a20:7491:b0:24b:1a6d:298b with SMTP id adf61e73a8af0-24b1a6d2b96mr5045654637.34.1757004012725;
        Thu, 04 Sep 2025 09:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmaVrqqvWvNCJ18FSo86iVsdvqCApjzOy7HSZ7MVp/HHNY25R6gM8RCj1Eh+eB9N6zP6fXQg==
X-Received: by 2002:a05:6a20:7491:b0:24b:1a6d:298b with SMTP id adf61e73a8af0-24b1a6d2b96mr5045604637.34.1757004012076;
        Thu, 04 Sep 2025 09:40:12 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:40:09 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:06 +0530
Subject: [PATCH v3 10/14] arm64: dts: qcom: lemans-evk: Enable first USB
 controller in device mode
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-10-8bbaac1f25e8@oss.qualcomm.com>
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
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=2112;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=uSP54TRbiqMtyGBnTmkQIYSdloVjaATg9VZzmh4edWo=;
 b=2gaDsexzwkO3wVXtaZNzsIWQ7hE1pPRzXTqZO4o/Cv4gMlTBQ5p9KeqXcvvrcsFGZYrm2pyEu
 EKWL8466lJwAIi8iSrGvDceB7WoNgyLW6PuolhfO24fTdhnHgLFfsNr
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: 2EOc6C-AxBxTByY8PIEnS1tRg1dTGHKl
X-Proofpoint-GUID: 2EOc6C-AxBxTByY8PIEnS1tRg1dTGHKl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXxDsp+bvcIXgE
 t2f1Czfu70B/oAulXk4iaupnj4AyAV/bpKSqmrzch/LHJxqvBPNZtOoeGMdPG6U3QLi6+miiS9B
 obEjecMj7WhjVBk28AQLjQdlvue6yLM9PIwsQQJha+sQkKKv3J85J+I/7HUgD3Y+enfGQsw0L8V
 LKyvnhBqlMGom+qJGQEYj4JfnkJj/RijTYuh31K9DZIkUw48J/rFE5q6V7hG+oUzh2o0UsGIi3I
 d+Ni30ma/zRqEEUj/0kKcVGZsx4/yBMnomb/89NkszG2B53KN9DJuYYOqvDbYFubN6CMNB2l8lY
 B7mqP5MFW0lf+etwwjO/P3XNePXz9CqJAr6ZI53QFPe8S3TFw2VBLeERZllAgaNdTDUk+ENddb0
 NCJfiNiu
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b9c0ee cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Nk2SLWWF8xhsZ517u1EA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>

Enable the first USB controller in device mode on the Lemans EVK
board and configure the associated LDO regulators to power
the PHYs accordingly.

The USB port is a Type-C port controlled by HD3SS3320 port controller.
The role switch notifications would need to be routed to glue driver by
adding an appropriate usb-c-connector node in DT. However in the design,
the vbus supply that is to be provided to connected peripherals when
port is configured as an DFP, is controlled by a GPIO.

There is also one ID line going from Port controller chip to GPIO-50 of
the SoC. As per the datasheet of HD3SS3320:

"Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID
pin low. This is done to enforce Type-C requirement that VBUS must be
at VSafe0V before re-enabling VBUS."

The current HD3SS3220 driver doesn't have this functionality present. So,
putting the first USB controller in device mode for now. Once the vbus
control based on ID pin is implemented in hd3ss3220.c, the
usb-c-connector will be implemented and dr mode would be made OTG.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index d065528404c0..6ec6f9ed1ec9 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -538,6 +538,29 @@ &ufs_mem_phy {
 	status = "okay";
 };
 
+&usb_0 {
+	status = "okay";
+};
+
+&usb_0_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_0_hsphy {
+	vdda-pll-supply = <&vreg_l7a>;
+	vdda18-supply = <&vreg_l6c>;
+	vdda33-supply = <&vreg_l9a>;
+
+	status = "okay";
+};
+
+&usb_0_qmpphy {
+	vdda-phy-supply = <&vreg_l1c>;
+	vdda-pll-supply = <&vreg_l7a>;
+
+	status = "okay";
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };

-- 
2.51.0

