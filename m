Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48963AFB0E
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955341; cv=none; b=WCex0dfNv46Jk9J/XiYojdkKjKhI07EAAC1kpI1HpwaReMRrvVcEAx1SrxRpupACCixikzhrdud2ctkHBe+nl2L07ICFe6lO+tqi/E7vzck3fgL48IqFQ1QGEgsU5ZYjy0Tl1mDPYErLmH9pETjv2MiSU16BuGtXY310vk9Y3CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955341; c=relaxed/simple;
	bh=DXh2TI45vU1iLpWsE+RYENmxgSc16LkuYVsOKJ6zBAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z3Jo3RvVMWQs/Ds/+jf8BzI9jrFph6NwSRP0wiqH7DtBOQ45s0sMHaVVYHNAsjV5UGkcYIHhuHcrMOuo4e7tObKnQgLMMQOAEMWUGLLlMLo/dVGA5pHf3Mrr7RVKRQMSB+vK6WfL7qs0uwAPVLYn5rfEftMsP0s2e8GQuV8tciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mmjs4U3v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xq1TprqZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mmjs4U3v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xq1TprqZ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658IwxU5327623
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 21:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iYYqWEc3U8tcC19eQELIhV1rxr7yBmE/dYW94QG/AcA=; b=Mmjs4U3vXT2qQ//u
	gQucDQb1FL1F0nKyNt1OH3Xc4JyM0cbCrJDC1C6Qj8ISqiLb/3e1daB2yyKae96k
	Tub6zD/BBRQcz6O3uPhPCwM5AUAigDpEuZnDgbLYVyFMVDdub/0XBx+wDcPvhtZo
	jyGBOQUd6/3zLW9EPTBQ1NzZKQFw68+tWfStFQEI4BcZUezzakyC25OMsaEpjBGJ
	9vOPK0SwEjBdQaX4U2+Asw42xD2t4zhwKFjdHafZKKXuy5lGxkRK9NSdgk2IP5xx
	K11jj3G5wSjMoe7dXv43XumwhZk+YWT7OYVJm+KKb+gtj1bRFf5ISxC76IgtRsHG
	LXMfBQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun8k3jy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 21:48:59 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84256bee9a9so3015801b3a.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 14:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780955338; x=1781560138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYYqWEc3U8tcC19eQELIhV1rxr7yBmE/dYW94QG/AcA=;
        b=Xq1TprqZVGbOlRQQ6/rnGBfymqTXxkKD/SK2FAlM0Bm5GGKrOQpi9KnKolAk4zPm5N
         RFDXYgdVzZuoCaiOIf0D4KaXEUSmpiCleKhpjOv1ZtbGUoT6HnUUlEOFP8Zk6V5w7sAa
         akacQ/EoDC/LiyfJoGVEQTU4vJzaFww+slOqdM7Bi9wD/fRXTUgoK1ZKwVGALEypJCs2
         ETGOuC4B79GaXO/RgFETcXs47J5V9hmMzPfXOcEpmq/KEThiPhGQk2coOKv2giCRfRw9
         C/TqyKtmdOmY5fn78PgjFbpWXw2REwocOJMhNQsy3x5FZiNW85BsApgtK4H1W/kR3R0/
         KOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955338; x=1781560138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iYYqWEc3U8tcC19eQELIhV1rxr7yBmE/dYW94QG/AcA=;
        b=rmcNMyz7gysVofqLvF7B3kzYNrKJ3WvF+rut5xWDbZrDmkILCaLM5Sk4KNnfeFjruP
         BOI7D2aB7N2GsnrEGwFJXHxlI+ZSBBjX8Y7Cfs0YKhBSVEQ9tGPW5G8ci3wuNSCGG201
         W76nCHp2aDtW5p89OubNepOJRpQpR5FKx8PLX+x4aUggtUhaAqZmDDnyI99MG91wqPBl
         rHw/BDTc0B+WVB3Rkh4X9J1hqx9R+yehtY1NFo/DaUiFnMKbW4CR6EwiKzVXbD9ZQsU2
         7/5L26Dr7jy8wQ4P3PHPFS37AMWA93nwP5V7o55lJUBeRN/FKsViatTQanjGYfqRfr+l
         rPdg==
X-Forwarded-Encrypted: i=1; AFNElJ8ibWu/3oLxsHSJqfJsk0/VkWLCSEeMQoUAmN8hcigYNKFFPhZD5Dg3CUaBH+guhfK5RnZBahDLoRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqIi6H3ZBcR8N4kWGqNnaRHby23YaPWg8D4JLnysHuiD0KPFgB
	Ga8V1lG4/XxrDAv86oQIqwnr5fZmcRW1IVOOuxyrrc/+tbxTs9E+CXjMRNUdbGXIPR4aXMzXi4O
	1YVNjBoVd0bmRCQ/RrCpI7zLxP0hJhJPAA0cSWieQ4TQcUxaEzk78J+0z57Z0hts=
X-Gm-Gg: Acq92OEWZbqF+8th9kJKqyiJNH7ppGuuGwjbvPhr7dP5vx3i0j80u+HQGpOhXymgDY6
	YNshpuuNF3RH2VvmTPUuYiODIua8mVB0m+dKyYdFIJ8JBGtPexNGjL3i+BHj2d3FQqTXgEDqLzB
	Z5r1vOV1qkN3/Q4SHomNHTOx1R9DBh7YlLDV4CZSJXq7ptGE/sNdglzfe5bkSTJnOa/SRPbYUFP
	vnnmmfXwRF5JSrbvVjl1P28MGRYsLmURGz8Whyao6bN/aebAfTU1eL1GOC7j7Wm68/jYb1PhQw0
	c1C6I5YNbkeGWbXE6Ru7J6Ev4q9RSy336kfoun1uP49/d/aZfWQCuKFap14YyLfQM8h+1H8iDMT
	C3gaYX1D9iE+TLjYaMUUGH2l+2A9JSiCif41OW0ne9f2Q5NvUSUytYDrWo12kLaNySjX13A==
X-Received: by 2002:a05:6a00:3cd6:b0:842:678a:a7dc with SMTP id d2e1a72fcca58-842b0e1300emr18228746b3a.2.1780955338014;
        Mon, 08 Jun 2026 14:48:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:3cd6:b0:842:678a:a7dc with SMTP id d2e1a72fcca58-842b0e1300emr18228716b3a.2.1780955337523;
        Mon, 08 Jun 2026 14:48:57 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828cf783sm19607485b3a.40.2026.06.08.14.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:48:57 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 03:17:27 +0530
Subject: [PATCH v11 5/6] arm64: dts: qcom: monaco: Add OPP-table for ICE
 UFS and ICE eMMC nodes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-enable-ice-clock-scaling-v11-5-1cebc8b3275b@oss.qualcomm.com>
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
In-Reply-To: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE5OSBTYWx0ZWRfX9UgoQUt8CZSE
 RrE3Q9l5yux2o1Wh32oAWJcAUNP0ar1oImjGw+dR0o1fnyE6IZJIzxc3vH53Q9V/5mcV5ssOERM
 /phiqO9l0601G6gRqy4Hu5jQPq5NaHQHCMbYMHHbZMIoMx+XSxNvmuNTwjPwNTt7MArWTJgBGCg
 Kb5kxOZ5mpqWJI69emzkyzWB2ndwLFh5PtKaIGw/RsMYYf7qbFfkAHqbG0P8NriV5fqEO1IWvYx
 HYou4jYFUqDvKYVWIMV9MKbw3QOjUje5mvHGHxkThLlEJdPiRwXng1NWX6KTB0EJLTQqk/amQbc
 W3rvVynMBmAsE3ypuTgW0r6eJli2GW513w9p4/yHzS9PHzju5NWD9pl4SnbxqQXMx4k7FQ94D/x
 v+wMh0Q4VIVCaT2zXmBTq/pn3dWY+eOYf9OPFx0FbJcaaLupDDhCpDZCCb7XRZ4PXGeOwIu63Mm
 VnQaz0Ql8ogQk8MRtKg==
X-Proofpoint-ORIG-GUID: eJ_iCaEjNKJI3JvGxIMnr2-Dh0YlTc_u
X-Proofpoint-GUID: eJ_iCaEjNKJI3JvGxIMnr2-Dh0YlTc_u
X-Authority-Analysis: v=2.4 cv=Z7rc2nRA c=1 sm=1 tr=0 ts=6a2738cb cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=IFdraIdqUsMg42QbtkkA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080199

Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
an optional OPP-table.

Add OPP-table for ICE UFS and ICE eMMC device nodes for Monaco
platform.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index a1b6e6211b84d0d5008231c55613a0ccd61b9450..d9298d8b7874b8669b2cded2a28a99dce6eadbda 100644
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
@@ -4878,6 +4899,22 @@ sdhc_ice: crypto@87c8000 {
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

