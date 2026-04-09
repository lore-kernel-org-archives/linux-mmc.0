Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C283C3C08
	for <linux-mmc@vger.kernel.org>; Thu,  9 Apr 2026 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735107; cv=none; b=LufpBqx8f2/wOLCZSnsrUtFXvMoWvyK17TU+s2BW7lOPMobgD4c3eOPk7lCFzBjXTAyYUDlHAuoDDQ6h+/3AIToOtEgRhLZF/60nsWZ/jfXzZoARhruGwkBa61w/bS9abxOdoJyv3DRhNKGE13urcp0taQ1UtpQiVcBmbBKZjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735107; c=relaxed/simple;
	bh=NzK2BKDDpiMn7S4hNvWZzsLjsJo/12wVptCDRhY76jE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpKB2GtPwqoQlZNA3g//WtTII7bOYq1FTJ10rR1s2B6sqrBBBs2Yh05E9fmXB7Hw77L6pT+B3TKYcDA3UIBvAQYAoLeym5rfKnSio+JvmJRGNWthyTvV/Vw3qIsNMAdatnecX7y1vLsL09W1fMBk7qyXVkd3uPA/aouY6Qh+3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H9IkSav/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i92La4jv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H9IkSav/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i92La4jv"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6397MoZi4046994
	for <linux-mmc@vger.kernel.org>; Thu, 9 Apr 2026 11:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nMtaeroAIa2z0DlOIF1X2BC+XORLh63KcMmIsYwtcHs=; b=H9IkSav/aucj/RjL
	pU8wkv1cdnPBMpjYwTMEiAWwL9tVVn0iJVnMxDbtjRf14yss00fzE3yIJ68qwSK1
	6ulM3JTvgYqlgF2QRnra3/T1Ldu0Dxmt4glOYVmDb3XBpqR1P46qkgkSvBnX2FeS
	xjRx7mP7v4dmKLsAISe/g+EB7XT8fDnpSszL2mJO/Wlp7JSefA9RJOQ6apvKDaiJ
	rGuoSkpQfcyjSen51I55QFtVeFTVdB3XCn54rqKlk93IZqrh7EtZOl6e1BAguCjv
	xDUPUjptYdWpuvFyzz81QYzBMdGtmDSbmRSXtBTQX9yUz6PhEi4qvhwAJXGrY9Zm
	DZa7Nw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddtd73tw8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2026 11:45:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b0cf396c45so12344435ad.1
        for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2026 04:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775735104; x=1776339904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMtaeroAIa2z0DlOIF1X2BC+XORLh63KcMmIsYwtcHs=;
        b=i92La4jvqevI2VYjEPL35UoiEqi5fCQ4K37SAFHS2VdEwoIMNyahRDnUgZ8dhQJ/L1
         expIeR90tri2tB8KHrZmD1mxH+LhBPithvX0Kp727cW62w1X1cE0yEWdpB3E8Hammywy
         uY4zy10Ws2sJxtxKNbYpu/sdI2vrUOaCyA8ehSByPjTejVF8ViZUFcVdCmlMzD6yRb7c
         hyeUuSrG0Er+gnhkFE/wD8QcEoGmX9z/UNe3S0oKveLqAsEM27PvdUxNzrcn63Hm3S6g
         jYtTK/eNwTMoM4yG3UrRef7dfqohNIijcy8DD/zUQw1C8RLRiv2hU4XpJKS4P1wuAnLP
         V7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775735104; x=1776339904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nMtaeroAIa2z0DlOIF1X2BC+XORLh63KcMmIsYwtcHs=;
        b=RAcsyagFk+n7EfhZeUGY+TX77oGFTlF0MXosZg987PgEmdL4U/QVHhjHn13ks2Ovt8
         W8skjgZptDpRO+8LkuS7uCpHB2/h6i0wJS60msCmRnbO4QO5p2BI8hK9WSxr37fQaGiK
         nfmG++TNKld8u3b+pq6fnUUX19UXOx0FRGzq2Roa/jdqOZAeNZwW2dFFPnTSkNKT25k9
         tilQ3EooaQp6P5/SkITgf1El1NLPWvPtHQ3PUypu83I4AOr7ic6X0ox8bKp55ZcRwsOl
         +EaD1EZiaTPkuo2Yd5eXi0PPbdirceMhc0iSGLUutCvSvy/pwA2TtvRGRz/xwa2Hqwgj
         jcBg==
X-Forwarded-Encrypted: i=1; AJvYcCWO5f0MaLLrsFAiCIYAtJ1QMgsl93CXUIoiXkmLqzWqgWPWPt3DGs6IemGLDpiS49Ee6ft5NmDUHpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9z+/p7B6gYBDyH42AmiikMVh59AupMdax2JakwNtR1hfAOx/
	6f+klROf4bGXTQDsxcjuKzrIq/uKwQ69TAV8jL1AF7m+CoTQ+EFxCg9KTzcXLGYvzKNeT/0GhQj
	RiyiCQImsv8EPImZUrdlz6YguRzZFvPNhocNA0pQ6OGGGtaj0I9Ar5fqCFNufCeg=
X-Gm-Gg: AeBDietfjDgLxKnlWLQSW9rKvTjTaN7eFpanNX5MDrgtiXkV345MLw82Bo4Wkxo3VWl
	lm+QyMfy0fpK2D0Fnyob9fMjlvEgfB8vY4POmZn8EAVGVsiLmR1suP9TjdZcg/ClEmFTBx7f1W5
	Yd941/iEoXcrlTezRhY50GxF43D4E+QuSx5ErM83G/z0lLyNWRVvFEEU2zNZsdbQcSDjnmWmDp0
	uhb5mDSLRwumMahaeYnU6NtCLKIGpkNm8TSXsooDxu9cpgEnHwj/31jjbjjaq0g1/58dZm3XUtn
	sgqc1xjLGfuORS1PCCa8zI4Avj5LHM+qYGz8hrikPymNHKcFKsV6Cq5Fzf0T/K0D+kRncFdX54Q
	0253Z9QI7nGZxVtyfeknOHxmMhhukxHMz1xCGuKbLteQHYo84mUry2CRv5vs=
X-Received: by 2002:a17:903:2cd:b0:2b2:4e70:6339 with SMTP id d9443c01a7336-2b2c73ca428mr36152825ad.25.1775735104263;
        Thu, 09 Apr 2026 04:45:04 -0700 (PDT)
X-Received: by 2002:a17:903:2cd:b0:2b2:4e70:6339 with SMTP id d9443c01a7336-2b2c73ca428mr36152615ad.25.1775735103795;
        Thu, 09 Apr 2026 04:45:03 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd9fsm230957355ad.75.2026.04.09.04.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 04:45:03 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 17:14:11 +0530
Subject: [PATCH v8 4/5] arm64: dts: qcom: kodiak: Add OPP-table for ICE UFS
 and ICE eMMC nodes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-enable-ice-clock-scaling-v8-4-ca1129798606@oss.qualcomm.com>
References: <20260409-enable-ice-clock-scaling-v8-0-ca1129798606@oss.qualcomm.com>
In-Reply-To: <20260409-enable-ice-clock-scaling-v8-0-ca1129798606@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=QoRuG1yd c=1 sm=1 tr=0 ts=69d79141 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=IFdraIdqUsMg42QbtkkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Z-Bw7ns9RSQo9TMNqLAeA4oufAcOWSaw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEwNSBTYWx0ZWRfXwHPkJSVCjJSk
 RvebEQHMlq8U9e8wU0cHu+m7AihMTeh25pqZQsRn7cq3erJC6XKJEkFg1SdeTmjAPubt2IoM/zK
 lI+Xl31dDW2QFoUSgWkg4/aen9LG8nLfitkbH2NgZp/nRw5ETDRvUqVOWVDmZnftIRpgb5Epn7H
 bfI2mkCQgenEcNRVpUOhx6XuBFYTBs4VBKNcF68WRqapNyMJLqAgnOmdKa5WeedqUiBe/5hQABW
 2pRmTLgOq5mE35P2wPuAoaI2R9zjnXFg9TNU2e5CFuKXTvMQbtcH5isC2wOwcWQYf4rcoQMGy/O
 VMFf30UpoyvokKy/pFIqsb6yvuVI5jIxUXJXD/mqOo6z1MhQqlnj4KApplKiSWJKcC0WiOWm2BO
 AqRMG3tepVLc+ykqtWxqmkQmojIpqwqXKqRNWrvAL7/Uh6smc0u++30QfDpof6lG7p1CYRrjFsj
 rKZCFoDumn4Pgrf9wKw==
X-Proofpoint-GUID: Z-Bw7ns9RSQo9TMNqLAeA4oufAcOWSaw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090105

Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
an optional OPP-table.

Add OPP-table for ICE UFS and ICE eMMC device nodes for Kodiak
platform.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index c899a17026fd2a10ebc528a816629c88ee3bde5d..b0aa1970d42a3bb0b9d371e0e6cd09b8cd164dbe 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -1087,6 +1087,27 @@ sdhc_ice: crypto@7c8000 {
 			clock-names = "core",
 				      "iface";
 			power-domains = <&rpmhpd SC7280_CX>;
+
+			operating-points-v2 = <&ice_mmc_opp_table>;
+
+			ice_mmc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-150000000 {
+					opp-hz = /bits/ 64 <150000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+				};
+
+				opp-300000000 {
+					opp-hz = /bits/ 64 <300000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		gpi_dma0: dma-controller@900000 {
@@ -2597,6 +2618,27 @@ ice: crypto@1d88000 {
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
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-150000000 {
+					opp-hz = /bits/ 64 <150000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+				};
+
+				opp-300000000 {
+					opp-hz = /bits/ 64 <300000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		cryptobam: dma-controller@1dc4000 {

-- 
2.34.1

