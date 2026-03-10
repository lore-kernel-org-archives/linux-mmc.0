Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FB3381B06
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142576; cv=none; b=fWqaXRN2doxUn4QG31x0gJbDhOPaSAxDikN5MQQC+dHZBBnmyff9P+DC2B1wx2C7J2ceTWXZunfE9suK7Z9JINnVJ5U/mol3gc9kQhpw9vCmtcEMcu2+dEYvcxpBE+STuHBRh50VGpVEVFhXBDlI0aiDserdUB62DtWrIYJU9/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142576; c=relaxed/simple;
	bh=WPmhXAkQl0KDFeJSCdUmhGT9lzk5W9kEy34gwEC3l1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CKYLpkSUkhqTcKjUajHh571eazhUPTNLUCimitQUAJkb2xvgmhA4uEib1GS80fqcqaxhUWOeODZh2WYiMParcKnKynDa1fveRSIXUj9ZuIypPD9QB0tg/7r4EN1BAKgmVON5jBAg//oTYBeTYhp/ZiOZpdS81+f+vzOZ2L5pbK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LPzE7ewz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fs6a+VO7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LPzE7ewz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fs6a+VO7"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A9D4Kx247058
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 11:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cVF7BkFdxkO
	QdBW05LHKmOpFtvTgyKB2JnKk5PejEnE=; b=LPzE7ewzXCNBqDzFvli3dkAHCqy
	Q2/nYGGLESHpvYxIao/bcbxDbdGdPfQxYIOEyfeDHDsfO+Sf4TTHKvNKbVAgaR6T
	lEeLGBcrQl3eURjaZhxbFJuvsLwbEFgH6zlNdfNQruI8rWoo/9B3OWbiXt2G7GYB
	B5w2x8Cs6u5PzxYGqFWhHKo50dMAxhGRGCqDwcLgnWREtz3fbt0fqNJPwAU9N9pK
	oRkXEglzBYC9hiSMw9Vs/olo8CXScwe0Il4a5nzF1JJEteJYlm9xGcTNhGtfY2Lf
	aIMmxWolBpRz/7gY7e7iTcB5iOB0IMbeHwqOlIP1Iv5Hb3B7zRymtmnGfSg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct88029bw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 11:36:14 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b630753cc38so58032650a12.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 04:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773142574; x=1773747374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVF7BkFdxkOQdBW05LHKmOpFtvTgyKB2JnKk5PejEnE=;
        b=Fs6a+VO77/6+gnAHEIoJeqv7BL/6hoUCdZLlze4fkf9PJkN/4Xy0LwjVMnl/limfHe
         H4vl1Pse8/Sez7WgfY2PBMgcE2WFDVHNOPdojFY34cBIvzBb9HqKeWB6yohnzZ7prBWH
         8H7ELtmEB7O/F40XLeNbwIj1Z/fXpKkFpz+SCKKLo6QJcNY7jg9Yt8z/jvfkR+LYFfVd
         g1oE182cQtwbLzNsYu21V3e5+9ZLYp5GqnreadpENjXV2krjG1cu4nl2nctNztXnYvpT
         r+0+9pSPCU0wfw3MkVfOMdAl0/NnLR6lSXIxX8+a7ULgSDJvQxrx6BLitWo+fQAM8+ay
         WfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773142574; x=1773747374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cVF7BkFdxkOQdBW05LHKmOpFtvTgyKB2JnKk5PejEnE=;
        b=IGZCo356KpjXSoesjFxPGE/HkzYsIJjEGPoqcxjHOBysKVVa56bPx/Upj4KvHINPYK
         qmt4IfNSOeTok0QlDi2FbI2xilm6mF0aiR/de624Fif2KRCbxSe+p2C9txkE0csi63PD
         BZOb/JIrOeDanyq/y4U559+ZFPN2u9r7LndI2VVeg9F5ZchiqwJcQTFBZ6671Rm8DJwr
         TnqJNXc+4XgKNwZf8tnINhRL4YnA8tTY2+9hCykPS49l1KWEBsFLMcs54+8jwyjiS689
         0SpGQGTqyUG++Qd3VBVEYD9czjXEo0DVFIERplJO8rTEIEh424AGCb67fcb3rZHSC8Uu
         fzKw==
X-Gm-Message-State: AOJu0YztoE++eecf1drJwRZFhCqOpEXwYTAxt1ILlJzH6YWMngwTDXjQ
	gZSLqq4xacpxTo8fx9YHlMafAgImgw1oyd3sp0xMoFXUgZ4+eoGs5qyz/Zb4WsHxyiZ0K++F9xJ
	Lbm7LUl73sKfAlaJJH5rKw10ojlGZD9GKpXiBbxcslcJk8DDukqqDWUf6AqQ8l1w=
X-Gm-Gg: ATEYQzwy9Rfjx9NkxKdCMKOCL8ZmkfxlwkvIu3EgbxlJjYKZ6q7d+ACIZfM5k1UHVSI
	wrjim3Uu2ntEXU28fsfpN4a9iu0t6ElgjZVjtzp0paVo5dVafFMgk03lUp881lDMye0PyjJlXXa
	5yR2bu/Ln94GdYrGnVn+7/+GZOTLaAK0gW6Nfxfh+leAs61uZkAfVyF+Z7Sc/AFijpPpauhUiJv
	xgGnfpKHrbPuadz4H9hqBMP/jNSrkbXxcHdV4hOlqhOpT4+qxnBH6r8Ca/8Qtjlep/xPP1YdU7f
	/D/Kxcl8ggUG9OXMNFiZbbll6hF3tFNWffA6Du4bTfrw4aWJcC0ElseRlqixhhN98F91SW1TASP
	eSO8KWSQtw8JdorEoDn5W1nDY/Sr8Btc6qx4sPZv7mBAGqkFQOaZY
X-Received: by 2002:a05:6a00:889:b0:827:3f01:d1ca with SMTP id d2e1a72fcca58-829a2d57060mr13256747b3a.4.1773142573813;
        Tue, 10 Mar 2026 04:36:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:889:b0:827:3f01:d1ca with SMTP id d2e1a72fcca58-829a2d57060mr13256715b3a.4.1773142573382;
        Tue, 10 Mar 2026 04:36:13 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4637bb1sm12364659b3a.10.2026.03.10.04.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 04:36:13 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v6 3/3] arm64: dts: qcom: monaco: enable the inline crypto engine for SDHC
Date: Tue, 10 Mar 2026 17:05:57 +0530
Message-Id: <20260310113557.348502-4-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com>
References: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEwMCBTYWx0ZWRfXyfejeZ1QGiwb
 CNqqGzUQ1TS6RLXIKfAVNjz6yjcBwANij9gjAp6YAZwZhQNqaIwMYl7Go1igJhcW5DHwTRP+bt7
 9XbcaNjW29PSHShSD1tGna/OQRjY3GW4ktuq3hBLYAplNodJIRJ6Y9+Prg0QxTnYm5NUinx8gCO
 CexHhdMq9I+sbukXMLDjTB19hBBowac4Fn67d4kxEJL/Evh9NLFWoZOOZ9QGAYA+wlTOcNb6z5I
 H9H/5fFNdzmVqvsqkO34bAhd0MR6OV7458qqin7s6qJ77RoQD/3UDXI4iEf1oUbLkDbeh9ZSuBv
 ocFzt2WM//QCcS1DfcqUYN2+v+jSIfUdn9pSUCmHe+VsMzg4TFxUJaDSaWT7QPGn1vdc1kFAO2y
 HLEIhbeZNrVWCDqhl0YieRZFtj6NZqOv3ZVHIABYHqrb5QeELaNvffT6uRnxwnPrpPVUtd3NTea
 oh3KEB9u7hXJ6126/DA==
X-Proofpoint-GUID: Bra9-m79rrU_98V4KCT_ZIU0u-CvTQLP
X-Authority-Analysis: v=2.4 cv=Jtf8bc4C c=1 sm=1 tr=0 ts=69b0022e cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=fZTdKWQFAU_LetDfPdsA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: Bra9-m79rrU_98V4KCT_ZIU0u-CvTQLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100100

Add an ICE node to monaco SoC description and enable it by adding a
phandle to the SDHC node.

Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 816fa2af8a9a..365af78b01ae 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -4202,6 +4202,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			supports-cqe;
 			dma-coherent;
 
+			qcom,ice = <&sdhc_ice>;
+
 			status = "disabled";
 
 			sdhc1_opp_table: opp-table {
@@ -4229,6 +4231,13 @@ opp-384000000 {
 			};
 		};
 
+		sdhc_ice: crypto@87c8000 {
+			compatible = "qcom,qcs8300-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x087c8000 0x0 0x18000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>;
+		};
+
 		usb_1_hsphy: phy@8904000 {
 			compatible = "qcom,qcs8300-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";
-- 
2.34.1

