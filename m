Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E692D3ECF
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019652; cv=none; b=UBSvIrUqqoAObNqgZuIB/gq8w/eefkQj7k+a3t+rGJNu2LCbKDwWieT8/5uXUReGEGL0DyLsMspiSq2s7UUdtwfz3i9SiCWcEYpXuJ5d+W5NBB0bWHRVrrtasuuIUqlxA91LT2ffTc5kb42rnsOfxy/+Wbe/sFEkfpxDQ/Vzaqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019652; c=relaxed/simple;
	bh=mlexqF5SSClorJ9LQ+lArQE+dRzsOnHZdcxeoekZzOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iNU/D2+JYYI5u8h7P7n4oeYzuqa37qvJdvZWXrE7lZBGrElLuf2tW+4ibkkBwlxoqOd7fNfhHYCroavu8zcCo2hO29G1xIa/11CggvTEv7EhaRQzhDMshg3DubdMKuSQxRljaWq3qb+0U3pCp/6/k39v//0QhxBjwfk8OiDhGFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oTsjFy81; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oTsjFy81"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GABqKd001809
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W5bbMVfAsGi/zGFdo/a7XkorWRKiev2Csg4UoorEa2g=; b=oTsjFy81xm+HPvNt
	w2pIvpVxiMQ+GuscYQ7vxIu5D/67hjvqM07N295JbWEDJqxsl19nVgONz+FLP/V+
	MUIXer6QxX028/vU6rxPn8va1QNycpZ95Z7rOK6yL7EE0v55WBq6IuCPszpIOrk4
	Uvh0ejxVg4z6QlOw5hwHoltsU6C2/EilPMGMWxhSwxsjvakZi9uTlKvjs7ZmwZdh
	dB2LeB7+SoDYyWXvmrs6FQxK6+hciTq/H0yRSXAzi48/7d+JsEd7b7908S+C7pH+
	JNG3yfvzVeWrtiuWhn1lpscy96QGmgEojkxiyNlHYcfVzdXLtR7erZNjZBaTUEif
	6skKbg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqpyj2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:47:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-262f626d62dso21357635ad.2
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 03:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019650; x=1758624450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5bbMVfAsGi/zGFdo/a7XkorWRKiev2Csg4UoorEa2g=;
        b=BTeeT/gcCZSKJX98aFKQRPMEbqS9D7ZedqQJonYcj0gaACTSEuuajqbUW86f5K08sH
         qBbTeO9aAt/G+Vt08gxgqLNAdstzhglqY37Fdw3Z5lyQOAVnu3NsjBtzs46L/bvUTIVn
         evDJwsqMWtHA0tk+cpPB6+UOTV/tmXPTCe913U7SOa7h4PsBjlnePSgop5r5vIH0gNI3
         l8X5UIafzfXp9dJP4UVPp+vb3y2kDu/ch8br7M7dCoZxZiA5ethD/5AVkKy43Sz9c/M1
         scW3ZXWA7rVo/pQe6t+gMt8ZDnFO1vLsyGLZWtTqmobIKO3C3S20GA4lQXBXqKAqV4aU
         iL+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpxV4cKWErRK+9ZsQMPyCePoaW7Kqvr4s6NTqg42Hv3OpcNAZSsVzarxEi/fQi/i8ZQLXbRH9cvk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05WOoqzd2zxZfan1t4dNqojjOT8OiDgv4G6avnkVyMIw+77yL
	T5HwaI3a8DyA9OssH4qsdcbIrtbfwmMT9MN8pDqb+5XDciU4sl29rzcndYIWPZXRTjoss5fF8bK
	zJSICJsjNiBS1CXjibOCLxHfuhijzJ8UeKaFTWkXJ21OLkB9H+yHJgwjz6y3gS7Q=
X-Gm-Gg: ASbGncs9TPB510JASos41c7fp5h3fMQ6rpdkkT5Dgl86CNg430WTZ++WoxCXCPbmpio
	6hxjeI9hgMPy8anIWXO/pweQpJmMIZbaLM+CVEbNcc1ptk7USLStkbrwgG5VwkKAigzM2LZcDoY
	YoZ7Huj/NmfiYrarts+yXMYyiQ5RRx4U8lrterG+oSDUMn8ZKolmcuYWqfrmJAZcBXcsRgfAp4I
	u8YKaIKPF6vsr6qHSUexYtaQBq6kpxYfadFm5qYmo88C7y8hz+XPRfzEYfHeLIbku1DvYp8YDfs
	s1QISDCnlp7ac1cTj/0rcltCk1PAr0OSkOsc22ALHLz0JuIB4BeMv5tigDCIOCiHfLzQ
X-Received: by 2002:a17:903:246:b0:246:a543:199 with SMTP id d9443c01a7336-25d278282edmr238524905ad.54.1758019649686;
        Tue, 16 Sep 2025 03:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6jGFWjqTWuORsJ51aFQBu3B1Av+UTVa/XXCZyM6ScHFCNT1dEfSNNMB/0PbuYoQ0RIVbYKg==
X-Received: by 2002:a17:903:246:b0:246:a543:199 with SMTP id d9443c01a7336-25d278282edmr238524595ad.54.1758019649219;
        Tue, 16 Sep 2025 03:47:29 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267b2246d32sm33122355ad.143.2025.09.16.03.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:47:28 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 16:16:53 +0530
Subject: [PATCH v5 05/10] arm64: dts: qcom: lemans-evk: Enable PCIe support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v5-5-53d7d206669d@oss.qualcomm.com>
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
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758019616; l=2441;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=1dTSMAUVpK/VA6UxCdymUCA481jMMWAbBqXExIY/bUA=;
 b=6aEz+wYvfbehYZRkVuSrVm+wQVlYKa5gmR/lChw2IGqZTd8TurAXb6u6Q5pQuxQ0yLfVHZKFI
 7WNGyaaBMLNB42PRhxPqFE89L+mNTiDa7AHV/52GdWwx8IkbUUPuyQu
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: j6PDrvGTw6POxtzt76SdZB99DZcdUj3V
X-Proofpoint-ORIG-GUID: j6PDrvGTw6POxtzt76SdZB99DZcdUj3V
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c94042 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=y_IpLqVBJp9He2uYrA4A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX99820levhl4N
 fhLAQDdF3nIUkvkKmNweFM6auRAz/EaKY8u8ml75FutW2qzJmaW03Z808wdeuz/gbdNR/YuXQtz
 7ktSi2nvvwEIpRUeV2StWlBoOq/5oVOutiQ9teUEDDEss+erC7yQx2cusBYS/cYkZuqNUfIz9WZ
 Olt16ZusYad6jiuP2620bMz5m4T22g7IgcHGg+Z6raByGsQUMbWOcrltHxqeR+TDq5/cG5EUO7W
 1ve678tQA1iiSRDk6LuQNE6fyeSH/4mkWPLA/dROrkSQjZtK8p+IoyEszrvIiNCAiVhHfUfDJAf
 9Gu1B/hyvmFfmVmJo33gjLshdTu2nrNgIA7Jgp/L2C56S/XhlYX56RO3I9Anwnd+rpuSrRC+afu
 yRBf/99j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>

Enable PCIe0 and PCIe1 along with the respective phy-nodes.

PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
attaches while PCIe1 routes to a standard PCIe x4 expansion slot.

Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 82 +++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 97428d9e3e41..99400ff12cfd 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -431,6 +431,40 @@ &mdss0_dp1_phy {
 	status = "okay";
 };
 
+&pcie0 {
+	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie0_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l5a>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
+&pcie1 {
+	perst-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 5 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie1_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l5a>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -447,6 +481,54 @@ &sleep_clk {
 	clock-frequency = <32768>;
 };
 
+&tlmm {
+	pcie0_default_state: pcie0-default-state {
+		clkreq-pins {
+			pins = "gpio1";
+			function = "pcie0_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio2";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		wake-pins {
+			pins = "gpio0";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie1_default_state: pcie1-default-state {
+		clkreq-pins {
+			pins = "gpio3";
+			function = "pcie1_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio4";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		wake-pins {
+			pins = "gpio5";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+};
+
 &uart10 {
 	compatible = "qcom,geni-debug-uart";
 	pinctrl-0 = <&qup_uart10_default>;

-- 
2.51.0

