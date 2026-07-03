Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0213EFD09
	for <linux-mmc@vger.kernel.org>; Fri,  3 Jul 2026 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086350; cv=none; b=Zfn5RPEZ0xEOm3uZgdNC88OLw4qwph2ixHlsIVdkeNUwh//XPU5oTul2LuC6ppJpc8ImFw91f2MWijVf5Zl9qVU3QEykb+MBk4jcJWRkJoE53RQBKF8g7xH2ArcWRFTUHYB58QvZfQrDAcBAOWox7Ssyj/0YqqnSqEFf1Esytt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086350; c=relaxed/simple;
	bh=WoEsQQXEHcp3Z4NugaMqCjtqYrDzpmWHIggHogkIi2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Th8NZ5gXQF0z6NRcMiLjSwAAUGgbhWIaPbi7BtgiL/8EKp+5DdukvWtMQHFpoAq2pumqQS8/F/LRnd7gLsFXiVhecpcR8JGccS9u+s2uriXAF7SCpAUsJ1pf47giZB6+fAT+fQpiUIjSMB87q8HXom7RMQ2lSfovzpdPf8YsK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m3ZeXph0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i4CDOCDG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m3ZeXph0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i4CDOCDG"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663A2t0G3772699
	for <linux-mmc@vger.kernel.org>; Fri, 3 Jul 2026 13:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=; b=m3ZeXph0qWHngde4
	cyKZge+jjCK5fC4rR9gZXCNMwv//46MvW0g5T3GTreKkoX81ZKjiGv2oAyBuI3J8
	AWDZ7yFrfxrLeyTltJ6MAyeFz1owlPAK3WMFy1/csjR+M6n+ZtfDY620VL38nM2h
	dJzUsWvGIC8BIEz8vc5uDQBGjV449EYxd1mORNaVVPAgD7kyEmii7WOT6T9SJhFF
	Iqhv18Qe4JGzwPqYT5En9tvzwEm++OlruahreWLUcXWodo6IduWS6YXkoMYvuwbf
	uX59OIdL1VpqYEIRfNysL+zWXfKlJDhp6F4c49B1EP5NfVFsPBai7e+vDDgF4gD9
	qOUvdw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6b038u25-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 13:45:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e5e38fbc5so51022485a.2
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 06:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086347; x=1783691147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=i4CDOCDGSwCGZzTGXaFVk26fDz/SyBF908ZiSnMusyd41CxUkO459U1bVjnuP4KPmI
         FcPAhZB4gxMSqNDizvdzdTw/6RU31sMIUEv4s5PxhCMkDeP5JaezFb+THsWAxYO+Pk1O
         vUhqtBqzKhh+TSLU7ofG1R4LWh1JpriJ4y9AdXRDloH46jeyxJpwoNsZEHLFCwu6gw9e
         8owdbaE6OrAda0O/Lh2BymmXRqPfu8fBPlgtLsXlo3KYzwo8zKuXRsnjDA3zVACME4LZ
         o6YPjID8Duf7QLwn2OCQZJnQ7PR7Wta2EPg8IOYCjZKBneKsNUsV8rbMGcthedmfSAsG
         ipyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086347; x=1783691147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=He0rY50929BOrkyrbYDIhzOSxPQwCU0eAo0/0iDT0zGaHrtXux1LuU7mxyGCuCeNFT
         ITE2YAT3ICOgKhfkhzmGyCGIT317b/KMsMT/6YokQM9N35Fv32Up6gqVAOusrUh6U5DD
         b706jIel6ZMIQyCgI2v62MZykx06foYDtQqdY7ofp5Q+WxiTTlI3DCSSl+ggZGf5rDbe
         3sEMlYuVldl/qaIOgFtki9+48GAkb3/2iAxT9siQc/f8wAveVA8rx34QST4Zt81phTq8
         2MVhF1FIdZ+D9c1ur4tbJqdSlj/j70kiuhaEOtX7Kp4XnrN61mVXjSM5c96pX2yc/ok7
         8jgg==
X-Gm-Message-State: AOJu0YwWsb2NV7pSvgU+Kzqy2d/mF2nyTPb0MQ+enL3OZw0d0r5CvHUk
	NNrPCddDexLa8yHA0Nb/sVDOctYlUN9yEK25CiLGsBPWHjqrvmvv2VwDb5XAl6H8PYxudSuafUb
	1R/d6z926YeDeqnwSGGp0PTfe54fpWfp/89WZEZGNgbwYvy6fu3W/V9Xi2rpo1o4=
X-Gm-Gg: AfdE7ck/hs8ba3kO7ZhHF59t1GL8wqb0dT6I7WP5V/sdItg2O+HcgDWJdMl2/bPl/Nf
	OiD7XMM97896t3qHLqIQQbwK5xyMZ4+/9kGxo9Ix5Ob3OBvfOjuIDxgnuDmFgMYQj5kFRIpQCrl
	DMQyMzYjXLvGZaYQgjGeNFk6g9VJfjJzS0QElxCS0ohI+L8IxX7XaDpa/zfSfqnK+VG562d+V5o
	XHFKjGSfsJaBTJjycwasyvjA7Y43HERwLsgzPfWcKzopEre1vpAfrRw2StS2e/ovkHb91Mtdlss
	LM1wpzO14hdah8rdB0uWYj3f8xAHktLgAEaswf9jid4874FC+1NrFcTCfDj1YNKG+/6emF34a+2
	sGwuw4ZFuVyBf+uvaTkGQiDh8DKggsdXMgbvGlYKWdvb2cKW6EMBpafNPp9Q1f69sdyATXHQ3AT
	Dy0vX2upMNzQjujf+nuIQpSJzFfNZqjunVmF0xvcxyloRE3Q1bLl6ZPB6cUnAHbPg=
X-Received: by 2002:a05:620a:3186:b0:914:d093:abbe with SMTP id af79cd13be357-92e781d3eb5mr1407961285a.12.1783086345748;
        Fri, 03 Jul 2026 06:45:45 -0700 (PDT)
X-Received: by 2002:a05:620a:3186:b0:914:d093:abbe with SMTP id af79cd13be357-92e781d3eb5mr1407952085a.12.1783086345170;
        Fri, 03 Jul 2026 06:45:45 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:44 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:22 +0200
Subject: [PATCH v8 9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-9-98ae32bfc49a@oss.qualcomm.com>
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
In-Reply-To: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX5Hh560X7obEf
 izc5CgzzQcOc01ecfk/Lx76tZnXQ6kqqMA/wa3bfYNCxz2XxfQjhHBRJCS/vkAofchzR3xp5ouH
 pmUC45SEUm6aVDnHqr1uVBQtrMXGX18=
X-Proofpoint-GUID: 61nYNxmNvCpk8d0eVAgDabT37IvhnLRk
X-Authority-Analysis: v=2.4 cv=FoY1OWrq c=1 sm=1 tr=0 ts=6a47bd0b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX7t9T8vURL681
 cLypS9Ou8jt7/leglv8zP6Cg1jpko3ca5ITIEDDuj91yf2n0Z16CnCuzUqkibmuVUew+IS1ZhZG
 n176csqbSdoCTbD9+fPoZXc1YuhsrQSeUEflpt8S1SH6JAD0C/VF3llzcTFU1Vrh2GWC0UNlKVb
 +04iy2QVcLcBKR+g2S7tBjv1MUdZu4L88ZE0m64n9+o3R84B4S2Ygk4fkxnBPWs6lNpxPmohpZy
 t6gxBvHwIV7E7DanLuTHTevD5jLgD0eVM/PivTcaIj+V9mGiEM0XoHC+lpT2FVgzyDU2aTskCcF
 mWNP2stFtRlgvBQ0YWYUyYjcNFoIiqm1KmmQwWqX38X13BcQGvmp8FXYOcN2nMtV2MO0k46XnxT
 JtoFRKA3yCkf0Jzr6CEVNf7AibMKydkYFrQFl8aSzs3KveYWbAcWXTNMMNFx/InbWT4vqiCqRpF
 uk6lovG+0+IPc5DmyYg==
X-Proofpoint-ORIG-GUID: 61nYNxmNvCpk8d0eVAgDabT37IvhnLRk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

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
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index bf088fa9807f040f0c8f405f9111b01790b09377..38839b8a361e76f6c1989924b16095b9d8815f66 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,33 @@ &sdhc_1 {
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
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			wifi_mac_addr: mac-addr@4400 {
+				compatible = "mac-base";
+				reg = <0x4400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			bd_addr: bd-addr@5400 {
+				compatible = "mac-base";
+				reg = <0x5400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+		};
+	};
 };
 
 &spi5 {
@@ -512,6 +538,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr 0>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 
@@ -557,6 +586,9 @@ &wifi {
 	qcom,ath10k-calibration-variant = "ArduinoImola";
 	firmware-name = "qcm2290";
 
+	nvmem-cells = <&wifi_mac_addr 0>;
+	nvmem-cell-names = "mac-address";
+
 	status = "okay";
 };
 

-- 
2.34.1

