Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E572342A80
	for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761477488; cv=none; b=QopTlLy04nbu8NakOxDAJe8rHjEY6Xdpcz/PXq7fP5BvgoR7JCG7izZB5WCoo5jH5xODmeSZ5IQ9Rx9+hijUo1ehe4/fOTReHvgK4giNUSyYB6xGZyOAEOQI024O9+D6ZOtmd7alskeDQP5wdecDIyDqw4cLNXtEjDp/5gnkK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761477488; c=relaxed/simple;
	bh=AFar811F9iCO3PW/bUYkCvTbMI/jIlhhcC3tuFxatKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gwZM7HJffN8J4dwDRlDmmhY5mru5Fz8d4+41rXzELkJBFlLrF+9kyO5E7D72rsukmPjA7zyM58RFYSRp9033hb1beRit4sXngAbRPv6n1EYlremvnv9Ja1lWQrwixq3pmrcsgIqTVnM0Nt1dIRJbisP3p0yBxXxcsoDBnfxfPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WAy3N3PX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WAy3N3PX"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59Q6bRGB3354515
	for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 11:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=PP4ZLZZk5lXfWJld/o73iVfzszWgXXw0Xp/
	OfYD7kEE=; b=WAy3N3PXBNBKdNFk4Rxa1whB1VCIEWua4IvyKx9nEvM25T5ZsiX
	oj1jrHjHo7nUyHfJjToelvgr+qos2aVn8w7Xmhm1ioJc5vKJeU9HYs/nlIgIPRCC
	dnnCiTPVaqUmPJrk17Qe8GYvQr1CA8e4FowX22NPey9kbXbLqTR7aqpnLHdMstMS
	Jhh3V9y/xu9/N4Y+f3hxm2LeOlT9vpvWk6lm7qPUhryP6rBt4ncRmS7i9+4BzCEm
	gvzozPKCb1dwY3KXv4BPkTfx041cCsqiyKX3fnLl5t7tCS/y7USMW5qAAN6Eg3KV
	RGLmt0sauKWIO3zalEULyn/Pbe+/tkqTa3A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0nnxt0rg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 11:18:05 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33ba96c9573so1158618a91.1
        for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 04:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761477484; x=1762082284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PP4ZLZZk5lXfWJld/o73iVfzszWgXXw0Xp/OfYD7kEE=;
        b=K2i8LvPgymv6T3cEjtzoYb95fu2WljmEcEjVZpSFdjTSg9YsHsWL+U7KlWQZyqEBvw
         50HcU9n2UR6NGhf9uSEpIkKIfiJ/wg7hllZip55qRtbJLZSsO4pLHZyiQnQ/Dl1yepeX
         Aupa1g+yvWYWnPa1dnAPYNMQ63aDTCbYzTamLejuM8j+a7cQIAFqsO8zmEntwG9fd+Nu
         3Xs/KikYFBrSC2UcqOSh0KG1JUN34aiQlxS0Fc9xK4ivAhyNpERZpti3S6gE7/5t34rg
         /q7rBRaMlPlB5xoXV6JGcMNR6Ak9MJrG0lrib3FgxagojD1zWoyFXeqRoBPNEiuHE2eR
         bPag==
X-Gm-Message-State: AOJu0YwYIYrSXFnWkAWWtY2aF+8EEFdIzJNCPfrW1AluWtEdqSUW+6LT
	OJZnKD4lv9Ys4bkFZT2DhQNeE8PpzbAKt5w9feyJwZnFB8Ff/sn8Sn1vFxbktw5NZi3lVu9+JTt
	k7drxqKCfkUB/h1I1ixVuI0nt9I7DSgrod3fTKUc6oPTulTj6TkUJrOboCl3R79h3Qd8URg==
X-Gm-Gg: ASbGncs/zxugesa7+Dpi16vmbuE2/po/my35KhcjyeKNAuv7IMiNtfYB8dgD4U2l/Yo
	a40CXrQkQ6BSywG70fFaQPA5kbC2DjYZcRl7aPor6wLuicEKMh7ajm9IbPagjfL+BQRmaewF0TD
	FrwiN1Plgr9oaqwJJn/kB65RefzLT83bnsEn2I1/B9ghvhwgyXgU79SauzEJ3xtCviBBkeRw5Vl
	lHETfjDYe9B9zWz102ulsVKPahguASYRXl8DovEAxCxJfGghK/Ogp1/lAGcQuiLLQaWno84pdPu
	ZtIB50IZWW9APSZrTQkFl60zqEamTGaUtMBQlBqEvITGQpWPrxj+eABTZFTldEQaDsjJvK1Aeb1
	Pnyez59aR73y5xDzBhOcvKRTL0NjsUw==
X-Received: by 2002:a17:90b:1b09:b0:33d:55b1:e336 with SMTP id 98e67ed59e1d1-33dfabe6c8emr13999417a91.6.1761477484374;
        Sun, 26 Oct 2025 04:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSo0JH7nP8ynm5o4I7Lm3GCE8tlnKfzC4jpWmfkVLIzkCK8S3DvUDI2E8nIlJhjI/sdz/55Q==
X-Received: by 2002:a17:90b:1b09:b0:33d:55b1:e336 with SMTP id 98e67ed59e1d1-33dfabe6c8emr13999397a91.6.1761477483755;
        Sun, 26 Oct 2025 04:18:03 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140301f7sm4707829b3a.19.2025.10.26.04.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 04:18:03 -0700 (PDT)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V3 0/4] Add SD Card support for sm8750 SoC and boards
Date: Sun, 26 Oct 2025 16:47:42 +0530
Message-Id: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Xc+EDY55 c=1 sm=1 tr=0 ts=68fe036d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=8g3-L627ePlETrSfAJsA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: AVJ7CruuLkZyTFAF4RTIunJSkRqh7GhC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI2MDEwNyBTYWx0ZWRfX3iUwuWk4GR+1
 9rZBwbZraYNg4BwPQp/TdA7m9RqaedRfcNRorZG9IdUatjHUJgN4HA/pPL9cts8R57sLmPODwvm
 TMpzUxSm8deKvDIB8gtIQ/4ZbAbIa7A9lscgamzL+vbsncq/29mdd/JHsxLUCT4mUfTIYN+esCC
 9wr9VrrO3q0eQ3RfNojdxUmKSLSW9y977Fq/ep6i9fvlab7aREMi86QFruKM1x0lY5i6iVgkTKj
 Ul11Rgta6RyVaFthlG2SHTWZSCwlR8IvcpDnDefddYglwIs7o5FGe11ercWM9+8kue+abTP5FvS
 bn1tLWvvnd6N+VKX9K3dGhSffIC49JQo9qQCgRYrO7/jlPItPcTOjZqCFKLG9NPMqeIFDhSA9L0
 /BhT5/5TyLdsYnv64WeeT7fIdZfiGA==
X-Proofpoint-ORIG-GUID: AVJ7CruuLkZyTFAF4RTIunJSkRqh7GhC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-26_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510260107

Add SD Card support for sm8750 SoC, including MTP and QRD boards.

- Changed from v2
    - As suggested by Abel Vesa move the GPIO configuration for SD card
      detection (specifically the pin settings for gpio55) from the
      SoC-level device tree (sm8750.dtsi) to the board-specific device
      tree files.

- Changed from v1
    - As suggested by Konrad Dybcio the patch into separate commits per
      board and did formatting improvements (e.g. aligning < symbols,
      placing each item on a new line).
    - Addressed Konrad Dybcio comment to use SVS_L1 for opp-202000000.

Sarthak Garg (4):
  dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
  arm64: dts: qcom: sm8750: Add SDC2 nodes for sm8750 soc
  arm64: dts: qcom: sm8750-mtp: Add SDC2 node for sm8750 mtp board
  arm64: dts: qcom: sm8750-qrd: Add SDC2 node for sm8750 qrd board

 .../devicetree/bindings/mmc/sdhci-msm.yaml    |  1 +
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts       | 23 ++++++++
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts       | 23 ++++++++
 arch/arm64/boot/dts/qcom/sm8750.dtsi          | 54 +++++++++++++++++++
 4 files changed, 101 insertions(+)

-- 
2.34.1

