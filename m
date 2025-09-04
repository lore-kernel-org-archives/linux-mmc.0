Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380D31A561
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003998; cv=none; b=ZZHTLNSU2d42NCNEzv0mYY91GjP6jCAdwrG6/w4LG5tkgEN0NnWlSMkM7iwleRQTs0kn1rK4VfgoGMvgTJ7mLrOawVPISojnCp6pNErdbJeAUiBqWj8la3nGxEBLxF9h1A4DYIYqCxgjgiHj30NgmJDh7NuqQPPaIPJYVXKGsrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003998; c=relaxed/simple;
	bh=fDkqRvGyaFinSWWq2t1lwFf0RsUH7vJwveAVvT94bTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IFbe2ELyATPveeNNxBC6s52kj6r98Mv2sOX/JjVQLolYw+tc8HVDAaP85TWQSYFwKYkkWpq3tnaM5kotmMkR6MpaCoRp8CieOKhcufYEuHoCS6LK3FC8OBb1BO5doKwkwxWe63DYCC4MDlwMLL899vVRelMaTUJfXa9cFFmnENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oKYTjy4D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oKYTjy4D"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X9AR007609
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 16:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xas60C8ijwiTmwJqhI40fQNiOoeLXxnVG1r0X3sdz6I=; b=oKYTjy4D0n4qQ0o1
	XQq56dMB//2ozU06P8HYW51yWWdR1d0EXY2FQKUzl2vzzv0CkUF6l6oVZRJMuO5X
	NSkDxELMXfhTTGvR5rgDBZ8DJv9AcdTyr49KR8fNRG5DIEnRC+Ny52nIJNkilRa6
	hbLqsOYCfmuUcJthhMlRqVKy2E5Cm2VyqxLV/b3LnVIXUI4SKlV4krmiUHoV4QYL
	AFmN+LmbvmzLVFr5a1qzTdthMcGQvwu2X+8szW9N9ebLv44Z+Gwl6+wMPyUc+PJJ
	5jEXAokkG75hMqPlJuCOPwwWyIuIORwCA+zn+RXV6lNarfJWOLgEeKvwrfx8ylct
	d3kOMw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura903yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 16:39:56 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77250c660d3so1392984b3a.0
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 09:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003995; x=1757608795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xas60C8ijwiTmwJqhI40fQNiOoeLXxnVG1r0X3sdz6I=;
        b=SEuhvt86Qp2Z2RHW/RYpV5gKXSc9YgFW3qvX1hT1P8V73oD3D9T5P7dVFXzy0jDdCz
         1vE5CjlkUvuqWrZkQbZ6gW4PLaZcg0DaMM1QhmNSkpPW2fyWDw/x0Y4rRrCItyygFlwL
         WH91lxSJmD5FX7gySJngA+R3eynyGaaI1yTRgQuzcH83+v2ef1otxDX4V3Jy6ahUa9Qc
         qyGWTfQb4fFOpvZFdT5VmdwGwjniPCbhWOHILiK5T2Rd+HS+73oBQGvHZQzx0Nkv7YdU
         IaH3h98i3FoszOp6peumtI5nsmkO8x2ZfB8obx8Pr29iFHdI7nQuvbZtq9QCz3MerqXX
         03iw==
X-Forwarded-Encrypted: i=1; AJvYcCWpcY46t5XIM8VVaPSnquE5Zn4l22DZ25IWqa3b2Y4lv4ZbifGFJQNTRw2NamqlPFJek0cTgCQsuL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9aIGAQuD0IwAI7ZE1C6NCMPK5nGAvTpJo+IHnDGx3wsl2VuDs
	Jt880yoTZU10xBbnfX1GgwXIyF+U7NlekuFBV97FVE5Gd0VnNQjXhhnOPuwx0Au+eDdULLgevOD
	3vrfTL1RmdhobT3ZPMcWmBOPQ7nifnqifeFX+EhV0fTkdEY5i6hC9RXKzp8AxUYI=
X-Gm-Gg: ASbGncuT4E7NHLR3I+lO5Y4lseg3vW46c60ve9qNdxkgRwwIEflwca9CduermZeHWHg
	m8tEqufrjK1qArWIXmN0VZY1YQuH+Qu3w7XggVTPXw788QzUEiV4av+09AfQvU1SV7FBpBvT87n
	ZnXSG5KFHXT9Nz3sZn2YeTxhPKxYiq6CFWJeP16D76cXCCYLVBe0jDRZo1/PJJjw7JN8c6GDSco
	Gucuu9IznA3XJmFjeqx8jV/Gjvb/KHBiklH3rXhDQYsISBzs8D8T08TpMuF31gfL5P118oLwBVo
	9ATte5NIVqwF4PM3D/Hub45X7+0aBgIzDJBRZ5rhjWKO7rn9tl19jO3aUMw7l7i1OTb2
X-Received: by 2002:a05:6a21:33aa:b0:248:ace6:755a with SMTP id adf61e73a8af0-248ace67795mr8575129637.11.1757003994885;
        Thu, 04 Sep 2025 09:39:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP41A3JzklvhNIPpcnoxxSAwwOYtQAUUMNoQYKRhiAy8Q6cGA9PJGa1zZ+GFCUFRtnpQ4phQ==
X-Received: by 2002:a05:6a21:33aa:b0:248:ace6:755a with SMTP id adf61e73a8af0-248ace67795mr8575090637.11.1757003994387;
        Thu, 04 Sep 2025 09:39:54 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:39:54 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:03 +0530
Subject: [PATCH v3 07/14] arm64: dts: qcom: lemans-evk: Enable PCIe support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-7-8bbaac1f25e8@oss.qualcomm.com>
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
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=2445;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=AqtBG6UZAsfussB7MJK1QEtygnY7f30ULmObk2D0omU=;
 b=LEmcR/9fffgUDa8DhLlIj6NBanm8EP60HW1h8I+sRyX/OaSOwSy0qGZsrE57ArTE2Ic6mhyiL
 9jxjR8kYUdpBn0n4CQzixqhXnmOgh+c+/RAJSw6eY4mThbrMSmUG2mK
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: j3QXFrHm7GiD1koviVi3mBAhrxtMke6z
X-Proofpoint-GUID: j3QXFrHm7GiD1koviVi3mBAhrxtMke6z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX1mF7AOq31Qt8
 nO0BsE6GtZHsW7qtPU6KZBHayxXxIFkAX6xlMYheptYOASpDqFYnqmM7eYHrnM3okMInoBlHaJj
 0lGobyGoPtvlJFdbo2sTYicY/zLRa0ShCiS2ISuLyOM+K4IRYDZD2Ro1iAzDbTrZ8AGpEBZsgXc
 Li3AYJ9r9DpNS7T2Q20NkMulRb+YD9P6h/HpEzsbK3kcCdisxBjqWpcQiVdFklPxtOvMD+gHvU7
 1g86+CpC+h/f2ao+/VWzzkGat3SzZvDmVnl6Wa9RcLOtvyC0sFPCDm1dyKc4qJduwQKk1nEp6nw
 j4CiRfasN6UnfOJFw+A2GCiXBDHXMiBpKWNXfyoFJ2LGEuLPFLcoHxfCObkTTpLCD2Ytt7GPlJe
 1Si7lY9x
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b9c0dc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=RIgN3AgQjrtB0c6oJ0UA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

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
index 30c3e5bead07..17ba3ee99494 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -379,6 +379,40 @@ &mdss0_dp1_phy {
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
@@ -395,6 +429,54 @@ &sleep_clk {
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
+			bias-pull-down;
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
+			bias-pull-down;
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

