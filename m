Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932183002B3
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900100; cv=none; b=crXCI49Jl4ml2+1nXmKWWPhwKRFqPQ75QNjWcq28+ijeHi2yeS+sa7lNenHa/WTow72RViswUlT9BorKo+ieUHhoqoTuGkSbwMnM7g78uIcfawT8BXgt9Q99Npia3ETi9GMghOl584nosP7OmgO618viwC6wFMuiw0Eo8NMlMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900100; c=relaxed/simple;
	bh=OMmO2qusXp7Lt8NQ08hSTCdRjFkU8mgyUlODCMZLmPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kkm3Qd9Wh5q3tqh7StD47fgG+jfERLH0mCSzN1MG/3KnDWrq0QrNCm6XudvpcP4lv4a5DSOdbErfQPhDVvpxta8qQ8O9pfNmHhAvwN37OiVzfaaSstljEqEX5jx40ReXlTeKQDkkKNdBxfEeJX/WZdTVz5a488+2TPE+xRN1/fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ioE/qN5g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ioE/qN5g"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF9DD003120
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 11:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HYUvyVFhjknE/WVt1KWvLE4zOZML2zuiKhdUsPmDp6A=; b=ioE/qN5g1eg8D7Xu
	7S12Iim6Si5kXMKfZovyxl9tgsw4l2Kq3HRCo7O13zZawjWASNSH1yNIK2ddOI7+
	ANrXcdHFxNPIW6i1wQqVRLh7oFC/yX+ZXogM47/aV5tAuoReNk52Ab8NvSj1giHf
	wp7RyU+nwQLJQCyNwVIvIMt0RM6vLboqJ7NnOW+Pq+eGPZDOCQ1IOys5DVZnnT5Z
	ye6cnolLNt74xSakF+EAeCipbkPmBHiaJ6d8efeLffXv+fUFLAKz05C6isKOi8BC
	0Za3/gi3JhdjY3ogEQDfQlmC4YXFxuMzpXj5iXEvAaeYo0qcaKweoBc9XVS2umeK
	vWYH6Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw03j2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 11:48:17 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7724877cd7cso3914908b3a.1
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 04:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900096; x=1757504896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYUvyVFhjknE/WVt1KWvLE4zOZML2zuiKhdUsPmDp6A=;
        b=SDH1/z3NqOc9rX8KwoPXTjB3pOBEblKJULF9yGaYH3WJVlmUlQMVVE/HRfXm+jSXS6
         wVvKnq9ri6SVL5GYENOkDitKur1MqR69bkSikmuqbAIZc2V7LPG0fm3Bq8ROxBcRF6eO
         Wyio7mSC9coy8KRswt1bvYdbG8TTkj72v2Kp9/4fLpK837fah/VHsEBve3rKKS8EY447
         AF/ZJxbD+yRHAkXO9hb+XGlmvaKPt7gZioVDUza2WXYSMlumcVGHRX/z65eJQPvyJTV/
         G7Kp/O1+eTbgXeimWdItrxo/87wLytxo+YBB17ADHZxqD+w7owqCsjiBF6AEb7wlOBmD
         BOfg==
X-Forwarded-Encrypted: i=1; AJvYcCXSNCx05TO1zQz0yJs0BdWiCggYJHj0okEw2XFSwJ56H6EE5mYUMID9+SMzs8HLR6M42Xb4XNoMYok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjVnXCa21Twe8LLKvd+xheAxBTt/xLJgsEx2LKYFF47GwRP+2q
	0L9DzB8eJtMKxC/0c6wN2FOjani9e0EOsMzWKUHW9f/E2XQXrDOsKZzLiZL7gE8fTnFeOx4m5IQ
	3gl9zVMLuvxfTA/4fRXEOO4RuuBHpbTjUVXaHXTQ0JdVpMTTmMfAMLeyBIYSRr6TwdBE7HUw=
X-Gm-Gg: ASbGncvagprPmtNDJWLl9uYVApd9/RMY+DchFvcAmBQ46CUq0gK6+Tuw9lb0aXY3q8Y
	MiJePC5RIDoWdT/5tL4lO7wxz/lkYskpGV/G3/q9oZ27SZEc8vDHbik95HzvLzd0KH/uUv9wvhN
	yp8wfTy6ssBo/6zLbvZhrXY/GtBPc4NT8EeMuDPSwrKFUfHfZjSeiGOIzonh/873TxYycbnVET3
	KfklM10eg0dd8eEOkfX4gUMA+zy7/VOW0q03vG/C/ADX5znXbn3YBCAzdLiOHwuNPLV4iZSPeQW
	nSawaxllYLkeJE7DVN8ALQoIReZOFNF7xZWAvVTzOhtgubV1aMGCEiNUpyGLgSNZf+Rf
X-Received: by 2002:a05:6a20:a10d:b0:248:86a1:a25f with SMTP id adf61e73a8af0-24886a1a5f2mr2868629637.24.1756900096002;
        Wed, 03 Sep 2025 04:48:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVF0YOtRnZh6lzIY4bOOxsucOqwE7IEqnFh1IXBtFdue3ljMah6LLr0S8VJ+jEOBFs+TNvxA==
X-Received: by 2002:a05:6a20:a10d:b0:248:86a1:a25f with SMTP id adf61e73a8af0-24886a1a5f2mr2868592637.24.1756900095515;
        Wed, 03 Sep 2025 04:48:15 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:15 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:10 +0530
Subject: [PATCH v2 09/13] arm64: dts: qcom: lemans-evk: Enable first USB
 controller in device mode
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-9-bfa381bf8ba2@oss.qualcomm.com>
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
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=2112;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=wbi0daESjbNaIOArppgBBTQqid9X23CoN+c1pFU2aSo=;
 b=oRJD5bisNnpttQ3ShOqU4O6Fi5tTtdoR8thW7WDzmP550KyX6RXVCczUsU48CPWFCTuk14V9X
 NXYk6OUNXoMCcaUpcreCPEpn4SKKXbJz6dUaLyuOh9QtmZOKBj7JsLb
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: 1PDYbNMmjMxoJ1uc1sDxLI6PPNAgXeEZ
X-Proofpoint-ORIG-GUID: 1PDYbNMmjMxoJ1uc1sDxLI6PPNAgXeEZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX/TCmHtmUSkCP
 jNyCMeTT7V7ft0rn8iWaLtyN99XKrzdRjiWvfKyqni8N2dL8Iqx5WXYSxdwbgWOdDRP4NZbPzly
 CH07dEWhMvRiR1aqTRj2tEiQJzuI7F+If6JAZKYna6aYtRaylTN4f6Sap2hmTWUVVd+xzfwPB29
 D4kdMcxIikB3BllWuA+4eIHQLDbBAvgQG4ANnnTCsmQbFuPrIL523LqlfJ/rslwhkQQI2ozh2yM
 iid3qgTLDdi4wHPlQrI32zvtQf3idqdx4vjEwz3htyXolmbN5IGVhCW/OeSjVpFdXgCTegAqKrP
 JLllgW/IxVTQyGVHh6QNyvu8GpOJK6VOA3NidqtsyfQDrajRKDkinPqJ61RbUDnS4/iHU03Fjgk
 lRT9DKih
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b82b01 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Nk2SLWWF8xhsZ517u1EA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

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
index d85686d55994..b67b909fb97f 100644
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

