Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C123B38B1
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838636; cv=none; b=XIQMzqIVpoKb6RQR2LV2UuamXFSVrxtgI7C602KyC8nhtSPRQqyQunmP0ydWQQJcNOfsPvWfvUO3Zata+RK1KA4LtMrT8LKQ5MqamxE74wzt13PTpABgjHsjKDehUF4t6RJsbEGEW8FbViLyBZYYZB5zCcncGmgV/HECjDGIvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838636; c=relaxed/simple;
	bh=6BttG+pYAFRWMP0PrYr5zLGMt3juyzzxnfIq0WOBgHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=od7ShHX7PcW03XUQp35SHbBi776gVQ/M3RhlWo/82NPptq/u2sKitffxF9l4Ha509+EA1zGhR5DKX2g4XrGQXE8fWcUXILUusezShda1hTjQ6+kCUlOb0RTq5uuPa4aI3Z/2kniqW7vTPP3+dKWVphKd52kFF6gpdsJB9N55elQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kjCIgoiO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hg2MuiO3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kjCIgoiO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hg2MuiO3"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEDWwf2152058
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 16:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=021fetJp+lEcp5FtkRBTh8oWI63wPki+tS4
	subRFo7Y=; b=kjCIgoiOWu6WVKH//7HmzRxG1mihS93SES6s0aGP9NrPJuQS1Hy
	/lKI5pN30EOvAzQNGC0HiATy8PxyXYqoZdnSjnPRgcHF2j0ZNgvelHKF3s/Bqbo2
	hjNQH86eaC+Vetd/5oeHgYhw0w3Tnq8uQTbXrGQy0f0LEsOwr/z+Oa/uMN5eTp26
	piilkGHcwsCabEhsWuximaga2i1UYSWuhsaTL2rYAcUqqRvfdoSvr8MAYNoeC2cO
	SX3S58uvY44Ss34HTf+vRL+Cfd7OVCpntDxyGrWnlExqF3s0S3awCsiupYSdHIp9
	0bbRBq98Sm2NhYbq4Rau8RW3WMKtzPxJJng==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44v4kn93-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 16:57:12 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30ec59471a3so924501eec.0
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782838632; x=1783443432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=021fetJp+lEcp5FtkRBTh8oWI63wPki+tS4subRFo7Y=;
        b=Hg2MuiO3NcntObXfIlT+Iz6V9QFXMFT0k47I2R745VaQX+ml99NIdhfvbxAr798IJM
         yP7dMtu1L0T1h9c62MHKA7aaJiXiq3B1S1pLxD+520kgt6i+YpCGhqRydu/IAg8oqTtF
         N52rETrDaiJhsfGN9JJJEvlG8IKgOqbiqZgbXMBnsC4ila8PJoqXx0HIP4Vn5NnJC+uE
         T4HPJzexKKSsG4qYWA/7xOPZ0soS2YhNKMkM7857x6f6wuip4fM29elzHv0uMwVunkcU
         edVEA61F7X1PDt9OY13px71OJIL9rVnKXwOzbQZcw3/uMbFUsL/rpEtJc8BsoltpBKmW
         6DqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782838632; x=1783443432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=021fetJp+lEcp5FtkRBTh8oWI63wPki+tS4subRFo7Y=;
        b=jOLPSqReSOjEZWXK92M4+wMaHVoSqHpnxwBRLAxBw4x0VGY6Xbcc3fXfnKhKTgeieP
         yBr9VR21yP1MPQkaWWOxc7s+gq6nE2Ajiwv16n6Z9dvtvP2QQfRnxb62BXcyXgNZRRWc
         JTw1SJQHQ6jIZibbcAqK7LKHP++cbvmbaj0gGw2AcokjtdLJMENMIHIPdfzbWKOjyaU8
         dLLv7EYax6u89hXfgOpM1QM+/Q4iVuULD1vIokprdXGaeQKy7BDNeYhz3i9p8ptIyfUH
         t4ZTtYAkksZQcgz+i81Fgd/0r/oNS3uIGGRdpT0T/IexT5zQh1CxzsXOAe2KiIL+C502
         pcgQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1CEQQvdTyf/Yt0OVQh9YMlQPiRYgbxyE/uT4E0d1ejl9ox5GcEYAP797RHumK7QI2ntc3cLMepm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHg71kAeGYYkQdc46GurkPx2LKGmzoCfq8woTdvqCFfaU2mssn
	zkv2v3hswbouy+k2zprJ3je+vUw19siZWMFz9L8mnhmuieXsQC+KX0P9tK2i52tnC1lTZ7Amx2h
	okGyvi9Va+VoJcqeJnD0STgJQnI1ca0VgWMk1JTEOnNupO7uNN1HRCbiaETBd3Hg=
X-Gm-Gg: AfdE7ck1+ZTnNH5V3n7LJ2OB4iAZrKmUQe63iwE1lOz+DEo34u45/EDDH2v3Ts7mK62
	QhP7TZm+CQ5RdX+pAanxuSSZTcpcOyNusw06cExcyfJAFxf9qN/59jICUOjQbrUseMTroCjT0Wi
	0SIomd4Zok5OssyzN0LFIJiKdhdjLrY58EDlvrATxDboJGQBjco13+/72/hRs58aYVZKCCLiePM
	XIn71MnRqtsTujjXBjaSX5SqaiAcUueUzRKQ7GCufypVsv/W/fZKR45v4IhumnXx9EU7gKnOOPz
	wMV7fIuSaLzSc+oktqzfXt4ewHAUVBvTLSyK8vrqdQ1rHIJauTkfiGEZSnGt8nGr9BF1UbRN8KT
	0ePHQHrJ9aS8E834DTTKeXxIg2aqzExnRmRLzW1U415U7gw==
X-Received: by 2002:a05:7022:6ba5:b0:139:ed5d:1b53 with SMTP id a92af1059eb24-13b2e32c0a9mr1683469c88.20.1782838631998;
        Tue, 30 Jun 2026 09:57:11 -0700 (PDT)
X-Received: by 2002:a05:7022:6ba5:b0:139:ed5d:1b53 with SMTP id a92af1059eb24-13b2e32c0a9mr1683429c88.20.1782838631472;
        Tue, 30 Jun 2026 09:57:11 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2a9b425asm12690272c88.0.2026.06.30.09.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:57:10 -0700 (PDT)
From: Monish Chunara <monish.chunara@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
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
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Monish Chunara <monish.chunara@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH V2 0/2] arm64: dts: qcom: Shikra SD Card support
Date: Tue, 30 Jun 2026 22:26:58 +0530
Message-Id: <20260630165700.1886608-1-monish.chunara@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: llMV9pV_Ob7_S_uDVbidnhdBYmV_yttF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2MSBTYWx0ZWRfX/s5QVEWiSPvT
 RXuRzQylNZVoBJFTvz2jKve6pJ5p0UsJGOD1VCFTho1vS5F2kPnjOPkEmvVrofDf01ONdhZFS08
 IMwylBA497/e4H5DhfliXcEUPN0g6pw=
X-Authority-Analysis: v=2.4 cv=JI0LdcKb c=1 sm=1 tr=0 ts=6a43f568 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1w3StAHzAm3vCDDRDnYA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: llMV9pV_Ob7_S_uDVbidnhdBYmV_yttF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2MSBTYWx0ZWRfX4sfkCV8ffYji
 RKkeRp8bjmTi0vazGP3ZyekAAUAE7dkZI+RV0JOnO8l3RCCyxCUn26vtgUAW2ebx8EjqX+tTz1v
 d7Ijl26AMuO4yJE9s6CBmP9JDCK4tU10W4QpOsb7L21jH2KkHfaoSRwScfRbdUJwriPnopC+/ld
 oIncL6SpOYd9aUYBp1JRjx5dDn/XabWML/yHogGINI+4Kn7exu79nvRRBb8cG9J4CQhtIyhEZaA
 NzcWYIvpDKwJ62eGbll1pVgduCwswQ3Z8/3pGWoq2R2F3LKhcpbDwS5CCUvOGe3imgdnK/iI7kG
 SFmbd8kdLxMvJr++X+/L2ER5sssfSPMS9gYQWyeOddsZAy6m2qikd87sWGRM3VqKClzWZPg9bwQ
 Wx/gM7hvKx963feePAlD858C+tKE2wiNyPz9d18TvCa/hfQrLiKoPkDq1EKP2XgIQBZRAh4FvrI
 ft0nJN5HXqj2ZXYry4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300161

This is v2 of the Shikra SD Card support series.

This series adds SD card support for the Shikra platform.

The first patch adds the SDHC2 controller node and the necessary pinctrl
configurations to the base Shikra SoC dtsi. The second patch enables 
this support on the Shikra EVK (CQS, CQM, and IQS variants) by defining
the regulator supplies and the card detection GPIO.

Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>

Changes in v2:
- Rectify the alignment for clocks and interconnect properties for SD
  card
- Link to v1: https://lore.kernel.org/all/20260604122045.494712-1-monish.chunara@oss.qualcomm.com

Testing:
- Validated on Shikra EVK variants.  

This series depends on:
- https://lore.kernel.org/all/20260612-shikra-dt-v6-2-6b6cb58db477@oss.qualcomm.com

Monish Chunara (2):
  arm64: dts: qcom: Add SD Card support for Shikra SoC
  arm64: dts: qcom: Enable SD card for Shikra EVK

 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 18 ++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 18 ++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 18 ++++
 arch/arm64/boot/dts/qcom/shikra.dtsi        | 97 +++++++++++++++++++++
 4 files changed, 151 insertions(+)

-- 
2.34.1

