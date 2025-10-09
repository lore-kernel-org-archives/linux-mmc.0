Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3381629E10C
	for <linux-mmc@vger.kernel.org>; Thu,  9 Oct 2025 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990773; cv=none; b=DI/PhXl3v21HwnKoqnTovje2UpwEmiMYNUiU9KVWMMULJ2I/8VHdrCQQjqxUtxTMmdkzoRUZsZFbnwnnVDGr1MDX8O7PJdL6RXOUi6xqITUKQztcNdfnWdgyV+b222Y6LvBi9D3UgLlka8nNJDqwnAOmrrcPxtx9tUt3v4jlk1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990773; c=relaxed/simple;
	bh=ykBQ7u8ZSIReYiJMLWNXe+5gYOOlY9SgqHAlyMhV+Go=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rdCMORQkoE8f6SvGf1aFUrg9Km+zHWMIhXPQfGb3volIye14BjOA4GyXg1YT629+hn09lEPEy1TmlhmO0W3hJB1qrpnJN9o22BUF3U4auVUHBKR2+rCC5mtxyWQkjUqUj9RzzUA1k8LL6Rj66js/JnX4AifHxwH6E3BygLwIm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bQQ2NLKr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bQQ2NLKr"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EGmm012249
	for <linux-mmc@vger.kernel.org>; Thu, 9 Oct 2025 06:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pANp4b5IxkjtlSbfF4Du1EXVAPUD9mR7LOIuI+ihGic=; b=bQQ2NLKrMRKPEJpv
	gFqa7HjhlMaqHLmX33Hd5kyRvLP4QmWXr7Rph2KjrSLxkBh6wndQd5wkdW/vt/+V
	q42eTFHvOLQdP3w9NE5UYdj8/3dqd7TCvrCrHAT06D1XYRjkRUsz06YAhJJeZHv5
	0xRZ5yMW55YKftCb71/KYmSV0iyV+rIte/V0fIzW+VDPdohDCq1ExDcYKzp7Wp6u
	cggiKp3Y+VKUNPO/KCtgVCMj2G+EkmVwaa1oXBQrJ5gjeBHOTXjJV/HjwIzAYlwA
	BDD4tFnDVbUg3EcXqFhZ8rHilC2ehURdaoq3EinVN5yyW5mBXz+VJUi8IBaf8kxR
	rQVvMg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4khpy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 09 Oct 2025 06:19:31 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6097ca315bso1623674a12.3
        for <linux-mmc@vger.kernel.org>; Wed, 08 Oct 2025 23:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759990771; x=1760595571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pANp4b5IxkjtlSbfF4Du1EXVAPUD9mR7LOIuI+ihGic=;
        b=IRnpHbY/YUMSMEhMKrMGwViaZoBY529q50/n9zRnUjuf8UDBWumcllxDWr4yp3datM
         NQ8Ti1PaxjObJdF2Q/txFzQ8z+sWHaIg246da0bzwq4RblxqRomj4TjQ1znnyq6475i0
         9hhGA8FdG780Fb8vVXaQHp7mp3T7sFnYGQ/uOe/dU0Df41dIK6Kw6giEOJ52VZGtb0oy
         IfpWYmuI9SUX1fFMgNapKGLHsIowXjWUV6rFuw0q3BGfa80rXXxx0FLQL+fF8t/mEtjg
         lmmuyEEeSFTbUnDImeR+4c7ALXS5wIbtUkLlvmlA8TrDoKBXd9uVInFZvA0PQRuhM019
         51qw==
X-Forwarded-Encrypted: i=1; AJvYcCVddXdJHfXK0ZdKzadm3aVtPymu1SWOVAkBXlye6gACp0TviVf+/hWLGYm9m0BAqiSVwi6S9WwaBqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtGdcLBxI+C/rqtIWcb3tYSZJBFqwjzFuG1EXDC/Ny5ykU5GR5
	TfSaFO039kok4aH+CU9ZJlKSmxGNwYUH3N/s9/CB0jWuHLkpQMSvymitujeUnxb/rsR3e7jrQQE
	uYGde6tLc9TINyBroIEqBCWEJK2a++FBWDxAwi+VbkFolLPkqofYzxn+CFlmLXBU=
X-Gm-Gg: ASbGnctI1N41mRZPQ1Dxt1ySn9t+9dMxSD7+3uMiJ8i4p8YPVHiHFN/eUOkHYebsrV/
	r/DQ4LuLggTya5te1wwSDV3PhZLqZXAqA9I7vqSvY+pyH4nLQi0Uv7QDje+EMU6Zf3nxNlKlR5+
	IqVGzxJFy3OCZH2DYEzXzjC0DzhrNVdSY3NUy028J//eY6AgcIEkYa7UFm7Tn2qLZo2SglKjWkG
	ORBQJ9BLFjHVEBeW5zG8Dg1UnU/pwlB5fLt3jduRIL1tcFgPYE+D/gbd8ydJsSD4aUCbcezchuR
	l99prCj80JNYLCFmFLYu08Dbvdep5HS7LeL6lCXQ353ybavtOosIYagWLFQI9eQs5rvyALuHdsE
	tSWAhR6k=
X-Received: by 2002:a05:6a20:158c:b0:309:48d8:cf31 with SMTP id adf61e73a8af0-32da83de278mr8455120637.32.1759990770517;
        Wed, 08 Oct 2025 23:19:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDDZMlxBEo8TNnN55hF6q2KHziI2Auqcmlg2+THc18Zu5AlzTesyPqOaZr4RuS3lQvYIxUuw==
X-Received: by 2002:a05:6a20:158c:b0:309:48d8:cf31 with SMTP id adf61e73a8af0-32da83de278mr8455084637.32.1759990770047;
        Wed, 08 Oct 2025 23:19:30 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099adbcbesm19239671a12.4.2025.10.08.23.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:19:29 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Thu, 09 Oct 2025 11:48:54 +0530
Subject: [PATCH 4/5] arm64: dts: qcom: qcs615: add ufs and emmc inline
 crypto engine nodes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-4-2a34d8d03c72@oss.qualcomm.com>
References: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
In-Reply-To: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=dojWylg4 c=1 sm=1 tr=0 ts=68e753f3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=IdboCmTcumTcOcSitEMA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: L2P0HSdzF4VFDWCJeSQIOj5r_-VRCJ15
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX3j94bxK0wqs2
 jdmPu22AQEf9HnDR4AZtf1Kiok7/w752Ow4Zbwg0gh2mlJ2HIsEUURaDVEdwheD2OdyfE5bdxjJ
 Jnsz6bOx9RJSnL+GqD0wdW4SdILTKzB/+KCAZNYZLDyVkprW6CptuYFxFMhKKswYOh78Y61dWxh
 SkhFwnDHoQkCwAiOCBeYnGbzIzoDILtJ7h8O/vfUyUMWMpUzdMZL0B3jVp2flGGXAGcJt5hsX7i
 HM+SCEGEY7JcQj5pt/AdD5qDjd7A0P624HiTcUFbPn7QrvDs+b13VFUqsg+A2BMQciUC0RQjYdr
 kqzBZW7diLnzCnAEYhcpKn0kG81OjRQ3gD7GY+v5bYccVAI4TlzFURchlid/FXxzg6ZNfQC1ikc
 83Pq2YZXCT1ORrGZGSn+2u7kU2xeRw==
X-Proofpoint-ORIG-GUID: L2P0HSdzF4VFDWCJeSQIOj5r_-VRCJ15
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Add separate ICE nodes for eMMC and UFS for QCS615 platform.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm6150.dtsi | 51 +++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index 3d2a1cb02b628a5db7ca14bea784429be5a020f9..bc1167b86e3896b9a54290e6a55ee2fa75a48c27 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -549,11 +549,9 @@ rng@793000 {
 		sdhc_1: mmc@7c4000 {
 			compatible = "qcom,qcs615-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x0 0x007c4000 0x0 0x1000>,
-			      <0x0 0x007c5000 0x0 0x1000>,
-			      <0x0 0x007c8000 0x0 0x8000>;
+			      <0x0 0x007c5000 0x0 0x1000>;
 			reg-names = "hc",
-				    "cqhci",
-				    "ice";
+				    "cqhci";
 
 			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH>;
@@ -562,12 +560,10 @@ sdhc_1: mmc@7c4000 {
 
 			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
 				 <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>,
-				 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
+				 <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "iface",
 				      "core",
-				      "xo",
-				      "ice";
+				      "xo";
 
 			resets = <&gcc GCC_SDCC1_BCR>;
 
@@ -587,6 +583,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			dma-coherent;
 
 			status = "disabled";
+			qcom,ice = <&ice_mmc>;
 
 			sdhc1_opp_table: opp-table {
 				compatible = "operating-points-v2";
@@ -613,6 +610,15 @@ opp-384000000 {
 			};
 		};
 
+		ice_mmc: crypto@7c8000 {
+			compatible = "qcom,qcs615-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x7c8000 0x0 0x8000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>;
+			freq-table-hz = <75000000 300000000>;
+			status = "disabled";
+		};
+
 		gpi_dma0: dma-controller@800000  {
 			compatible = "qcom,qcs615-gpi-dma", "qcom,sdm845-gpi-dma";
 			reg = <0x0 0x800000 0x0 0x60000>;
@@ -1249,10 +1255,8 @@ pcie_phy: phy@1c0e000 {
 
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,qcs615-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
-			reg = <0x0 0x01d84000 0x0 0x3000>,
-			      <0x0 0x01d90000 0x0 0x8000>;
-			reg-names = "std",
-				    "ice";
+			reg = <0x0 0x01d84000 0x0 0x3000>;
+			reg-names = "std";
 
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 
@@ -1260,7 +1264,6 @@ ufs_mem_hc: ufshc@1d84000 {
 				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
 				 <&gcc GCC_UFS_PHY_AHB_CLK>,
 				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
-				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>;
@@ -1270,8 +1273,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				      "core_clk_unipro",
 				      "ref_clk",
 				      "tx_lane0_sync_clk",
-				      "rx_lane0_sync_clk",
-				      "ice_core_clk";
+				      "rx_lane0_sync_clk";
 
 			resets = <&gcc GCC_UFS_PHY_BCR>;
 			reset-names = "rst";
@@ -1297,6 +1299,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			#reset-cells = <1>;
 
 			status = "disabled";
+			qcom,ice = <&ice>;
 
 			ufs_opp_table: opp-table {
 				compatible = "operating-points-v2";
@@ -1308,8 +1311,7 @@ opp-50000000 {
 						 /bits/ 64 <37500000>,
 						 /bits/ 64 <0>,
 						 /bits/ 64 <0>,
-						 /bits/ 64 <0>,
-						 /bits/ 64 <75000000>;
+						 /bits/ 64 <0>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 				};
 
@@ -1320,8 +1322,7 @@ opp-100000000 {
 						 /bits/ 64 <75000000>,
 						 /bits/ 64 <0>,
 						 /bits/ 64 <0>,
-						 /bits/ 64 <0>,
-						 /bits/ 64 <150000000>;
+						 /bits/ 64 <0>;
 					required-opps = <&rpmhpd_opp_svs>;
 				};
 
@@ -1332,8 +1333,7 @@ opp-200000000 {
 						 /bits/ 64 <150000000>,
 						 /bits/ 64 <0>,
 						 /bits/ 64 <0>,
-						 /bits/ 64 <0>,
-						 /bits/ 64 <300000000>;
+						 /bits/ 64 <0>;
 					required-opps = <&rpmhpd_opp_nom>;
 				};
 			};
@@ -1360,6 +1360,15 @@ ufs_mem_phy: phy@1d87000 {
 			status = "disabled";
 		};
 
+		ice: crypto@1d90000 {
+			compatible = "qcom,qcs615-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x01d90000 0x0 0x8000>;
+			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+			freq-table-hz = <75000000 300000000>;
+			status = "disabled";
+		};
+
 		cryptobam: dma-controller@1dc4000 {
 			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
 			reg = <0x0 0x01dc4000 0x0 0x24000>;

-- 
2.34.1

