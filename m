Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC835959
	for <linux-mmc@vger.kernel.org>; Tue,  7 Oct 2025 05:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759815902; cv=none; b=fSSuxCM5PoF+5x0BDzCKgcjLZLcQV6shryazpVwquFJIfeOOjxv4R74/aou+q0Grq3CzVS4d3Qav6Xjcb2eBfgyuA3gmmdUiMSp1eLaARlVExbGmeZQXi1Rtg3EVQDDak1LNnNj6jw01hV+qJaBTKHOJ99HjIt1+zcoTo+6yGac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759815902; c=relaxed/simple;
	bh=lpVzjcBwOXM4SN23tt4fC4BA7Luy5Tc4dyql00/KvbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AIrRlRBm30GMk2yWUVR0s3GvRxh75UqzOuSlktYtvwTNhiFolR0TvFB8K+/IHPmZ1ns0B4SH8tkyUbrG6Ae/eo1MAY0uHXqVCUhnvNWCxyC4eNOxjq3EwgTRjFA1pUixEGpIavFDLTtfJSYh2dbDg8+EvijQsMJetjykKiENJbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zprfjm3E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zprfjm3E"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5972s78F000300
	for <linux-mmc@vger.kernel.org>; Tue, 7 Oct 2025 05:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KIJxcpMYEnmG9XD1E/vZXymkquIdcw8T6Th
	rEVdfbdM=; b=Zprfjm3El4N+LzprHmpDA31d9ZXA+SJfAUUFr4zpz/RHl93B4Xt
	pko78uyV6E/E6izruKojrzlvmQEqPXSTIa42gFE2Nqm3pJJeX0g6PksGcHE+s+c6
	lIu6ncdY8kkuCqsqVg5fIAWbbaAGXMQIV5ICiu3dBDyPvVCn5XwDHsEwV1tu6YAu
	7U87cZDudEjLg99hmfp38O2fKrl64s45ZUQK6DgOquY7+vI9JMpNVfkRU4qN9YhC
	Zk4PqYgflilJzq0rgPoTzxGsrmO6JdMf3kAWNQFUTg3RxU/Pp80N5ggzRuXoX3oh
	EnzLnNtc8ZBTSb7fnMbBWIOuNmN/qmr317A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1p3de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 05:44:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3383d1ce439so1880475a91.0
        for <linux-mmc@vger.kernel.org>; Mon, 06 Oct 2025 22:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759815899; x=1760420699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIJxcpMYEnmG9XD1E/vZXymkquIdcw8T6ThrEVdfbdM=;
        b=QlRREkpE1ZKECUu8O+kJh1cyJyszKayp/o5JS0Zmr2mPtuze+uHnHMzWIeYmiLTBQd
         lnZtMUCBzMX8irH3i7aGDgpWWUh6Sw3OC0SsCBhfXWtOkY5cXBOiUg11DCACBdRcZpnE
         KM5RqnWNR8yADa68wwqrt72KpL8/RSlEgmkDlbj9dMQlsnuCLGmtpBl8sXgzamIBytG3
         7Ngvaf3hojLFnXIYxuRZ6lLsNS9CWuI62skE+JezHfNhvwucj3Hy962jMcE+I00anu9z
         xPbT6s2cv+iLEzIWe3PZJK4aPQgdWig4PVz8X+o6MY5iJ+/7vMlgRiV6rWc/dlCiZ6O0
         oq1g==
X-Gm-Message-State: AOJu0Yw/a/wEvgiRUkyYw3X7qdU73kZ11/PzkPixQz5gnDml76ToudVu
	/6Xvz6tuMWWEfxlaKipExH3r2HttOf6fqW0C1UgXxqjxwBlGpCWIJUPGdhPyK8gqMnepqen+NUh
	cqBRJyHXqooh5pw1Ik5VFouvZNCv31uhzVVhtP2kHQ/Hj+Y1xNlWOh14TlfhzFg==
X-Gm-Gg: ASbGncuMFssLCqu4HvGOs8GMmfX9CwHb2lyiZjh3PX8eN+bli2l0ybkJ3ycGo0bmhiG
	0NuRkguXwlcmMWZ3xqswqH+1oaTDYKeR8YWy+eOsu1oD9C3lErsV6XGu1YTbFPjSxkI/N7cI27c
	BytL8jihDgYDyBQ25CRqvfFI2VgDRU/3U8lI7lV/FuTUulom9HAA45sfh4gd+5I0wVuvDAARGrt
	zT2lqJsmjEvTD2fYgwAfiKHYXdj7No9o0PrDECnHEIh2+/wOaIvZEuUZLDgnqsw0+WWYczmxpA3
	AD2OCOVuHVgyMsHI3gjZ//cCMATHysHG5fUxEUDDU/fajDzCFPHnZ6x3lLy8g/uLXpJvclou8s4
	1
X-Received: by 2002:a17:90b:3b86:b0:330:7fd8:9b05 with SMTP id 98e67ed59e1d1-339c27a2520mr9699647a91.3.1759815898937;
        Mon, 06 Oct 2025 22:44:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErGc+yIrFJKtSY7vYdT2RQdgafbYIfgt1qp3puRvmqRiLtMmkJVl+tUt+GE7S4w+S4kSKxag==
X-Received: by 2002:a17:90b:3b86:b0:330:7fd8:9b05 with SMTP id 98e67ed59e1d1-339c27a2520mr9699627a91.3.1759815898418;
        Mon, 06 Oct 2025 22:44:58 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339ee976b81sm502624a91.6.2025.10.06.22.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 22:44:57 -0700 (PDT)
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
Subject: [PATCH V1 0/3] Add SD Card support for sm8750 SoC and boards
Date: Tue,  7 Oct 2025 11:14:42 +0530
Message-Id: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o9IfjcdbDv37hTcZE7Hxi9ARfT9gnGKb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX1tBRd0VHZoN5
 Y1N1LPnILnJEV/fEJ49Go8ZSOmmJQJKMrYVhK7snrcgXG2CL2P+tPkZr3erKIkpePbYaA5uWvRK
 lrER/mlfq1NUEDzwj9X0EurQiedDw8sI5Mm5+1NW1QXn4VaH4hiOyAXw3B7THXoegSJhn9c6YIc
 t3tRJz8JvxYtZ5rkb8FW1I7HZyQT9zqbCmbSK8hqKpm7i9tDWetmLTPjX0PkJ2KHWMMhHeZ1X7p
 KPj6TyxhzQaKa+Api7Y6vMZROASPlJ/IT8BBn1qBqRkWajP4Bi5w6lm2PuJ8ahJ3ihqpcDPBvwb
 b1dt6GV5OC99lyWXNxYP8a6RfL2acEohwnOZn25rArP3lBpWSrgXjS4IFQEK6zftr7RQ+316qbu
 +fHaCQZsAC9KTLT/+W2oGvFraDUjJA==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e4a8dc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=F0tEe3Y5rRK-XVa5dUkA:9 a=zgiPjhLxNE0A:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: o9IfjcdbDv37hTcZE7Hxi9ARfT9gnGKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

Add SD Card support for sm8750 SoC, including MTP and QRD boards.

Sarthak Garg (3):
  dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
  arm64: dts: qcom: sm8750: Add SDC2 nodes for sm8750 soc
  arm64: dts: qcom: sm8750: Add SDC2 nodes for sm8750 mtp and qrd board

 .../devicetree/bindings/mmc/sdhci-msm.yaml    |  1 +
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts       | 15 +++++
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts       | 16 +++++
 arch/arm64/boot/dts/qcom/sm8750.dtsi          | 63 +++++++++++++++++++
 4 files changed, 95 insertions(+)

-- 
2.34.1

