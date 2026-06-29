Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C243FC5A4
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723356; cv=none; b=n9MiDGhwjwhTFY6pcqKpNyjosBEoUwbn+5pk83ps30A3WYt5sdpCE/r0G+HdhOaNeP+uOa7BpmJXvryu0eLYKTbxObURYAFQDgpYXoVZLOqa1j68Q73VZ762X6sN7lIiGnB2843EZls89rg9+d0N/5Nz5h3HTwyBQANOuT4gzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723356; c=relaxed/simple;
	bh=45LaNgBPxbRtyHZ0FmSbWF4XyTOkfAE6p0u9C1oK9dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fNwNDGDfo4EBFqpL4U4zBRVe5/2EN0WIukpam/WjbreD6VgDrnx05Qi7gQHjPRDj3BtzJsKPG8/9twiVyjkF6ev5lATEwIJiXueIQ0W14wddscyURQbm+5KXK/uY+MSvxYtxN9IflVVGFVflaOF17gQzaGjckH8alNEmAeWT1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iq4VWTls; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JhFJ5Pfp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iq4VWTls";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JhFJ5Pfp"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8O7Dx2348325
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=; b=iq4VWTlsEF72+xeR
	4ttGhDzRIivrHn8pUV919TlnjWQskne00TWo/B6pv4C/c5TDY81vqnrJHR4XE7oY
	THxmHiVL61ti1m5iInP+4M1nadSovvZzm3ha+MdheyY+dqx8/d7EBfICmYJVcoeo
	XejDAXu55tkdsr8/EuMbTaqJIgRHXEeNv6EZeFcqTpVxoSLZ4jSI8FM5Us8aE6TZ
	MLm1hyqbfAdaBawkp+nFNEd4bFdPq+n/ah3AdtCjKbEXPdBIYP680DXc+odHnxMe
	+dHBQEZHsdIMBUf1IMMKwqN8o1yg8hGLhkmmlwh23gvMdLBw30CLGe9zBhgrN32C
	zXF7ow==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s04qe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:53 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5bd7ea84c73so4174278e0c.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 01:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723353; x=1783328153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=;
        b=JhFJ5PfpGSdedGHhIMIkd96xfNqyb5vnQy0iYqaOarZZL7UFNsP0/vyIyEdcWrSSTd
         qWDNcqvwkQqN1DzovU7n1ipla9428RK6aAsFkqIe6BOuZoYhkXHUKQ+fLFlPOo9A7T25
         pqd2gwkKu44jjv0UAnsadhDrCZ4L0J/FGZDLfIGhBzz8paeXuRHNU3BS1qD4AjtqEPzi
         lP1FkZ6Vhv063JrQ6I1maFM9Uv/Gcm2TMQY/BCgK6hD7bMHjobyDT64ELKM83KDqQO8r
         AJXcUSbxRFFTMpmUImm9j9wz9Cw22KU71cFmHJmXatLfGhKGfCjNYmrvefMrmwn/RNQH
         NwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723353; x=1783328153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=;
        b=oXII+0PKA1yJKP41dMRTXxeWbEAfI3ytNn/YOikkQREPuJ4ZMwGQb8oUljg2kHyfE2
         AwJONoSZItiPqj6LWYP7gXw5JhhCdwDFW2igrhJuVhZsB03BeDRx4itxPitg4kSTTzuG
         gahW5tCHgA0mieHOE6x2FDty9mGdfS+xHeLRyzdhRkIJQWbA5pnsPoX50kohO6yCo419
         HaOhn2hjTsEA02clkaTyXvTSOoUeutdwULnpgxs8+N64vUSmySLkb6ALPKOCftPiWBlV
         UJ7uVZv4JZLYuxWB+KDevKZFX3Fv5bj7iqSLOdNuS70S5FaUJ+kSWcPMRJx0zDbXHGkR
         UAbA==
X-Gm-Message-State: AOJu0Yw7C1H4BZHteLGQhuHW76/W++5iOboJaIZjvpqomCJZoFieRvuK
	AcXUvhylYWVmR/gdLg+8CWrkWIBqZ2E/196KeFifWSfya3kek9pNtBWer6sEcQgmWXECWBJQf20
	xcptXeN/WdT5dGyveLDW9aSP3ddFu0tT2bDEZ5k4XWPU23UzNfVbg8cBoHics7sE=
X-Gm-Gg: AfdE7cnRpJpyKNv/ktMsSvNIZrKNEFZiHil+692Szx5awELTqoHVGzNcIefZh9Rb1Np
	2XV6lYvlxA7bksYk5lBaUfwCaWqSwhufQ/eQhXTbTnBa+/InvVPEq/ZOPNmlPZZAFwQKDQgM4un
	4OALye3DvyCk9z+6UpWeuCXoUOvHqc0TpjghiisuLC3/ejYyqGfhHQuI3YrrRXamcOli+lTA9vC
	Wa5QlCbxD5J4cPiTo8A+hX0TVpInDb2hfgB47OIKGpWxRU0+qaRMy7ZoDl7CT3VXeu16ybPIe7l
	ktZ012iE/bVAol0f9vOcUrF9iC2UGaWMbhehFK3MWHqiTk0ksWcTi9hvEHoWRGw8y8MTGy1R6+Y
	8+BcIQ3dsxNu1x8BPVSuhKwJprfo953u2MHPhPt3jpcCx0gBdAyK9UYRsfQo5a/npvKyRTgZ2JL
	DWQ7sGnb+02k4WkuyjBynzdp2NO1XU8GZgmLpa6pHxI36+aAzY76Bx2FQl4rPRZfcXG3q1IGwGF
	dmA7e+4K/xjkYxNceQs
X-Received: by 2002:a05:6122:616e:b0:59b:9264:b06d with SMTP id 71dfb90a1353d-5bc2ae3c4f0mr10167340e0c.7.1782723352637;
        Mon, 29 Jun 2026 01:55:52 -0700 (PDT)
X-Received: by 2002:a05:6122:616e:b0:59b:9264:b06d with SMTP id 71dfb90a1353d-5bc2ae3c4f0mr10167320e0c.7.1782723352206;
        Mon, 29 Jun 2026 01:55:52 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:51 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:28 +0200
Subject: [PATCH v6 9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-9-f02513dcd46d@oss.qualcomm.com>
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
In-Reply-To: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX2RqOsPFwHpI9
 IFIo58PrGtzz2/Mve6RI+M4gOoiR1VDkLmzT4J191K4c2Qtr9sIHl+4BbRBbPY/bWqnFtJDm7Hz
 s8m3vLjGFhblByy7dzpFNCX1tdSGjmQ=
X-Proofpoint-ORIG-GUID: nOkhnnaGHGOFY-GYDrO5nPP_bzkMyVQ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX/9Z+Eba02jBw
 WqYW3VL5SNanX+iL+BJC+EVnO2qhalefLTbCUVI6+6yoOa2QQdYGMVhDW0DIN/rB5Mrx707dmBk
 +HXNeByw3xt5/THnd0YwYmAdOla6VUlAUshoSmT6htvcRIzEVswPyP4dtxXyLcKBTRYTe6iHOiw
 aCy7nB2WwF0pClQF/MFwlnzQa/bExpYZnTfypMAbXrAkUIsRjI6/0pXfXcfwCJH3s5LU40inLWo
 ZCm8RlkuKXdXJZTyZf4WPXkolst4kZhFDyxE7nDiKH27IjYFtYflojXUMxfvx1pMGk+zy70KdrY
 IOU8nk5EIS+xwAdybYnn8OBSRACCT/DJ6+RrKlRJ4hBaxDE1kYjOfqmoGi5JZUEaUaea+pNfkD2
 VayGwE5pYZoffrGDMLos3kbJ/DWCq2UtCIce5ZRrRUBhCYaHKtYbYlUWnXTLk08tpZYQ0kXUe7O
 3vjBPBChzUD9cjGTaBw==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a423319 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: nOkhnnaGHGOFY-GYDrO5nPP_bzkMyVQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290071

On Arduino Uno-Q, the eMMC boot1 partition is factory provisioned
with device-specific information such as the WiFi MAC address
and the Bluetooth BD address. This partition can serve as an
alternative to additional non-volatile memory, such as a
dedicated EEPROM.

The eMMC boot partitions are typically good candidates, as they
are relatively small, read-only by default (and can be enforced
as hardware read-only), and are not affected by board reflashing
procedures, which generally target the eMMC user or GP partitions.

Describe the corresponding nvmem-layout for the WiFi and Bluetooth
addresses, and point the WiFi and Bluetooth nodes to the appropriate
NVMEM cells to retrieve them.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index bf088fa9807f040f0c8f405f9111b01790b09377..128c7a7e76b5b089044745f5d6407d6391055fc2 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,40 @@ &sdhc_1 {
 	no-sdio;
 	no-sd;
 
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	status = "okay";
+
+	card@0 {
+		compatible = "mmc-card";
+		reg = <0>;
+
+		partitions-boot1 {
+			compatible = "fixed-partitions";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				wifi_mac_addr: mac-addr@4400 {
+					compatible = "mac-base";
+					reg = <0x4400 0x6>;
+					#nvmem-cell-cells = <1>;
+				};
+
+				bd_addr: bd-addr@5400 {
+					compatible = "mac-base";
+					reg = <0x5400 0x6>;
+					#nvmem-cell-cells = <1>;
+				};
+			};
+		};
+	};
 };
 
 &spi5 {
@@ -512,6 +545,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr 0>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 
@@ -557,6 +593,9 @@ &wifi {
 	qcom,ath10k-calibration-variant = "ArduinoImola";
 	firmware-name = "qcm2290";
 
+	nvmem-cells = <&wifi_mac_addr 0>;
+	nvmem-cell-names = "mac-address";
+
 	status = "okay";
 };
 

-- 
2.34.1

