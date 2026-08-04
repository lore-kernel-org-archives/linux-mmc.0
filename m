Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35BE353A90
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846068; cv=none; b=jXq1JB2yZA9i6osxCDNCLOKeDCBnUWfDyX3BYTO/c4KBmSjSiVXB1FTwcgqRM3AmLgWPDWZJdFbHbOTfZ/FOOdTOpTRwaRoFGXeX3wWanFLOD6ZHHhmfwIlZekvs6zP0zOSc8ANa+lTJBl0eeCy2ezaQXVQV3kJT8zaM+g/Vn6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846068; c=relaxed/simple;
	bh=7M65xX2SPEAZPbTkfMIRQqvlRwJZ9lkojNzAD6XjxXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=svigVQfbk81x6mguMPhiSdT2H5POdgky9q1ixIbCPZ49QBHbyXLnFum2z6DBl0yiLp3C7A74MNJiQB3b9GQNoaThPItRq1AfAQrsVRd1KmrySEFwfkmL1K9X+30Rrt3DbnkvoxDRAuTDPRSS3KP86ySHnye0vG/08FdEyI2p4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jAMXZDtO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DykT4pxi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jAMXZDtO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DykT4pxi"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748CKPG3373810
	for <linux-mmc@vger.kernel.org>; Tue, 4 Aug 2026 12:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=QW8b2paILWu+Ej0pRDMZ4QBKcqdnuTo0dY2
	YaB6hRZw=; b=jAMXZDtOWtbzFZPi25xMx0U8dZ1MoeN30qOdP+uTPR23IMQqKhR
	QR3P0sikLsk7mtMu1BvzshwKGg8VOnjq+CQYartZTPne2voG/MeO2mez0yKQ37K6
	/NUFbm8gVTwvmGFNOCbJVpxUgkbXkACndtTrvpqBfRWn3QWFqtvvlufoqa12UsoA
	/sYwUQgoNWE7CP/qseIf6cVCa+J30NsvJE9MQEt85zvO1/fr2kQoPs6okVY4Wp9C
	/TgrH5DSHlWVZ+6/AOTHFgunUEaDnN01cISPaAksvkD+hC0UoH9N6K3L2NeEEKK2
	MUs9XRy7jrhHG8oSrWCj7eXjdHl1RsGBVxg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty3r44mn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 12:21:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so7118375a91.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785846065; x=1786450865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QW8b2paILWu+Ej0pRDMZ4QBKcqdnuTo0dY2YaB6hRZw=;
        b=DykT4pxi/oEuk1aRq86BTsQxEfqHXVLZxOqxpAKkY8VVLGmmDgPLV0Bt3b3iX/vV+V
         /vEQR4/4jbAW+FHrzL62c3kxoTPw+tIeNBNh/XL2hYdKKFVWdjWJhYtTLP/vkDxF8wvO
         5iQsFWMccWN1m8EAhk0svQpRjmzEDD+LPWejF3otzQ6Q1JMlA7cN7f6UwsBsx39m6RM5
         UUldLaG7uB2ly4xAIs+2rpy2tWPcbs212+0HGbRxme7uKOsQQbTeiKxROPlIPE7L+Vmd
         E57pi7itXdLApRJbVHpn8HVGGwDuD1aAAG9nlUMx3HUT24kHZxD60QH4+F/eoEVZ9tIA
         dn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785846065; x=1786450865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QW8b2paILWu+Ej0pRDMZ4QBKcqdnuTo0dY2YaB6hRZw=;
        b=FTrIQy2pfhpYnDUZ0mSXqoYHCsX+PH1MVAyy0IeVcH2Feq45Pa2om0Pd+PCY1RwNa8
         HSzV6SLJb5YYAXvJJTCHIIzwDBrj7cTf8IvAAmnFGQtTZwcyZ2rraT+wf3tZmncZjf9Q
         jxN+fzFlFgNkBTs+mnhIIV0dz+BMVJY33KtXioJXCNeBevGl83jZuAsC1sDf3M2rBPf4
         uhTeVvocAlSq7S0T+UrlZpcABJxrCo10akbH5lX7gXOYZ8lNLzyWhpZtuvXN9Gfb5t8k
         31dth2f/T9mIi1N76e1Xx+2UhMiOSqxj7ASEWF7yERDCEJUykPmLzsKVaghzgurZmRxB
         nWaQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFVdslnxwfV2DvtGY84Khm0ULZuf8me+wUevS3yr9tp0msrnoO5A7naeKrTzkq6lcH5N0YT2fPSzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDFlTRG3J/qR4pr9mVD1UnWFLNw+EVkWvh6CqBakTJopEEJljk
	g/L49cDKCtIHY3cDphDkse0kZ1sI68aoEIfOJ81USPlY1psDP7vLk5JS6XsQQK1syzMhUwVlAEL
	6SfGomMzh5dFf/lsQ1uHDC9wr0uGxm4eaH63TRuICm5bUbmlqvY+OCDlwPdgYa5Y=
X-Gm-Gg: AR+sD12zNuVQSbvlMXd7k08B7hwD+wjL1wIPWn0N9sxH8VTVBLbdZsVQHgT3jXzdWYQ
	pmyfAclXhzIPa66k+9rqYc3YYoojaarvx+pwjm1TZ7nrCwrxim1LRLxDMgpGGP0fKN9sottKgch
	QVLMIVuuBZi4CI7xRSwS5mgoRneoeV4MLYehzjDDLQr7ob5B/OWwN6xR8tanNOGpKo33Jlpo1Fm
	lX5ORFDYh/j1RRLsSIXOfnA/dcMD8t4ha/O1DsedlDqasGPKIv43toI30Bgxqz0Ih3u7E/MjfGY
	7QnxHhwu9lAeOFP5dAk/II2QzouymReAtMZs8cSZWE5XfRccvPaV18TWs/oKK0WknC29OdzCb6h
	/6lH8E8CrB4iAY7aRjHF3Vl8mqI3c8E7nvRM=
X-Received: by 2002:a17:90b:3985:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-38fbc4053d7mr12011117a91.7.1785846064700;
        Tue, 04 Aug 2026 05:21:04 -0700 (PDT)
X-Received: by 2002:a17:90b:3985:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-38fbc4053d7mr12011071a91.7.1785846064182;
        Tue, 04 Aug 2026 05:21:04 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fedc650a0sm1237832a91.14.2026.08.04.05.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:21:03 -0700 (PDT)
From: Monish Chunara <monish.chunara@oss.qualcomm.com>
To: Monish Chunara <monish.chunara@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        Kernel Team <kernel@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: [PATCH V4 0/2] arm64: dts: qcom: Shikra SD Card support
Date: Tue,  4 Aug 2026 17:50:52 +0530
Message-Id: <20260804122054.3462145-1-monish.chunara@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=caPiaHDM c=1 sm=1 tr=0 ts=6a71d931 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1w3StAHzAm3vCDDRDnYA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5OCBTYWx0ZWRfX6JPA4GISeYCC
 M508n1Phc2tXQp5IamLbWebzZSAZp6/fRJAMRjRm+9B6F6bBbLt1I056zeGRQqXQMwygzBrvsCA
 fA9EwDAmSPvZu3PQBL3QJSW2GMwd/68=
X-Proofpoint-GUID: QStitoeAH9f2mM58kG5ZHiC4sSjykjUb
X-Proofpoint-ORIG-GUID: QStitoeAH9f2mM58kG5ZHiC4sSjykjUb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5OCBTYWx0ZWRfXzqWRnd4DMEbq
 ncamZfd7UVVULJ0eZOq+cuW9IB6qxl9IrsFfAe+xzcl08eOcX4yleuQ7ANfNsOqIOsWIBdsdZr+
 yx/QaelPDWlrCeioC+l3WmNMLeP4gNnI4OMtLyAM402yO8LzwHnAyLvudJzQ7oeNNoACfH/8q2d
 UnasFOK46Jo/0YHd67rZl1/K9Zmvc4V4okPtVZQO7Zshz7RmZ9hkeFgNd7Dm4oVdXFKgSl1pfdM
 0os4lwy2112bQzO663cN5s09v8lqkO15YQPQ3ymNYEus4NVBA+OFrB+QZ18fiZwYy3E9l9w8D0W
 HP1eKxXmLaDErBVQVmRED95pGW4D6Kh/97O19bgCzSbb6RKblxJXBFC1FMUB1NktCNq9HI0rw9r
 qwRNg/gbi6HWsy3ezLwUJqbzZhzHwL2JFPiVuYDtyMDd0wRHiv53urt1NuMB6XZoEWX1BKXigjf
 jnMUrGxPqHvKOTekyPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040098

This is v4 of the Shikra SD Card support series.

This series adds SD card support for the Shikra platform.

The first patch adds the SDHC2 controller node and the necessary pinctrl
configurations to the base Shikra SoC dtsi. The second patch enables 
this support on the Shikra EVK (CQS, CQM, and IQS variants) by defining
the regulator supplies and the card detection GPIO.

Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>

Changes in v4:
- Rebase on latest code base
- Collect Reviewed-by tags (Konrad)
- Drop the dependency link - since all base changes are merged

Changes in v3:
- Padded the address part of the reg property in the sdhc_2 node to
  8 hex digits with leading zeroes for consistency with other nodes
  in the file
- Moved the common sdhc_2 properties to shikra-evk DT file
- Link to v2: https://lore.kernel.org/all/20260630165700.1886608-1-monish.chunara@oss.qualcomm.com

Changes in v2:
- Rectify the alignment for clocks and interconnect properties for SD
  card
- Link to v1: https://lore.kernel.org/all/20260604122045.494712-1-monish.chunara@oss.qualcomm.com

Testing:
- Validated on Shikra EVK variants.  

Monish Chunara (2):
  arm64: dts: qcom: Add SD Card support for Shikra SoC
  arm64: dts: qcom: Enable SD card for Shikra EVK

 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts |  9 ++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts |  9 ++
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 11 +++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts |  9 ++
 arch/arm64/boot/dts/qcom/shikra.dtsi        | 97 +++++++++++++++++++++
 5 files changed, 135 insertions(+)

-- 
2.34.1

