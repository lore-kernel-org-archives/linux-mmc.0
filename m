Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40E3C4577
	for <linux-mmc@vger.kernel.org>; Tue,  2 Jun 2026 22:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439098; cv=none; b=KSrd9A7neSKOvW1AOoZo2Sdr+S5lUJC70axzyJsK5iy12cYrdao1nNY5DMWBD8JDzCfrf/eTXGNaLAdMMFpuCZPMre1vx1Uxc11Zk5fk7ollOMvIykX6phVmhWaj1pFkcKZ6gbN2wAy6ZRPRtf4J/WYQ5c4nb4pDG0qxWkldtkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439098; c=relaxed/simple;
	bh=DXh2TI45vU1iLpWsE+RYENmxgSc16LkuYVsOKJ6zBAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ThIYa5Bv3rDqxXCRiSGiUvSpIsa5EE6CZDL5OCQ0SAfYzxHKWKNxA9bkfk5P24xfhYgb9KkQ2BJB1m6FsDBkLFzzgYOFaKKdzXXpC0I2LhRykh6ZJ/kFoQ1JqRfDVvT7FQMMBalx9b7Yu9AR5sPKQgVx2p0P5p0R/68272zU4y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CgIvIyfS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G8UKOYi9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CgIvIyfS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G8UKOYi9"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652GBKOs3355448
	for <linux-mmc@vger.kernel.org>; Tue, 2 Jun 2026 22:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iYYqWEc3U8tcC19eQELIhV1rxr7yBmE/dYW94QG/AcA=; b=CgIvIyfSHTb5+Lt4
	G/vpGmyy9FnnoEJ4K8wXe2sGjDvtPJ1oKo49PRf0evNOrHHOFMk0B27yuwAMon9G
	nnMiO7quixhHagozVYNCZ8/xApFry5bChPrHRXq3FsWVrOkPnL58GdMMmDBx3kX0
	7ciQpBxBUpCR6ZObbUj2cwo+ZVHfNBd9TfDP1M4is84uSoijx2mY9e6zIw7omzAG
	MN1D4beevj9til2vPwg0on8m7I4bRHbwOLuOJqxSGblOuJ6KegofKSNeFT0Bffgk
	qItdLRRJwL7vm7Xio1ThXO3X0huJhLXGpCqLr2VV+bzmnVjZ/eIxyXdCltV67MVs
	+SJKgA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehvkxb2ew-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 22:24:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bf32fb7cb2so30172755ad.2
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780439096; x=1781043896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYYqWEc3U8tcC19eQELIhV1rxr7yBmE/dYW94QG/AcA=;
        b=G8UKOYi9twN+tOagaIqtrtYLq98h1wX8HM7FoC64BIKzl6AE1sS8aGjaBOaYnEyoHk
         yBoMt98sg4OXsiinFW7K6EKiCaMTPqwNxQRTAl7XcHCsGWdxN05dmnZ2rgjvlZb/gLSB
         yEQi353e2aIELthLvUP4Y0u4kPlZDfSMIPvHrOogEYdeccBd+qxyRBKzmc6GFG5XJ8gz
         ssOUz73eJxWPRUj3HH9Rki2Le0f6/G5Ddcw2j1jlEg0PFJ4DWiJ/pjhvLu1Z4918YZUj
         6KO5uIR4kuCvEOU5j0YBxVnEz2NGDUmbVpawrN82B7d7o7CdUjrBpF2Dj30QQzkLMlVT
         MW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780439096; x=1781043896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iYYqWEc3U8tcC19eQELIhV1rxr7yBmE/dYW94QG/AcA=;
        b=h5ksFw2gv3yKd+FlsyECfHTBx1EYeySQqcwWOCk5twEcNDTbabSQ5BilrQO0VCxdRH
         qj0Lc8NKl3jlEHXbpnkOZ0R+Rj0tm2HjRrwhbdNPn+pxHK34vdFE0n9ZAm5KcOYh1/0i
         TWKPEeO+25OYyaR8n3fvj41YkOA2Il1qd1FZB+Qbcv3FfqgnKRY/YiJtyzMdOUTzAgk5
         oDELeGjN4iWJd1oKuxFsqFiVWWUgChJZIZ4lHt8JKX2cDArTSXSgpq3J9xTxiGebacf5
         iNsuAwbN/BXzTtWiRDpsIkXD+BvGEBIIqshKh3U1AMiE9+pBOwumCuNyVIdgYOhwQUsZ
         8A5g==
X-Forwarded-Encrypted: i=1; AFNElJ8++C3iYbLLJpeRjDYNUAiNl+N7J48j6wLLFeBOxQqwIkzq5YZzV3N3UUiQ/Fu4PHMkgTCSRVM1t0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl7hyu5D+j8lI7kNXPHld6Vi4QdcA8jYmbuaMCxASIn1GMDLNL
	jmSVkTu9iJEshtaRalLWRgy+TXWcPrZiaUqSzguvpET/z7Q/Lr8EGHGO4kWgjYD9Sh06H94yOW8
	ugEraHA2BhC4QDjnWPj6UpLzdUjiFDurLAMesi61kBS2/PaUE+TcRnZeuq8H4RZI=
X-Gm-Gg: Acq92OE7mZ5Oyc/JTxOYllp7tFA/SP3LGwcdUV9kmd0qWUnNmj+XW5Mmt0PnaUpHa+m
	/JkDgQU3d+XD92ar+C9fjmOnKnRFvW35X/qBj7XCAG8c9ZTlaeg5zV3laQYJHSVUHH63MM7gxKb
	jl5EhrkSQuPYj7zS7hfE68XWfAMDZoYHo+QFlra+uHPmaFnBn20Dpesbnx5JsUv5zXH/+A/wAlP
	iK8dJMtpFDVgFItAERcq4BtHN0QMspGmZ4LId49IJZPJ4E0IbRWbFB3OD4ZadrDbUvePnY0eO9X
	XE2PhNNeJZ2+YCuajsBX8gtkJhMnwo9k86BLxVW6xV8IU/uRoK82rjjM2Oxq/YbcblZqmmpoWrh
	Dq627xA7UZm6Y2WCBBmNgsGR3i3GF4QbcU2do/4Wmam1W3H33+JGbmWwM3UuntOKghPyg/w==
X-Received: by 2002:a17:903:2a8d:b0:2c1:660a:2941 with SMTP id d9443c01a7336-2c1660a2bb7mr5879795ad.19.1780439095650;
        Tue, 02 Jun 2026 15:24:55 -0700 (PDT)
X-Received: by 2002:a17:903:2a8d:b0:2c1:660a:2941 with SMTP id d9443c01a7336-2c1660a2bb7mr5879365ad.19.1780439095116;
        Tue, 02 Jun 2026 15:24:55 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e0ecsm2698035ad.45.2026.06.02.15.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:24:54 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 03:53:57 +0530
Subject: [PATCH v10 5/5] arm64: dts: qcom: monaco: Add OPP-table for ICE
 UFS and ICE eMMC nodes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-enable-ice-clock-scaling-v10-5-b0b728435356@oss.qualcomm.com>
References: <20260603-enable-ice-clock-scaling-v10-0-b0b728435356@oss.qualcomm.com>
In-Reply-To: <20260603-enable-ice-clock-scaling-v10-0-b0b728435356@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: b2yrvV1UA0O6ja8Qo-Ll6tTGpccyYAhA
X-Authority-Analysis: v=2.4 cv=GYknWwXL c=1 sm=1 tr=0 ts=6a1f5838 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=IFdraIdqUsMg42QbtkkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: b2yrvV1UA0O6ja8Qo-Ll6tTGpccyYAhA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDIxNyBTYWx0ZWRfX1mMTUtIr51Vw
 slSSFTMclGCSEAgcUDKLLG50bG1BUFjHP4ae1D2hv4zkx2UMNTHHUgBk2BICebqYMVWnWeISupH
 U2UGbpB/P1qTkuX7J7FLF0iBnV3ertDltcrVHWVQJ1sZ8IGyUv86D2y3JY8wm2dVbn5/qD/J5I3
 fZw77D83zfIi6uRvu2l8fNuW5q9Mf/mMPaX3WlQHcoNgQVnmWzXFRlKgK66yJx1Q1fouZnPqpof
 AuUrKJCTd7uJGoz0akOBZ9dpj2Xf47bZbHX5Pivnm4s2DP+jFprXQiP1wC9WiITnDvYNLSkwLbC
 CYAz2uTIc/jpdXa7oTr0w/mmRlfOON5y/EcgawvZkOxiWeF8C7gLp9xcLLklUEwzQqDXqI/73mt
 zZT7ACbG0MejDuia/1M0fZZB1NcR0UUh8jRQW9FdMrxP6FwQVYUZ4FyR0cyTJJWRzA5A+UIdxQC
 4w9hKVjKOPRv9NHS35A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020217

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

