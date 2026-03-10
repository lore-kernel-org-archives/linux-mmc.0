Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622136DA17
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142573; cv=none; b=Rk1UEdPIDIZn5AvgGiW90Km5yLUe9KnBxhl8yye9uQG1fT2AhVJec8fA0mEuxo8znr+rvVrLT2EKZ/HajI4y+lHCXODN62hg5V8heTRRKomYGLxJ1Xu+PGn/Uh+Gn/5XM37y4m2CS1UfBEz3oJD6mGLE/bcnOKfIT5TEyIV0KeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142573; c=relaxed/simple;
	bh=8ebMs7i13WqPF0zC4w+oVAIdgnjTx2rCxck2UIJoxuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RbHL/PbcRKR1OJZ0XRgiAGAIYLAEQAuUqirxrMDM3g8qLUdjTBKI9PgYZjAuRiqNoDzLHFMLJe2YAgPNCmNVpC17Pku/fJbtSjeq9TrXqZaBQO0KH7YXy6c4WRZE+lgaBaM8annCbMPDbn/HGA09qyxQQM4ZbRVwKpoQ2zNg57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Decthg3V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BkcNjDIb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Decthg3V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BkcNjDIb"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A7wJcl3124459
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 11:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=prNokE296Cy
	f7UgIGcapomuvXdqfCedaVm3IT2o8IjI=; b=Decthg3VTvS4p/rnPJkdAkRXGKT
	hYKf6EHC2x2NfBlbF95h9huxB/SbRqIjeYeJMF5GC4H0us8Tae3Ea0N3k2IQLq+p
	cPdWWkmop17OcNOOfPx8VAaihV3KWnBtNPNEuLYpGw4lKIAL6KYdVBLjpduhFvwa
	nSEwP5l7fiQzImjSA+I/WpfC2EtxeOS1hX26i0+Pk7RRj8lo44XWaAzBIg22MGHQ
	Se7mfbtG/WAf5h0FKCpsS1PCcSdtAuxULm2rYFFYawX7UATMi++Xws0an6+K0Z6I
	UheYF+vmQvE6XNuNfWy0Ff5peFoFnM0/ppcefjTH1fzooAAVkbiEikxMzpw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctfcj0v0t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 11:36:11 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82992206d20so2756936b3a.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 04:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773142570; x=1773747370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prNokE296Cyf7UgIGcapomuvXdqfCedaVm3IT2o8IjI=;
        b=BkcNjDIbxUXQ8VxCWUKDUDclPxEYQC10yI3vbkar5zLAhYhuGmkzRE1IYvMi9FuNFx
         yzorpZpefo2W7DJUNMVqxzn9jWnX3FkzinbPfo+8L2gOiTC/6xDmVTHsfClCbRDwJJfu
         5uADi4BELSCBOHOd9+ALR5yzA9vK6T8iIkcJ3ncrUwVaMM8U50hVcZbIbBybyK17eN3Y
         A6jcBsJnSSVmhRa+96PvxG1VjdFBizuRMuesD0EbMq4yC2PJNOgl0RuS4kJ0oG9FHzzg
         9Lre4RSpfTAWgbwQB6MiFFxcws/BNMI71JHYa/MTXdWK81Ke4Ay8dNnqgy+hAafrVvM+
         2Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773142570; x=1773747370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=prNokE296Cyf7UgIGcapomuvXdqfCedaVm3IT2o8IjI=;
        b=JOOmU6JMub0Pt3Cl4JITrJLNcfPLjaFhLKIULVgy7U3Vt0LJq5oXU9w5Hf/9o55Smb
         vrKUVwCrwiSybc4DtzjAyjmEbAYGW8WXrC2pjy4mRZYdu5YuEwY3IKOdX7uJbgXmENtF
         s1om6SWcCS4hyNwCEwGB5Xk2kqCFjZXQRH+6bo1tkl1au/YPaNQOQKk7INRVm/1HgTQx
         6/ySh/vCleE3JGPkjaZu8AJ+PtGWQrZlJiChv+bkN9FG2Re6oY7QqEiaPPDhZ9dhpnhc
         +TwI3ScfBNI+kl26qO3a6mycvqnHhDzaav/ZfyVgiyWVU3lPFrEs1yeXXxXBVsG/ebaS
         39PQ==
X-Gm-Message-State: AOJu0YzUuOV01izqOeiIvEy8b6zMuaWFXKjlC3e1mfKDfVzopls1xTg0
	/Xh6+hXg7JBHot7wPl0Wr5qM7blQvu119DPhlYEItLV/xFDmkL7awJPh8I8U/w5UuSbciOVoV3S
	kKH9oioA7hcmPhBwR7RbR3bySakoebLRDqbfvk7sXUpTOXITj/sfFowjl+HiQ2u8=
X-Gm-Gg: ATEYQzxeLWqeXrLT6ddAOgOrNSTRqqktOXRh7fj0oOvGyTiQa79UkHgzZSwKmKuZXzS
	gFTgwS1CjyGo0MbLuUkE5jiSD4dbSesiS91HRVJsxoeX/5QzQZqK46+ysbd0Nz2lBLzKaUi6Z3A
	lcsjDDOGvd1JOyzhxGJAFhvrGW/xAz8n/PqU/j9mgYAtmDVwV2Y1n5wcuTY0XcBUr97JA8mWATu
	spVmHqC/IJkTCR50y2FIY4C8Dz6G86srvQFNqWYd3dyiywWN6t/sqKhlpLtz1Izvtpce87o7/aH
	vh4XTNLsAI9dOC0urJWQXbazUmtdeH+1EZezveN4FW5LR2equ876eV06Kj2vK/wAHiSgS9MgSAP
	M3oN0YZ9xxzlBDAO/dafRaKHyAMcplztKsa6L/D61c+tAxtP02aVm
X-Received: by 2002:a05:6a00:889:b0:824:afd8:5e91 with SMTP id d2e1a72fcca58-829a2dc16eemr13169816b3a.10.1773142570244;
        Tue, 10 Mar 2026 04:36:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:889:b0:824:afd8:5e91 with SMTP id d2e1a72fcca58-829a2dc16eemr13169782b3a.10.1773142569796;
        Tue, 10 Mar 2026 04:36:09 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4637bb1sm12364659b3a.10.2026.03.10.04.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 04:36:09 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v6 2/3] arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC
Date: Tue, 10 Mar 2026 17:05:56 +0530
Message-Id: <20260310113557.348502-3-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com>
References: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H7fWAuYi c=1 sm=1 tr=0 ts=69b0022b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=w5lGHQi5D-TRKhmXJ3sA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: YOH1j68YzcmA5gEn3UJRkTu2IKPDATnM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEwMCBTYWx0ZWRfX64zz5rzRSJRn
 jOZgVrk1iQtszfWSr4LfepkaPozrjh+SaX2XdC3ehjRjyFMUAAAbaXKVaTqwU8MREfqoa/eSFjO
 AYPsdTPX2J9GsMHmoO3hHEz1QYKqHNJvUIsZyZk0jyV/KhPajsjpatnHFhdRvKMrr/kIdleKUEU
 dW3CFFRu5w0pbIE2fXbGAI09S5Rd8u+L3j+RbfhKQ2N7nG75X7KmGfC3Xz4PVxeDK8PLHEWKUbn
 JWZv7inUy9SxA3vzurcJPftD3JOYoHMPVD7mfuJBlE/wMqlKmbCXQ2gTMOL8Sbh+b8pq3+NXGV/
 dry5TUUH4cDvjPqJlbYWPtkw0BEGEL2cDm1KZVJNMOCkTwGFCDIBoPaSnHPCSAcP+F9H8BX4Mih
 qzVtGDkO0IbFDHCBHwh2IGICaZlgCrBfZSvOqYcBCIFtK7FswbeT4sCPsC04kNVRohYdrc/bSx1
 tujGdF4USKEkas2YUEw==
X-Proofpoint-ORIG-GUID: YOH1j68YzcmA5gEn3UJRkTu2IKPDATnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100100

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

