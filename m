Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4499D3C8723
	for <linux-mmc@vger.kernel.org>; Tue,  2 Jun 2026 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439092; cv=none; b=cecfHvMOgR7GfU7QIwXMAT/qiOLevhQfLFzCyIaPdKj35FTOjW43M66o6aiyg4r4Zuo8eqWLdYS+12U3DKMFy9JhhvNqMj8bhPCRUwRLYf4ohPMIwr9hNp8GANEZ1bKkeESbqf3T3vSRW1aHAa7QEqLgORurtNuem/uUc9sPjvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439092; c=relaxed/simple;
	bh=X0xXkFgpEGLjkiFblpwO+BnhWlu/bE8cwlCDJSPOaDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eYIQz6PTmZBdZ74wgDZfPbKuhoGesw5p8ddoHdS2fQ19QRLBtHect6VUetbiKCJW0qILTPKKSJ7uZaOknNFgKErHPD9TZIJvBd8T/Fnbbo4Rx5JLkVo4Ir2JOsKFelj7wWtAd7Rw+lMFI9u7RRAfasBnQtPhWUYjgDQR+x6g+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y/M4QeiD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kPdXe1sv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y/M4QeiD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kPdXe1sv"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652JAK2L1316907
	for <linux-mmc@vger.kernel.org>; Tue, 2 Jun 2026 22:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ETNz+wmmpsdRAuqSqBnBouCW4jgWHavGgQFIoIN6PGw=; b=Y/M4QeiD3c4bC0ff
	kVey7lRX3r7GUHXdS+2EGnLye6NdMt8vHy6O80X2h5zbdHYMzNXRYpnJy8iUogNp
	fmBGgVXO1ltEyk31mdGnVhKl4hbleKsHVySVsn58sKiGaUcnoUylhuOA3xNSs3ub
	UpiZX2VqTzOGW5fCjbMcIrNOZ4mqV1ThgBt7tJlUH/Oa78uRyMWcPsLcSmMXydSV
	xAz4Uo0ONVzDKfb50M/wrNBch0HgUDPGH9Ujao2Vb5/WwhgXPCd7aOiOUOLmJChH
	mTRGVbmrPi9O/WeWeNHPIcHtp/E9CbGsWYDFZLc+mnyMoFWHzfPioeeqvgvQX08A
	mhwOOg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehs9vv2fy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 22:24:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0c331eda3so38698225ad.2
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780439090; x=1781043890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETNz+wmmpsdRAuqSqBnBouCW4jgWHavGgQFIoIN6PGw=;
        b=kPdXe1svqYYwc37MLnn08sgAb1uLOiOA9wPLJXkNDWmclUgW31629lVda+Vhfht0ud
         ulOIfeEEKTJTT7Zy+yJWkUxBeptbDoUhBxz+AjhlR6QSU3TWGD/2XidjvsLrk0/n1dxZ
         7EXjKDJ1/DLjBnJZPGR+3sGlMI6yZsYHmeFhucOqCUuKNcPZXA5G6eAb0X2muzcJP9WC
         xVxfOehf1xE2iVJHsCQg6YrQFQLpym0FoO+ivm6ZonfRLrVsJ5ygfuv19tyxcuPAwsaF
         nKqh+DEEONB0hB9/2zwqNjD4AO4AtiDjB6CHgKPtXGtBYfnyp8qVhQGN86wUmYXvYzCQ
         mrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780439090; x=1781043890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ETNz+wmmpsdRAuqSqBnBouCW4jgWHavGgQFIoIN6PGw=;
        b=e9EaIqAQBEJewOwcy2yImlhHn75TEalVWLax2cjGeT/8NJH8nn+r3PdlaXKcZMWPe4
         d1Ts1H+Sh2HePWhtgRmAgwhanjodTwJLu/7bufnvPcLkiCWw/zd/SoQrVnY39Z88Uc+n
         zoqShwh9RLkl7vpn6g0n5M5+xN2jmuLHFs5YCqTOSYUDkkFwNwCyUWN1x7tbWjM+M71R
         2gh0Wb6cTQAsRm3LAvEyPEEpi3/cJvlPXTjw2Oa3L0n3G3gDZh0dAoRwB+Ct6Xq6y0p5
         1hQDDVkfWeAMRa2HzF/oWglAvMnBNCSzfmKC2Q9LLftRW2du6QS7ir/PurCUyRnyrw0J
         64YA==
X-Forwarded-Encrypted: i=1; AFNElJ/hxeg+Pz6Ym/zmolEbzNn/fJtdrIUnPADTyZyQ+qUsBz/XkbZQRwomp1AM8uMAgH1NttYB6Po2uDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw102sjpNr2IvkkANJ5jRr7fTfVUadQzM15rDFmODmfMMIyXh0r
	8yx18HJSzrtVegpxV/PDzws83Uqqj2YcOtGbXpCHAuGcuYR2j1+2l5+u870+aOu2yrC2SSG2Rsy
	YlT6ftKigcKuRTKMxl2Qa85X/ighLBBmq/HP79ie1dZDdiI3kubuxEOR5tKYR9Go3OObyN40=
X-Gm-Gg: Acq92OGiBvL2zL4twTVowmS83aMm7hBrfC1ZOdJCtdDXRqkCPy5z87bPR9jGRkjIzM/
	kUHOF85xjy9pZ8d4mtHGxPWUaZnMeD0frnnLWvcmXzTLGVIerJ4VsBQewsxnFxv2x7nZvgIzkEJ
	DO61rQfyBG9yOOIHeAEzM86+iZ9RcvkybqaaxBX00LWM3471fdPThD3X+kVVxW4cdgHToL+c7eR
	YdhN6y0EcZrhdDzPReH9YZvjUZwbs5nSe56M8kLnwEmnGfWRuP7TSrsXUxhSnCc09sqrRetUNux
	p8epPIpN9RxUz0OPuohKdS94B6vJ7yIXyVWeu6vw8FHWhI88xI8EpXRNhR8EYi+NbIBh8Ede4Q1
	+nn9lgKPVotnM0qbP8jiM+Po31wqRzNbsEPRL6pmHZbKzRJ36tU7npmSvXRaFP7rK5M2m1g==
X-Received: by 2002:a17:902:f547:b0:2bd:2de3:5181 with SMTP id d9443c01a7336-2c163a2ac1emr5553295ad.9.1780439089929;
        Tue, 02 Jun 2026 15:24:49 -0700 (PDT)
X-Received: by 2002:a17:902:f547:b0:2bd:2de3:5181 with SMTP id d9443c01a7336-2c163a2ac1emr5552975ad.9.1780439089464;
        Tue, 02 Jun 2026 15:24:49 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e0ecsm2698035ad.45.2026.06.02.15.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:24:49 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 03:53:56 +0530
Subject: [PATCH v10 4/5] arm64: dts: qcom: kodiak: Add OPP-table for ICE
 UFS and ICE eMMC nodes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-enable-ice-clock-scaling-v10-4-b0b728435356@oss.qualcomm.com>
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
X-Proofpoint-GUID: b7UQv3YTTKcLjXFayUVpC5-VZ2pYXZ6v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDIxNyBTYWx0ZWRfX7RmxyMo6E9kV
 XWVAk/d/mhl8iV40M7UsLerwDUQta20y7JTmzdvubEi3PEPQGCrzl7w3xo9LMPx8pmsGpmIQlKH
 4jkNFZouSnUnwBD+O1w8XcfnQyyWvZsJQ9bdXMIy+Me9Q0y4SAYJSWFxEY51YxWKjQ6jlZb0H2a
 E6xHjfTpCBmrN7pY39QahDSVCfaSmu3RdWh8vgbVwP6N8dk/oXDvyN2c+Chgplx5lGKSl4u/8NK
 UAEjJLthjWzaiwrflthFE90+yAzeyOlYkmjxtLZsRQ+1gvvP/eJ8Fo3sg9IbBsmzVi0/IY+9D7E
 0gsIDqPXcDW7NLi4zd7mMzjYwjRC19pxtBayozz9LdYBEQAZVOAD7VWxE23/MGfPnc+yAvwhH1B
 G+j6hLkR0JHtVhWRNe/9bBM/yA8CNFnZZDh6gNqSe+aCO3jLsZKbxyyH2x9GsQV0/8IPgTofkv4
 CufgdGuowpaX3Mq77Qw==
X-Authority-Analysis: v=2.4 cv=NYfWEWD4 c=1 sm=1 tr=0 ts=6a1f5832 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=IFdraIdqUsMg42QbtkkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: b7UQv3YTTKcLjXFayUVpC5-VZ2pYXZ6v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020217

Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
an optional OPP-table.

Add OPP-table for ICE UFS and ICE eMMC device nodes for Kodiak
platform.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index ecf4790f3415c46781c8e790d7892a41300ee7a0..cd76da7e49d8c664df6a60b5c18418c4e97a3ba4 100644
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
+					required-opps = <&rpmhpd_opp_svs_l1>;
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

