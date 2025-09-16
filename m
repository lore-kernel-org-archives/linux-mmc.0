Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C611234F489
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034798; cv=none; b=N/pDTZ5JPi+p+uAFzhIlvd+9cBBIbK3Z7JMZtDv7AALBS43FREn4CZ6VlO8Gn0/Es801RvXtnIm3SnzrJfLu3EC5rBNUc/fDtsTgGnJnHAT8jPlvKSdd9LIATZ3XZqP6RuogPJnFFXYHyQcVViJ/Djje/2SWHfTpIg6KewiQwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034798; c=relaxed/simple;
	bh=2Nt/WViwfyk1OM7Esn+J4JmZrNIA4MYrfc77+xCl288=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DWCzgrCA+KkhvjmGU4ut/ZuZdzMvjErws3jftVRoNy1qDfA7EWHcEsOKqO5CdF1z1RNuIAhNvFNwet9T6SFXdzHFWi03CCFxYG/+yk5DvnSEmoyALzGrhTwEshVxDC5SXX1b5ZNktdqvGQZlvjhEfW1EwufgCZjjyNgPb3aq/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XfusKa0S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XfusKa0S"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA56Vb021250
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 14:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XxJ1YelP0P/MEMkGmrnvBSD031m8K/rwDAJvdjwN3a8=; b=XfusKa0S/birWy7k
	/XRdF2GH8cOcoUB1W1cXoQuiT8bfmP/oUXopD7VnXVokd0XLO2Q2j7qOwwG1zARH
	GTwBwXb1vNgXcya19uA9r/acedUKghoZMXShpVQn8rbaujz98xX/jEOyk51AWbKR
	mGviXbL1Er9q6R0CFX/JbdjMTBc/mYlMn+F6v42L187GsTNIHJGwqzVN54T8f8vD
	+pjHrTPfIyP1b2eHprC59T0Y8k+TIXiONL6x+RlWWw2Q46+oEaT/RMO5FipKxzHw
	Hgt9+8LR/cjG5rnfzIw+szGaRvX1dT9UlAhcGS4co13cOz/Z0AConxz9eOqueWdv
	4gl5sw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496h1smsfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 14:59:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-263d67851edso55927395ad.2
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 07:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034794; x=1758639594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxJ1YelP0P/MEMkGmrnvBSD031m8K/rwDAJvdjwN3a8=;
        b=c9CFtPiElr07y5lGzUR8CDqo2CSZHRXidOelrxjaEFkaIk8ttuzfNt+jShzyNGBJxc
         SbCGsK2ZQyICzbiW3+3wITxpY+5IZfzD7ZTdeWAxg4biTbpbpiOpUUZMueB51/8kWlNY
         Niq2dUFGARKz3jpqJvwjMB9ZgBFOMK2ruwke2fyeFIDO/6z2eHS8RkJNugnU5j9KkGKG
         dCGJIJQqcCx0ZKKNEZiMZWjXmHqxJKdbYlF5HCLkkGS6PnLM7L6odrxdY9xb0lyJaX6y
         QfJ12kAU+8j3XkPDGY+vVeZ6zxtWs+Hx0jdgrm7bRdCt+aqlc2pq2Tc2zjEq65JfpCxH
         p+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXznBJTVKx76uVQWptOuY9XIY3ujtCn8NWVoauKyNNADRss7UMaBk99lMp6CPdr4nUObNRMpzS6li8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbwU33TyObb4vaLL/2aJ93RXG40gUHp9aogz0ESr5xfmANj6Uo
	FuwySIbxjgB0LOHHzvwEoZW+fHtfcylFnK2VfbJ9f0mi5MUc6qHJTb8zkYgvh5Xtvj2IKAS+Wvg
	UM9+BBVf4cKLzrmwrXwAkrw3r+bjE9rPsKU7b+g9JWZjseam6GUP1vTdbugS8e5Y=
X-Gm-Gg: ASbGncvDgmTwoV6Qo3lfMbd6Z3VntmqytRksxLBMWsl/fgXGM2S6bwyAkb/YehzhQUB
	ctlZ/zhISpe4Vy2BKo6IPijXNFo8+vuvAMEM3v4Gi6nj5W85McsXYxIQ0cle0m8quATyhIbiXdh
	Xg7299Fewku3EMksiMDlRLSWLZnESMAKZM4Mk0kYajJoZmm/OhHiNU3IK/IwVh/nn3e/U+1Q4cZ
	gAKZ1IZ06Ylj/jSdoZigq28sk7xOti6CqKj4LPm5KCBP7OPrpb6ugoRglUd2+SaILShFDpVGrAk
	FX7+5hX2zEwNVITwW0PQe5m0InYM9VJhOgtCgDRkTKODdFOhF67qPbsF8bVsUsMEllXL
X-Received: by 2002:a17:902:ce81:b0:263:3968:5911 with SMTP id d9443c01a7336-26339685af7mr113520555ad.60.1758034794443;
        Tue, 16 Sep 2025 07:59:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBKRspoWP15CqUB2yFIJlfOBXgK+lGPz+ByxAJIF4pwJhl1lPwAbpVj3lSNB+EVNj1pqElnA==
X-Received: by 2002:a17:902:ce81:b0:263:3968:5911 with SMTP id d9443c01a7336-26339685af7mr113520265ad.60.1758034793892;
        Tue, 16 Sep 2025 07:59:53 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm74232615ad.45.2025.09.16.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:59:53 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:29:25 +0530
Subject: [PATCH v6 03/10] arm64: dts: qcom: lemans-evk: Add TCA9534 I/O
 expander
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v6-3-62e6a9018df4@oss.qualcomm.com>
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
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758034770; l=1374;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=MIs5mqG0clseQiptNt7kkk2bdolwAQ9t0S/sVJLewOk=;
 b=HU7WP142411mJ1xhoSDVToZVg4hEjSVd+9TznIykJNgekMuOp3FQoFPXGQ30F6knBFzqB6DsR
 y0OARcqMwIIAlJhUSap0I4maVjq2mGL7jpRy6NuZ/mROwBn9xisvh7i
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: CMaLUWBeUivpQRmpzXQohau-mLFnb1Cv
X-Authority-Analysis: v=2.4 cv=A/1sP7WG c=1 sm=1 tr=0 ts=68c97b6b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=5DqHOVUeJ4EYgL39aBIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: CMaLUWBeUivpQRmpzXQohau-mLFnb1Cv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA5OCBTYWx0ZWRfX7XPTzLZnK0Z8
 EcXT3B7jylCrCcksRKKhuI2L4R/VNPeq/yBbS9jixYpEhVOy4N6ldTWRWHqgvnD0iBxjpB6XP6K
 /1edyqJ/R059pEhqTRJRp4n1Z9crq+MbyhgIqt9pV3VC+elQVcJFOY6HxnuPqOfo/xRZgrIqGHp
 9oIpKW+70JkzOHYwMu2AZplJX/LyIIncF75Vl4/TccX8eoFwxsJ8gbUQ6XEZMOmKWkUB951hXn5
 HxRivKZPEX/GLZlQfpFGQVopy75018MXUhIF65gLcarWQ8lw0G98l//Pajli+7oHUC1TznT7xWg
 Hhe8wipgE+J0IkX4DNQCuLPbaQVaC4sb6Vkt+TuEgknYwHvIe83DyyhDWvMMwhIVwHKSDUpqyEL
 KwXpuBkD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150098

From: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>

Integrate the TCA9534 I/O expander via I2C to provide 8 additional
GPIO lines for extended I/O functionality.

Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 4da2c5a12c1f..d1118818e2fd 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -341,6 +341,38 @@ &gpi_dma2 {
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

