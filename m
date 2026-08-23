Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CD3B3898
	for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514501; cv=none; b=tIfcYGuuqAcwl5X80J6Xm6YAQ+FoFJPcKWYn4u9V0PVEU2rXXpyaDFdUVVVf/Zwzu0XPOo4X+zcBAdO+bhBMMl9BT+4CBVhDtkhPOKHpiQSGnzG0FSpAinmhbsAXIRTrtk/21V8dd2NDhKU2J0y8t9iuFAziI/co17OGhDX2uFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514501; c=relaxed/simple;
	bh=x1iqRk3HVUS/CcF/hXLoxPVnQK7ivi+5ZVRHnCUMofI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DDkHqcBgYWL67wBZ5SpDRo85qtC2K0U3x8IuBu3RaHR1o/euv/Dx+ifl4WqvCcTSnC5j0BbaqQ8UkneTuWs+PPBFAjfDnTJ9IxQzXEGRFoGWWuYx6MhQrE/gziJgr7jZ5T6+auGaope4i+JT30g+M0jNmiYLZCtjUUZ9aryfZTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p3dMq+Vq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jy8kf8Dx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p3dMq+Vq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jy8kf8Dx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67NG6hhA4129359
	for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 19:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	faESQJSsZSzMQIUWsvbnCDla02Ciwf6cJxe2npadCW4=; b=p3dMq+VqfawZR3Wm
	EEeGohZrhHqV2cTLY51Auq6UB4CAaciPKw6RjxmlC3v0BimY0TwyxCkf3gqJwq+w
	QNUfs0ojv0ok7OB2Wz23LUm8hPsneyoFm/sBQrs/FoUgYFo0X+Yrr8DhGpXBKp8B
	sWyYJwWuEE42Psb0tGhalwZNOFEubgrs1nWuMmF5rrAXaG+KUpYwJdN4KSe3tKU6
	4ltzIWHE1e8mjXuY/CcuoS0ev6D5nLrpIL2WHEvJQwIUNvZy/54EQsfqNnDwrgfe
	wskZ5jJHEyhYOMFGUf5S9IdKKiHw9o/sZMZgQ5QslBoZrACsCLwYlE6tyYP3c3/D
	5DbsVw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g74hcv89v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 19:48:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d54187d8b0so16000395ad.0
        for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 12:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787514496; x=1788119296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=faESQJSsZSzMQIUWsvbnCDla02Ciwf6cJxe2npadCW4=;
        b=Jy8kf8DxrKoy1M+Ho5aI4CcTKR86CUhddV+0euRG0Ec8rx318ROFEsoCeIldnhE6vi
         jEH/5krQmd/5scBSQvLTwjpZu9vnP3IF/I44g0vYd7AOlfjswUsVaXYlAU6WA6hncB4b
         SbdLSTcTrCfwwTZA429/6/VaFs2VrQxktkxksOQXVaKoJM+5XQHwP5496OMwjkHuTKbJ
         1/OzUIV2g9REB1XpVa3+2pP5coIvMDRfJlnlaBD3pjZ4fXMJbTDcdwoxXiqNHxPSqhAo
         hwwwa6dv5UvF7iUpZnTAJlVuY+Mr/hRwlrYh4c8VOWTcGimfNd9jnOU/ABhGuhD2lfzN
         U8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514496; x=1788119296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=faESQJSsZSzMQIUWsvbnCDla02Ciwf6cJxe2npadCW4=;
        b=qSM/WsAHC6vnsgWtNKpBcWD7LS8gTCWy+0vhLMbTSA7hhbeiCuoJM2d+rpDGySGawm
         Vj0XREnWyyz6+eGbr/N0Jru2OEXiRAnqU6yXoQ4Gb4ISiXTJpstUwxqFopKiDkIEN30i
         s3NevHWhEjlOoxr+KHFzRUQZfpsO741EKjk7mbN8DXlSyrgPo3atpYCZRSURVcXe166x
         ZGPcQz9Wc48kyE6Y4h24Pum5xBItVXFjHyAOQSvqMlnA2iPoVTzv9XKKFjWxcMNzjeb+
         kQ30ADO6mWC6eChrwFfimst7iHuerf6mBb2KyMn4mKemOEpxXeEHR6TWFvBhfXfA4UR7
         HwMA==
X-Forwarded-Encrypted: i=1; AHgh+Rq03NXqQnleTsvW67foaiOIULQ68g3RWj/8eZDif0L72PQxG6oEE8Ir9aCpgqX2VZ3u8pzf5MRq3oU=@vger.kernel.org
X-Gm-Message-State: AFuF++mVtqHcehqvwGLMv2xeRPuEx8O+lwrhmT8B8/BKRf7cqCmrXfSi
	/qPMPoTcClTkdRrvOMcL94JGAQP35EL9bmQ/uz2BWCjgoUj4WDfoqXc/iBCFWCSC7TuIaeAWCdh
	pUu3J5n2FjATPaAp8/xpLa+N6yl7hcCjiuJVGjOaTdiqp1vEIeyg5FdYfGDZ+j10=
X-Gm-Gg: AR+sD12Tb1tWYAMW7zpLWYgTys4SBea3WqmWfkLudosO9kAwQSwySYRaGh+dVE46UDK
	oDy8k1968p0KRF9x9vEAVZepXAq8nQ71dgPgt3tZB5HNu/F42bCckjSNAtLGr3PiKoQ2s2Clxia
	HPj6NTfYiqEBtERZAm71Otr8/oYY4pmSImkSiCavB3Sxy+8RPzfZoem3DOAa3/jjIKC969pubJT
	sycv50HsDx2I7wmgGLHIhm9gkkpEi+8V1Eb/sXtIXkTHo/cf/Yz6Q5hxEiCcRiyOj9uzPQpKoNO
	mMh9Y4zdO9W/CcrVFyKz+zuvfIU+Vc7LSI2D7UteatcAV/S+FEd6soLtye9Z0jMxXI1VBrti7wf
	al5PddqNPOr7aah2sQsPG+A+i1jrpGZSK8zSEjA==
X-Received: by 2002:a17:903:b10:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2d64a9f80afmr400110675ad.0.1787514496536;
        Sun, 23 Aug 2026 12:48:16 -0700 (PDT)
X-Received: by 2002:a17:903:b10:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2d64a9f80afmr400110045ad.0.1787514496128;
        Sun, 23 Aug 2026 12:48:16 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f925190fsm32321623eec.31.2026.08.23.12.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:48:15 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 01:17:42 +0530
Subject: [PATCH v12 5/6] arm64: dts: qcom: monaco: Add OPP-table for ICE
 UFS and ICE SDHC nodes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-enable-ice-clock-scaling-v12-5-09271f583dc6@oss.qualcomm.com>
References: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
In-Reply-To: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 4Enrl5Jebt3Pd93mtKzqx2TQHmA64AKa
X-Authority-Analysis: v=2.4 cv=U7iiy+ru c=1 sm=1 tr=0 ts=6a8b4e81 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=IFdraIdqUsMg42QbtkkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 4Enrl5Jebt3Pd93mtKzqx2TQHmA64AKa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDE4MSBTYWx0ZWRfX4JaGKK6xiuwv
 MB/cLXeNtTarfVRUVVAx/floXCakbbC11lUpVmRxj4mt5pwOquUu9NTIuc/TD+qe0CkpDDb2TQW
 uV3NyaKPV9qWp5Awg6CEVS3H51XA70vQupKXWd/Aw+LSUMDCgBOJS3kZyMdBQ/ZMZY3A432WzK5
 52NS4k84TyqiNq9uuEXZmoTjlvK1ew14+Fmq3BcjVFyd1I9MaohVrlvZ8dxKLJXcTXEBQtaYwkc
 0TrOuG9RMX6qAabQqdUpdsi6gT08SKS1OH7UI5AaQNVzjH6jGFeoCciljFZr+LDRc+B6m9y/J2Q
 yczAAvwz6Hz1SEGWf7+DHuqYgPYJPVNnQHmWobdkc9lCjShmihzXrMo0oM+8FeXw5TLd5SIHL6A
 i2aJ3X1S6i759FuvQ1HVFdX4toCslUqsxB9lzZB8+JXWNgXEzjbX6o64/8C42RPzq83FPknpVSk
 263nHrw1IDujQNdCuEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDE4MSBTYWx0ZWRfX9PCVF/aWCxu1
 yeGpvKIDoQX99tDfWx+0Su68bZb9C5lI0l/ftPu3BBnhMJ4Sl+D4Z8TyxswFxI/ZG5eLywXOPa3
 wb1KHYMuEyBDXrc/JjxqYoYLboFyrMg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608230181

Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
an optional OPP-table.

Add OPP-table for ICE UFS and ICE SDHC device nodes for Monaco
platform.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index ffb13d61ee36dca61bb4a720c51001fbbd135a40..91f55244078a9122365cba635f8d0034f70d11e0 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -2742,6 +2742,27 @@ ice: crypto@1d88000 {
 			clock-names = "core",
 				      "iface";
 			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
+
+			operating-points-v2 = <&ice_opp_table>;
+
+			ice_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-75000000 {
+					opp-hz = /bits/ 64 <75000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-201600000 {
+					opp-hz = /bits/ 64 <201600000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-403200000 {
+					opp-hz = /bits/ 64 <403200000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		crypto: crypto@1dfa000 {
@@ -4907,6 +4928,22 @@ sdhc_ice: crypto@87c8000 {
 			clock-names = "core",
 				      "iface";
 			power-domains = <&rpmhpd RPMHPD_CX>;
+
+			operating-points-v2 = <&sdhc_ice_opp_table>;
+
+			sdhc_ice_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-150000000 {
+					opp-hz = /bits/ 64 <150000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-300000000 {
+					opp-hz = /bits/ 64 <300000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		usb_1_hsphy: phy@8904000 {

-- 
2.34.1

