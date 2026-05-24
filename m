Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03133A70A
	for <linux-mmc@vger.kernel.org>; Sun, 24 May 2026 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650785; cv=none; b=bd8ahl20OPrM0r09wwtS8T16MrEts5zoKtqifJ+RxZSadOlQ54CK3IusNCgoqR1KAwKP9oJhWco//Os8weCWIf1qGkl8lTE3ZAXCVvdGUV+0FWcAXkBZyQ1oPxrGRyJ/vgbfzZu32h2cxs/zH4Rvgdjwgp/PNHnCU26Ws7kyznA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650785; c=relaxed/simple;
	bh=/x7fhiqRUVFf6KsQ4pl3FTJpHo09DykPuFw1fEIj6wA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+Ab7Wl07QME3thGqOtu4xaHOdrlN93Pwtr/6burT+M3dNAHaom8eXQrWn+iy0vO/4lu6/iUatsUATuhDpOHXKTq2GOz/7je9sycJbRoUVtzBUfFkjhFIwxOB3jKYQqqvFBB9WPlUD43Cx7uKzK1FBbyhcA8Sh2CYOtZR8Pq2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MGYNI2A1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TfxD+KY9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MGYNI2A1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TfxD+KY9"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64NML4iO1948381
	for <linux-mmc@vger.kernel.org>; Sun, 24 May 2026 19:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DMOlm7hNmzx6629XwqNAUJiu1R6QF7UImrBpTqYLhBg=; b=MGYNI2A186PM3f/i
	SiuXuk9wLr00ADqXwwfM01E5ZuvFtZnjJwt0V4v4ezjfoAMEn7qADTwbAVnQjp+N
	K19wQBw26/q7217xCZZqhuD9/SyPq8lC9KKYxKDC3jOIFK59gfdZwIpcpsJOqroF
	AnugYWU1pGi0GWD5J3dYABndPKdqdeTgKaylppCIC3J64u/1umXuTByT86hBQLBW
	TkYaMpatmtjl5vkpfNGbH1wQCDWaoZo9QnPcf2xpnPrM0NJpaJmaBFdiBk8hc7vs
	GEHp5knbhHnA1VTbB2E88Jgepd1iB32WayYKqfyFQ1uFM+B6g/kiSAg/y1AP70hz
	6kV41g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb5h9kq3e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 24 May 2026 19:26:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2baf7748d0aso88546795ad.1
        for <linux-mmc@vger.kernel.org>; Sun, 24 May 2026 12:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779650783; x=1780255583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMOlm7hNmzx6629XwqNAUJiu1R6QF7UImrBpTqYLhBg=;
        b=TfxD+KY9p+VMlBCQ7eGdbTsI8o+Cmm7jYubK99DoHIZgFI8xDpdhu4Kn0wsqpsri5n
         JmHiu6FSLwCsJwaULML0jMsU/SBmVeJfdWibPugwExK+ed8NhRJL2tMxfLYPtTfDVMkx
         MvdWKVvgYhnWuqNBJ4ngSR5pKe5gZCy/LtVcnpKD4GV4Kx4gfB7XXYTWdLJ0h9PVXLi5
         yCCCpfkH2Nsl/hbqQZYYy15HbZRzyRnipREIrFKhALNvADn5EoFHmOLiAEv9fkwPaHiO
         mPuRs3vCMOWPtnrHdlhmSbuEmguScRKXFGb8+A2jkYT5I9rCcTlu+ytZkO1X6cjqBWVj
         EviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650783; x=1780255583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DMOlm7hNmzx6629XwqNAUJiu1R6QF7UImrBpTqYLhBg=;
        b=YSTeL1FAJOSq0lCItPeFr+IaApNqLgB7iYn33ySOyiVqxYSd0ppK6sNQ3tPv3YvcoD
         rBXFK7ZyhztOvJKdHCigotJ4a8h40J18tRr+VPdjchoOhHfnnUM4251CmS02czd/XmOM
         85CepC4EL6i+Q8A3qpKX60kmuURPuv6ThRNz0BiO4nxyzK8l4d3hhCoth/fONr3ao9NN
         0VFhAKGe7U5ltS8QERlHEAJj0LzGBrb+2WGtviSfwzTwxwFWuBHKMOTKqaJwXlBaFFTy
         xck//6lBPhoX8Q7WWdxetfeBF9Evwafr9s7pNQXhICVbkbk7xPWZDK82J3Ey3h6/LFLj
         VSug==
X-Forwarded-Encrypted: i=1; AFNElJ/6Qbp8/c40oJ4PvG9JscrCmwKTnfwrjmDP1LAJ4/tFHs84YOuL61m2vuaF0qKvP2k7p3JyJrF25js=@vger.kernel.org
X-Gm-Message-State: AOJu0YycVY216Qjddg6i3U7ZtofEEqKMxn8jrq7aP2M7zYIUQEEIwlIs
	yA/ZdT/V7HFva32+WHJismE3ruy+dYJASwBqu/KciT/NkubN8cfA3Z//C7Tmar1R0MmP6Rgaejz
	c53EILHyjejCraG64IMJceNAhIl1VyFlc4PdLWLECph3NMbluuofBMEgXGTjdJg8=
X-Gm-Gg: Acq92OF+IdabVplOeEA34onNPZA7MjkvdufEtARiPiQiX1lwBf3rErQQuuCAuMAdB4e
	2Vi0ISLb3j4ecw3/MG368a396/Vm1vf2yIIVKs7V1iUvmk9LjK2V0zRs163iUH0xmPLJXgQDjML
	U0E1r/BjDRHo9jOIWwAJMJ+wqwFqdH5gnJf292cd/Wsn55zPpkZDeLaJTSDTkMEhN5hqLFZhF60
	OWblcbeWCJ0XG7rBK7DnijB27goDORaIwmUEkL9JQb2H8kZhaztlsXMqXpScHn2rGWCNFwXg4Pw
	gtdDBnbvYateL6GKWb4P6mwpYmnp8AIIhmV4LHj4S1NTVJYBtUStKECJfGFd3fVnTWrDsFWmVv1
	C561XpLZwIwjFM+sHw9Ff+97U1vJCcAJQBblprUjVusG7JVMHlRjoo2+v944+dsaDqoRlNQ==
X-Received: by 2002:a17:903:1b70:b0:2bc:cf06:6835 with SMTP id d9443c01a7336-2beb0346047mr123255475ad.8.1779650783066;
        Sun, 24 May 2026 12:26:23 -0700 (PDT)
X-Received: by 2002:a17:903:1b70:b0:2bc:cf06:6835 with SMTP id d9443c01a7336-2beb0346047mr123255045ad.8.1779650782559;
        Sun, 24 May 2026 12:26:22 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56ce2cdsm75329945ad.29.2026.05.24.12.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:22 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Mon, 25 May 2026 00:55:51 +0530
Subject: [PATCH v9 4/5] arm64: dts: qcom: kodiak: Add OPP-table for ICE UFS
 and ICE eMMC nodes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-enable-ice-clock-scaling-v9-4-c84613e9ce47@oss.qualcomm.com>
References: <20260525-enable-ice-clock-scaling-v9-0-c84613e9ce47@oss.qualcomm.com>
In-Reply-To: <20260525-enable-ice-clock-scaling-v9-0-c84613e9ce47@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 5Cwzlty7ryb00Sf5Y5aekiCdIhNJJ16b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5NCBTYWx0ZWRfX1zKowjZ2Qnin
 FreX/ty1HdrOiA6dzMVSm+dr4lhTs1iKMAPdt9tMajwkBo1dhHDNdjrIAYa0WH/gx1nftqoKw3k
 A6hifaz2yeqSdFu1d2GR4OiFP9r3XJQNQi3DMRDN+roii70evC5w9B8Kn/1RyMAmvJNkm/LM/K5
 aU5BA1OPGru0HoUdVBiK3P3LY/Gw0G1aOG45Vzwipl7ZS/m2ZWTNRA/NgGG29dn2MujRY5CtesD
 XG6Rg/9THRF7FimwAxytrSgou7+f8JqGvfXldjjYels1uEX8KgZVQP3BVPDAEsNvdzXh2fnjkfA
 cymyZCqj6nr4QkQyxyF/X/PPFYh/nSWlk6vPbd3BBvwh+tXzSZqhQ0g3DK8WtTOn2rX9YIQjVGC
 Sg3kh6P1iOUw8wmzLKvOJ34xqLxGA8RY6LnY2Ai2CSkvo+YoebtzroS/4Izv6ySARdDgq/xoTkL
 0U2cBsyM8KW6sEQjSNg==
X-Authority-Analysis: v=2.4 cv=H7jrBeYi c=1 sm=1 tr=0 ts=6a1350df cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=IFdraIdqUsMg42QbtkkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 5Cwzlty7ryb00Sf5Y5aekiCdIhNJJ16b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240194

Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
an optional OPP-table.

Add OPP-table for ICE UFS and ICE eMMC device nodes for Kodiak
platform.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index a8260f695058525e77653fd8005fd3d250715a91..8a8328c5dfa88b69594fca926f4f7c1825416259 100644
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

