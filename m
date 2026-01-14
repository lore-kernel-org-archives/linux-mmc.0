Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD51E5B7A
	for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2026 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384136; cv=none; b=YV/+BpTfeJDFQO6D7o1+xkvww4Rg6CAQM5jDQEQc56gywINfGaRy0RELPxbPfpL+OOxOzuuhMgW3aox/17YYP3MtQwXTA0Kk46z/Se7nLnbfhTNxKDhJt6W0BGCHPcv3+Xgin8Ctp1s8qWazWTMEc3zNrxsgQyjT4HkiQzd7JQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384136; c=relaxed/simple;
	bh=XKbQTgAiCmuD4bNEnAkHacxTQerpy/XXCG2fPU0ianY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YdlEj69SdlnYy144acrxYrBMHeMLYPGP2HA3iGRq9/qjyWN9vTorRomEarqtL/kTXXUpQpHTX2I31oiHmx9cXJ8QbllVNuziu8L7IZ8pOniJ5qJy2a5xnqXH8/TLerPP6futm7/WvK+REHWlPkv65H7s7cHMiWEpN/yrqta9qJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l+o4dDen; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JYSwEKBa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l+o4dDen";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JYSwEKBa"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E7jH9X2841471
	for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2026 09:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WcNoruIEiYTEC0I/gLNDb0GHjNtpSFU1h1V
	6HGFR5iQ=; b=l+o4dDenMh5tmH1dRGHUJa+BgAu/QlcN8eQmU4nnvKZl9IJLidc
	NWxkL6wm/tgOW/M5jdG+eKiZGsOefV+J8q5oAb0DrOw2EGPsTR1gh7OZoAlsSoaO
	BTepoQUQVKTS/+IrRp9YNReCj/AnPMyuAuQ5SsHXrMuea9nskJRRML5I74lEmtxr
	ZxRCswn7iyaAo/0RNaC17wEWOQfOE+Vy516Jkxu/1abrx6Mtu5gjvI0rE+SGYhg8
	KEE3QMxS9yhlJ6Gn6efOmW6XnkgGsoMO4uBYyETqsH3oFHj02kP5yny/P6uiWa+x
	xd/GsVTeLPOUmpJs4ooViZL7PCZWZSXYHiA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnuk92ssk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2026 09:48:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0f4822f77so167780505ad.2
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2026 01:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768384133; x=1768988933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WcNoruIEiYTEC0I/gLNDb0GHjNtpSFU1h1V6HGFR5iQ=;
        b=JYSwEKBatbNLvVHC1e1jVhicBkPKd9vqqWIqOpjDiZVHo4of9RunPf4kTcROLBcKDc
         BroV44zZFyvgsVVDesOhxrLILTKHYxDJ9WooOnXpCbARuXR375X72IOm9Ow0eCbcTaI6
         FChOgNt0FVZDNdakgG7iSiWYNUPk/oEEdcNp7zf+kKJ2U2TNA3OM6luuMBJ/BmGPnx1n
         hI2AWa6tXyaOaVCrRp6sOOjw0I0AyYLcxkF6J/F17OUkN0Ko76xvlTi7WyFB/FolKDm1
         qvFf82TAB5kcYc9cDelnAoIBZvIl91SarTKW6xbZ32U1eIRpU/rccnZduOp6g0fz2Suk
         namA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768384133; x=1768988933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcNoruIEiYTEC0I/gLNDb0GHjNtpSFU1h1V6HGFR5iQ=;
        b=avohLrs/GO1sTFHC2C3GjGaxYdZ/bky8W02Gr/zKqw03TEP4R9w5IaEe4Y8Li6Tlny
         fG3sn6Rv5ybJWNUuHnWv5whoGqFNeN3SBGC6TSsyvjBSfRZv/II61Ce+2a5dATuc/UK2
         MGp6binNnzgaXOdwfjqMEdXUk9lCVaAxr5Thwkn3yWP4pam1mx7DCf8Lp0U5K1mjGAZd
         410SpH8/yqlLe0pkBs1ztsRskoAfpiTP5cfHgfQSKTKtgaECYspyWLen8gsL5CCEQMZE
         NEBs7xd7cqzKvys5priwUdbJ4ExHitTzv/gFRvNXOsX9oexLqO4MR82o0jzLe5rOpDWv
         +HEA==
X-Gm-Message-State: AOJu0YzC65LWXBR6UNMBdSrkaodAfAMNu92AplVbv1gZvaFBNTzY+3/t
	PAV47h5UO+uVEhZ7oUflogTAutJfIteIDQ872YA0nrosGtVPU9vqwkiRz/3aRNU2P/rwaOBj95k
	JTIN5vssZxpJK6CTsoKc6vESB2fG24fqgBUZh1A1OH/HpXTcJcukOYjY3Ys4/ETA=
X-Gm-Gg: AY/fxX6Yt3r0yYmMpjEHWTpJ2g+AVlUlQdO7S+8z53TDGaklWiXHjtzLsLAwmlqH/5X
	iOyhm8GAU01OmWc9VQsiLZ8s4/flkqtRIY0RCJJ8MQNRYHggJy+v62AZMOmHSL4E8KFiDDcW2KA
	Q06Ti8SUbPHnQI1vFSRnPXEqA5CFEKN7dFaMUon2bDNuyB318jcwjGuHu1x6QRfbXMCYPEHcVK5
	tGx+mhAoFvTznFSqjxBXPExanm230nBJ8+eVNEUsPD6zABBp/9/v5/gU9x+iR2HhnZ31IvxMaO3
	6onEFUFjtMoJlA+mlpzOQVfDjldV37aHlmjtUsJbYNoywUC+feZ8I060DMdVd5P7W8+XPWWwDl8
	x++/2Vy0udJLsQ5C4bJNMjvuzMxpxhpsElVQ6fS0v
X-Received: by 2002:a17:903:b83:b0:2a0:b62e:e012 with SMTP id d9443c01a7336-2a599e121a4mr19779615ad.38.1768384132960;
        Wed, 14 Jan 2026 01:48:52 -0800 (PST)
X-Received: by 2002:a17:903:b83:b0:2a0:b62e:e012 with SMTP id d9443c01a7336-2a599e121a4mr19779415ad.38.1768384132511;
        Wed, 14 Jan 2026 01:48:52 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2d93sm225335075ad.63.2026.01.14.01.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 01:48:52 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v2 0/2] Enable Inline crypto engine for kodiak
Date: Wed, 14 Jan 2026 15:18:46 +0530
Message-Id: <20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ebQwvrEH c=1 sm=1 tr=0 ts=69676686 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OaewepulewRRD3_FMPAA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: tiOdxbKQEhT45Qqndslm0JZEyqYNeWGV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA3OSBTYWx0ZWRfX/z0XgKKM1y5A
 gAtygKiUyNuCVbtPsLKMYK8lE9ixKkuQxAVcbwY4ZrD8H4vnyAIxZefQ7c/+B3x3cnP9TiMmHiO
 hOjWSo9gmzruYbslAWmmdDoJO/Q920D6uQ8fe5NHFJ4SDvq6/zrWpdtphZVr1RDOaFT/d5E7fqr
 nPnAT0fMsnj1ORAYRbBgyPTqdMbMWbXOfrF1Unfg3xQ/3XZyjoRAjGKbrkSvpoVCTNBNHkuBfTy
 ImvQt5B0iC26Z2ZURJAzKxbB5JzdNgVYUhHDDZ242IpTPDVCVgONHMqjA+sUVVPMo3QRHVzOmte
 oDdiJ/5SFitu5FD1y4AEpQYoYbbekTZU8lTZRIqM0sZITu4ILWPnjqEMM72Tk3BhDiHI4/5XzWH
 EkcMwbe+DcLuNmh6xH1kwK/rlDUO49sp5W+h8NGfp2SSeMdgPU7RNRL3jTXMdqYdKwfkW0upg4t
 3OK+DpMPbuJh5kbWqJg==
X-Proofpoint-GUID: tiOdxbKQEhT45Qqndslm0JZEyqYNeWGV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140079

Document Inline Crypto Engine (ICE) handle for SDHC and add its device-tree
node to enable it for kodiak.

How this patch was tested:
- export ARCH=arm64
- export CROSS_COMPILE=aarch64-linux-gnu-
- make menuconfig
- make defconifg
- make DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/sdhci-msm.yaml dt_binding_check
- make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CHECK_DTBS=y dtbs

---
Changes in v2:
- Removed the "if: required:" description for "qcom,ice" dt-binding
  as the ICE node is optional.
- Corrected the ICE dt node entry according to the dt-binding description.
- Added test details.

Changes in v1:
- Updated the dt-binding for ICE node.
- Added the dt node for ICE for kodiak.

Neeraj Soni (2):
  dt-bindings: mmc: sdhci-msm: Add ICE phandle
  arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC

 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 4 ++++
 arch/arm64/boot/dts/qcom/kodiak.dtsi                 | 9 +++++++++
 2 files changed, 13 insertions(+)

--
2.34.1

