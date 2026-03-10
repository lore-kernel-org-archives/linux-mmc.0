Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B22ED141
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142566; cv=none; b=Olc4Elz/fRS5QVoDFIq2jqudLw0b9HimGynHfqHi3f3hCTdj2IkUC+u0G3MG1ymm1MKSI/X9dXcKsxy3q9xGuF/lsYTMg0hmcfq0WmOAEOYDI6hOqJHmQhOXaDtIThs/FTo00ocD39RNgJa7NN+YbWBsyNIotkIJgRBbZpj/TRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142566; c=relaxed/simple;
	bh=JSBViZLYLgM3V5sDHNcbG1/UOiRj/kvo5UJxPKT4kfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=da92KvHH/xsEFkszUdbnmL9/+GWM09Re+M35XHLfm4Qidk4ueOs1dV/GDF9NRs85VloMvFcF7M49QZU+gp9mDGW/TUK8nGow0Nn9e1ErcXeAiMVOb6TMi/G+hz3BUD8BhBivTluwxDbneTgkxeq90/FRQMDyZz6uGfsqr3pEfiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y/az3iSJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rts9tMqP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y/az3iSJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rts9tMqP"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A8pcr23690695
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 11:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=nlioHbQ4rRxL0XauG/8nbvUDu4aBay9qTv3
	o08Jr0Tg=; b=Y/az3iSJ1qKacDc7qsgmpXYVEj+yFcipi6G2S9wj7jfjXzkhMp3
	/PnapBh90cxBCPiHyB2to+UMuWO2dUewjaMAty9HOpmUTdi3IExSCiMOi1cQDb2/
	9+04a/ANgabnMIONyerZWejIx0op/bLpS/hCJVSBsEtLG/B4jmQAynTms4uQ30Cx
	e1JK2vove8sE0zhRQhLYQLFalZf7m0J07fYdlIej/LoNSd4IM3FVx7loKJXBRyeM
	9zINrzhnmG8HcMbsZzyBo7iwJZtgkiC76iK32fYYfTpS3o2OogpeUsT4QpwNvJZM
	/oltTsRVpzM72/AU30hMUFPzL9R1qEst6og==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctg5ngnma-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 11:36:03 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829ba0e63e8so1082145b3a.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773142563; x=1773747363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nlioHbQ4rRxL0XauG/8nbvUDu4aBay9qTv3o08Jr0Tg=;
        b=Rts9tMqPd1zDXwRvripmJDVAKBo494FYUOMBSridPxeHITfTVviqSqksvDqHxI0nSk
         uYBsMkZ/Vgc1Xv0fDCQZj8svQKda6UognKj3Eto5r7exUcAsqBgsXDMyPzFLbZ0n1ysg
         hd6ASgpKcYkszURfLWImUnWXC+2oyqwn+NWlCxeso5PJpA7wnBneHWJLns0W+6HQNiZA
         vN+VGcYivhDI4ZKl9ODb3AUitUAiQnVNEwCBgPYTKAFgb9X/ABozgYawiCmbmFFCksw0
         yodCTn6tE+k51ahSHJ97eEwN6d1tSD9vsCoOrQdPg8LAbywSRbQdvs17TvL/bEARhVCw
         9A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773142563; x=1773747363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlioHbQ4rRxL0XauG/8nbvUDu4aBay9qTv3o08Jr0Tg=;
        b=jxRq2neCXw0dZMODi5FAG/xI/Vvoik+yM6M304SkbfCC4Vxcb5vMtKlpweclPCmZ88
         jreBj0ZdDOzxuiKELM0tLOJLjb+N49Aw8HKRWw8Esc29AUf/0uQSil/akr+3ZfewMXS4
         BiG7Sq3Uy57/CI+8nymxrIaTQAFKQfrOuTXduhTXyXcPQElPYpRt9fvbUnmrOr3KY4mv
         T50wfKUzAfGIr+Q/mX4UJDyz31LW76UfgiEfp0Bb84B+gn4of/ghINVjsFHzPtHBhQyP
         LucpFmTOkbBUaPswNZqCVNYjcOrXPJ/BRFnW/6me+kEi5htuTwvnS7Qcdv0yyRFp2y4I
         rtMw==
X-Gm-Message-State: AOJu0YzF25rF4ouJpvI0hOOByIrU8VqxdAI9163MJwsnz2byfIvJ9tq8
	03G9nElAtuCkCshB2M34Qs/IDLowUxZBmlwtY9ZLyceEVIb0kOG0LKV4um/TcjEfLyOVnmAfiJW
	f92s+KIJHxgoWzhbk/U6m6tiYAZIdLC+d9hQQoY0ud6oJbXNSd/B67xl+O49yxQQ=
X-Gm-Gg: ATEYQzyqGYShVdGIjPk4RU6fbGCKnQW8ydLgTuiNFAD9SFX7Z9R7HivFpdQhhQSHgZk
	sajiDHNalqPVJdFpCK+fZc/jNfN2ROaz7pUGqlbjGJWFp6H1NUxFFuSzT6yxyfp0u6OqT2Ksglc
	lCydcSIK5o/+ZB5QRNj2fl52pmvvMYh2DVMvLpwp0PGT+3PHfHkg4A0QmfmvpTDJjcOGJpXlrZ3
	xxa8si2MRObyOZX/Xmrg+3OuJu15NO2KTm40G24UBNkDRXGVQ44alfwahSu6LUz+7cIgWqYvGsM
	frzSd1IQVxvStqvdY1R3vrKEeWn50F3EN4x9CUDLV7PbX5Bxr5Y840cH4j+IFekltJ8PvZFRNwm
	gxRg5Ikgu83wnIdr1/pUxvIk2weaZK9PGzpSIOnviDGLXHB4Lu7Ww
X-Received: by 2002:a05:6a00:3021:b0:824:a22c:c6d7 with SMTP id d2e1a72fcca58-829a2e13d0cmr13144124b3a.18.1773142562725;
        Tue, 10 Mar 2026 04:36:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:3021:b0:824:a22c:c6d7 with SMTP id d2e1a72fcca58-829a2e13d0cmr13144099b3a.18.1773142562203;
        Tue, 10 Mar 2026 04:36:02 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4637bb1sm12364659b3a.10.2026.03.10.04.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 04:36:01 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v6 0/3] Enable Inline crypto engine for kodiak and monaco
Date: Tue, 10 Mar 2026 17:05:54 +0530
Message-Id: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: n9Ea-gplab5ttn4m-Yo8nyHM6aif_FLw
X-Authority-Analysis: v=2.4 cv=ervSD4pX c=1 sm=1 tr=0 ts=69b00223 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=OaewepulewRRD3_FMPAA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: n9Ea-gplab5ttn4m-Yo8nyHM6aif_FLw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEwMCBTYWx0ZWRfX6Ytvm9/umBd3
 5kb//nO2H1CYyOt66D8RhjxeuQ+thUEjRDEHVx71jtn5vPoZV3BEikRO2J4Pu9cAEYcRaKpivcB
 lrWF60plPuv9XZuhpYCsad/2I3sjQ85e/P2Ji500x8P26/r0Iom6CQiFGFv0hRrvCYZBN4YfZdQ
 NuYpIh0nMNVI/A8F9PoC8nxdrc2vz+lPMwMTjtmpyB76I8w1r0S65iR8kdlT2XdrMcuruuOCq3c
 VARd6DvmLwFltaPIVuBpsZc09ZqFWu8Gd8ANQxi04/WfHc9stF9/ahBdEZ9nh/EHqICzQ4lZMxi
 xcqZ71W4AUGDG1N4mfgn67u39d9wyFCopN0RZRELoaE45l0Jz33oEfwIcuEkaDCTRHXZJCTkk7J
 T16AeqfbTk0l1oP9k17k37XU2w6meHiDiYPKmUhQwFERYp4fCjP0lj5QEFTIHKC8rAiGTxQTDmO
 GtlX9gJgbTvkRRodRaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100100

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
Changes in v6:
- Wrapped commit message for patch (1/3) as per Linux coding guidelines.
- Signed off the patch (3/3).

Changes in v5:
- Updated the constraint for SDHCI 'v4' vs rest to reflect the 'qcom,ice'
  constraint.

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

 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 95 +++++++++++++------
 arch/arm64/boot/dts/qcom/kodiak.dtsi          |  9 ++
 arch/arm64/boot/dts/qcom/monaco.dtsi          |  9 ++
 3 files changed, 85 insertions(+), 28 deletions(-)

--
2.34.1

