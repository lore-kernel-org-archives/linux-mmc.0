Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523186;
	b=4a6WyO2vViLumEkbSd9gkGOgy3apxOEjb4CQw5L6w8xPhxpic6gpieVT8B62W9+y9XM1
	 uMNDIZ6dBIrTMTDjyj45gm8DCCzPOdYGV4b98wTzPz37F4QeT7C95hkdV8rxJVNxcn1jz
	 KhrHYoXtWnl5LXqV2b+TttDavQNP9Pj8heUJkPIZf7q2JB5ZWMQBmPtKiL+E5a6LfrXqx
	 vanhnZ2G+Hn5cL4YZ7rqKmOU4dOymQB3wEXBJtE8Ub+yEkWg8VInYH8zjBxGG7jyefcJ4
	 VEmvofKV18RKB3wFsXyEci4OGw6qQwMKOUdAjTyibntv0kwwupU4dzM3Yljodxy8QKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523186;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=L2FQwINb04s7mJ3OBtOg2oqHSpYWCSQGkL/MPOtCiMo=;
	b=AdVCNxd2wqaI4FR865oFw8Lm4ZMzjE7kHEwKO0e7hFwS96OizuFCCSratZXBCDudbuYm
	 F9bxSOfaOCkZbtGIBgr/rl64XFw/3pddrLRc/zKUBkpEX2YbhbcwQuqjOQ1cC+qqAD32H
	 Jpogpyr1h2GNHL0FUTXN90N985mZGX0I3Fh7uB1JRgqT6/K45cKOmzFs+pQzFBMa4r29y
	 PgGtRIvVarog6/U36unEnBE8xtL5G5F2UwvIjhy9tqeiv1ZIS1xxtgSRJW+6SK2tgUTDv
	 hhhDoSpXNFm9KgZJhQC/jV3RrXW/SHMV62AaXbdwpKjtRKxsDWJRefmRzmuCVX0VrTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q3xZNhkB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dwzFUtuJ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E91606A89D
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 22:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1E91606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q3xZNhkB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dwzFUtuJ
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACJZmGx1183522
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 22:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L2FQwINb04s7mJ3OBtOg2oqHSpYWCSQGkL/MPOtCiMo=; b=Q3xZNhkBWFe1lWE4
	AeuH8BITv502qgQA/TRAo211X9vwsHk+KQQlAR14tBWzdyvAQPKufqKCH90hoe/S
	b/wTZ01ZFma0DSVxlG7EFUhW2NCf6x2I+IL8c1N4leJhK9YWc6opA2O53L/+nDtD
	zX5XHeB1lhiF7COt3FtfX4JJZO1EudxCiIQDj0aBz/TcJUxmqXkPS/G3Aavvy5vO
	/u552aoPrquOBEAIYJ6a4rKMDpvq67mYgVxTPuJOOkj5mn5+VK23ULSU6njl/ZZH
	0GSuQj6pjXgjDBjMWdXnHo2rrkA56S2hkvCjhCANCACcX4l3Gl7mIpCLT2PofdFu
	C0m9tQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yukp35-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 22:39:45 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b3b45597c7so533310c88.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 14:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794523185; x=1795127985; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L2FQwINb04s7mJ3OBtOg2oqHSpYWCSQGkL/MPOtCiMo=;
        b=dwzFUtuJ7ekdHlCB0W6m4FY+Tv/N3J/oXG1qgwuVTWz72d7htWNEnPF/UU0HqI/KNt
         enO0kjufy1EFhnVarx1pOl46rHvcJJkiMlLyAWF33O2oEWoHZddiXIcfIO0fizVBzPkZ
         HOAHB076y8it1Td+OsGscVrarLk4l8yyMMDPuLgR3SE3u+ov0qmvLElgrixDBjQMZjiU
         EE05vYEVeFFB89vEuRxcZo3Yh9Xo9QgC8eeLEb8NS+UPOW5fmosNOsWhEsNmuE/+/rJE
         G+jVJ2lvqkTq70CkpdJazFS6X7PpmViHMDj0wkSKV/kBr/tQNPDeS2C6SdlN8sW/Df+n
         uydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523185; x=1795127985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2FQwINb04s7mJ3OBtOg2oqHSpYWCSQGkL/MPOtCiMo=;
        b=OYnwyAv8VTxxSGi5oN7PfaI5kKopjatWXatVMTqOnLwV6uZjBpERl6O8mA1TbCFAOU
         jsDQMHBQ4BKhkjxt3RpYA4LCd9fsDT2vNz9rKF56xx799Ho2q14kTJAGUnqC9xMph7dq
         TqOhW69xnYWAqrWwssCYhz862sThXAogo1RIja4SU49ySwkYy88S8AL36R5Sb0LvU2rT
         q5TaScj2wbC6Tn4AbYD7CyXkA2G5UIs+/MpEsHUMHAsEiifBS/x253JAQFQ57zD4L5rW
         SNcJ6OllSbS20UDNJ+NZdTwiFwJlcM6UPQyD7gehWoBeAGukkCg7Z0keP410MBYocHzA
         yvAQ==
X-Forwarded-Encrypted: i=1; AL+hErE0BmeBCIgHjH4XfwLZLiVeA9KR+n5Cf8ilIbhnXYocjuQKFGGvAwgO8RbSmtvs0YxWBzihYivfODo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8q5BZA9Dl0lhhoBFOcAtELPnVpNWwKp+C1KnKS33wJrWy30qCC
	toEIhBWM9WdaOmYUCaLAYb0Wn5Oqfc+hJRwUWGZSkzHeBzQZYbdsE49BlEl87Wn/du0dYQNz00y
	+RdBjk59WNB5ipwFUToM7qjlxDPKMLOjfeVMtbK+Cf2zEKb5qG7p76d78dKLVWgk=
X-Gm-Gg: AYBFou3K/YpkuySh/Smw+0D64AoYM6jJTbVnIYCE7DbOSxWXvOf0kS/GjhKpslLCQoB
	2sAGbA8bDUrtzs9pix4tYWLhvsuZd40rzSfXXGKfdtGiEQwBKQ/gnZakGrMsrFS7rjBvW097zOY
	9HNG39UKsOCTSm7+m1RX8W7a8EFTbtoAP4K/Xea+Gw4imoYm1dZzwK/YVecOMxPifgyzKNlBXoc
	AdosUGXRTdQCSQ1BO4JRwzl7CliCmmjPAkTA5h5DOMhaERLIZmeGwnFf6S87tF2ln1HOH/Vpw69
	jJBtN9HC/q87kD+yma65/mBxY0TckwR6g8yhOTUf5cJaiWdh06XUHhEau7lWxxobJObJz57NYTq
	QpiOgDAY1unR2yE5hSPom5OGe/NPE5aTRNzBWQ4xccdogMRCWESQcAq2XMkDxWdn0XUA0A+GuRw
	0saGhKjib/TQ==
X-Received: by 2002:a05:7022:f503:b0:166:b307:5855 with SMTP id a92af1059eb24-1b502fe3953mr895762c88.0.1794523184497;
        Thu, 12 Nov 2026 14:39:44 -0800 (PST)
X-Received: by 2002:a05:7022:f503:b0:166:b307:5855 with SMTP id a92af1059eb24-1b502fe3953mr895736c88.0.1794523183996;
        Thu, 12 Nov 2026 14:39:43 -0800 (PST)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm2333496c88.5.2026.11.12.14.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:39:43 -0800 (PST)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 04:08:31 +0530
Subject: [PATCH v13 5/6] arm64: dts: qcom: monaco: Add OPP-table for ICE
 UFS and ICE SDHC nodes
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-enable-ice-clock-scaling-v13-5-258dc817bd63@oss.qualcomm.com>
References: <20261113-enable-ice-clock-scaling-v13-0-258dc817bd63@oss.qualcomm.com>
In-Reply-To: <20261113-enable-ice-clock-scaling-v13-0-258dc817bd63@oss.qualcomm.com>
To: Abel Vesa <abelvesa@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: bnB1M8Ky-Q0QRL_QI8hAyRWyLjmr3Ug5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA5MCBTYWx0ZWRfX1ZR/kOtrO0Oj
 FK/GNtpkje+SKuSplFPa+254WQL8Z/iFxI8/gA4E8t8sQ8/lTnJ9FJXARvTt+UL5f1KvjqOOmls
 SWfus2Ge36CKqRQMAHxIVB7NGu5YiwU=
X-Proofpoint-ORIG-GUID: bnB1M8Ky-Q0QRL_QI8hAyRWyLjmr3Ug5
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af64031 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=IFdraIdqUsMg42QbtkkA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA5MCBTYWx0ZWRfXzTM6vEy4+xY9
 IQn+HBUqZJJUc1Wl0Et/nHw0+8aD5bN9k9kbPiMQKzoQgPROEAc9h2ykWDBaTNc7ZLMClTg7iJ/
 jjeMeV/uS04gwKSX4EBHorXqdYXQPOEAj+NM8vyV0ivNd1qXECtOi10Sy+NyYClTdilnMtAMArz
 qznd/UcQEWxw2gX3kwVMhlwr4d2PzAJ9Grx+R7ewoNFNfJwrh/N+w+xlhmBKz/pt93YGLC5XXvi
 Jv7l+GvARKsOJNrviFiQ2VzzWqnHtzITtpIX7bJ40aDaDIDsd27QoqKkNqcpN19o0EpYAheo1lL
 2BlV759BJGBN+ojgMvcLDxtlxIxYTVKyHJDBW5n+iqbHQRJpPqe6TiQNNnzOpuX344jXiNW1WSt
 k9FvYSx6iKnt3CaVeDqH1f3yyvkVuC46v6+Hi/SW5HQvoYkQZZLWetLuFbYS507R3XSngjnTZeq
 mY5ml89f+7hVkY11QTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120090

Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
an optional OPP-table.

Add OPP-table for ICE UFS and ICE SDHC device nodes for Monaco
platform.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 3541313a79bf47fe27499f6dc370cb778d780a08..d7e2038854b0bdcc91d65d5712290c690e772258 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -2725,6 +2725,27 @@ ice: crypto@1d88000 {
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
@@ -4890,6 +4911,22 @@ sdhc_ice: crypto@87c8000 {
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

