Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523179;
	b=2dQNaP/pODRkMRtoOtw5CEdINak18v6AlxdeecNgJ57xkepZPytPmKCe/euldb/Q/kGu
	 1nxZasXGgV7ur5u4CBwnDst855IvVGjHDxdTyx9j9L1RLwP6EJyS1e4xjd8sCYdcevmB7
	 EZELumcg8iNQwNW3BNGRbOI3zKVKZVDApgQQS7ZSh/aLWI/Zw6u+OB35CfRVWR5gdr1Yc
	 bxOgcD3DChxJvEBrvKiJj3PJgNUCW1g2lu9jUVlwWwDYLnrw6HuP+MSYL3jMcCceVSaWS
	 1c8Ag1KBAhmpA169HbvnRA0aU8Y+rGRlhaZ0F7zAWmj4g8JMn4AbLMEtvd+tt5w8hKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523179;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=h5d7qQ1TmiafTLELdwxVa2K3qpo7e3rfmt0oQazEA1I=;
	b=Jc3y6iSBFbTiyHteXNTTIkMjFTB83HwegX7VQq241TOiL6F+3ROsbqwAvJh+4wxXZClA
	 GnkcF/jsL+KVtNHzdlUetNZq7Sgzm3EUq7Ukbcj02VfxdlrZIDMLxm7lV6m2AtfAC9G2q
	 fPNCP7rUlO235ZD3kFv2V2o+UgBgl3yFy9PYoLgkZXT0bZoUHF9mrv4cWFE/zq+V2dSPL
	 1vaoqahEuM6M3XlqrEP01HF+6WNHGq4Hu35KDgXIncg7sKlcnxfVzuGcEDDVvKZ69okSP
	 8XeXKKexThx/fB6xyvOBhnmpDjMggQU0SN6bmntmOMbmlEiQkNC4GPELSb7wRxx2Nzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PffptluP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FeJVhMhO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E64060A2624
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 22:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E64060A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PffptluP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FeJVhMhO
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACJZm2m1183515
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 22:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h5d7qQ1TmiafTLELdwxVa2K3qpo7e3rfmt0oQazEA1I=; b=PffptluPAo9AWFlH
	b6SXJuXvj4CNYdzrEcMKlMqjIGmfFAw7foySfT9Ag/2KpLeCba1+0DawoDpHTet/
	73jnUhT5yV+GliUh3/VuOF5hAa4cus18hUMidkNVdBA8XY3KvosqC9SIzaJzcRKh
	yjbvZBJvfvbLJBA/n6rG/sDuFoUufFwb+te7wO2ngClA95Jk/OQgtKjnrn5H0/yg
	XTtxdmtxb6DFy0nPlmmCmPMbsw0em7LuZcdq82epzuuMJSWB3mXTWToMe3c0kCPk
	Bhwkm8+QdgpVkcNYwvvx1kqHLq/wwlAENMop6WV6iI2gPMBG4a/+DS+BZHOKTScv
	YfpPnA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yukp2u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 22:39:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3425098ae4bso983564eec.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 14:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794523178; x=1795127978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h5d7qQ1TmiafTLELdwxVa2K3qpo7e3rfmt0oQazEA1I=;
        b=FeJVhMhO1ZG9zVHEigvHJWvYBBrEQHXGoocJNJSCtxDoD6UxFFMkxlupoBaqbA+M4V
         o8RmQQyw6QkQKGovol+mM7LYC5u0sDQTnVGFzKHx7n6eccYUIIvLAi9/7igSEqwhHXmh
         ZSFFyhTsuHet4QGuEsgffBo5vWNeR+5gCJC+d593K8b4jJyg263NniFo5585dgY8n/1y
         RaRZPCYNLEvC+uOeyK8fWOqOgiNclpLf0x93LpwKWsdbvMo7Vo+GGNOY4jZ/hJIbroZ8
         R67DBYj26P+C86ChVIXXAwVMPGFfYxzcbTuO8acVjwf0Y7uMvRIlvtCPO5UOHmaBkCxM
         8WHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523178; x=1795127978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h5d7qQ1TmiafTLELdwxVa2K3qpo7e3rfmt0oQazEA1I=;
        b=Nk+GVerwgu5iy3QtC8uq9aLcCFC4vyMYqVQ0VoyuHHV0BtV1rDU/745w2+AnT0SFye
         pnRqiRS5z78+rD/+tz++DcYfjKqKEE7WbjTqzjw87nONfgXYstTL8hLwTb1bhdaa91C/
         OQOR4LOo4q6OpopF+e4yUpptI6eH/6WJP77nC08jbW92DL1pRHFtgyvyoRjArlOLjypo
         HWf2Uf8m4/QI99otGouHJEXaTV2nAocUIDX2BOfQ7V1176xa24ASg89wK9r48cBK1Son
         Y2dmel9Cez/1TzwC+2i7dWXcn4VPZJC3AuWhYbDeJAnzmVg7xXogRywFP+098qPJA9Jm
         mY1w==
X-Forwarded-Encrypted: i=1; AL+hErE7GGapRCudTq6pckOkoX/+TkgQabh4Ds4G696V41fjus7RZMzYbkm6lV5jCUyvuWY8RIU4jInswTE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9si5VVVwm05LJVyzyKSipwB7lRGyAqTpsu5bAJqDwC0X9Nam6U
	vVye6M9nKCBPmOQhzbEU1wOpjXHXiQddPa6lF+WIqgNbhNpDqNqpDeCwuQBSq7FMKyz4AcHJLz6
	4K3B5ktxyFbyQmlBCG2uei65hMjaLVhix16v/EzMwhzzvAWfVHU9khsQsJtdsLmUtujwXX78=
X-Gm-Gg: AYBFou2ipkmCCiig3JWPzXXWOZeF6lTN0j2xsBHgIIysFlAudFYEPELWXqG7C79pKlK
	e4WG9rgmhjZUl11XuDDWj7PlHUVeBwrGG6p+FGEqVzLhqk2EggLi5KLtotmSH7OP2p5Bl8HAmoZ
	euihgxZc10nW8gwoCdiMBOJuyUET/R9UkHL4CinWebK/DeCaoI6vhR5Kl2mBizwMlArSQiFv8tn
	V0Qijla4yRbFidIJDt7FbDWlVcAQ9J/pUIBRB9dvDSquUS+munbPwfdIeN8/n4YHVyIZRQV4LdS
	zW14r/haP8CK7laQkY+cGZTaZXH/2+xUZNVfRcP5QvDm1qhzZx0kR6UZIPhysvgIC+8gVJF8T+g
	bxQTn4PJuhki6veAFR/mL2CBzVZU8ruThgcsDfZjn9sgFMDFb+rd5efUME+JvaL6AiAJ5Btfob5
	qbeuFWNAU8dQ==
X-Received: by 2002:a05:701b:2402:b0:1b2:6d4d:9d8a with SMTP id a92af1059eb24-1b4f5ea832dmr2727966c88.2.1794523178052;
        Thu, 12 Nov 2026 14:39:38 -0800 (PST)
X-Received: by 2002:a05:701b:2402:b0:1b2:6d4d:9d8a with SMTP id a92af1059eb24-1b4f5ea832dmr2727934c88.2.1794523177498;
        Thu, 12 Nov 2026 14:39:37 -0800 (PST)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm2333496c88.5.2026.11.12.14.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:39:37 -0800 (PST)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 04:08:30 +0530
Subject: [PATCH v13 4/6] arm64: dts: qcom: kodiak: Add OPP-table for ICE
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
Message-Id: <20261113-enable-ice-clock-scaling-v13-4-258dc817bd63@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: kO-5Mqw7eKAl7nd4epFdfvejS4x-9mUh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA5MCBTYWx0ZWRfX9J9Gm/+t/Ja2
 LmdhUymaR5q4WeyKlVBaxz6SipY6n2l4VzZsOElkS6l/kJeImISgr31JZCxcGRYIHH1flcYAsQM
 qLbsEtqdhHRqfEqGhhtimG8g0Z7Y0dk=
X-Proofpoint-ORIG-GUID: kO-5Mqw7eKAl7nd4epFdfvejS4x-9mUh
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af6402a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Gfx0KCctoiflwLzBlNcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA5MCBTYWx0ZWRfX5plQE7dWhR9y
 oGIwEHHhUIlicWSJSParsd97jvJp598IaKkBOXECqO8GHQ4Kvrs0JrJh3dOSFm+hfl6INPtltGl
 n08VbRerY5sAIgIP90p1VN55WoD99LgufroIjSEvXul5DQwqQB4U3PxEeRBheRNTcEm7EmOogVy
 6+xIvm/g5mCbL36aFSOuXJT/700LujWpiWOo/3EKl1mtnidjG5NeNdhl+aD0r1GT+UzhX9gy454
 agSlOaj4PmsFrtkM7+7Woe+7bUZFercMXDFZNu0kaJBS/LKbuwP3osoJv9JWrwNAzFxvuyHCtqx
 HqLAcdNS5bSoAVHN310oDzAe8hwYkZ1HjRA/Wrf5CJuQyc7PdKV52Vhs3k6bqqQxS4p5EqtyTlQ
 5t0JBGqVJc0MGkWTiKl91AlarztsVd2tcCstNM0cCQGK52bDx2cCJmyU1RIzHc+i46QnEdJLvHQ
 up+ZXbUNy+bFbbv6TZA==
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

Add OPP-table for ICE UFS and ICE SDHC device nodes for Kodiak
platform.

Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 10e9a5279ed60cea1514097354b8f0f59ffca2fc..397764d78dba579fe95654deb7b01ae3b1735f89 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -1100,6 +1100,27 @@ sdhc_ice: crypto@7c8000 {
 			clock-names = "core",
 				      "iface";
 			power-domains = <&rpmhpd SC7280_CX>;
+
+			operating-points-v2 = <&sdhc_ice_opp_table>;
+
+			sdhc_ice_opp_table: opp-table {
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
@@ -2608,6 +2629,27 @@ ice: crypto@1d88000 {
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

