Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9528F271443
	for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 05:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771305935; cv=none; b=q0y9AipcrnIXi5u24Bky1PCgSsKheevUFQoYRTEsB1MbKgKJkFYYejKdbfgcF6hLmGPZOoi9vnpVleiDW/9wi5cuLhJ6z4r+AetRPhRQLgpuPsliCupppe4Tq/Zjo6umpEOBW5VClvM0E9gqb4e4BRojNLKlmKZYzsw501LpQRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771305935; c=relaxed/simple;
	bh=4IUnM654Ar4fSWUu/NzKK40+sy6o/VU5RUmxIfrKHQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cQJLKowln6fdn3X5ouC7dhDrTp8VMw+wC2WXMM380hOstdQIApQfOfx+CCuiU9KEXKw3TD5RZajhxf6efs7PJdN3eEH6AdY/n2ZUK94FlZSRiLn9N/d5ZZCPFpuTA6fUumXgovYjN/6Tmd6pgwFJ22q2YazeooJAOw1Snbkc/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nP+0NvI+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aSL4Fg5s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nP+0NvI+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aSL4Fg5s"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GL7iDu125852
	for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 05:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=LYIcSfbMA1RittLgd3Rfimx4PDL61+MOKk5
	Kw+KK4GY=; b=nP+0NvI+71qihla3A77mg1akS8jEHn2RMxf09UQEXqxB7BDFd5t
	w/dIjc4G+wbQZbGnlQUMeta0guiX/ZnGyM1WQgLubOmTPhZ9J0ttpaETYO28Jx2S
	Iw0UcihKDfzi4YBNd6gQRiJ31qVYPMGomz2m+2erxpVKol8hH04y71TfPiy0msDL
	NXDVZd+cGuQmkTkc3z+GLbX/7ZgR09jl4cA195ysQPsnxT49vmGZ/RLXBVKV9WTr
	No14jILiNWmUo9vEqRQLRYFLc3/ezxNgbgN2+QtnYf3eTYvwN0eerAD4HV5CqMl5
	rXD1TIbreWQp1uz9wtnL2jaxSrjEgvO5uLg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cbyxujbyv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 05:25:33 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c6df833e1efso13229176a12.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 21:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771305932; x=1771910732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LYIcSfbMA1RittLgd3Rfimx4PDL61+MOKk5Kw+KK4GY=;
        b=aSL4Fg5sbErwuWCPrmYp0knVldiQC/QJruiBhhYOgnlNypnNQ1eaZwu9PI0iRPfPxl
         hvOATb3Gk79u5XS+VkZKanFSW3YjyBcXmnsv/a76kmVzfD/LALib6+b1nhayU0neEYvP
         4c7IaoAjM/idoK1j2fxdMTncURLWzNYSYLUGkNWUryaE/437bvuPssBQvKOp9y/Iulj0
         5dTmB9Ze0X2apsbFneppwrRf6cxSet7Je+vpCoYx6TyJuWSYVO8RSfSw+I1E/gGBv/tq
         Tc6a0ZPROOEyPAJEBJTpWN0Ex+g1LCK2CmLiwbttxXfWaCTdeC+jRYT9hj95pHa7Nn5K
         aYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771305932; x=1771910732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYIcSfbMA1RittLgd3Rfimx4PDL61+MOKk5Kw+KK4GY=;
        b=ctVEnP/YSf9zJCI0AEF0wZjbHLjCHYPBSXTcB6n6lfCqyvr6LraJc7Uwbt2IK+nEHP
         D782zOG73d0F9fuSvz5FpdPqqsjcz3nQkKvhffUAX2b+sJzOPgcJhkgQdTI4EHNmeLRi
         gwSpTWsYwoRbBBS8F5qYaUAxgewE1GOnsQTIjcuw6l/GtoIP+glo25GGRVz7qFmVZUCZ
         89d61Zj7ZIjK2zMvp0mk7dWZSiSWCxBZDLU1twAkSNLRQejrUq4ncFIzTR7MRZJ0z3ij
         iingDbV5ikpuXMIXns1Qf0zjpchwWTKmmVkoOaHm9OQDURT5O9NXQSj1Yy5olUgssLqe
         96Cg==
X-Gm-Message-State: AOJu0YxTXnUIP69g7vzpMM248XvQmtAkdKAH2cJrbxXe6QhpFEsfQty0
	o/X7kaHf4XcYES/tESyhDVt5hRfppE1AiRVcT2/4voJGzBN+HLkLntdY55j1MYD+Pd/MKrZlgsQ
	3tuHLspK2PMWxCrwvvsxE5PkajPlwbavLzq9w1HjsBk9N874uiJuTjbTz8bTxPX0=
X-Gm-Gg: AZuq6aKlwtfDAWQAWd9x47yoK/Z6cZE+k+EBqM77oBb/RBkZeaZ6ski+RUdHCvF+6YK
	y439RKPCg1jRknYxmUSHxWefeOTuNuENpG0feAZbEEOIsXo6VGTi6c1KaWrTj1saCJhNBEGi+nU
	XZCt817BDr3wYB1auA4vT/A564UzQeJyGlJhG3VfIr5q9L0vXLPhXtxAfSvoWgraqRH+5r2JmgI
	CFUtq0BqzPYsB7JOicCG88EYqW2RXg1sEly5NVR26gtPs+FUY4TCONUKfzLTGyUBHSNsuwYBriw
	PVMhl5a8RK9QsoJlEo/PY2qGD2m3ozK/FVFAp1LQcqfKqx1rTIqsPIU6ONI7mRBr26zW7FIC/lL
	vJlaToURp+Wd8CesbxnNxh56R+nROunERfhC6gsu7WPOzUoJpd82Q
X-Received: by 2002:a05:6a20:12c9:b0:393:625:ef20 with SMTP id adf61e73a8af0-39467116735mr12413761637.4.1771305932443;
        Mon, 16 Feb 2026 21:25:32 -0800 (PST)
X-Received: by 2002:a05:6a20:12c9:b0:393:625:ef20 with SMTP id adf61e73a8af0-39467116735mr12413739637.4.1771305931980;
        Mon, 16 Feb 2026 21:25:31 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356a87f47f1sm6537685a91.8.2026.02.16.21.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 21:25:31 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v4 0/3] Enable Inline crypto engine for kodiak and monaco
Date: Tue, 17 Feb 2026 10:55:23 +0530
Message-Id: <20260217052526.2335759-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BrirXaoBtFIfnDnvyMNRSjuIZOuQOuYL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0MiBTYWx0ZWRfX8Ofvj61SaBPi
 +15GYgUq5cCmcyzq/NoAtA+Z7/GGopzyWMitQ7m28g6VjgXexZutp/vC8oHsUPwXQ7bHlnRbc9U
 x1q+wC8t8NHi2sQbAy1VR9TxpXxYUvDM94bFxXkLT6kk0mhtxLe27ivTyaCtNPhCn/6NRbRySaw
 U9zmzeXUS6n18PU25jzinmUh/OiRf6an0v/EhqCIgdvL//YH+qosKrc3Bs5FiCkRK298n1j0jHG
 yEhAGNjGDEq/W24p8HiE3xWkNNtCcOEtLxzGq7AUcfgFl2YVSZQnW8/VnRy+7Ib2akXEnOrNqku
 e2RdQgFWuxb2OwxkxctaWLuFWncTqZksMylJ9v5qFjIl5fN9kHEXvbb2X2oub9AM8PppqZ/yr8Y
 oD+VYcicgJ/jr7Wdq2wIC+xxzxP+h/0lcu6awdnOtgYR1nKuXzVkzqA7y5XwDB3hCLUsBLVDSYq
 gcDjGT21U/XTZPY/V+Q==
X-Authority-Analysis: v=2.4 cv=BpuQAIX5 c=1 sm=1 tr=0 ts=6993fbcd cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=OaewepulewRRD3_FMPAA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: BrirXaoBtFIfnDnvyMNRSjuIZOuQOuYL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170042

Document Inline Crypto Engine (ICE) handle for SDHC and add its device-tree
node to enable it for kodiak and monaco.

How this patch was tested:
- export ARCH=arm64
- export CROSS_COMPILE=aarch64-linux-gnu-
- make menuconfig
- make defconifg
- make DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/sdhci-msm.yaml dt_binding_check
- make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CHECK_DTBS=y dtbs

---
Changes in v4:
- Added a new patch (3/3) for device tree changes for Monaco SoC.
- Updated commit subject of cover letter to reflect "monaco".
- Removed the text description of constraints from "description:" for "qcom,ice" and
  wrapped the code.
- Corrected the schema code to reflect the constraint of "qcom,ice" usage properly.

Changes in v3:
- Described the purpose for phandle in "description:" for "qcom,ice".
- Re-added the "if: required:" description for "qcom,ice" with proper
  encoding.
- Corrected the uppercase for base address and reg address space for ICE DT node.

Changes in v2:
- Removed the "if: required:" description for "qcom,ice" dt-binding
  as the ICE node is optional.
- Corrected the ICE dt node entry according to the dt-binding description.
- Added test details.

Changes in v1:
- Updated the dt-binding for ICE node.
- Added the dt node for ICE for kodiak.


Neeraj Soni (3):
  dt-bindings: mmc: sdhci-msm: Add ICE phandle
  arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC
  arm64: dts: qcom: monaco: enable the inline crypto engine for SDHC

 .../devicetree/bindings/mmc/sdhci-msm.yaml        | 15 +++++++++++++++
 arch/arm64/boot/dts/qcom/kodiak.dtsi              |  9 +++++++++
 arch/arm64/boot/dts/qcom/monaco.dtsi              |  9 +++++++++
 3 files changed, 33 insertions(+)

--
2.34.1

