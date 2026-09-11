Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B02A39A80E
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119588; cv=none; b=uQwmp8s4+2KGP77zTNP25IxhC4U3W39XEHvQy2DIGmuZZVbKR9gG2AuU38G73pxPaxJ2KcSvKDEwPNbTDDWAfrSjqMmZkcndCLOxUzglWM57WqA6HWYn5yNUVoFeN3CUPtcb0nsImQ77PFeF8hIwudaeejfK9y4t4d2UvlrywCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119588; c=relaxed/simple;
	bh=A3670cG5pqWhdM+3g7uDH/kQDG79YTkWX2wDkBAkcsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i5/jgiIYEiDNCI/sGNDMeboXyMnDVeFY0nXWqDrnovPAtcnM4rpsqIekUKUAlegluvgGdTR7I0z5DCIA2bH0m26AHMHaUOfnCcjK1Q0iU4arVMgo8TzmIXwM8ugrTTH0H/hnCHPw2bMeZw7qME2d6sE2qfKy+FajwrtGpEWhoig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n+wF5XTI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iWB/SVWW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n+wF5XTI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iWB/SVWW"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7kpjo3513951
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 09:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=B/U7CAw0STdy1SmtzubC/sAJKFjxf4bCxFS
	FnjNHPCY=; b=n+wF5XTIrZ+1D7pGljJ9uDrnMXx1wkjjkeHp/QEjQTZTV/8TW1S
	tYKfgM39vYVUKBeMbqFGX/hLVImJQShG5zrKiXLKLrdFygpd63Uey3PrpOkPl1re
	Pgy97mEfDGNsj3AOpFP3GL31W/uI4h6hiieeo4Spt8UedN+Tf1+6UIlnigIoyuyc
	cta94oJcSYwqSGp3xg7IaUkMbdlvCIwSLF63eWmmVMAT5eYKq6NGLFwMcE7/jCOO
	tGfb/uv+DROik4uc89p+LnpM4uUZiHYQ0tO3tOXuIKVWO/RkuGILa2+QEcNTg+Ag
	ChVYi1ql7pSRT9oHbML2YOl0d5g7Nfe+pzA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd50ywt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 09:39:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-385d2703b64so2147753a91.1
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789119583; x=1789724383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B/U7CAw0STdy1SmtzubC/sAJKFjxf4bCxFSFnjNHPCY=;
        b=iWB/SVWWxwggMKTh2STJzwdPcBgbilw1PQPJqJjInXuAIkYPCZiLD7t23BMOKrqT+V
         HRZeiYCZFonEStwWvtMav5YsleQ9pApgujflXUD1ZIitkr01u9nd9iODvztOOZqpvEa/
         aPx2osw7jBG0pTpHpvMgrmwSOcGAgSphBUTTaD0rMBQ2bAz5fMjbmeNWsJS3ou67YljJ
         jE5a7Wl7q7BcZRm3exLfqkIGp8wGA92xYrZNf2rhpD7WYoTDympPb04RuG/rpqsyjhsf
         9ZVF5lEbdptAaZbbV3AOxQJyDqW2zLYy+Hfwz8swAM4Fj54L8C9HmIkMMsMwqeDBp2sE
         xeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789119583; x=1789724383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B/U7CAw0STdy1SmtzubC/sAJKFjxf4bCxFSFnjNHPCY=;
        b=rxBiawabPs6tmAhffx8SIZnS9xWZWu3yWtanCHxW0vssvGVaCoQmI5GlQv8q4YOXNf
         7MVfrHSX4UiUpRsfIXY9rc7LJNTfI1czkwtOR0TfumzldVgr5YHLuzYlhqw0KPnDZ2JR
         RiJGTitivY1pG9/GGxJh4JcgZQWNib8KJSIycM1qvYXwIwV80AaHcsPhVkKsvxFdyVXf
         BJ0/FcwsNUT6fkqsI5SviP7Fhz0ACtC9q/oCKcd+viqVxWsSK0pDN4nViCEQjKYKPRGR
         kLvvA+9EUHVrwrjOJ+YysowQYWXrNnGyJIOsnU6n645q7GZElA1ILuTwHs0sZ19ioafg
         prMA==
X-Forwarded-Encrypted: i=1; AKwUvBzzvgVeZdZebq1U/hTVygjgh3Z6M9lNuzADyB3jJKnF0VT2SBp5YFh4Z+O9stTEkZOL3HUpnDgTKgw=@vger.kernel.org
X-Gm-Message-State: AFuF++mSb7vCp1UN7FVVfjxfNLnBKUG7fdFRxV7x0tsYwZL5waJwpK6m
	Qlsaq9teNRD53hl+mbyBlq8pUcxXWohn5Uoi8WW4DcfvphQv/Hk7VM2OUPH9KwPFTlwP9cex7b/
	smwPObKnpfnW9r6oRgIfhsGH5QkbEVF4Jru+Y2vO7tXIJIlBujWpHo5p7FkVgS8k=
X-Gm-Gg: AYBFou2b3YBDPKDHZI21CCu5srU25bX66Ia/E84K1+z8zCpTUOzoZXNCxFjIgCT+6rf
	Drl30pV9hkdKns73KpIskMi15KZr2y+DPLKzcMMY8l5Kf4OPKWzpbTaoAV+OReeSvCCpociED6m
	UWz4RTVXUPw562KpLiLnvOmOu99F6eTVsqo0envdjdod4kXAN8CHlifK2dktCAu8maY9oFr2BnC
	wpgoleR+cSHd2Pw5ZXETzDf5TWEa+z/sfTCC5AOU8tNUrYNSRVYnIVLXLh0em91FjOJhNTdUotG
	kpc7lvWvnfHz64/NQDlJHNFOgFHFaxwED91ZTlRjlc4a3Cl96ER9Log3sSU2gcB2X7/YbTXp3iM
	y0yNIsKUyyHh3tYeN1vbJB2dUI1DDig1ugWE=
X-Received: by 2002:a17:90b:3fcc:b0:38e:a52e:a3c9 with SMTP id 98e67ed59e1d1-39d7795b9aemr11523605a91.8.1789119582938;
        Fri, 11 Sep 2026 02:39:42 -0700 (PDT)
X-Received: by 2002:a17:90b:3fcc:b0:38e:a52e:a3c9 with SMTP id 98e67ed59e1d1-39d7795b9aemr11523568a91.8.1789119582489;
        Fri, 11 Sep 2026 02:39:42 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm5549984eec.24.2026.09.11.02.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 02:39:42 -0700 (PDT)
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
Subject: [PATCH] arm64: dts: qcom: Shikra SD Card support
Date: Fri, 11 Sep 2026 15:09:30 +0530
Message-Id: <20260911093932.2376058-1-monish.chunara@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bU2-r8AHpG6GqfvpJ1DtqF6p65cqqRvR
X-Proofpoint-ORIG-GUID: bU2-r8AHpG6GqfvpJ1DtqF6p65cqqRvR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEzNCBTYWx0ZWRfX3jErAp+/X5Zs
 0hy3UAjAaAGZmtiUujQun+cLsWT2Qo9DtX56vJJjM723YT52puvz6vz4r6m7I4r0+/Wt2yQfpXo
 o3SS+JZHoRghDXFoOp8URX0r7yhyTHE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEzNCBTYWx0ZWRfX57Xc53EpFa0A
 DklQmnpKvIVu62I4CwjwiTKts4ftpl3RAoniuDUXEHqAeP7hdmx1Wlt81Tvsot3NdtGQHIC29O3
 3zVd46qKYRQCneGs8vjMqHTVsSb56pxB6sMu2FICYZA6mfDNXs6nDti4L17E2fD3LiKAsGaaoxv
 g0bo1McC5KLkbMVQ5HYh4NDesYlJUwliza1ewtb0IqYeMO8mL1KuUsrcqdzQueLYJK+tsjTLF0D
 ftuc4w+TGzuuYLgAzd8gbtwzqIttDyHPrEFKcvuNYhmkK6dAG8lGsHTFguM5JViSJQXeXwgEqcr
 MKwJwRw4zV2tLBuJyIXHGpdiN9iZognwU1gWQcqdPt43EHO8Jmt/5n6oI4xXTwjKPwk1DQ+sSwq
 sScYq9YQW59zxKC9+kQMFmiXrme56lGVqa7mXUiaE69UJcqkBfON/M5EFQMXyF4AqhwAQ+jL9cs
 DvxKpakcdffpTAbf3nQ==
X-Authority-Analysis: v=2.4 cv=db0VTnXe c=1 sm=1 tr=0 ts=6aa3cc5f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=LG_lQ-h6YDT1eqFI4YwA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110134

This is v5 of the Shikra SD Card support series.

This series adds SD card support for the Shikra platform.

The first patch adds the SDHC2 controller node and the necessary pinctrl
configurations to the base Shikra SoC dtsi. The second patch enables
this support on the Shikra EVK (CQS, CQM, and IQS variants) by defining
the regulator supplies and the card detection GPIO.

Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>

Changes in v5:
- Rebased on top of latest linux-next
- Fix interrupts-cells to 4 for sdhc_2 (sashiko-bot)
- Moved gpio include directive into shikra-evk.dtsi (sashiko-bot)
- Link to v4: https://lore.kernel.org/all/20260804122054.3462145-1-monish.chunara@oss.qualcomm.com/

Changes in v4:
- Rebase on latest code base
- Collect Reviewed-by tags (Konrad)
- Drop the dependency link - since all base changes are merged
- Link to v3: https://lore.kernel.org/all/20260702073354.3641966-1-monish.chunara@oss.qualcomm.com/

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

--- b4-submit-tracking ---
{
  "series": {
    "revision": 5,
    "change-id": "20260911-shikra-sd-card-61d428639de0",
    "prefixes": [],
    "from-thread": "20260804122054.3462145-1-monish.chunara@oss.qualcomm.com"
  }
}
-- 
2.34.1

