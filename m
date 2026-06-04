Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430584014AB
	for <linux-mmc@vger.kernel.org>; Thu,  4 Jun 2026 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575659; cv=none; b=lzD3JcmZLi4Uzgk/FQTVvC2MdIG9kTX+isfiTFc0nQ90pJfJvdH7PgtTwHH5MrPEnef5/qsXbG9+OL9QVNG4rX3KwFLJinfVBmJRpROec0voNU8TAE3tcPBLcfEEU+3HF2Ky8+KhwU6/hX9Uy5kdHub/SjhbPMOQi0lnUgO9G+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575659; c=relaxed/simple;
	bh=p5xkoa1gmzX1cE3P0oVCRxj95EpSdryxboA/A3wsVfo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uzp5R0uqyI79llfSvh/WTbLCpK/TKCD49XvqfE9EMlo1oHMCepZnlMWOyJIlwGDjn/ifi6ghr5GkW4PtCrwawzG1IF2nyw7627VAskn4T4CvjyZydcFAqwr/52qA89XrMDHfRjGLIkg9enGQbzIMGpV31UjM2dOV+PF7jhmTzmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GkSlNpTv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jO3h6HsG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GkSlNpTv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jO3h6HsG"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654APrPa1993364
	for <linux-mmc@vger.kernel.org>; Thu, 4 Jun 2026 12:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=shQsQJ31RNDx6YS8P72R3K54LrumYBDuPna
	sYDlIeVs=; b=GkSlNpTv+1E4moRuv1BAC3kOWj9w1MEWZ/fO3nBL9VAO5wSCqkH
	7YVqndGukM2rGajUq2S1pyvmeK4kNDdHt54v0TxoPKeZHsjycCRnPCMQ5JcJ/Wex
	Q9uKprDdd2ecL8fPs1JmKhq4tGCAixM9ies6bUvuVGvnF9Rv7+7fSG/b7P+iFVWW
	/epj3CKhdKrxNLiY9WRLroZqDZNMoufrJ9PsIB4vI90Zb81yJ2SuI/iIW96D0m3B
	3nwJvSXnWpQ3ncnvbjEs+Y2K0zhsXdL4RW2CgoFqhZEoxn7TDx9H5OLIiizXVwdO
	FMfbbw4llryJnvkU+Ol9XIYjgWG3VJ4tvhA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs8pukdb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2026 12:20:57 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85a2ed88c8so796714a12.3
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2026 05:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780575656; x=1781180456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=shQsQJ31RNDx6YS8P72R3K54LrumYBDuPnasYDlIeVs=;
        b=jO3h6HsG5t8uhRySCRfkhAtWY7UkMisd+sThzIsT/y8VKbKAUETkKllpAmg55DeLAe
         nOf6YqD68WK5qVNF0OVylkHKWmnjUvsJ6DGEDviVAfb5/nu3ra4okd2Y5NhKUempuRI3
         mT/DKf/ZVz9AZwm3Z9P6EMy98y5L9FdaDK/FN9JJwsGIUWnaPKvsSsmTs4c/99zuUmeP
         heirnbgVJGW6mrl1LZTuo7uhczSRMs7k8WI+p/1HviMSJauECRmzUywauin0n9mKDiZY
         JYut7MyeuCW5n07gkU83SroL49GamZnsLixCezjPDhIcEhtMV4bbhBUCv2EUQDEKg6Qu
         OH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780575656; x=1781180456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shQsQJ31RNDx6YS8P72R3K54LrumYBDuPnasYDlIeVs=;
        b=m7KpmLx0gZAC4jsaDZIMVeqUL/gQjZp1G1In687SEQ0TWMsERJ+S4rz8cfom+eOP2y
         NyDFxsbOzmk7PPp5euYc71spKrbQr38yzJQXCa2f5n8oy30pAWbISDTQXCW3NXbhwIyJ
         uOa5TcCpWkf0lVxAlBN5b3NVQQXk9WBVkNEaUtK+5l983+P4uV0pkyyUdnrBAtf0Vbcc
         Xl5LfUZJqcHfrn+F4OX7pgFbmFDiswgZyZH1R7gF9AH1tS18eThRgzB0Rm3Wqddqgj+9
         b4mcfo3/zibY0aJC3g0RJzl/dl6uS8X9eHljn/Dtp1kCDpaAkdoMLsclqP2JXFdYxrxV
         xrow==
X-Forwarded-Encrypted: i=1; AFNElJ/LRBqAxSERFlFIg78ZEnV8cnph8JbZqaz18Woe0UcQb8dgeyZhbN/D/xQxeOJxg4wpJzfHvCxNfGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYEzM4ZylydZc3MXIc/3vxF6jpdHqPMhuSnI3+FYOgBBfgl2oG
	uLslzRf+Ngqf0HfGO2l1ftOCSmsrL8tHjKLmMQMXBkGMLp758YGD7kOxmqgTAy3yALZmKKXPcIW
	mceoZqh9uzOLdD4z6Y2MX8/qFUxWYgW0ibJE7v8YlfaTBT1wkq53XrcNcsA+qlw0=
X-Gm-Gg: Acq92OGxnWM24DbSQl0fwuebg5V+6DJxN5q9qxYYuQAOTEAa44+gSkDrSuy6BSgbrV+
	PnIl9NHbNX+uoyJQ+p9qJXuVN37djgtTNmgTUONFNVUaUIfavz229H65a+W7dIn1refNwwR4PA/
	30WQ68gWcRDWh7DuRxrwFqaluKQPogKysj9wYEdeay4CNRJMn6z9iO0v0JLhHD87V8vOxcQfqL5
	LvFgFzy5ERz9mpD4fTF7bBUK4nc9wY5mUOEE7xabdYvCAzq9U94HVowIHDsoFC/pb68llfQhye6
	4S0vOo103gu/iOGEiPb5OxGd6d0ajHZ/GWWGBP8HXd9Bt5gJzH2SuqD/s+X+l6W9YVUo7qSsySx
	SaIddp3OLLNtlc8009mr3nXwZcd/OLq2LG+cnvTwmTENhLPE4jYYZndlwimKJ4XX1JKc=
X-Received: by 2002:a05:6a20:d612:b0:3b2:924f:70af with SMTP id adf61e73a8af0-3b49798a73fmr9004099637.45.1780575656076;
        Thu, 04 Jun 2026 05:20:56 -0700 (PDT)
X-Received: by 2002:a05:6a20:d612:b0:3b2:924f:70af with SMTP id adf61e73a8af0-3b49798a73fmr9004067637.45.1780575655609;
        Thu, 04 Jun 2026 05:20:55 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df045c2csm4796903a12.12.2026.06.04.05.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:20:55 -0700 (PDT)
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
Subject: [PATCH V1 0/2] arm64: dts: qcom: Shikra SD Card support
Date: Thu,  4 Jun 2026 17:50:43 +0530
Message-Id: <20260604122045.494712-1-monish.chunara@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NZ5D2sgBxto3TGKv4ib0hind6aKOT9SP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDExOSBTYWx0ZWRfX4y3q87fHze9b
 JAGypr7xdPI2F0U72B1KbvyeFmMlirBJKaLDC+p7mxjM4te54DiaGn2wVecGrFMcNJ5DJW5BAvf
 T8KoZ4x1O2GlM7NH/lR+J3PjPnG+N55PIoig/aDpqY0PwWfuN8fCzkolRR2Z7Kq9ddreXs9Bd6F
 D25eR4hn+uDkPbW7B8BE4WPVV3B762GebUFJGAHbNBRoffjyCN7DgfXpCrpYC45tWwFa7y94GpQ
 ikUBDdIDRfrqMPzomnFsbQwcb1eSKAFVj7CHxFxX1Zm1zGcVtHefEaUngq4NuvL6OJ4cRPsoAGs
 W+xqRME/oiHRcaJW69KQiRvD6Iao+qPxrDEVwWrS4x0uthOGzRjvwbhlxssfDmRzj0ZJw8C141W
 92MANLn7JRuS4Z5uJ2mdcaOUR3r6/8cRfTYkpmY/H2gce4cqVB7JsJ2WVFwhCz6jGix9yZpWENm
 D947sMf0VwH2pWfe/6Q==
X-Authority-Analysis: v=2.4 cv=E779Y6dl c=1 sm=1 tr=0 ts=6a216da9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ms6Ar7DOZ4z9uL9UNCMA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: NZ5D2sgBxto3TGKv4ib0hind6aKOT9SP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040119

This series adds SD card support for the Shikra platform.

The first patch adds the SDHC2 controller node and the necessary pinctrl
configurations to the base Shikra SoC dtsi. The second patch enables 
this support on the Shikra EVK (CQS, CQM, and IQS variants) by defining
the regulator supplies and the card detection GPIO.

Testing:
- Validated on Shikra EVK variants.

This series depends on:
- https://lore.kernel.org/all/20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com/
- https://lore.kernel.org/all/20260521-shikra-rproc-v3-0-2fca0bbe1ad7@oss.qualcomm.com/
- https://lore.kernel.org/linux-devicetree/20260513-tsens_binding-v1-1-1780c6a6caf2@oss.qualcomm.com/
- https://lore.kernel.org/all/20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com/
- https://lore.kernel.org/all/20260522-shikra-cpufreq-scaling-v4-0-f042a25896c5@oss.qualcomm.com/
- https://lore.kernel.org/all/20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com/

Monish Chunara (2):
  arm64: dts: qcom: Add SD Card support for Shikra SoC
  arm64: dts: qcom: Enable SD card for Shikra EVK

 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 18 ++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 18 ++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 18 ++++
 arch/arm64/boot/dts/qcom/shikra.dtsi        | 93 +++++++++++++++++++++
 4 files changed, 147 insertions(+)

-- 
2.34.1

