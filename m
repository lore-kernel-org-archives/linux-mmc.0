Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7ED2C3244
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019669; cv=none; b=spm96xF3i2ilrIbQ9W7EJ+3mO8DtD1BIOqFck9DdQrVvn2pRWx67x86MWiMNReu/BrC1tsT99Lt42lWNyJhHcbUXAcvvg9P3zuSnI1qdiR7uX64UI4IQTGbSX46cDl0+WksyASBQckYN/OTE8FW62mmYY81wOmLve/QfFRMfOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019669; c=relaxed/simple;
	bh=Xh3bCDxRPGdeUMg7ftYORU7Dc0rcHwejwIfGZEV/a1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s6JB+8jo9USQ66f74HD3kWbQgdrB47+sZC9wr4qZugX0TUrfKwTXi7bHB5ducW6YRVrCU4L0vffMZz3L+P/wIk2ZU/MviJTc20NtOt/rLse6zZ+xSmpgjOEmHbkizlFfPHlkQ4IwPsS9m6ApewlvHTQ3GBENN+VvFWkJdlTcZhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DfFCn4Zz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DfFCn4Zz"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9pWuw013417
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ODqQ/K/dAfyPRXOmmZNlsOn5jkquIIDh1zp616ZCCw8=; b=DfFCn4ZzI/aPlBSy
	NIUEkWrOQ493AvFLqjo96+4cFQ7Kyoc8fBJr0K2BjMQFPkEq4th7CLFzN3A2jce+
	NaxMwYI0cEBIbBNuvV1SAZT7bTA7/AQtJGoH0hv6rBR589geAwoyvtMKn/cOl1Wy
	SoKFkF41ihmQaWL3RPkUyJYPECmMQSx1PlLS2EjrbyAQ8cpmTEDY4vCwc0J1buxo
	BxWkV2vU4G8CLm9anDGYPExp9Bd0V6W/EfWfBoZM0co4Fs8IPgoVj5wutl+NWI/Q
	DkiVnk3yQQPlBtBXoKxFskt9rS1YJwc+3EyUG2y1SNPZkWpOJyfD4Dlv7wT/FnVZ
	L0Ysbw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496x5aspnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:47:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24ae30bd2d0so50228535ad.3
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 03:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019665; x=1758624465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODqQ/K/dAfyPRXOmmZNlsOn5jkquIIDh1zp616ZCCw8=;
        b=Z2megnxPzqYFQvKMDuybTizwLaoZS1nCoCcBgE6tE7tBCAACbRs3tR9QyELQPidoQa
         36zVNiFQs//es7uHZJ3S1BKXDVydvdRtIoMkEjUGZs7U6K2LGSq9c12ghi8PjwcSlBF6
         wt9syadEGM3lQT9DXYJV/fMyfGsr4fYMqQNfAZc4qOxptgEtaBjyIjQ6b/Qiymdx+1h0
         rBlsAHqkYpG/g9gNw0tXeyHYCnkmdUrN4apXuniNhNi6pOHtH7GUt8NkcAOMUu5fX89c
         gWLzkBxjM73OZHCaMsx68oZvuUkozVJsg36JVfdfR9Bg1VqHFrgeCrO1QBNBxcfCWeUJ
         MJoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlHi/4yCi9WQ2oI9rjnyyhtzp3h0dvwvr6NRiyasJ1Bxv7J8sp6B/gtBKJvQUD5aVYmjLjzJSj/W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE0BA157/RqYBx5blpF76HTb5KXm62aaveW/4yRkqrjeitEpWJ
	sbXjUiQFIX9YEK8NqsyRRMQO2ooeWkO8wiIq6Jh6jI6DFqXmcUf1QECklInUniHN+Ww053LoXqD
	ZBVMqTc9j0Syh6764hsmky9kPOuTQcRsZvISgLj9PYJEReGaPtqUUBezdxOuyfuw=
X-Gm-Gg: ASbGncuYNSoREhlMduA+HRnQ407Fk4WFOPf0glj1KXoqV4vIo77m+FeCXEhkAfKmpDc
	VH8m7mXgsiRrMaL2MO9+KjuEqZ9Vvy1YLg/tYNgTPB9zLyX6RrKrBrBC8uYEg6ekPeF4E8bFh2i
	KMHPkZQOcTfGJANMhpmcjDmmfgbB0te2FdGUXV+M07tmgSiEaFA2mEVJFHwygcEPFccShD6eFi6
	Pm++40ThPnjUQdUEv/Sr+HWajsONkLE5nARTDRQEL7BcZ5s15qgzrvqNFUgBKrSJEexeHbR9j2k
	ITvy8PecW+y1s0juO4LF+4Jv4YLWEzi2xIzDreAqBXGaF5HW5dqKyurc3j88VXqZGiZw
X-Received: by 2002:a17:903:3804:b0:25c:ae94:f49e with SMTP id d9443c01a7336-25d268649femr185578925ad.37.1758019665512;
        Tue, 16 Sep 2025 03:47:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE0fGMtJfLYMIEVM/pgumrWhRmlKjg0nqmbiYh0SPSOapIziq1XpGKk2RRaGMyMzlA8c++xg==
X-Received: by 2002:a17:903:3804:b0:25c:ae94:f49e with SMTP id d9443c01a7336-25d268649femr185578685ad.37.1758019665030;
        Tue, 16 Sep 2025 03:47:45 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267b2246d32sm33122355ad.143.2025.09.16.03.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:47:44 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 16:16:56 +0530
Subject: [PATCH v5 08/10] arm64: dts: qcom: lemans-evk: Enable first USB
 controller in device mode
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v5-8-53d7d206669d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758019616; l=2173;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=DQii6EbbvglNpSD+FTgSUwcIcTsfuxbUAV8xpnYrhRE=;
 b=YcdxLv8Jxf5tw1xDuKv+Gv+kgAh9vtH5chpvn8bb5L5rb/KxA1L0De5TH9AERkBzj3ER0pVKu
 MtudbAK1kIpA7BAiqaB3wZJfpHazpoJ8aFKkBfV6cENd7RUNiEeRUA6
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: 3RNtQN5J6yXZ2HTJqq-dRbYHAu3mGjV8
X-Proofpoint-ORIG-GUID: 3RNtQN5J6yXZ2HTJqq-dRbYHAu3mGjV8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDAxMCBTYWx0ZWRfX1KP0UOJgGWmx
 LRAJzZ18wOla3e9cLs5m6ymKnUbAOuB/F/OGan8x+PDFg2y6livp9U5P0kitIddxJgQ4zOUfBDX
 n2ZzhjGqvpKXYzy3vIrJPcldmQrGRxdM9jIKz1JWW/bT19bCQvFyI79nywhu3IK6vV9BSesoqDz
 +caoInaIX8kjgQp582a8lv9UltZFts2qvA7MgeKMXCJcUsU5Hu2e0ZDVGYzzdvazvVNOR8d10HC
 yJHMt2WNZOS1v7HJX7k2xEIhvchCIcVoGbhuv4JbOe0TM/wTvptSB1VINv6z6dZMhf9+piGaRre
 uK8bSZyO1w1NTU9Y8gN//UTBzBkeF5F9YYkYXslhhJvjVcvrSEX1Z9mPaQHJBhJQSPw9faQIab+
 ob1dCecc
X-Authority-Analysis: v=2.4 cv=WpQrMcfv c=1 sm=1 tr=0 ts=68c94052 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Nk2SLWWF8xhsZ517u1EA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160010

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
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 5e720074d48f..3a0376f399e0 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -590,6 +590,29 @@ &ufs_mem_phy {
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

