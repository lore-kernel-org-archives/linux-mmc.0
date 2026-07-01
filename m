Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFB24C77C4
	for <linux-mmc@vger.kernel.org>; Wed,  1 Jul 2026 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921677; cv=none; b=hUpWuHAefjTX57eEcI0vLZ+gUaJBTag8H195JdSsV+NnVpmt8dtM7pj8W9eRdBSXGHKu07NuAamRzlpkVdxs+bTXCCv6XqbPO4U5t8JQ8NXPtU09TsmUkfr/o1x0EZyX/FTaC/XwJQ8etCKoRT4qmEd1u3nqI+9YFagpKWV+sbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921677; c=relaxed/simple;
	bh=WoEsQQXEHcp3Z4NugaMqCjtqYrDzpmWHIggHogkIi2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dECU6Q8NmOjm3lV+kKtLTbSI8eLrVC6occqm7uE8BVfct6KQ5CwfRs9oe+fNju6LFzHq70HR647HKZtCDgawfqIkbAzhSJs+qS0+bw9O4BQUwwW5WyeVubrlTvwmA6219JwpTl18TWXqJtE6yPR4bPiFV1s8SKkejWhOF9x4rHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sq/4TlU6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jF70/2De; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sq/4TlU6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jF70/2De"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoCeT1553080
	for <linux-mmc@vger.kernel.org>; Wed, 1 Jul 2026 16:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=; b=Sq/4TlU6exhyzy+K
	qT9msILIdxixfLAxMRh0G1xJpAKvzWs+ZtpKWxy3uGndIQq5dUiSP6UBO4SL/Pij
	Z1jGh2bARokNq8G9wo5OP2turSINkMs51RaXW6y8CCNSEptt//shZHZFk+wgSfAy
	AvDvzofP45s1zaTXy5X1MKQH2r0Z7Id+XYNo9uSQqmGEWPua5QqEI8GfW7dtdRIl
	iji3q3edsCaC+54kQGJH2rv8D1nHj+89qG3sTtg6c9EHnu1toRLWSuucWo6SBHxU
	L1RYwdkd9PVMqapCHK/tRDocDlc1CHAjWB/DsLeETtI9XYrVe3ixT6G6u2JHDj4x
	D6AxDw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sd1fr6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 16:01:10 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9bd376d65so1197093a34.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 09:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921669; x=1783526469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=jF70/2DeBisEdEjdvqAbvIXVLcj9pmhfTmlLj9jbjLevltW68YJ3v4IRQdon5O2i4y
         +xaJeZplRGRJA+S0qmqkSwp+g8237VfcCZ09O53UESCtI1+ptLN2Uy/2u7JQ5bIfv8sS
         TfPMH9EIoEYXDRkVpd30kr/tQVQDSagg+ZEkU3DYtYbxmLkekJv5+sGgoF1LPQbiY/Kr
         C/uvDc3k9ibZHNTReQzQxL/opffsRs0SQK7NP2zMYnYZGmS8Fdg24KRZWvrPNkhxQFFV
         NWn5lib1Xzcde9LLFrALgsT0tdpFx3wi8uoTr/J/4qnHv8lFWcnFFCCNolXaEXFGd1Q+
         6M/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921669; x=1783526469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=TPY+jp2q+aJrehPvjRVBIj9Nu3Y5WBKC4jc7u3NPeHhzYelhlGjg/4cGuaNOj+z85G
         1GjMRUKs6X6MCEoOgTWaJuETEmvOMDLoFDGXeqIMeE3hIBd3l7pTK2bGQDW2jd5ezcWL
         MWA887mgcF9QayKU/qUYLwB0klMiEdRRVzKDxEZS4ZATrYFMBWvlnovtLePQ6tP1pfGo
         7d8XMfatwfhWHMTij+f+Rq0K7Hucw5Zi3/RB/1LYqL3syHPWbqTSBlc00AYVd8EmIKwi
         d7Q0nmZZdwP9XDODWMsS+IKZHbbaDZEeWovRCB7Io0IqrBo8u4r8L7EcsQs9WW+zBKfY
         aTCA==
X-Gm-Message-State: AOJu0YwJ1DqdAXics11B9dSFnzx1Y7Au6vyLAy3bBwpPUQOLyKgrEIQI
	kRGvieldmg3e41XPYpH3iDxIQkn8U+R7ZyizpWyaYr6pYglpgjMZ7KE7nSdsXiO2WAixrgm8jwS
	50+uOgG/wPUjisdPgWdYd7jVuiqia349pqY7rzDe5EDC4FAd2Z+TG9ktrevXzgG4=
X-Gm-Gg: AfdE7cmn7kGZe1pXR3p505t5asl9wTWSes1uEIoRphWiZNmdUrZnQNRnX8iLZyEPnP1
	fT8YiurczGxNiQQNcWQKFIHY5KlI53ov/HqmfG26XhOAhUck6BeI0n1hal0kKUpdQAsyMv6uwOX
	atkCJq6Rq5QKXcJ14DrwsidZCBvUBzU9UUsED5LH5nqTRKaR3LZBx6tfh8opbO9vFGOzkuA+LkN
	8YU+Iqhl/2o2VrvAxG5tJAfitWCXPZGLn1RK1AfeyZPgk40kE6KD3Ce51COyW1NLbGum7R46lqq
	0J+Ph50XVCJQwa/eiw6OB3WWrxhlWEqWw4EntVrX5s+zDCl8F3qKg+FcjQXYmARQLozdYoWpv/l
	eEkD204kQOtcN4j1iG5uksBQ9r8Z7zi864JUIxhrofQOeRTnpggCb56GhrPVWVVD1VAgYOEdjYT
	JJCQJGsFLNn9nYjTzdNF2IK3nog89MfpyQmRqOzI0uYJeR0mmLUlZ9z9OE+i7zs5c=
X-Received: by 2002:a05:6820:200d:b0:6a1:50eb:2113 with SMTP id 006d021491bc7-6a309b97f95mr1372354eaf.72.1782921669024;
        Wed, 01 Jul 2026 09:01:09 -0700 (PDT)
X-Received: by 2002:a05:6820:200d:b0:6a1:50eb:2113 with SMTP id 006d021491bc7-6a309b97f95mr1372277eaf.72.1782921668477;
        Wed, 01 Jul 2026 09:01:08 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:01:07 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:33 +0200
Subject: [PATCH v7 9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-9-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a4539c6 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-ORIG-GUID: n_WwgIAEn3vCLocGbeqZ5R9C0SQRR_2B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX2V8968kHUf/f
 gRyAaE3hCTsWYRz7cjC+UyLpxpq9pyWnu1MVR+huJfwzVc6d10pQ4/VR4uUj0Nf3j2tlXOzTJDQ
 oBKCr1fa2IU6rDzEJfuDW4htqdIkttE=
X-Proofpoint-GUID: n_WwgIAEn3vCLocGbeqZ5R9C0SQRR_2B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX52+0yL4LhPwP
 wChCNSlhqBZMXgNspPFbcCnHALjMYmkIecr23mK6m0FH7ITqLS7rOvVXFlZz+GIGNUKRp10Yjds
 cyOUxef6WRD1RPyGAwnP65J6YFl4e7RF9uW48hbzbkSIaETTAo7fuNLvtMwnPuaLZgZi2Jcmqih
 zRBvgx+E5nBcVO3Yvpc7N1PTFVbTcSHPhxJk1dqATHfflmbovtUiFkq6Q01a5/iuKtJgnDLbpzY
 TqE7BNCCzx49k7a/hKrWNewtUtRh8ELqZnsND+YXXfznNoiVtygsf+Uy/JF112ApQUN9dOOoC6Q
 O6zAZaJvB8vtFAF3qidPnyzYn6KQFaAe4c3oDRF9BhbvecNGM2UKaIRF1tynrtzdTuM/xl7ZnOI
 hQU5EkNpqMx5HDDDz1T0VNKPFH0LJg/RUI9SGzOqD3arTH9kS8HsJac00z+B2DAyowzdRCFFS5z
 QqL7jX0d4l+bfKU9x5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

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

