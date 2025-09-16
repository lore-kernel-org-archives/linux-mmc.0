Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760ED350D4B
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034809; cv=none; b=WAW8wbwq2CMnx31ox94TOWxYYZAa8ZM04HQ9pASB1D33vMKoOvunYftnZ7gGHb5sZo/bSDQDCfkEE9T/bGrfa2d55CEElc4F/E0aYtKfC8GUGJPlvlxhksVYvZYhMIX6h9Fx/5mIBkBjjhkYO+NW7AzCGfnOolgBuGYUNL5utmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034809; c=relaxed/simple;
	bh=gW0bPo3OkmUFna1ZDaJHjlE8SmA8Fb3vkmArQbP1lQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VFGqnQTL7OoPcZynZCLlJfUuNvoznPAwwzH79s2j7B6kNZFaq9oUTfVDPeSQJvvFuU0C5vowAx1pQF3zceutHQBM4m8KetrEujfFDbFpx+khb+gkyb9xj+TM81a35ZK5ZgWGHoydr/QEGEI3DR7bndTE4LYSB1ev6NrT6wWPg2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kryeaJq+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kryeaJq+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GEGICG007118
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 15:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DfmoJCJYMW/3EkyXGndpmyfnXojx9Z+R8xHTgwqc19U=; b=kryeaJq+CAVPVeZs
	5Mnk4BSWozSGC/kzOElFYesnzCnpGRIbdLR1drPh2k8Tg9YzhMPIx5/vJaYypNsn
	weaoHcuibn/K7klHYfbPQ8WxtvBWvcvaC40J9GnL1B1Sg7rRx2PbiqaXTlseyQOx
	fDX+KXRd19i3G1SBa5IrK11qK6Vz8GnKCP/NSAilZySEcj/9yQ+EhK6/hSYW/ioX
	PXHlMW8olP2y+NtepNIJPUxVZO8CCnIZOGNk0zMPkOcgI5IRFhooXxHNvW5IXC/8
	Vg1uAfpbe/8krCOSV2d4jRrGaCt955ZEwb9iLcI0HLvJD+kQtpu5X7oOQF53vxmX
	oFphig==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma983s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 15:00:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-265b1c650a0so26894335ad.1
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 08:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034805; x=1758639605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfmoJCJYMW/3EkyXGndpmyfnXojx9Z+R8xHTgwqc19U=;
        b=HvswR/RTdljd+sEuW2QkZNJuc3nUwP7x2Vq4/O8uVKg/HMqsw8xhDyeICh+HrzaVSo
         Ub23dW0FBjqGh3MVvZN3Xl2ltP9Q2i8XLum+TXC3vaXpi15QpIP81j+iW3wyiU5mY2mG
         k+BGpFVyj/V2NllY94h+btpZkuvypBTcdvGCH+KdyZ1K2ZBHhA6qCECFbppBNjwqWHE9
         PgwN9B086impLrUnh+pVfjdkaL4RsqYxqzAzILn91RuUuPsuZwL/5ikvdBJY4hLzFm/5
         Dhk4Wt2VFtq/6LFRLbVHgc65P6tLu53k2tNL0K8n1BAmmwqeJBDUBFb2/OOiW/ksnfK9
         TCow==
X-Forwarded-Encrypted: i=1; AJvYcCVFYhBlUrwcxwKsVMxKpCcpOzHAtp45Z0vJV+Y3QcCaVLTNPtGXYBW1WdK/HUjjoLAtIJCXUekg5Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2OPfTPhMZCtwzKgBidfAQ6cmjZAS8iGdKr5xwV1+uBis2sjfW
	8gD4bb5ObTEaeGQrPqm8SkRt9R42NO+rFolmWBCpVrHlbFkLvoWN88zuPg8i0idszllo0o2e7k6
	OcQBR/bkqQN6EHd0+GKu6H0d+di9pn4zV1LW5krbNNvt2frU3Io5G4DEmc9N25l0=
X-Gm-Gg: ASbGncsug1CELBlrKqJGtGBdcNgWgD++KiEONoieHYaN+pAQHPiqgaB4oa+qZgZ19dv
	OYzBsdAgM9khBKXUUMyCjMvad9sROJr7X+fhuSUG1xJb+O1GWD7v0eyKhJZd8RXZFXOh7XTjMQA
	gsC4gMoC4Wv6ZEeW6PTASxRtXpHx22rXWu0RsrVu2y2glICo98NT3oD6U4UKLRvtH1xoXDcpNtO
	znKreK0qX2PJz864qYFhCTyn56Mfa0cylLa9h2f325DpB4V0Av9ss8UpFpHjgeKB9EimqyWNbe4
	oXxO3DX1ABI6fghOpwJ1t7pPAc6fq7ydpiKRY0aSbxRnx1Axms4mDy2AIlboNFN8pJEI
X-Received: by 2002:a17:903:2411:b0:267:d7f8:405d with SMTP id d9443c01a7336-267d7f84855mr29224635ad.10.1758034804860;
        Tue, 16 Sep 2025 08:00:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5eMZ3RiMQThYk5LoeR9kX3JpRxyHtX+/pIEbsAA7FmX7mepRw7fJ9bUWKCBjk6kV7kbNZUw==
X-Received: by 2002:a17:903:2411:b0:267:d7f8:405d with SMTP id d9443c01a7336-267d7f84855mr29224045ad.10.1758034804410;
        Tue, 16 Sep 2025 08:00:04 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm74232615ad.45.2025.09.16.07.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:00:04 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:29:27 +0530
Subject: [PATCH v6 05/10] arm64: dts: qcom: lemans-evk: Enable PCIe support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v6-5-62e6a9018df4@oss.qualcomm.com>
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
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758034770; l=2502;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=3WsuSGjjSbB/JTrN1dwDIFLbf/p0GZwKko6k8n3FmiI=;
 b=sUXfC3dIKKDaw9CiY4EJTvMsBLjNH0VUE/wTCuR3uY8De/EzQ3wzGaIcguY3uTR8iU+6KQKIg
 hA7Zcj65CgxCSmnYgSQg5Zy8MEqKbNZGHovLvxIGtEWXeSrnsvFH3ia
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX/MA/twKO0II1
 c2QkkXHhXkjjbWh3Gae129lWjqrhtFTaquQnvIyWW1Lggb4nu6KkDRQeLyDR/A0JxMrt3uGONGe
 pS00/sK+KvrLamnylxxSwzXFwLPJiQYl7os+0lPjhxrDV6dCVUp5L1LCBGnQEqxL/I0G2G6Q8aU
 07+52YiYidXcoFi8kxJ9FXBJvLwFC2Se20q13ds7MUYQ/5KoMmLYyOxhpzDdlSf3SZGmqzHP7As
 vpNsgN1akJxuJM1zIuzOHAAKFG161i0BLc/8TM42WDq6OxsqE4Aq7tLgcKzozL2jyf0uvl6EW+P
 bARABb+nDeRA/FXyI8MYVaH+swfaibdv7M92uAiFoQh+gZa+B5k6DKxl8IrT8zq44mlHINcPBSF
 SGxpK2/f
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c97b76 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=y_IpLqVBJp9He2uYrA4A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: CQmoUSwQ20IfuUoSuWRnKej0HuweBzEI
X-Proofpoint-GUID: CQmoUSwQ20IfuUoSuWRnKej0HuweBzEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>

Enable PCIe0 and PCIe1 along with the respective phy-nodes.

PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
attaches while PCIe1 routes to a standard PCIe x4 expansion slot.

Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

