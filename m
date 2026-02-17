Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585CB2882D6
	for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 05:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771305942; cv=none; b=lhlmuorRwkKVRENY9X0+ntynWVPEK0WXodsNsA/wuEIJ/gPx0TqByidqY+jGRtVXslnv4XiUccWAOH1ZTFABjQ2SECCrzWwLUOmYsfeejKRmBXUKLUNfHHdm5t6urhrxMOgwPVgsMpccf+mCzyzD4HoeFjkPs521hkxV0wPkjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771305942; c=relaxed/simple;
	bh=8ebMs7i13WqPF0zC4w+oVAIdgnjTx2rCxck2UIJoxuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=skbU1Hg52QvJz8XkgLt5NukQs68ve5rp1nRHnLm9wyoLFVfftHeDZ2p+Uc8YjlJ/R0hwBuJnRSOAXsod/8VI63ZdDFKJcoVIMm9rbQxgoo6zpTJ2RcrbS2Ym+LtK8yCaeStjT/1u8sm4Fy9vBVtyRcxFVwvaout4wvC5CCeYKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EJ/YsHSH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A1yxBOPi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EJ/YsHSH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A1yxBOPi"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H54dVm2111841
	for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 05:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=prNokE296Cy
	f7UgIGcapomuvXdqfCedaVm3IT2o8IjI=; b=EJ/YsHSHpkZ0c0FOmJlPVWDIQFf
	LJvBzW7eEv48Ba3mD5rQ63ndipmShdjClfZ8NwiwEQzbqMWcWwMXBi11Gh7hjseu
	IsLxCm1z1G9Q48LqimN7jfWl77Cpkc2mgyUOsJ0/RQx3jThyshDnIlfBgff21zLD
	wDVhGD+YSEUnaTXKTAkGu4lL0THeSnG8Tij4QxUhZLLAXhd2eqO5FB7+z8LQjFn5
	7X4AsWflv5C6DT0M0jPLqavsewLwvNqiylxetTvKufWBUUcTcbPvjBqzgth/wpwv
	awqOUHnuU+PuWkPCmachjYfllAGkP2YZRIGE0cIKgw0Rk62noEQnPfdMCFA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cchv4g15r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 05:25:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3562bdba6f7so17990946a91.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 21:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771305940; x=1771910740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prNokE296Cyf7UgIGcapomuvXdqfCedaVm3IT2o8IjI=;
        b=A1yxBOPi4QPt6E3ph77Tm3nwwz5qk1GAOC1WNM7xUNTvZKbtkEXKa0HP0/EWMGzM4n
         PBC1VLyVYcbbiqYuvNYSUs1MLooZ6dx/cIoXA42MQS/JF5ErC6AgRMH5fi3fp52kw5Gv
         ujPH2TRki4sn4eClUXVLZPUgP7GZCxyBRZ/X8J2BnWbxOuPAnGTE3Hnmdgb1X7acQMdo
         RguvYv9BZV5gdZJp8hOZTeCVY8VUOoVNapBA3CjPYgGPLO6UMc9z0UgwFZWEaLlwLqsf
         HehFPdZBxcCdue4zUBVa2Y4k/pTH6sJ+yOSLFHt9NoWN/AOCDCL/o1/BFXpqfNS7zYMT
         XHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771305940; x=1771910740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=prNokE296Cyf7UgIGcapomuvXdqfCedaVm3IT2o8IjI=;
        b=JbosujNSjZxwhhEql1D4VjGATL9eufWH0Xy0avfQOqubuif3TE4f5r7OejMMqHDcuR
         4uDHlgFlf6WfZwivVlGlrJvKcjrvldN0DKNt5kYGcV1IWJNrbhBROOVy8XEQSBoz2C1J
         b2DEJc1BQd1C1OmQPyhpcILAAD6cnavuRwh8Ui+KtR/L6MghYt6rL9cU2k/Syd/2Bbxp
         NuAz/Lfqhv6+2g2IA/jlYtD2wiEE+VagnT9U26NFc2gJYV0e7C9vzrwiph9SlvDIP0wP
         xmMJakXS1gnpWaCl/Vf/C5SbvWJwp5OuKIsQdrCkyUt8tpXkqFiRYegLIoqtPGj4XxQV
         PDCg==
X-Gm-Message-State: AOJu0YwtCDEwwx98JcPwQnsILZ4Ke3UDvg8TMY539E7jlLKtoE17alX9
	X6fY/2m7ZKKkH/iAbmR/XM3FI5ifkpmc9xli2qvCaJ0Dk/3TCfaoaTtj6Daez4v7PBpJPGt5O5V
	RuQlQWCYAWYVOxtrX125BI16RagKbsNYpQWjsaqE7WrO//lO82cCaizzz7xpv1cs=
X-Gm-Gg: AZuq6aKudFl+H3I76ekab5RWuEGMBJs5jt/IO6OkKyNKb5g2TDynnzn9xYR4LD/fThe
	ZF7Vz8vecsj4jm2a81GqlQcTRgR1g4+1OuW4QSs46Cd3GdTIuw6nn2m0zJnUkHpyTA5luDHHlCD
	CyPKIbd8nVsnKLY9R9JS/1OeagRNSX1RdihSt0j5i3H/NXBv4A4aNps/Gws2rppQRdDu+S6Bsx8
	Zaq8g6UY9O2TEyxRXRhpfdQmg/s02A90SzhXjD7owfmWqqlDLf8kkLRAS0h2led/dxM3uOF0AIb
	GwImFn2+zLS/y+2NMjGwGhLwa17Neh9oYuRB3VopMHJLPzpzTmrtrEtJ4ZfNcDg1bdPO8GZnWmJ
	izicJE883lnHMtUapeTIFXBcwcO16dfPDMW102yk28l7VscqGueQH
X-Received: by 2002:a17:90b:5384:b0:356:268e:ffa7 with SMTP id 98e67ed59e1d1-356a7660a64mr11950301a91.7.1771305939983;
        Mon, 16 Feb 2026 21:25:39 -0800 (PST)
X-Received: by 2002:a17:90b:5384:b0:356:268e:ffa7 with SMTP id 98e67ed59e1d1-356a7660a64mr11950282a91.7.1771305939552;
        Mon, 16 Feb 2026 21:25:39 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356a87f47f1sm6537685a91.8.2026.02.16.21.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 21:25:39 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v4 2/3] arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC
Date: Tue, 17 Feb 2026 10:55:25 +0530
Message-Id: <20260217052526.2335759-3-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217052526.2335759-1-neeraj.soni@oss.qualcomm.com>
References: <20260217052526.2335759-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eYAwvrEH c=1 sm=1 tr=0 ts=6993fbd4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=w5lGHQi5D-TRKhmXJ3sA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0MiBTYWx0ZWRfX04eDLaGYB5Hg
 kHDMTMArDUNUFU8S3l2f3uvavCzM4tMzRKfq039ssne6cutwN12Td5kJDQo3wkTn9BImF5uZ54o
 VDnoQ8p5COhNdCnbPyHMHhnuFgXc5SdqucY2ciYuQZD8wkWxyAh+0yFcG0uQjC8M5rvPDhPJbKx
 VOH8CenJUAjhZ6cSraeiGqtoVjzGYAWwQcx8buoD5sGg2KDEUnB1K5Ht2WgNJU5sjjHcnlSBrvN
 sKhkomjd29YrFAMAPvM7XzC462kBe+GhFOepmhq0IEoqJgCK8jXkXwcklGhblUaPyLRk783lln1
 zevD0MQXnm7RKOSUmFKpmavfwo4yNSU/7vo1cH+oPImaLZNgZt3Yi3wq+U4tHiC8vj9/vg2mir5
 0h5fzYXuRBbBFb/o16oCD09q70WbsG3avFtrhAobYi3UW3nz/BXuiNOaqnd5GxXncITsHyqe527
 G5nFnACjkqFtpUO3cuQ==
X-Proofpoint-GUID: PertaSysGAkz08C-1YNdSlqX_93tOTbw
X-Proofpoint-ORIG-GUID: PertaSysGAkz08C-1YNdSlqX_93tOTbw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170042

Add an ICE node to kodiak SoC description and enable it by adding a
phandle to the SDHC node.

Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index c2ccbb67f800..de01a6669522 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -1045,6 +1045,8 @@ sdhc_1: mmc@7c4000 {
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
 
+			qcom,ice = <&sdhc_ice>;
+
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
 			mmc-hs400-1_8v;
@@ -1071,6 +1073,13 @@ opp-384000000 {
 			};
 		};
 
+		sdhc_ice: crypto@7c8000 {
+			compatible = "qcom,sc7280-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x007c8000 0x0 0x18000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>;
+		};
+
 		gpi_dma0: dma-controller@900000 {
 			#dma-cells = <3>;
 			compatible = "qcom,sc7280-gpi-dma", "qcom,sm6350-gpi-dma";
-- 
2.34.1

