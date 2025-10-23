Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4F30DED5
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218976; cv=none; b=E4e3NJZYLFU3NT4mP+AZMiaAFJobqbIw3F0hTd20DEYYi6ZIVj9baYTUMwb/O3ZkuO4LWk3zupraiSPUYXfFmWYNPhxoMhGc9KJ651FLsOjw01+k0uRom93g5YfTEqAW+tTOzO8YRdgUPxj5c7DwCebNBC/JbVhALZGejb7baMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218976; c=relaxed/simple;
	bh=1jDd8Jo+Lv7AsUUim4V1DT0S98q8LzCRKW9vJCyfXzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aJi7uCCAeNnTNbtnlgxDGeoFS1kMAAwTZLa15GhR1qwuNYyCBtNq+mHUxxD3pgCZoXHc4sAqbf3sDr4i1aJt6Iw+glNN+yOFgbDHxS4WmQJY5CS0v2oTgezWKTE4nsp3jocjejZYiZDOLQuyCawmg4bEVdlN6/TNDK4MTP3WXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iXtv2thD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iXtv2thD"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N87F1Q020803
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 11:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uIRW+tJ1sHh9tj17uy8X8x7Zj3ryD5FfPGl
	NlKORe+c=; b=iXtv2thDlKf4FPos8+PsKBw1o7i9eT8tarlGQYJLZPDDpLSJt2O
	67pJReCvMkC3KCMNvCwlJUVRgfPywQ4vgGqVdo+YVn7wxd49hj8ZTEx4IEpsIkjE
	hfITtfBCfsDdQHfwv/7kQhJZmTWK6ajcz5bAu6Kvq8FCuuWbjyUQ417YOqTVsSmp
	J58Ff7UiOP37sw8UmD4EBciw+X+ATRE2+fB9o/UAOHb3i5u+UuJzP6TXPeVjpP+W
	+H/G3fccBZPoqa5AQnKV20szz66LBkmbpnYxs/JIemnhy6O+NcSHc2RNSV72PbSh
	vC8M7r294omwJ7osqcR0LVhU0ITcf7BIXGg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y67qj5dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 11:29:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-26970768df5so1512905ad.1
        for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 04:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218973; x=1761823773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIRW+tJ1sHh9tj17uy8X8x7Zj3ryD5FfPGlNlKORe+c=;
        b=svHWxeLANqE8zz1eUKX4OCdvo/KRwokyJIGYaix6WHuItmFJeFjEeOU0BKF5zEEYQv
         ZumTeowzdJQ06zBP0J7v8ZGyIJxGaut0zZaOH5VN8Bs4wb1uATI1IfIesxD8DMtkcmsa
         lUNjHe8NHtYtQ4bo8ARJ5C5EgyIR0ehXj0EkOgxM4d/GUPv5XfjdPgMccWCKkWi2bibP
         cbvUaNL3M8PZ3Qst+Rvz8WZxpWRXG2NM55xbizlQxHyJIDk1P83heEMSsQRpqOOsWFEr
         h3QHD2L8TMvCA/RySJCUFki6WsmxLxGOX9Rrghta3mSJOR2aBIf17T5qLBdFS01vXVWY
         AQ3w==
X-Gm-Message-State: AOJu0YzVj/6xoErLb4aP3f+wt/oBYgK0/RZzfuKZKsYPGe67cADN9AaS
	vXPtJSrbAyWBjYmhnRsMh8uvqAu2nzJa0BffYnw8/uLn7UMfyyhw4um/F7y71+L3Xn7QlYSsV6k
	Ga5uLGUFYQl0rBB8bSEIga4bwLtFPQqzCLlXuFd6qaB1PeOhJyA5RMF/CHHbozg==
X-Gm-Gg: ASbGnctfjaks0XvVchzsGfuwGyJvy+kHWzEEDwMtswDAkeZjTklo44zo/nwkQcrnnac
	YH/l591WdcJonUj8MAKAhRSoZ3lBPF2bO9qGofASYTzn++eo1Xo89VOpwyiSSUhXSnz1FC6xQkF
	O4WnWy7G+qCFBeEYlVn1c2TG3wlIy1dWwORffq5eS1jD6fsTDX8aVw/d0ICgx7GnqmudA4thRG4
	HVImYzJoV0zaDJZAshOLzLmTvyWHFXljotJn3Wa1ukpohRPaIaD2IJvlu2vWmU4YvzU40Tncbv1
	FRbQF5JMAe3RT+7IrgriY8W/Cxupek2tpMaedYWts6XCJkmhfLD0yGEcokq4Cj7WASYGnIom3Cy
	MQtvtgWSbAocImpTSdh8ok7F0RjG1ow==
X-Received: by 2002:a17:903:f87:b0:27e:da7d:32d2 with SMTP id d9443c01a7336-292d3fbbf0cmr66007985ad.7.1761218973060;
        Thu, 23 Oct 2025 04:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHL+TU70n2qTyvfs8ktt+I8r3/ZZAeRdKHl1cuECS6O6kimjZqydFi1762GpAmBkKwHt5XsA==
X-Received: by 2002:a17:903:f87:b0:27e:da7d:32d2 with SMTP id d9443c01a7336-292d3fbbf0cmr66007835ad.7.1761218972688;
        Thu, 23 Oct 2025 04:29:32 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e1231b0sm20438815ad.97.2025.10.23.04.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:29:31 -0700 (PDT)
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
Subject: [PATCH V2 0/4] Add SD Card support for sm8750 SoC and boards
Date: Thu, 23 Oct 2025 16:59:20 +0530
Message-Id: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2OCBTYWx0ZWRfX94P1SpWdWN95
 HlJTth9KctD8R7DL1CljFUkoH9R5kh4LfmQN/IQWqWTFVElIMQIbPt9ot0gyW2axBdVTwNfUAk4
 KyyukrQun21RHrHOwcmXkdGZOLeLym1Z7KO1SI4JVv/EMLG9YX9jgKR4+46cJtFG5KE6n6SPCEJ
 YO79eFXRJNasG8SBVfF3TqJob2j/pA7Wq5YU2ZuoW/LOmdWQ0uI5+l2Sa0KM4Ee+CEXYL4LFT40
 26+IkUl0RhREC2dKPkn2oMrSpwjmXeDBvajxZ335/zvoz39+gj+DVsq8Cy+T2yB6tWVmp0msTOH
 KKB8Gh2PKcM4EdpMORyBnAk63jZE9NleWed4vo4duNiIZDAQjWCYEr/jHUxwl1Xk4ogEx2PS+xW
 iyt4Tnlh4MAJo2UrleMFOtpUHiAL0A==
X-Authority-Analysis: v=2.4 cv=LMRrgZW9 c=1 sm=1 tr=0 ts=68fa119d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=3Kx62KuiyRAImmK_TA0A:9
 a=zgiPjhLxNE0A:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: H1srKkEiBs9WKEUe4Nd3wcJjgPeC9znc
X-Proofpoint-ORIG-GUID: H1srKkEiBs9WKEUe4Nd3wcJjgPeC9znc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220168

Add SD Card support for sm8750 SoC, including MTP and QRD boards.

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
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts       | 16 +++++
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts       | 16 +++++
 arch/arm64/boot/dts/qcom/sm8750.dtsi          | 68 +++++++++++++++++++
 4 files changed, 101 insertions(+)

-- 
2.34.1

