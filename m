Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB7F46BF;
	Tue, 28 Jan 2025 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102954; cv=none; b=Wc8l6fAQwtzKMTXm3+EqegRK/KcvDgiG2TEFXcXkSdAmO//Aa2gWvb7Yli9qT9b+10uFqKGkDQySp/+KpuXMjATz+EGzUGR7kW1JPG7lHBwpqW4AJZOGb35X178dN2qDNyVtvD2zY+7/SRF9SyBjXMbi09D5P8S7Me8vErdD9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102954; c=relaxed/simple;
	bh=OU8DcoBp0R1QIzI4e7kFBMu9NlMu2AkMVwiiRFdkX6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpvV3U+gWx58Q/Zpeu5XySIEtdQbuuFb4fnQ2a9Syp+c11JdmyLlpljkxc3qwWw7iKGrBs+xPFmwws0neaLWMBugOUmrLHlsxkkyVoFSvD2wMffd8x8s7+Ve81L//S+TOtOCdIc56dzee5H3iCYqaxhK5At7pIivzX9KzOSuWAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=nNfd35Uv; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="nNfd35Uv"
Received: from pps.filterd (m0359308.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SLMcD2003940;
	Tue, 28 Jan 2025 22:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=OU8DcoBp0R1QIzI4e7kFBMu9NlMu2AkMVwiiRFdkX6A=; b=nNfd35UvJkWt
	iu4q2zPwXk7z1jU2AX+NJ8ZbjypmA13zLF1w+ZVAYe9wW6uGIjG4c+awKRr7vgZ5
	aFcgO4/Iq/Ipq7CHi0cvqslGcMqmewE3yxdtc0T8D+E6N4g0kYPBYY5t/8qBzEvU
	bixG08yvUcTCXgzBi7n9QNI2P1SSorKc1uD8pK+nxa77FF3GlR0OaU9tuSStJPzB
	2xZ7DrHtaQjkKyzVaZUn8Uqkx6gqXOAQY1UxqyoYRwwEjV2Wb9OpJn2uj+RK5HzY
	b87FqfkjqRIx/Y/cN09mxwOsY4pWycH6cOGUbw2YTwONjxwifSl6gaW+b4FuyYUL
	hRXAOhO8yw==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 44f73krkpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 22:20:29 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 28 Jan 2025 16:20:18 -0600
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Tue, 28 Jan 2025 16:20:18
 -0600
From: Erick Shepherd <erick.shepherd@ni.com>
To: <jm@ti.com>
CC: <erick.shepherd@ni.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <york.yang@csr.com>
Subject: RE: [RFC PATCH 2/2] mmc: Allow tuning to be skipped during card init
Date: Tue, 28 Jan 2025 16:20:18 -0600
Message-ID: <20250128222018.295627-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <93f9d38e-60b3-4090-91e7-aebf1ddb72dc@ti.com>
References: <93f9d38e-60b3-4090-91e7-aebf1ddb72dc@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: VsXM1kr37KosBEhQNzOSjRSXEU_RAeWZ
X-Proofpoint-ORIG-GUID: VsXM1kr37KosBEhQNzOSjRSXEU_RAeWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 lowpriorityscore=0 mlxlogscore=644
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280163

I have been working with a DDR50 SD card that does not support tuning.=0D
The card's first tuning attempt fails, which is expected, but subsequent=0D
tuning attempts cause I/O errors due to async page reads. My first patch=0D
mostly solves this issue but I was still seeing I/O errors in the case=0D
where the card is reset and attempts to do the initial tuning again=0D
despite it failing previously. This second patch allows the initial tuning=
=0D
to be skipped if it has already failed for a DDR50 card.=
