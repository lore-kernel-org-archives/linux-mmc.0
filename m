Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628254;
	b=pxEHrzfYj7yjpDkKl2VpHjM0IVZ0EMgXfeSWAnE3AtTwHvYOyvBq0dUSYI1Ca68IUI4/
	 M1iKGw3geREKug72aepMemOSttZ2+pcpcjlToGZ/xaBSU6mqRP1K6r4cC3k3rju0amm+g
	 nd8FitIolLowriTkr2oQuQqqkdDOpBRfcT7nlzcWwqXjk97lg2FKYF2Xfo1aG3xo13tOJ
	 7zu+x6HpD1oiZwcTLMKXhJvEWJHvThl+MMOvQPsqX5xV9T0zPRG245t6Mf/gq3bmCutEO
	 mlJD8k/PHUHnFfGsm/iaABf9kwBuwwfvdYDhU5LcNjmhEHC2/Z1NOXs/5WR6QqEToHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628254;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Dag14m3h5gt5hwrihR8wyiBARY23IaTWQ9lhSc65Xxg=;
	b=PuxX4AYrWg9fEur56r/8hZwu/1OXPCS9eAqUnrpcrz/3sUtGbIFwNgnlTzVZD+w+rgTB
	 /6QrYapHP6Y7kGrviR+jgpaeVQ2sn9aUQQ8GEfmtnpc7J41CQsFSY7IBc4zNdWNuyiPwE
	 nEotaKRMvBzuJmVgwb7z3Y/hMv4pgpUWzb1Ayj5l4ZTNhvPBXyObMDTMBR0HMgtwYXSE/
	 oTcEAcRBeNabyFO76O9iX92YLVQYq/kz7wTd4oRRno2EOeW8avnRX6pybeHqOefRxFgWd
	 ZUBBWV2b6X7fi66Cj2ME3xoW4FEMld0W9Js3ZgQdDoHxDvYD+mofUpFHVhU/tJbuTVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AmGnfcRi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PCu3lvAc;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA0860A260D
	for <linux-mmc@vger.kernel.org>; Mon,  2 Nov 2026 14:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CA0860A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AmGnfcRi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PCu3lvAc
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpHq32991812
	for <linux-mmc@vger.kernel.org>; Mon, 2 Nov 2026 14:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dag14m3h5gt5hwrihR8wyiBARY23IaTWQ9lhSc65Xxg=; b=AmGnfcRidw1WtTb2
	/QPiyYNMjZPVGchsRWQhON4B9Pv3fhbtVlN7nwekiFs5KCThHj8jidECAxqnQjnT
	rV/ttEOryTo4DSdlAnDPHqyk726P9FAYQShHoqpKV8w+zn1geS/zUCi0w8APOG0G
	EyapIi8V9k+WrPCSl3vvZjQe0qVL3oo1EQUsd6084zPRsiG/QJtBPj0Z8Tr6E1Tv
	nfyAcJpwV289YSFhWrxB6a9rYLLGIfW9YEC8TVmj7iacdc6IsZF8TlnfTggPEZXA
	trcPOQb9qn9gRRc7ma6ImIYjUHyeRpICYf6F6eA8BcZnod7jPwdkHwjnN2x3gwHS
	aJ2aLw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsavgmrp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 02 Nov 2026 14:04:12 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso1866559a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 02 Nov 2026 06:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793628252; x=1794233052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dag14m3h5gt5hwrihR8wyiBARY23IaTWQ9lhSc65Xxg=;
        b=PCu3lvAcU+YdJuK4r/F+Ab7Dt8yEM8k/WzlSEBXFoQNNHAcDXWgYJImJarjsnGfx30
         cNJu/BeOex5Osl5YQA8twYGTQKoDG/Ljxoh2dSnBdZ6bEEHjJHHL++ebwWUX4VcA8GHi
         oBhl7JkzCqjOr3W8LnfD4xk26f0UFDs+e7zkOFV1pId1fI9I23ZEUFcCf6opq7mNIANZ
         arI4VufbHE0n7pqfXr2hXdlKHgb0adzBFxVxz8ytQfJSM8JaY/hjWYDUpmU57PJY6i/T
         jZZacXYLrFnlf58eeHSQfqfLngDhjrnURr9tNOz0KTjzAk+oUFwEvWVQDyQI6y5K2rkN
         qrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628252; x=1794233052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dag14m3h5gt5hwrihR8wyiBARY23IaTWQ9lhSc65Xxg=;
        b=evBv3O1V+5lQajBerh0uuSzBlktaIgZo3lRCDNo//T3OjseaERBN77PPHUWxXQlB5m
         3CoiO35CkQJbLaDnu6bAVH4VlWqBNwvPAuHId9Az+uRDSRLlDZMCocgbDP0geiJ1FO2c
         nbS1b7qUjbwdefwYrBODbr2ZOk9tWep3EzTT+CUZIpJH9TOa0zvNBtb94b4ALVXSV8Wb
         H5tBVC7QKYABG17v/5aMHEeO1VcP0kD8m6VvlSAEwdLhMQIeadYOGVmR5TAR3oPXqHOj
         6kHdt4qZWP8hbcdppYDqSGSB/yhk031TSbH0Ze4SaxGGn7TC9JBiHvIC5AMrtowebQiQ
         HoNw==
X-Forwarded-Encrypted: i=1; AKwUvByI3haQVITOsO9FV/lUca4yXFYjU3qvpnxhoSXhpB7m9VmsPjjJ4Vq2NlGB7MBu6PViLR/ZU8M4QSU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIw0PByeyIDf2mmX51056qBS+sGeyTXLKm9bfAwplw7edj2SUZi
	tDsjVGEBmkAdb4UP02J6YPn5uQwwyhVLOoO95O97I3GnstHPuW/otmR1Xuv8reoAbbBl2XNPXbG
	4Pw8tC69/xthBSclVtsC/NagIgeXwUHGxaP2mFCYDddvCAxnpDTlOZe9LICYBo5M=
X-Gm-Gg: AYBFou3CeY4Y2sFBHSne87qvPOVi5hnqlcsNlqEivHwojnb6LYbE9NrY2/tOSLufXeh
	pb7Mxd9vSSEOmMTds93lAoPRAdvD0kzFuw7FwNp7pSImy6UghaVwIeBjeJkKSJEh2RiY7R6S6HD
	ICoFClrl0T01kPIwYVnpZvAVlz+PjBbAiUJvSIRAwZa77qpILsYxm/dVH6ihaQ/QajqtLxKDDTF
	8qAAQg2t5I7SE/o700ukifN9akoEVhUhrlMQ2BBHhOjdDHXmfes60981J+ZjBckeLAtqGGN3KW+
	ZoLmijYUJhF4Lb2BppcAsHi5RRaIN1kry/MgMKfLTCA9kA/ZrcUTG0//AmphQx0epBwSJLvSbw/
	0basVSltK2aAHDlNGId3IMeqyQ7hIUaioubCVHlb5UeUC80COS8dnKiDUanE75EunBlQvFqkCS3
	E=
X-Received: by 2002:a05:6a21:496:b0:3e1:7249:e265 with SMTP id adf61e73a8af0-3e928d46829mr7631059637.27.1793628251843;
        Mon, 02 Nov 2026 06:04:11 -0800 (PST)
X-Received: by 2002:a05:6a21:496:b0:3e1:7249:e265 with SMTP id adf61e73a8af0-3e928d46829mr7631011637.27.1793628251158;
        Mon, 02 Nov 2026 06:04:11 -0800 (PST)
Received: from hu-ahari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fd956sm2286942b3a.3.2026.11.02.06.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:04:10 -0800 (PST)
From: Anjana Hari <anjana.hari@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 19:33:41 +0530
Subject: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Document bindings for
 Nord SDCC
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-sdcc_scmi-v1-1-244dbd893051@oss.qualcomm.com>
References: <20261102-sdcc_scmi-v1-0-244dbd893051@oss.qualcomm.com>
In-Reply-To: <20261102-sdcc_scmi-v1-0-244dbd893051@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anjana Hari <anjana.hari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shazad Hussain <shazad.hussain@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Ram Gupta <ram.gupta@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NSBTYWx0ZWRfX6Kv+sBMv4oiN
 nEGTW0+xT9zUe+yTFhb7GsQR6Hna7sVmq4WsBkqcy40owH7VKzhAtx01lk04A5dIFjaY1ddZ9qt
 acVCgKCnd00ZTlHNxkoew8Nlt+VihPbou46r1buTVQ3lxVmNdYEKpSTVD2nK/9o7+YMEelGUkJo
 ymYaosEFjH6gL04ltSGMA3ubCsbVdwNdWuR3B6Y8bmdovHlpVuGqSRtkD84IXOieW14Pa1M8kl+
 j49FpzXr72wRPFQC/lFVLhYIfsUonlg4PjACl1bgei2e37720n7LiWx9PAAEaATVWMK7F0ZDVqU
 IV1BQuDsCt6CYCvy7wX+JjnhOUYAp6u87dFhY1pVsANN9OOf9qBioW9CqmY57aNyBgMu/qnhRib
 xW1ZELvCp1t0QnnrY31IumVcX4pPIeoPM3T6cWHGb5nnGOl2tMCAAxKsQaltbLw5Jvf0Uib2WF/
 ZIn/oJYH8RyupwWsmqw==
X-Proofpoint-GUID: gapuKRV7J2l8Nxsip9tvP6Vawefd3-9c
X-Authority-Analysis: v=2.4 cv=FZmiV5+6 c=1 sm=1 tr=0 ts=6ae8985c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=o3jdfBYt8dMtDUvNEAUA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NSBTYWx0ZWRfX4KfvxAqYTtbi
 nEopW4M1xCn3oMsKltsziiDXlZ3XF1WSAb2yUTbgSZUEiqLkgMjgkzKNEDgrSai81YU9Was5O6c
 3jIOqyjZnc2YevQk8dJ1rp8ln/UGups=
X-Proofpoint-ORIG-GUID: gapuKRV7J2l8Nxsip9tvP6Vawefd3-9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020055

Add Device Tree binding for the Nord SDHCI variant of the Qualcomm
sdhci-msm controller, where platform resources are managed by firmware
through the SCMI power protocol rather than being directly accessible
to Linux.

Unlike existing sdhci-msm variants, this binding does not require
clock, interconnect, reset, or regulator properties. Instead, platform
resource control is abstracted behind two logical power domains:

  - "power": controls the SDCC rail power state. The kernel requests
    power-on and power-off transitions via the runtime PM framework;
    these are forwarded to firmware as SCMI power-state messages.

  - "perf": exposes the supported clock frequencies as OPPs populated
    dynamically by the SCMI perf domain driver at probe time via the
    SCMI performance protocol. The driver selects operating points via
    dev_pm_opp_find_freq_floor() and dev_pm_opp_set_opp().

Both domains must be listed under power-domains with their names
declared in power-domain-names.

The compatible string "qcom,nord-sdhci" selects this variant at probe
time and causes the driver to attach the two power domains via
dev_pm_domain_attach_list() with PD_FLAG_DEV_LINK_ON, ensuring correct
suspend/resume ordering between the SDCC controller and the firmware
power domain devices.

Signed-off-by: Anjana Hari <anjana.hari@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/qcom,nord-sdhci.yaml   | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/qcom,nord-sdhci.yaml b/Documentation/devicetree/bindings/mmc/qcom,nord-sdhci.yaml
new file mode 100644
index 000000000000..c512628617b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/qcom,nord-sdhci.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/qcom,nord-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Nord SDHCI Controller
+
+maintainers:
+  - Anjana Hari <anjana.hari@oss.qualcomm.com>
+
+description:
+  SDHCI (SD Host Controller Interface) present on Qualcomm Nord SoC.
+  Clock and power resources are managed by firmware through an SCMI
+  server, so no clock entries are required in the device tree node.
+
+properties:
+  compatible:
+    const: qcom,nord-sdhci
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    items:
+      - const: hc
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: hc_irq
+      - const: pwr_irq
+
+  iommus:
+    maxItems: 1
+    description: phandle to the apps SMMU node with SID mask.
+
+  dma-coherent: true
+
+  power-domains:
+    maxItems: 2
+
+  power-domain-names:
+    items:
+      - const: power
+      - const: perf
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - iommus
+  - dma-coherent
+  - power-domains
+  - power-domain-names
+
+allOf:
+  - $ref: sdhci-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mmc@b84000 {
+        compatible = "qcom,nord-sdhci";
+        reg = <0x000b84000 0x1000>;
+        reg-names = "hc";
+
+        interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "hc_irq", "pwr_irq";
+
+        bus-width = <4>;
+        no-sd;
+        no-mmc;
+        non-removable;
+
+        iommus = <&apps_smmu 0x1580 0x0>;
+        dma-coherent;
+
+        power-domains = <&scmi34_pd 0>, <&scmi34_dvfs 0>;
+        power-domain-names = "power", "perf";
+    };

-- 
2.34.1

