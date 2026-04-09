Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D693C344D
	for <linux-mmc@vger.kernel.org>; Thu,  9 Apr 2026 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735114; cv=none; b=j1XFdC7OWXP+zya32yBBGB+wSD+Ky47wPhTMhK+5R0nGFnvCDLyAbi4gB8UoZ0TWUkQoBB0PheXWXXLhVzLtbqMQXTRYpG20a0DccwdwaE7jsn6XBTsHPnvRkkWGINK4jI/RcCehGyC6YqnZhkLlIKcGMSsNeqe+tP3hiSp/C/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735114; c=relaxed/simple;
	bh=aw01N71X7OSXQ97plKv8ZOqyJOjru5oyKexCvfhnNmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M0lOmKvvlnhs6hIa3JP0Yuqaih6f7YFO2+tpfnQKS8fefpHudyrYOgko8wVDB1sddpWl6LaSgIp0g9Fd+OW9frUou2ZBSWX9nlzpCCXz/xB9CyTi/lmmCG3+AWUBMwhXMBrKGRY9rLRsCSVqkfvudqEqPH2RtO7I0OMihIwfy0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XeXNuyiT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ex3Vr3re; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XeXNuyiT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ex3Vr3re"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6397Vf3W4048060
	for <linux-mmc@vger.kernel.org>; Thu, 9 Apr 2026 11:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dWFVvxPeCJBC/TWX3FpgsqH95wMogFwZyp5cPPTpvng=; b=XeXNuyiTrn37eCEw
	QuHPb6zL4VKLnd4p984xc4Txs15B4tS9uzdzH5/JC8lga4AL0JHJYlKdJU6FVdFE
	ZJROdrc7qjOWFgDDVuGaLr9ad1Jf+8vEZK0E1yOXkYNi3nCu4yBQ3obrNspySJWP
	KKL/8Hmlp+Q1k2H6bsUwnlX+6nwbsBQMp4VDcz7DxQn6GuWwPD+ky1mCHnUHiKmw
	LXv6GEiqDZd9IbJWoDMkNcPGF5TXUslnDF3/16bRtWWc2v1fZWnDSMeprSJmA+qF
	5FbmkD4wa3DfG3/kMBijc2aE7DyHpTQd2p41WD/MCMORTFH/MnJlgTCA7rfIN93j
	8kt8oQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddtd73twk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2026 11:45:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b0cac007cdso9379265ad.3
        for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2026 04:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775735111; x=1776339911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWFVvxPeCJBC/TWX3FpgsqH95wMogFwZyp5cPPTpvng=;
        b=ex3Vr3re+LL21kefQhChz8lOvhqnj8+UMcFbdtRXJ+CXoiGMDDCNsJA7xNS+tT1I5N
         A213dZDdLRiLM4MEVbRP6Jwt9PJizJ1+n8RexzXpSD2VA8WFzhgG2P2bfH5S10pRJPVH
         Pg/h6dg8FdQ/a3c5oFFPn31T3F6XKNnbcV8srRNQbhFOUA/T1roKTZRiQIu4or3+w8HZ
         VUM2//C5DgY6CIkInAroWhuy4RWkLZP9bZ7I4dfYWQofzU3tHHqAec+ZPS3NRZl6AFaH
         zmjt0RpZW+gX2VUvenrL1X0e+GmaA7MXulP/7I4R6pp7yOKJwUsQxs6hZNdC5d51ecoz
         aCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775735111; x=1776339911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dWFVvxPeCJBC/TWX3FpgsqH95wMogFwZyp5cPPTpvng=;
        b=ESgm0OLNQlT2oFgdA6Sap6PsjUXVjexIIDZwxPs3qrs9p2seUw8CwpSxx+cOoH8NF/
         YY4pu7V+6F+ag2SZKRGU0SXSy3Htg2uxuFmp+QKk5F39ek1VgFj/EywjjO3gABYArMEe
         dGPF+VohdYR7v9vIq/qIRn8nEcWZcIXXO8YFRQiSVrx+WC+upyfXdQCarqonueRUToGs
         Ac08YNy9CoQ1qlJcdDIx4ERp98snrTwE5CwW3HrYnTmCsp7M/3MsnmCF0bBImhU2q2yn
         C4Bhnj2zHnlfUeT9eA8x3pAxi6hsefbraiCT8TI36wsHoYYC6BRBO7G+mIpIyYFgyX+Q
         BK6g==
X-Forwarded-Encrypted: i=1; AJvYcCU/tbJ32BGXOg/U2WI1zsE1vTQL+HzWnwql2LMo7cwdsrKEPD06yEyHELhnuYyujM2JubDcNqKhwdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv9OaQmCjKD/lHCXGimqlrQmxvsulk9qD3BhwOJGeas47u14kP
	1YW7axrShNNUBUAMXrv0rIgkd9JAkHrUirR+1GNOXY2xOd2sNmc/4Fsr3Vft18RiMscdbBjcGKV
	ZeKsPxpRNEQ+/vRDHzCQtmC/DFzWr/K/SRvzZliQGE0yx4nV+rHmYVAo0R7J2vzQ=
X-Gm-Gg: AeBDieszR5aOnT287Clt78tj/SNycY2gmAAfiB2YjykkVhF9x993O7UisyMzAjWgzKz
	IUXdjZmmZXM+zLw0y9Scg+RD3GFGkkjMyyokw+52PwA6wpAF8HKzIA6uwvpxCNWzWaa4bOSJlZG
	4MKmHkB9/NBzwWCRKQb5JE5vHNgIRdSsuu6YpqOZcgSD9RNw7xAektndYcJIIvzsBkNkN+ALk0q
	jnS//GR+ugqLGhhn7dvTNYuCPiDMCAsZmSS6YuOAUSKTbAGcK/LUXMqqYtVSx9bt5aK8F4ybXX3
	jkN62PODsU7VLvn9Sr0OA/7odZsLosKikfsSuUIdSMgCB5/8InAjUeWW/MeOeECDUJEq93dxQW2
	oCNmzTA/HScLiS71+0rHE5h8mBuKmIOroZPtTynSCEp+4cqXSbCE28lq6OEQ=
X-Received: by 2002:a17:903:1ac3:b0:2b2:45b7:306e with SMTP id d9443c01a7336-2b28163b7a5mr241542975ad.3.1775735110655;
        Thu, 09 Apr 2026 04:45:10 -0700 (PDT)
X-Received: by 2002:a17:903:1ac3:b0:2b2:45b7:306e with SMTP id d9443c01a7336-2b28163b7a5mr241542555ad.3.1775735110041;
        Thu, 09 Apr 2026 04:45:10 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd9fsm230957355ad.75.2026.04.09.04.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 04:45:09 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 17:14:12 +0530
Subject: [PATCH v8 5/5] arm64: dts: qcom: monaco: Add OPP-table for ICE UFS
 and ICE eMMC nodes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-enable-ice-clock-scaling-v8-5-ca1129798606@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=QoRuG1yd c=1 sm=1 tr=0 ts=69d79147 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=IFdraIdqUsMg42QbtkkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: EygRc5Wfq5a_3xa0HLhE-7PpSWa_x7xX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEwNSBTYWx0ZWRfX/Eh+1SYgyNjR
 Re0a7ADWRy3/DDg9LWEEuWyQncA0JSvK4raaj623TkthwVD3BqRev9wmJVMmLPxY3rKscQVUsis
 DyJenEyu8noBj15FGR9bqK6G3Wlsem/Fizn3ZwwAj2TV8KiKb12xXGT/FNwKIGCSyD4OmL7WT1E
 yMkUUVEnATbeHZP6CZoTpw8eUoKjWog05ySzMWgRRN4ah+fT7btBK1NBEIMX9cKdlG3ISIyqV02
 TMDIsNAZLQR5GW+e7x89VRpFQD1eFfFR5/J9udItMPIfFv4ObNND52kbsP8oBbjh/7NLbq9E28d
 RJ48LP6eIiRxIMX6bhbLRN333f8epYbmherQHHmkUKlRlwLGshX6DQT+ZUv3CCtr9n77oOIgVCe
 e0iDS0vzWPvXfQYsApcJ5KU87p9Q9zj4dEjEyg6nL3lcsmuN5Ygwne5fe5KKQuhoXV95IrsjzzO
 3JNCa0OFpfGTR07eJeA==
X-Proofpoint-GUID: EygRc5Wfq5a_3xa0HLhE-7PpSWa_x7xX
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

Add OPP-table for ICE UFS and ICE eMMC device nodes for Monaco
platform.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 487bb682ae8620b819f022162edd11023ed07be8..cb0e554e94d237b0adccb55fa9ed967bae9eea05 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -2730,6 +2730,22 @@ ice: crypto@1d88000 {
 			clock-names = "core",
 				      "iface";
 			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
+
+			operating-points-v2 = <&ice_opp_table>;
+
+			ice_opp_table: opp-table {
+				compatible = "operating-points-v2";
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
@@ -4797,6 +4813,22 @@ sdhc_ice: crypto@87c8000 {
 			clock-names = "core",
 				      "iface";
 			power-domains = <&rpmhpd RPMHPD_CX>;
+
+			operating-points-v2 = <&ice_mmc_opp_table>;
+
+			ice_mmc_opp_table: opp-table {
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

