Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7482ECD20
	for <linux-mmc@vger.kernel.org>; Mon,  8 Sep 2025 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319629; cv=none; b=n/asitflSDQwsjmQWjT0sc7QSDWQF0/6FHGTWOadNzvicS+2VTwxRXC1mZkGVDKPihjKwYrq6GvFr7EkzImUDKfR8ENiBcxmPRf2OM3xA50t+CFzpxXbx2aBMri68x/h9+zKVf50JO4alQ6acHgkqQXJLJyPBW25BKA+t8bPrfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319629; c=relaxed/simple;
	bh=gBYL50YC1XDuPqvactY/HGpJkmgy7jZJJarlpKpBrwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZ0Mv12jAr3UXhLF/XfAoIqU88vyFKyCGfjnBO8/JjnyE5/LMrfDa4RFHheBl6hm7JvOo9wnO8SBlTD/84CZbqbK6ist8wkwoXGMZZge0KdlPp5zjtHx9WvIVL3syYssvLSd4MifP9TzWMMDa/a32sEH0/AfioUaZVhyvMoLqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dp2bUuWz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dp2bUuWz"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587MxUpw006860
	for <linux-mmc@vger.kernel.org>; Mon, 8 Sep 2025 08:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rF2ixXvd+CAVz8mNHLTt0wOko08EhUec7UB+gMTdRyM=; b=dp2bUuWzeLYrMdh3
	xBGmajAhoW0wE4g8Na55zjrnR0MxuhNvRtVBKb7HT60GyeWypyzIXqWzCETHwNJP
	LQTrd+8rpAXv0xWsVDtj9rHhGtrkjObQ+nXR68gRQkPCqtW7imJJZm2wH7/ZYZfH
	ZLJWoBW5UH6vsMawubGjxvbWrP9Y0zflvY4zcM+LPldfP4hxm7pQweAfJAkhZ7dp
	UYv+ixev0xAf+gkgdSiVy5HtxYh2/HOwfmLVk8qgahhPqwteYy9vZXNGzOlHcTBJ
	WVIkS4xFy3mBQ3klei3zIhNDK061p2RPCjoPgfJq3QS+hmrYBEx1hsq3ew02rcld
	1dftYQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8bswv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 08:20:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244581953b8so46326945ad.2
        for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 01:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319625; x=1757924425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rF2ixXvd+CAVz8mNHLTt0wOko08EhUec7UB+gMTdRyM=;
        b=xU1PXbki5JN7pfg8ughishCJthaRFJrtbQY6PkghZi810aDDMo3FKUGNGDhH4ZV0oM
         OIHvtdktVJH6l/qOAB2VFc1t9rUTkPbevIXkmJiToRxaYsn5Bk3ZvIeqOqnRccZvoPyc
         q3oPqnPWE8sr4gkvuTqQy2sUnrhquCg2NJ/7gDlq/q8diV44Ns9/LSi+Ig6kGCuWoyZQ
         D3i3UL3yC58Xn2Bt2o9eNU5rl9T+mq8LGhdMM2WOeb+TlMNDUY2XEO5rzLlHwXrikU2c
         Q5opwS9qYhOLq5pGuU6Y8jHiLqgqmpFc3z5fJ+L2Bz3Z9vOQZMsg4UL85cNY8KoQ/WiB
         JcUA==
X-Forwarded-Encrypted: i=1; AJvYcCWv6J0eCpseWmBsJN8vedtd4IuuJpnkSa3210bhPWA8zUB8PVTuBy0o1C32Zw47SsNxRdMY2UclON8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYxUqhtzUi6jAJTuX6IZ/mduKJhh7UbyPdqNvcJDd/Mw1jwJrd
	onHw2JUlGJG+YDme6iSt4JLshkihEaJpLNwZ53QNeZQrciSz1pnJgNOlxDerW2q9LZZLRToGouX
	bfRp9JZ2CIq7HEbCrgb2PkFG8mHZzlcoFQzPN2fEIM2k3my62xGg7WQ2hDwrIKJs=
X-Gm-Gg: ASbGncvDXuCa54ablKksG8MbQe6Ont5yp5VG+LdJOH9LoMnr1wiHwK3MOQX1o3LzoXR
	oH66juW0W5l2RENcyrW8eZjPZTZxCkHXVyhh4RvzEKGGBPR4qHwkkYy5bAlpqsu9EwiGk221gMj
	VY51X4Eb8Awu/mtbIXBnS8ys4B0dwkPQLqZgpQB3G/XiANoU2r0QjG0/U83nHfpHUCI7u32vGbP
	C+h7SIiAkh5xlIggjNpSk8UDMYMMK6Bs6czqIaELOd6sIqpFyh0sImIHUJKAxZlqI5+3MeaED1f
	eqhrYdwVzL2g1pVV8VEuDtDwgY+6unGZc5VEB60a02agOso3Zkbyzx10bP8yQa0TT6hY
X-Received: by 2002:a17:902:ec8a:b0:24b:74da:627a with SMTP id d9443c01a7336-2516f050096mr115464995ad.11.1757319625027;
        Mon, 08 Sep 2025 01:20:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4jVT7W/OifKwAmzHX3E8eS5lp8cqvuFI63Bk1zsxQR6CJi6eIpk7aZvqHkSYv1XuC0Cg1Gg==
X-Received: by 2002:a17:902:ec8a:b0:24b:74da:627a with SMTP id d9443c01a7336-2516f050096mr115464595ad.11.1757319624524;
        Mon, 08 Sep 2025 01:20:24 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:24 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:53 +0530
Subject: [PATCH v4 03/14] arm64: dts: qcom: lemans-evk: Enable GPI DMA and
 QUPv3 controllers
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-3-5c319c696a7d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=1269;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=X+CejMSc/iURyNBdtIHd2b0fknWkLUOZo2knn9rM+7I=;
 b=69UvAQaEZdQB4XITcnpWuh+ii9MjUlEFC6sUkQg/714wq+9n+m5oVmf3MHBWmDuQcPwQo4Fth
 if7W+CtGUV3ARrm2yusKZrv0XAub0o85QCtRf1dtyki0QStCLYQAh07
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX242DpTkXNUCv
 S05XbcHZsXPueHR2k3aHDSZrrKzITOf1yjm57H121Zk3hK04ZPC73V72aXtfM9shPnXhf8ouUBo
 hmF9gWojRwISUIamXS3LuOmoKqeFiRk7UBmXRy9vycdnuxIxIbRuMFu4gbyALqjta/EcSOYEE7O
 07nE7N97TDUBsFqLF/R3F+6zm4w/Pd3SrsA2PTeu3buBxH4us/lGWZIlAqhyDFxjKFFUJiJB3vL
 3hln/qRjJq7YgonaUWBLlti/K4VTWarCshVG9T+1x9hG8l3J0N2r9opItSfAtUavPmq6S2+Jlle
 pSYPJ2ztNqNDfV+pR4Ka3LbS2X/SswdBdTPXkLmkfnd2o21L7i7Fjwz0ejGzbRXuepdwDlgz4lj
 4KZLipnb
X-Proofpoint-ORIG-GUID: c-x5vnkd7ur9ElJJy3bJpwT-Mx_9twXt
X-Proofpoint-GUID: c-x5vnkd7ur9ElJJy3bJpwT-Mx_9twXt
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68be91ca cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hGGMonP7TOO80wKNN9QA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
DMA and peripheral communication on the Lemans EVK platform.

qupv3_id_0 provides access to I2C/SPI/UART instances 0-5.
qupv3_id_2 provides access to I2C/SPI/UART instances 14-20.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 9e415012140b..56aaad39bb59 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -277,6 +277,18 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
 &mdss0 {
 	status = "okay";
 };
@@ -323,10 +335,18 @@ &mdss0_dp1_phy {
 	status = "okay";
 };
 
+&qupv3_id_0 {
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
 
+&qupv3_id_2 {
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };

-- 
2.51.0

