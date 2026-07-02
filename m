Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16893921EC
	for <linux-mmc@vger.kernel.org>; Thu,  2 Jul 2026 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977654; cv=none; b=g3H2iRcF0A8b4ipnQPRxSqz1aYuR57Esrzj72SYksJBsl3du9DVj2HBzCAISCc6sRPouNsJlTqJR4aVmEGUrpd5psvepbRpt4qF8+DrZ3eNdiJl34IYcZF6alsdw9xYqtzQxqMEui73biGXuhZGhafI4srT/5AQpszeCzQPm9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977654; c=relaxed/simple;
	bh=B+5F0jXQKJiQbvv/XTXZjn525cwtwuKuRgNUoxwKI1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iCq/d15iVDUaF2kEbxbCgTtpcMpXYwYAt8xfhgcvSfv7jFAD3VJ0JbT3JIGXWxnVfM2CVxEMr/WCtoHOkqxbeGJc2CWx3ea+xWXsFAflbb66wBne+nD9CV/oEQMdK4wcfXdQO17afZRvoFDPDDHa4b+pl/DcWyeZlFcMqAieV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GFPnwKRu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ADws6Da/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GFPnwKRu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ADws6Da/"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KSeO2960255
	for <linux-mmc@vger.kernel.org>; Thu, 2 Jul 2026 07:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JitEdvI6i7d
	f8QMRAibL59DICOV+9hKv9N6JWPI62GQ=; b=GFPnwKRu188+Ve0Co85KecIiVff
	c4VyemtlfV8/zZTC4H/cfF4jP+cO+bvPKXhsK+v7+LndnGMdHCYmq3bbm15q0aEw
	jPYbVw+IStGn+UKh+GyH6g0jX9o9tiG9YPA1dR+Mqr9TVFAG3R/Sg1AzQrdOs14r
	hIt13i5N/OmOC4d9586tBx/po/pLgnJkRCx9H+ThNl3lFzb2P12Xl+WvLvz8sKGy
	Ed7CFbnfXF1uWBcxa6Yg3Oy/5fw29nNj2gt3h8n9jsj/pXJ3NAHxdw3MWyoKLD4Q
	xQpbppD4kFrJLJphhV06k59ChfuFz4qW5n0pYlK2LE9eoTLUquF1V7DM5fA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f563mk0w7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 02 Jul 2026 07:34:12 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37c9127e316so2175664a91.1
        for <linux-mmc@vger.kernel.org>; Thu, 02 Jul 2026 00:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782977652; x=1783582452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JitEdvI6i7df8QMRAibL59DICOV+9hKv9N6JWPI62GQ=;
        b=ADws6Da/GsWtp3M4Do7OG1tnhOJGXV2+Ef6QfaficFvnhFx+uOj16gTYRnpQ5yf7xr
         Z0E2APjbEzlPdODT8fTMBoOqnDGGmsyxdz75vWw+ygtstTMOKt0t0sXBoHwC0PKQL4tA
         bUUlCui8BSz3uh9rH8i5iiKnMzsi6m98hx0CBF9d9d/RfYm5J0oCpY/AJ8foBmphJkAJ
         PiDUy+hjSIliKnmg0GIFCWgYSk57g2uOGRQAcEIqJaHwqQOkLcrghcL0R1heAFZM/6eB
         BbzyeL+LH9fGO2/1HgsUYYXMHKhbvW80Nqb9r/y21r0ESgKCu8vuH7dLVO9hqQ1R+2FX
         GAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782977652; x=1783582452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JitEdvI6i7df8QMRAibL59DICOV+9hKv9N6JWPI62GQ=;
        b=gCL61O8OIWZBAjCaWB/tDd9dPDklvQOcly5KgWdBEYLfXeJ1gUFaJQh4JaxQztxY0p
         uaAa6kG0k5icd3ALEKWmYvinLeHh75Q4zS3r6Bi9HbiNJxkOZvpDDbD0qt4EgiLX/THD
         XddT2elByLeXb1OH3WQvASNMoUyuC0TyrUFJ3Ubp+SREaNF4m1mtRBzgVeztPDJVYCQY
         vDtsKk3KrEPeb5YxBG29Jdz+QnuONN5MnOizY0dYcar6eDnY6VA8vpVvj6mxmgDEp1Cr
         1xdwO4WHhHUxk0CMYqmVQ15Jqf5y67XFO8ZaGVll3ZQ2of5zD0sApbly2Ug0pKJu0BJ1
         AY6Q==
X-Forwarded-Encrypted: i=1; AHgh+RptdFCfdwti3nkAO0s26JybZvQX2D4KmKs03m3qEBiD4z7DxE/BNloMZkJ9J4iTHybWLm5cEsxfbf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJg4s8PkU5oJCY94+fDzjXTgzgvK+9QKB1F4lYespI2tcbwgn
	ClxkT1Z7H9LyokoCGBc6lH71nN07S/DNwf360iUBABLCw9QQBGRTMl9tL82+tKcJBQqBblqINgh
	9M3z7b1pB0bX/PEs2zCcoyS1koh33n6rTTS0AbSF9FLaMukyUH514ynUrlMEBzWM=
X-Gm-Gg: AfdE7cm2g5Ia6ecOVlTvXNHx3xvnSoNKMP40WynXujPrK2b75gxfkjv8dwaBAUwB2vQ
	YEWRy47plFj0TXJKU926WzCWBlvl8q7ssVYLVhslORBpDalZGVeBCOMoxGW6rYnChpjcgZh6rz+
	k/Q648RHjz6SvnoYIA2qofjzpdwFgDymJSdAoOV2+OS3j22vKjFvJJH7F6lnCfPjm5XEZzFQL9g
	EU1ToVIefevwVmnw/6zkw0tTi23uaHhgVfSa4rD4/RVKq5+z2ON6ESBd9v2lzSncg7GAHf600yL
	j0wS6Nvro+OxuAhopW6j0zO9jHgvsxZ6Mb5oq1yvHNZ2s0c01KFEOHFSCN4ArOqPX7aJm8guO+u
	xVn5eCHKEhVHMJi9EtLQ+MtshA5+4+lxb1kOwXc9V8Lzeug==
X-Received: by 2002:a17:90b:3149:b0:37f:133a:3e01 with SMTP id 98e67ed59e1d1-380aa0abadfmr4951443a91.4.1782977652164;
        Thu, 02 Jul 2026 00:34:12 -0700 (PDT)
X-Received: by 2002:a17:90b:3149:b0:37f:133a:3e01 with SMTP id 98e67ed59e1d1-380aa0abadfmr4951392a91.4.1782977651604;
        Thu, 02 Jul 2026 00:34:11 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380e163211asm587380a91.3.2026.07.02.00.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 00:34:11 -0700 (PDT)
From: Monish Chunara <monish.chunara@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        Kernel Team <kernel@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Monish Chunara <monish.chunara@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH V3 1/2] arm64: dts: qcom: Add SD Card support for Shikra SoC
Date: Thu,  2 Jul 2026 13:03:53 +0530
Message-Id: <20260702073354.3641966-2-monish.chunara@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702073354.3641966-1-monish.chunara@oss.qualcomm.com>
References: <20260702073354.3641966-1-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eNNTJx1eTiOl0ywKfvVoSwbXmNVREn6I
X-Proofpoint-ORIG-GUID: eNNTJx1eTiOl0ywKfvVoSwbXmNVREn6I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA3NiBTYWx0ZWRfX9AtoXRKDnHVd
 a2CRArGu1pY4VbCDfndT+pTo+jlO9kGmIwr3e9HFqz+3zWvPEHq01XorUQCmIqbTVV11TiZ/kk2
 NkTqLDbd6uAUezqhjw+Yg2ZrPJQf5gq32791ayqLPjs6zxF3P3z4NfP8f6Ke3hdjBFtiAN466tQ
 bnfFtf1tqbuxiNezmeC3qq+M+02YK8+UroxhSJbEsmZ4+QQP+gtL9dOhCt9F8GHlZA6J0aRUP6P
 Fv4sa3uZYsT6aQKhGKWNbuPuCkxTdN43CAfcYKGvH7pRsc0kW3giOwJ9gFz63YlTYX8ZfSPNrQz
 LeCoSk0DMPJ4VxnM4wm3UsVOm74qUQO5RYCsUnsLVEwkzRmAUIQI1KqYxDu8dJsMTXT1bHPze+q
 L3jypmDZVzDBNof4fQFm+SMiRGTpTuQTFuaoC9lNg2S2ckkdwmqWJvaMa/nvHQV88pDL3vm+PHn
 i2+LxLwrp/mcbaJqoOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA3NiBTYWx0ZWRfX9IRlrvC/SXtE
 x6WuAMM6NbjRwMj37sguNn4vNFzo34j09hOWdAKigl7QRyublaMmMDAsJSVw7xMHAabVVRp5Erx
 CjnC/Z00sX3Tw8lZeJOzoCOFLAI2LBA=
X-Authority-Analysis: v=2.4 cv=UopT8ewB c=1 sm=1 tr=0 ts=6a461474 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=8A8miFJkZQRJ8vCztksA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020076

Add support for SD card on Shikra SoC and enable the required pinctrl
configurations.

Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 97 ++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index e67fe047a683..02997d603099 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -829,6 +829,53 @@ rclk-pins {
 					bias-bus-hold;
 				};
 			};
+
+			sdc2_default: sdc2-default-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <14>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <14>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <14>;
+					bias-pull-up;
+				};
+			};
+
+			sdc2_sleep: sdc2-sleep-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			sdc2_card_det_n: sd-card-det-n-state {
+				pins = "gpio89";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
 		};
 
 		pmu@c91000 {
@@ -1081,6 +1128,56 @@ opp-384000000 {
 			};
 		};
 
+		sdhc_2: mmc@4784000 {
+			compatible = "qcom,shikra-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x0 0x04784000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq",
+					  "pwr_irq";
+
+			bus-width = <4>;
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "iface",
+				      "core",
+				      "xo";
+
+			qcom,dll-config = <0x0007442c>;
+			qcom,ddr-config = <0x80040868>;
+
+			iommus = <&apps_smmu 0x0a0 0x0>;
+
+			interconnects = <&system_noc MASTER_SDCC_2 RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>,
+					<&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &config_noc SLAVE_SDCC_2 RPM_ACTIVE_TAG>;
+			interconnect-names = "sdhc-ddr",
+					     "cpu-sdhc";
+
+			power-domains = <&rpmpd RPMPD_VDDCX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+
+			status = "disabled";
+
+			sdhc2_opp_table: opp-table-2 {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmpd_opp_svs_plus>;
+				};
+			};
+		};
+
 		gpi_dma0: dma-controller@4a00000 {
 			compatible = "qcom,shikra-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0x0 0x04a00000 0x0 0x60000>;
-- 
2.34.1

