Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C6628DEE9;
	Mon, 21 Jul 2025 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091046; cv=none; b=dW+kP0Rbcff5SgncV+S9GLrBmVHdI7iqp8YF7dgt+C1NEe7hBc+4iJVetJDiJKaS/MAWKBpTTW766W0QA76cy0aTtMSEedvGXQixzTcMSZl4J6wWqcsu+BbhVF4e3gHuRl7R/K2bveai/V/LpQKxc3b9uq2/IQA8MyASWhxfUOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091046; c=relaxed/simple;
	bh=hmoYtww9WpKw0vRY5u3Si1hp/r3D/QoCvulijGAxN1g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hL4NFo52i5H9qu6pjlJ3MIFpoOrLJXqjaAUJOHiMikbkzXyJ9CPTNq4CQ4KLQ+FT+tk1s1PWzmsvbmuYuw2myI6zjq3hvHHKBCeWNmZ1tMeyNXZUT2iDm1xKWdbDLslwegvvjc3dFpto8D9LD3OdxFSLcZSDFTPp6k8pG6wlk6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PR3Bce8Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PR3Bce8Q"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L6DWSN030800;
	Mon, 21 Jul 2025 09:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=tEpwa1I8vQquEpZ5nxMXN7QA//IvLOwZDYDdNE2Ne/8=; b=PR
	3Bce8QMP7Vg3z7Y69Ho9GdVYZUzczLiAlkV0CpVBDqbHdtC2oVFujeNUaLY+n28G
	MRZyCs7LAWb+98YlDemBcJ5UVB94m3gCCShllwsiYEQJjAyFCKRzD79ToCYZzw78
	48mJZHdY2ut+P7XNRSSDZ6Qd6zEv5ILirpa/0J9UhR7PzZHScSYzpLuczFgOVSDU
	GqoCUyxZbYyQcVna/ZpaoA8Z/C/nSvUNvOoWZv5VRKrGjnC/yW/KAsKZ6Xd82efp
	/oqpu68RmmP550gzTlv/otsEwjsR6HMsH8Xm+FDi6S8K8fzj6oZcUUTFQzuKRp3i
	hNHPfkycRxuaQ+AAuHfA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3egx7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 09:43:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56L9hmXs030183
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 09:43:48 GMT
Received: from hu-sayalil-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Jul 2025 02:43:46 -0700
From: Sayali Lokhande <quic_sayalil@quicinc.com>
To: <ulf.hansson@linaro.org>, <wsa+renesas@sang-engineering.com>,
        <avri.altman@wdc.com>, <adrian.hunter@intel.com>,
        <shawn.lin@rock-chips.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V1 0/1] Export an API to reinit SDIO card
Date: Mon, 21 Jul 2025 15:13:27 +0530
Message-ID: <20250721094328.6556-1-quic_sayalil@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NbIF0-jdFI_UfL1zelq3BH_ivbfPQPLo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA4NiBTYWx0ZWRfXxhnBbKEQaYKY
 PBg8VpoDU2ZNjqaXC89k9aGGsQIxCbFtpGmLV6pAS8juX7aMARMGh1Vu8I/pu3xlMCoF4eRzO7n
 mDWioTQ0bn8TB7KR3GQKKqBOj9I7QndwEzfIfZR9QbCPYSELmKmP0AvN1JSGljijmrDqckZTmxz
 1c5PIal6lRlkzZ20nvA+vgPEnVjWAKJCnAsKJcwUvg07mnDjGPk5BhqsPQwINk5jkjwPvFkP65W
 Hw22o8lta0S4ZFL5WuRdaOuZzCoQ6rrbx2xAtAxSKgCRfU0grYvGDtVDsW7IPcOKu9cy5izVDRw
 a5wFDikFMGCnjjAsmbLGZNInfx06pKXFpfCMw1xHDut8e5eaGgGCP69vSRA/WwJo6qEOxSyPT/y
 IQjZaBih2QTZAi/wp6dyfXxmmjXNNs3LgQPLNncwkAI24A+tsjXD8r0wemzfgW5yl6IQSwxy
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=687e0bd5 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=VyeUceQKped4y59pgd4A:9
X-Proofpoint-GUID: NbIF0-jdFI_UfL1zelq3BH_ivbfPQPLo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_02,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=770 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210086

Some SDIO client drivers, manage external power to the SDIO card.
In such cases, the card may be power-cycled independently of the
MMC core's runtime PM state.
Currently, reinitialization of the SDIO card is tied to the runtime
PM resume path. However, if the card is powered off and on again before
the autosuspend delay expires, the runtime suspend/resume callbacks are
not triggered, leaving the card in an uninitialized state.

To address this, export sdio_reinit_card() so that client drivers can
explicitly trigger reinitialization after powering the card back on,
ensuring proper device state regardless of runtime PM behavior.

This change enables more robust handling of power-managed SDIO devices
in scenarios where runtime PM is disabled or insufficient.

Sayali Lokhande (1):
  mmc: sdio: Export an API to reinit the SDIO card

 drivers/mmc/core/core.h       | 1 +
 drivers/mmc/core/sdio.c       | 2 +-
 drivers/mmc/core/sdio_io.c    | 6 ++++++
 include/linux/mmc/sdio_func.h | 2 ++
 4 files changed, 10 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

