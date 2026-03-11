Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5703BADAD
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222378; cv=none; b=ZZHptIc3UfXMAm5yiyONsWUQpnE3KPMl6vMlckH8k1cRKRnxIMPzfXE9BHMMHPdQ/dYLdRjU5CmN6E/bTQbqu3gHyuEOdJbzM4Y+a+/8FV7ZWPgbpxJLqUCw1WMg/FOj6fP6k65evCjp8tlEfKxIvvOrk517UZENYG0PvidqgZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222378; c=relaxed/simple;
	bh=RaF0QuXKwHuRbyMdYdDcZ7PSBhm2EjPLewfXNVArYlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lELD+r50wWmQtV+1K4gHDAqh1dy4/HlIUcQhMy3cHK5LS65YEPqD/Ur5+HLju8svXnHewgAL8RkN6UmEejXqHqKynKcnvUHrIfscgXRYCb4O0d+y+DSq+SexA0sotIDceNR7iCSg3VP7DxgeXs62tK3LMPIM0I31apJgUs75PFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ONPgauk/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H6c1dCIA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ONPgauk/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H6c1dCIA"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B88iZY508287
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 09:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mtfoC6gmkkEv6OfhHDrmNx1rm9QcUeD7kbqb3pSgfts=; b=ONPgauk/e8Qt387I
	8K7EIedrkGmMwp3w8XkU8bVEZDTXddJ3rGNwbQWsMkMNrTlxp5XxqLZ/QeA6Ikkj
	C4uAy/Ki3V9n2rObtXBM4QumUvvMkN8A6awFrpFpUVkAv12w0Kr0GzpXcrQWpXW+
	eFLGDwZg4rKcVvtjCfAQl8+RShvxUg8iR/MLP4+A3RKaA0Ukj2/l3iEHT78q/WK2
	Q4rF/dRw7IMw/4J9qNjZ3Vwvah4tMP8Af++sQ/dxBA+zfiTBcSrxtPO7FNhf3cp0
	LbdoUE0K/FOqFERCy0IcmUKSp1+hv4FoqzJ2WtnRwcGRSZ/NQ505lmUNz3QzsYEY
	eCrMKQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctppak78y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 09:46:12 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c7387c70046so3319668a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773222371; x=1773827171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtfoC6gmkkEv6OfhHDrmNx1rm9QcUeD7kbqb3pSgfts=;
        b=H6c1dCIAOKQbPzDS+owATI7CcJrBi+GLgUnwLKrlLMUd4MyIbcD2LdYdlZknROyDj6
         jdF1Z1VJssEQhV1CJg0lKcSHlHChS/e9Dr1z5YfK5D7vV3dsbbNehjj9x+FdChvcTZs1
         R1Gt1yG8lU6NLjWoox05zOrcVSfIj/NtmsunOZUNraU3e2AwSy8ZE1uMLXWdUFSWqdT/
         iWlttdPa3FLN2ZXMhl5wCVQLvjsdC3dJ+Z9/AFca/NxQi0+khaubKEduevxqG4mTjtUq
         9UGNZp0py6y6JfwIZkuLm3THcHS50WKAvPd6wKDeAzAB2amo6UwKDBwiToPFgHpEnZuj
         UCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773222371; x=1773827171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mtfoC6gmkkEv6OfhHDrmNx1rm9QcUeD7kbqb3pSgfts=;
        b=inQw89SCn1OAyqk7BZaDeTK+BX7WCq++Me6e+xwwMtp/snnoVlGShwid6jvUXUc/xI
         wr9kUfw+Rj7fo00UF/R3QbFmmwQWX6cN+T3TnmJ5fbVMYaX2EGg2zDYXaAWyJprHo240
         TtIJg7Gg+azK6gyNvw+vrERVfrv7UT7vzKKf53J+ZEPeyXHL4LvUBV6UtNNhxI4CqQ0T
         FJUaQMUeOLEdGv+Ag3I++igYv2QomAAFsWhGp1z37itUATBSvMulY/mXqgNBhcgkUuQx
         ca5uNeftjX2XTDaAWQlk4/0qJTkiMjW9fJBfqcBhlcO03s2FigmyLgUy8F5TGVvcQ9PX
         Mkpw==
X-Forwarded-Encrypted: i=1; AJvYcCVBr6FEPuHmAQhJ6nfd0uMglhAty8/oWQNqWXU6NFosl5Uu+4keflU4aHOYYUVYtqFYysPwFbtaL84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7WPJxpyPPHjzPKwla3WjPvmdki8+xPjln+zay/n+cZChRe3c
	JyVqKW+aaITE049GQoX+2R+XGbjGRTT5o52Ger6KN7GpbJmZZ8eTnyQmQemdOcMLJczvZvnWqbR
	b6mzGmm+qq9/mP2WUYoiT+ON7fKTF7mcSukXA7AHNWdZ4n84X7RhHXq87TeERpHs=
X-Gm-Gg: ATEYQzxUiosPeoJkkP9i8YPd8UqzErsDIPFcPpjulmG/bU3SNYCtYw1/75Iv3LsZkmv
	ajp4XlRay2eORV8+Vo41+i0zjLIvamFGfbJod6Sb1A/eK/48nk4JoNDIiXFyFkPKxZTnp4PUovn
	JLzzsNqSSI60xa/WIOIBYntUcaSeen5+mGRIk0Xq2wOgXX2XPgDjghwPrxCzP6fjkmKa7WSUJsB
	Sk4JaVrpPukDd3hlwYFaQUgOl6l6YFRkaf1340FdQZqHJsevH8GM2Zeakl0pMDAcPcfGxd/sXja
	I0Hdu2Z9ubnhZSwJafU3ms8SN7ejRefngXr1H3izLMxjRZjWGEG2VkklhEfm41HDfR3pE1HlUKm
	10bT21g+eZMbrtEO34ttti52kosYzi1YmrCKd1qgkq5noDriKB0hl9tDJj6Dd7FLlDgLBwUJ7VJ
	z2le7zXgSaK38yXnPm+wXnF63JZZyASbeX2oIVMRyX4wUcGZ+zd07bQq0p
X-Received: by 2002:a05:6a00:a21d:b0:827:298e:b7c0 with SMTP id d2e1a72fcca58-829f7076035mr1931538b3a.47.1773222371280;
        Wed, 11 Mar 2026 02:46:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:a21d:b0:827:298e:b7c0 with SMTP id d2e1a72fcca58-829f7076035mr1931510b3a.47.1773222370772;
        Wed, 11 Mar 2026 02:46:10 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df5ff0sm1677403b3a.21.2026.03.11.02.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:46:10 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 15:15:45 +0530
Subject: [PATCH 3/9] dt-bindings: pinctrl: qcom: add IPQ5210 pinctrl
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-ipq5210_boot_to_shell-v1-3-fe857d68d698@oss.qualcomm.com>
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
In-Reply-To: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773222347; l=5789;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=RaF0QuXKwHuRbyMdYdDcZ7PSBhm2EjPLewfXNVArYlI=;
 b=G+i/GwR3fBoqiog8vNLpSnt9kojpr/LLeiVo1xfhY5r91jb3RCNgOjkA8elGwgdDJJDCqoFlL
 b1zvtzSAlvYCKRYtBIR0XyNm+SC1oLwTPlljQ+D9fIJzD0njX+PuDd8
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-GUID: nsi9HO1rDYx3kVzSbLQ_JaPkTCll4zNh
X-Authority-Analysis: v=2.4 cv=D7BK6/Rj c=1 sm=1 tr=0 ts=69b139e4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=hD0fcazERHGK-ooIS8AA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4MSBTYWx0ZWRfXwvFqvvBUXuME
 6J0Az7wi9Z0QrHCe75V5pWkkU1fE8DQo5xPumknjXqtOrX1yuIF5ZxYewmqi4w7eHYyAVo0KJ/v
 o+0XVdRSIwZsRFKxKOJRbsDmuPoZV2cr6YCwHKjqvdKDVQdfRKQqf5LJjUf0sgzY7mr/wTCgsW9
 rC5lMBSeAZi3UqcTv3UEUDluZ2zRGUsqFZ6ljfuNsHJVdxYNwkAQ57oUK48LoSVTLe0PaSoFbhz
 /sm+2SElGIQTDqUENerY5aCYM8HoLkW7epglHCxJ3YoBRVmopY0XB7vRkJr8tx0WGdDUIaoT4Nd
 HIiajMrdP9X81CXMPn8R9k9Zw3X0Svgb/xhJCUcc0ZwsNthIoECsHN/gTdQndkMZ/2ZEqJoFaj0
 wsCMJIZhl68cZfAdoIxJifDviMabmojZTkBgnjvl66Ek27Gc4axuB6Y6ph8FuABvmJBGRhb4Iuk
 QjpnjBBiE+8BSnCvIVw==
X-Proofpoint-ORIG-GUID: nsi9HO1rDYx3kVzSbLQ_JaPkTCll4zNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110081

Add device tree bindings for IPQ5210 TLMM block.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 .../bindings/pinctrl/qcom,ipq5210-tlmm.yaml        | 141 +++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5210-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5210-tlmm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..3e5a46638385cf7925963c7e4b615c67e642152c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5210-tlmm.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,ipq5210-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ5210 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
+
+description: |
+  Top Level Mode Multiplexer pin controller in Qualcomm IPQ5210 SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,ipq5210-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 27
+
+  gpio-line-names:
+    maxItems: 54
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-ipq5210-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-ipq5210-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-ipq5210-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          pattern: "^gpio([0-9]|[1-4][0-9]|5[0-3])$"
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ atest_char_start, atest_char_status0, atest_char_status1,
+                atest_char_status2, atest_char_status3, atest_tic_en, audio_pri0,
+                audio_pri1, audio_pri2, audio_pri3, audio_pri_d0, audio_pri_d1,
+                audio_pri_fsync, audio_pri_pclk, audio_sec0, audio_sec1,
+                audio_sec2, audio_sec3, audio_sec_d0, audio_sec_d1,
+                audio_sec_fsync, audio_sec_pclk, core_voltage_0, cri_trng0,
+                cri_trng1, cri_trng2, cri_trng3, dbg_out_clk, dg_out,
+                gcc_plltest_bypassnl, gcc_plltest_resetn, gcc_tlmm, gpio, Led00,
+                led01, led02, led10, led11, led12, led20, led21, led22,
+                mdc_mst, mdc_slv0, mdc_slv1, mdc_slv2, mdio_mst, mdio_slv0,
+                mdio_slv1, mdio_slv2, mux_tod_out, pcie0_clk_req_n, pcie0_wake,
+                pcie1_clk_req_n, pcie1_wake, pll_test, pon_active_led,
+                pon_mux_sel, pon_rx, pon_rx_los, pon_tx, pon_tx_burst,
+                pon_tx_dis, pon_tx_fault, pon_tx_sd, gpn_rx_los, gpn_tx_burst,
+                gpn_tx_dis, gpn_tx_fault, gpn_tx_sd, pps, pwm_out00, pwm_out01,
+                pwm_out02, pwm_out03, pwm_out10, pwm_out11, pwm_out12,
+                pwm_out20, pwm_out21, pwm_out22, pwm_out30, pwm_out31,
+                pwm_out32, qdss_cti_trig_in_a0, qdss_cti_trig_in_a1,
+                qdss_cti_trig_in_b0, qdss_cti_trig_in_b1, qdss_cti_trig_out_a0,
+                qdss_cti_trig_out_a1, qdss_cti_trig_out_b0,
+                qdss_cti_trig_out_b1, qdss_traceclk_a, qdss_tracectl_a,
+                qdss_tracedata_a, qrng_rosc0, qrng_rosc1, qrng_rosc2,
+                qspi_data, qspi_clk, qspi_cs_n, qup_se0_l0, qup_se0_l1,
+                qup_se0_l2, qup_se0_l3, qup_se0_l4, qup_se0_l5, qup_se1_l0,
+                qup_se1_l1, qup_se1_l2, qup_se1_l3, qup_se2_l00, qup_se2_l01,
+                qup_se2_l10, qup_se2_l11, qup_se2_l2, qup_se2_l3, qup_se3_l0,
+                qup_se3_l1, qup_se3_l2, qup_se3_l3, qup_se4_l0, qup_se4_l1,
+                qup_se4_l2, qup_se4_l3, qup_se4_l4, qup_se4_l5, qup_se5_l00,
+                qup_se5_l01, qup_se5_l10, qup_se5_l11, qup_se5_l2, qup_se5_l3,
+                qup_se5_l4, qup_se5_l5, resout, rx_los00, rx_los01, rx_los10,
+                rx_los11, rx_los20, rx_los21, sdc_clk, sdc_cmd, sdc_data,
+                tsens_max ]
+
+    required:
+      - pins
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tlmm: pinctrl@1000000 {
+        compatible = "qcom,ipq5210-tlmm";
+        reg = <0x01000000 0x300000>;
+        gpio-controller;
+        #gpio-cells = <0x2>;
+        gpio-ranges = <&tlmm 0 0 54>;
+        interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <0x2>;
+
+        qup-uart1-default-state {
+            tx-pins {
+                pins = "gpio39";
+                function = "qup_se1_l2";
+                drive-strength = <6>;
+                bias-pull-down;
+            };
+
+            rx-pins {
+                pins = "gpio38";
+                function = "qup_se1_l3";
+                drive-strength = <6>;
+                bias-pull-down;
+            };
+        };
+
+    };

-- 
2.34.1

