Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E60356760
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718576; cv=none; b=sTBGCJTaLksRGkpiReYrbPITxM4WuL7c6T5OZGtItLljzux7AZLUkWnL73sQRXDKzZ7Mnu3TFuWtIoU935dSERR5zqkdOb3YXNuqF7ORzu6/XXYIvaJcn9bT9ugpLROiAdlVKDhPoBGGDOjd/jfVzq3M9zd+wAAurfxh1AJOut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718576; c=relaxed/simple;
	bh=xm5CxsUKMbCzRIh76JFDuGswHLuECFh0jFoVKUFTh+k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MPCmszs2ZZZZIYvX7G2L4/XjgSXxGCgLlsyROUC78oLuLgWDQ2sflrUkxILz3YlbpCoR/XBbpqyxxrpZXuWHyEj5UF9/uKG9mmtSYQGzmAJqZWR2VTwQQv2UQa5JXfKR2QxNiiNF/4Z1dM47dp/CtKEBZ66e2Zg/dBRG0KX4Klc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V06HOYaR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MTUJOscy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V06HOYaR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MTUJOscy"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6sNMY2143179
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 07:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=z/SbcSMIk/FEwys9cVxncR
	QPP6glnhqNOthgYFbVrVc=; b=V06HOYaRQE9YZVlqFnyNoDqHQJfYRyiHUmcHZx
	ULYKQ+nl5WXHciuyvjoi10goyspXRcj8cpJKofGRRa1td0o8fx1eFnPrt8B1CVmP
	vK3rMvVh5srYpsojOYiziIp4GeaYQxTEzhrwSZSb20yMRASPXWqe/iyHcWcUeBl8
	xx9Ws6b2Pp4CQHZ2mRvJTsvkla5vIKVYlLz41bnzGlRyIt6sikxO+yAeRw0GIy6w
	KEL9W+dLNeOMzceYp4LC4wO+Mk6yZ1ERPpMCojiQ7kuAW2bL7hllqEsiGQ3E2ZNy
	JqtkDAkIb9mcutRwsDpRYhoR166DzOr54t66v1ONtQ+F8Gmw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8nb9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 07:36:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37fd707bc1aso726776a91.2
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 00:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782718566; x=1783323366; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z/SbcSMIk/FEwys9cVxncRQPP6glnhqNOthgYFbVrVc=;
        b=MTUJOscyxkdHkHO7mQbPC/RDZdlCBPCQjo133T0tkvdSN1pOn7ga1/Z97m8TAFMqEi
         BKpNpfs6H6bUmwG+5W0Kj9xeetz9trgzCf9s4bFCvl5oW0O5cla3f23ZPb6KT6IKDTic
         QJ/sB0JWSUce2z10nG3iyMWUcESer61MN6UMzZGKL8w9L3F79HFWrf/a4YpbIRdJ0nbT
         AmxqYq33Qa+KAfobBtQVofAwadA1/k/dZ5hv/XW4y5hQrKLxkIy171pokWZiaxCoJukp
         hVWeDd7eRWhtkQ0x6fS0oYPZWJI5OICh9RY2u1g0OI/tGP3WbrIP93UZX4i97N/nnfja
         L1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782718566; x=1783323366;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/SbcSMIk/FEwys9cVxncRQPP6glnhqNOthgYFbVrVc=;
        b=IBgr6SnseNV6cLrZvUzfuhSftaLEuM30+ryRchN9ggBw7YZHShg4jbu+CJjvO1LRkr
         K8uhJPGNI6E4jKILzL3l7b6ylArndLNUOjBkLBbv9+RsBsIHuxIZY+AQMmCVWD5iJf5B
         oyFwoi3mPY8kNikADkkuGVvBry119L/ACd5N3UmbYKdqvc2GdL4N7OwvQnLq+S8zMF0U
         IWRxS0BkjPpUXFEvFy/WabQC6e0hXlT4OvpOBKCyk2acQVW88/UtZsb3IzCbCDweTnow
         j9J3xnyx1LbFTAIURRZjN8ahIy561EPvjRxbucwXUxP+mUrXufkoCTf6c5biJnvBH1Gm
         GsoA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8xeUsqdKPzisjRMr+mYttvr7JecEr2szeykoGz8Fpl+OHEDtYZJZDXCrfro715mElLWg+sSPEjWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywegrj9Hax82biAMyulJcwoGcIFg23oKzd7dlcthmb+UgnjA3UK
	SzZaxffhQtgfB829PWBX9XDITcTjdwyvNWAxXr2O6ZbmOFcxAJZCSJqvUNzy+YF+0SngaAaDdqh
	lhUPymTAOrtlboNeYCKL1gk0H7jeXCLvghT3Nu+IUi4K+Uw7o+Ud4ySkA7QbgTS8=
X-Gm-Gg: AfdE7cmA35rIG59YmAxHgWXHrJRiOnfnFysirkxV9BOWv+xXbh8JFp7w5DwJnQzjvu0
	Kl/T47Yergphl3BjOXbjghcWbg6FX2umziAJS8EMlBv3+hjacLhsfLZZlnl3SkI0k19+/asoQPJ
	gDq6kAfYTeSTtFCnrbVA/pJkShFx9LQpatyT965raVroQafjbFjy0XbeWQwNortR4HZuBv/kuEz
	oTQxSFs+OC4nnWYoIgmWapPCHOMNkW7ktO8Qz0w1roqWDeJsWRDM1uL/xDgAJ+voIAUGHrgrJEa
	68PqqaaBW1w0t8jMme+vcVFPZoHkyN3528QpPQ7vGn4BNGsTG7RXkIeD+PLeLXYHn9ixN5gBjhX
	iQpiSe8TJNjPsr3rXOX9aBL+5N+73rz1jwEGB/dVaiYEH
X-Received: by 2002:a17:90a:d450:b0:37f:9ce0:af32 with SMTP id 98e67ed59e1d1-37f9ce0af84mr6821372a91.29.1782718565530;
        Mon, 29 Jun 2026 00:36:05 -0700 (PDT)
X-Received: by 2002:a17:90a:d450:b0:37f:9ce0:af32 with SMTP id 98e67ed59e1d1-37f9ce0af84mr6821352a91.29.1782718564958;
        Mon, 29 Jun 2026 00:36:04 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37fa9629f8fsm4537979a91.8.2026.06.29.00.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 00:36:04 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH v8 0/3] Enable sdhc inline crypto engine for kodiak and
 monaco
Date: Mon, 29 Jun 2026 13:05:30 +0530
Message-Id: <20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEIgQmoC/02MywrCMBBFf6VkbcI0JKW68j9EShqnNsU8zLQil
 P67qW7cXDhwz1kZYXZI7FStLOPLkYuhQHuomB1NuCN3t8JMgmygkUfuLHbove1oSSnmmfdS2Vb
 ZXoNWrGgp4+De3+Tl+mNa+gntvHf2x5Cj5/OY0fyloQVVNxqEVrUGyWseELOZBMXgzpFIPBfzs
 NF7UYZt2weKnOuluwAAAA==
X-Change-ID: 20260629-ice_emmc_support-b24c84cb5054
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2MSBTYWx0ZWRfX6cDNPjOiucp8
 WwqL6sHVdxMbhh+zG9UfHEpFAQt4qrn6mK5LfxMn4VMee9yF4ju87zIbJgfKBfSvaYrmk7HONNM
 M1FFp0rZNJnoLC0LctaWGhq8hG9fiEQ=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a422066 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xtQGQhj0aSk4Y_6bxbsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: vubS1ICUG2Nfyp3Ol7Wc1-D3Ijahe_IX
X-Proofpoint-ORIG-GUID: vubS1ICUG2Nfyp3Ol7Wc1-D3Ijahe_IX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2MSBTYWx0ZWRfXxUBCpSPz6+CQ
 5AFxrfNP9IZoSbdUeuolz5t+2SWpQAcXwJhqWKGdr5moIg98VgbkJ+pRZVmYu+WXd0+4oXFNkAK
 rrqCeiuMeOe05KR43GYfqIPgiegi+AdjPzrCuRfgi/f/Kr9poaCVApUdqlls2ftJe7qY8+tSX1D
 y2xo6itXdFw5v/AR+YEeARFAqZhG+VmF+w/p0DzFab7kRv/5aeZi7/sMNb6pCRTi/34jo4nQhrB
 NP33tvfLDtcULfZ4tCchf2TrIuSHmDMN8FjZylRqWVcqQh6mUgWY0pTu2+5CMekknw6WF03+7Go
 7kJk0TeWZGq+uush98FgBZ3A+irENG0wVAZS5e4RTw/jb6GbrwwCOWDTviitABsWBkW0TIEe9HE
 yeXwooJb9700bfvrP9aO1Emm0hHH1vZVUt0K9tCuqanwaibqa9mwNDCqU3cVPBe/AO7yEVyLhQb
 EZ1+ngnAwPuRrNRsmlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290061

The series is combination of below 2 series sent in past. Since, both
need to be picked together, combine them and send as one series.
Konrad and Krzysztof, request to review series again as I've made minor
changes only to this series.
- https://lore.kernel.org/lkml/20260608041650.541502-1-neeraj.soni@oss.qualcomm.com/
- https://lore.kernel.org/linux-arm-msm/20260409-ice_emmc_clock_addition-v2-0-90bbcc057361@oss.qualcomm.com/

Document and wire the SDHCI to ICE relationship on Qualcomm platforms
where ICE is modelled as a dedicated DT node.

This series:
- adds the qcom,ice phandle to the SDHCI binding and enforces the
  qcom,ice vs embedded-reg modelling rule,
- enables ICE for kodiak and monaco by wiring SDHC to the dedicated ICE
  node,
- adds interface clock and power-domain requirements for the ICE node in
  affected DTS files.

The ICE node is kept disabled at SoC .dtsi level and enabled in board
.dts files where the corresponding SDHC node is enabled. This keeps the
SoC description reusable and avoids enabling ICE on boards that do not
use that SDHC instance.

How this series was tested:
- make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
  DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml \
  dt_binding_check
- make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CHECK_DTBS=y \
  qcom/monaco-arduino-monza.dtb qcom/monaco-evk.dtb \
  qcom/qcm6490-fairphone-fp5.dtb qcom/qcm6490-idp.dtb \
  qcom/qcm6490-particle-tachyon.dtb qcom/qcm6490-shift-otter.dtb \
  qcom/qcs6490-radxa-dragon-q6a.dtb qcom/qcs6490-rb3gen2.dtb \
  qcom/qcs6490-thundercomm-minipc-g1iot.dtb \
  qcom/qcs6490-thundercomm-rubikpi3.dtb qcom/qcs8300-ride.dtb \
  qcom/sc7280-crd-r3.dtb qcom/sc7280-herobrine-crd-pro.dtb \
  qcom/sc7280-herobrine-crd.dtb qcom/sc7280-herobrine-evoker-lte.dtb \
  qcom/sc7280-herobrine-evoker.dtb qcom/sc7280-herobrine-herobrine-r1.dtb \
  qcom/sc7280-herobrine-villager-r0.dtb \
  qcom/sc7280-herobrine-villager-r1-lte.dtb \
  qcom/sc7280-herobrine-villager-r1.dtb \
  qcom/sc7280-herobrine-zombie-lte.dtb \
  qcom/sc7280-herobrine-zombie-nvme-lte.dtb \
  qcom/sc7280-herobrine-zombie-nvme.dtb qcom/sc7280-herobrine-zombie.dtb \
  qcom/sc7280-idp.dtb qcom/sc7280-idp2.dtb \
  qcom/sm7325-motorola-dubai.dtb qcom/sm7325-nothing-spacewar.dtb

Changes in v8:
- Added iface clock, clock-names, power-domain and disabled status in
  kodiak and monaco ICE nodes.
- Enabled ICE in board DTS files where SDHC is enabled while keeping SoC
  ICE nodes disabled by default.
- Updated trailers to reflect co-development and sender sign-off order.
- Revalidated with dt_binding_check and CHECK_DTBS for all impacted DTS.
- Link to v7: https://lore.kernel.org/all/20260608041650.541502-1-neeraj.soni@oss.qualcomm.com/

Changes in v7:
- Rebased on latest linux-next (sdhci-msm.yaml renamed to qcom,sdhci-msm.yaml).
- Added links for previous versions.
- Link to v6: https://lore.kernel.org/all/20260310113557.348502-1-neeraj.soni@oss.qualcomm.com/

Changes in v6:
- Wrapped commit message for patch (1/3) as per Linux coding guidelines.
- Signed off the patch (3/3).
- Link to v5: https://lore.kernel.org/all/20260306093332.4193993-1-neeraj.soni@oss.qualcomm.com/

Changes in v5:
- Updated the constraint for SDHCI 'v4' vs rest to reflect the 'qcom,ice'
  constraint.
- Link to v4: https://lore.kernel.org/all/20260217052526.2335759-1-neeraj.soni@oss.qualcomm.com/

Changes in v4:
- Added a new patch (3/3) for device tree changes for Monaco SoC.
- Updated commit subject of cover letter to reflect "monaco".
- Removed the text description of constraints from "description:" for "qcom,ice" and
  wrapped the code.
- Corrected the schema code to reflect the constraint of "qcom,ice" usage properly.
- Link to v3: https://lore.kernel.org/all/20260206112053.3287756-1-neeraj.soni@oss.qualcomm.com/

Changes in v3:
- Described the purpose for phandle in "description:" for "qcom,ice".
- Re-added the "if: required:" description for "qcom,ice" with proper
  encoding.
- Corrected the uppercase for base address and reg address space for ICE DT node.
- Link to v2: https://lore.kernel.org/all/20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com/

Changes in v2:
- Removed the "if: required:" description for "qcom,ice" dt-binding
  as the ICE node is optional.
- Corrected the ICE dt node entry according to the dt-binding description.
- Added test details.
- Link to v1: https://lore.kernel.org/all/20251124111914.3187803-1-neeraj.soni@oss.qualcomm.com/

Changes in v1:
- Updated the dt-binding for ICE node.
- Added the dt node for ICE for kodiak.

---
Neeraj Soni (3):
      dt-bindings: mmc: sdhci-msm: add ICE phandle
      arm64: dts: qcom: kodiak: enable inline crypto engine for SDHC
      arm64: dts: qcom: monaco: enable inline crypto engine for SDHC

 .../devicetree/bindings/mmc/qcom,sdhci-msm.yaml    | 95 +++++++++++++++-------
 arch/arm64/boot/dts/qcom/kodiak.dtsi               | 14 ++++
 arch/arm64/boot/dts/qcom/monaco-evk.dts            |  4 +
 arch/arm64/boot/dts/qcom/monaco-monza-som.dtsi     |  4 +
 arch/arm64/boot/dts/qcom/monaco.dtsi               | 14 ++++
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts           |  4 +
 .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     |  4 +
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts          |  4 +
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts  |  4 +
 .../boot/dts/qcom/sc7280-herobrine-evoker.dtsi     |  4 +
 .../dts/qcom/sc7280-herobrine-herobrine-r1.dts     |  4 +
 .../boot/dts/qcom/sc7280-herobrine-villager.dtsi   |  4 +
 .../boot/dts/qcom/sc7280-herobrine-zombie.dtsi     |  4 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  4 +
 14 files changed, 139 insertions(+), 28 deletions(-)
---
base-commit: 3d5670d672ae08b8c534b7beed6f57c8b44e7b43
change-id: 20260629-ice_emmc_support-b24c84cb5054

Best regards,
--  
Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

