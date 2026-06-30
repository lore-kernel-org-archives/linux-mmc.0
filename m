Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A573B38B1
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838642; cv=none; b=Z9Q3O95vzHACzQmjy/qWFOTlWouXTS+073nWdt6o0kDxhvaDfHB6JVOeSJnYSor4fVCroq4MYcpV93N7jiftgFuEZ266wCxX3OPQ9SafkBgfDeqFEUU9JN8ZWAqsDSvLDShkilcWTBpT+2I5EQaEruJOCp91jgJjlxNmAZNcycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838642; c=relaxed/simple;
	bh=7dZnfERlDQb7BhudKK2Sq6SR1qLriZjh5wi8+K13iEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vww5Kfh4f9Fts8fIu/IDYdLiDlN+bSuXOnN4QzPAW+kyZ2YisgmFsSC49am3aRkM7ubxid4Nv11V4FqzYVFCnTXc9+3v9Vyie4j2YYdcCbk31UdZ8+ZZdcDEkLRnKOxZsqAhWo7+z13b6S24X0YOuRVKdgHgY0x6krNYzEHDCSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E3fGs32G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y0gRl0wQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E3fGs32G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y0gRl0wQ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEDG442216870
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 16:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=StVoceAKTdq
	K+qw8Y2JzYWOdg/02lGruQodIjHI1xpo=; b=E3fGs32G4FiVGENax5vkCZA70nd
	daTpi7K4rcA1biUAKGRI5Zv46UQbwidc6WefUQ57r2kqOVcSE6V9sKK0TrZV+aCC
	qYgPsjBe21ir3msx/aX0e1vy+apo6TjxROHF3Iy/s180DVaKPupRBGxoGKvPOCyO
	0xTansJL8Z/tzpMW5SAKUk64I+h+qGfkiFXoEla/f23LoOrKIp22wMH4f3H0oT1J
	uz6fJQA9oUbyixiflWpknvgugRTdfRY+f8ALdetkzam75Tv6ljH+yjKpdyEDWQtv
	1XLXnbvXcxi6mLBnlK8D4UnlZS4YHcoaYrKwAs2iIkm+TM0es7ec7XjtSng==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f43vfku6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 16:57:20 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-137fc6f8e9fso8587568c88.1
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782838640; x=1783443440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StVoceAKTdqK+qw8Y2JzYWOdg/02lGruQodIjHI1xpo=;
        b=Y0gRl0wQQma9fpeLyMPD9AfHVzu7ALpKgWql4v9zi8p4qe3VHWU/Rv1ykwvEd7sjWl
         wff12isFt9xYzkkE7pqbnOd1ExuqG61ES74Vj895VgCJCf2DhHuddgIW6uV5kak6FUdt
         /6F6t31/raAxTN9csQesHSmnLKTprfF/xNcZannytgYEcHqlnu+1IgrHsxdfzEVv4Tue
         9YwP6n77/vNlMNfjDcfT2jNPc1uQ/kRjKfM8UClbJK4LboM+VYfKMLA8JsTgv/XgehIS
         ZycRFw4SqM3p3uwYFnhudG9VQMeRK5GQTEGAF+QoSYPLRF5l88XMzGAoQzSnYLvsaypJ
         ETVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782838640; x=1783443440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=StVoceAKTdqK+qw8Y2JzYWOdg/02lGruQodIjHI1xpo=;
        b=m+7rLGmL0dNGQKDo4im07Re5BbojtqgB/mnGnaV2XQLGfR3wpl3K0kaVaTQkayh7iS
         veFE8eXHJxmQa999LMzZaEQLBAgjo4GsUUzSl43/nHTJMlSOE8ACwGr+nnZB9d627fs8
         To2i+yWtj4dZWOebjlM+HpyqG4pJIKeMqKodoC5G5mEW4uGOfTxS8TbMsxuS96SDf66n
         ZpCRK4r1CGi0RXSWbzAtiXTKO5LhKCfbTjHfD0VRF8hSh22hm7SDa5ayFWnKTyElU+EM
         Qc72v5B3OpWwPMQLvvfsqYyuhhlKXtGlbYKzb/jlMZcj8TSodrwC1xJOUetxpE3sYN2I
         HzjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kmf/5OkYZLNuwVC+c5EtFb4zZf9BsDrGIo0pIxdqS1AHrzBtjyP+5X0ITAJuS/AC6XMGkDp1Rq7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvM6AwRQluMpcy57K0h+TC8tDtKmbJHR7jvg4WU3yHSCjjbm6
	GYe8dcRbvUb35hVBCOUO6+tzdC3m0m81F57n81tnMtnxY28qG3IlLl1VsksM3kEUw8h++c6OymH
	LzqNNSkwOFioIOS6qmKaWmfhgllRW1hzJRO4rd9tPyqFYN5gxJoTU8KZ9BmhTdU8=
X-Gm-Gg: AfdE7cmAF6EWvsGm1EYqhHApsrHq+WmVNV9c2waYJjConRiNIkYMFDuLgc7JZwXgS76
	nCpR6Jx61Idw0MKU5Y55cA2PLTls1OU9FjP81WdTB/p4jRhvWKS8pCIL7+TQ0HfoCrsS7NnkP7y
	UNC/p0ioZDt42mNhIdkTw3Mm3ZlbuEqgXqow4ZOeivZxHbZ0nFQEOhFybGUhI3YptSV2FbD+pMx
	d/JiElOsOR7BhYT6n2iuHn1HeE+dEzICZ/RDGoQz8XsbHRWG8tPdEQtLgG5s1eF4QKV030y2VQG
	hQzsJhieQgTXeUmBvehZIPtyun2DNMM9BQc92WFrl3d2Zpr03R3uI85mHUQbw57SnLD1GtQtTLO
	J2TzulYsYLcYbvIyqe7jwHQnHvP/5ZI9gOMdKIs1Q5mm3kA==
X-Received: by 2002:a05:7022:672a:b0:138:6ef:45c6 with SMTP id a92af1059eb24-13b2a1572d6mr2901699c88.11.1782838640108;
        Tue, 30 Jun 2026 09:57:20 -0700 (PDT)
X-Received: by 2002:a05:7022:672a:b0:138:6ef:45c6 with SMTP id a92af1059eb24-13b2a1572d6mr2901665c88.11.1782838639548;
        Tue, 30 Jun 2026 09:57:19 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2a9b425asm12690272c88.0.2026.06.30.09.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:57:19 -0700 (PDT)
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
Subject: [PATCH V2 1/2] arm64: dts: qcom: Add SD Card support for Shikra SoC
Date: Tue, 30 Jun 2026 22:26:59 +0530
Message-Id: <20260630165700.1886608-2-monish.chunara@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630165700.1886608-1-monish.chunara@oss.qualcomm.com>
References: <20260630165700.1886608-1-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wcREOofMdihTmw9eW7y0YbUEZLII8G5M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2MSBTYWx0ZWRfX5FvQ3r/PrMmY
 iQq7CH4XLyKozfjHx4CMTSf6IbP//HtLAjcrjp7KD+UommV74w9vNDyDYPz8vXN+mrT3xGS/pK/
 M6xBqrSlXfzhgbG8wXKlECtYM4WGFHvegJrRvk8C9rOgUJmWDy0qfTpr3cU8mu1oqXNFowXuAZa
 4CIpj+qTOaekYoxjnqXXYZy3rTtlnVwviFoIKu8Vj59Gh1yQipit99Hi1lfY8f9dLfnzR3c+8PD
 sg6lLJlXOCDOqXeLe0t/wEzukY03N9ed6pXWKXcY2QWB86iXCuCL++0CsaxBc05nElBTfdIK2Xe
 vnKamQJP2zY4rCF7F8iS8XMNhsnHFBwaV1jY0stirJJIhzNfhp+kOfIF+HZYGrPq26reeAW2zT2
 YxXl6vK/YbCegk0tkET9+gBnPagVrz9XCj/sTfaz2f5Tk545+LUr7dcq8qjWo5Lv03oYm2kRX5t
 CDTxhN/iAZDycXHdTcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2MSBTYWx0ZWRfX4tdbTF0Dv5bV
 +oWg5jQMw1/+SNIqeiSiCpSer6QgVhflh4ORcmKr4q77S8yyp7NxcUmer9JNgsjvCFQG9wExX3P
 Tcjg91ijEsvcPBt4ewUMj7Ip0Wcd7JU=
X-Proofpoint-GUID: wcREOofMdihTmw9eW7y0YbUEZLII8G5M
X-Authority-Analysis: v=2.4 cv=PcXPQChd c=1 sm=1 tr=0 ts=6a43f570 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=LDB5gES_c2OzCmg7MN4A:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300161

Add support for SD card on Shikra SoC and enable the required pinctrl
configurations.

Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 97 ++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index e67fe047a683..cfdee8a2526e 100644
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
+			reg = <0x0 0x4784000 0x0 0x1000>;
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

