Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2EA18A95A;
	Fri,  7 Mar 2025 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.142.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382226; cv=none; b=IbFR6eZNfuOLqIC7ZgHapuXXOwhRwZGf1fFbognxR3dzsegSy3xiQ0FqaxYvGQdNecJHJQDZMUx2ZztyC+YIehswujQpOHotZT+0q8bnyjUc2nc9HjQh8czqnilixBYvf/3wXfWfKVJ8Lm0fTKwyaizMf3MiREped3Jv83qGIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382226; c=relaxed/simple;
	bh=yOM4i59uKYsdzmNGpsosR2xCB0EyzSdoJmGhYL1OgIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhVRpOPXHyv25/7ant/mzO4VH4sDSrhICoszQLkBC8VUWzH1gRccx6hwGv+vTXfCpJIvgjC/zyMU4z5YDcTbTE4qiuiblj+WwL03fW8TPOT/qKnRsXcK/WEw9VvLyKS14mb/sk+tZqMtr2yi2dQMWtFIt+2tf0p2iQx3KaAGycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=p/LI7ccW; arc=none smtp.client-ip=148.163.142.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="p/LI7ccW"
Received: from pps.filterd (m0144092.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527Eh7lh016676;
	Fri, 7 Mar 2025 21:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=yOM4i59uKYsdzmNGpsosR2xCB0EyzSdoJmGhYL1OgIE=; b=p/LI7ccWrrMA
	jeEMzF1e6f7of7YaV4z/bsKzi01iA5CQJDWe2UNW9gws3fpbi+XJS8d/ddJ3UQYn
	ndsUAq2ase02uD697wf6ZGo9dcbLud0Kv0GWhK8X/NxX4hcKiB+d+qN7xuAKNmXz
	chJk60uZDfOMIqhya89PyIu9+aGPEkSaCxvCuUuIHKjU5jXotwSKVZSssqRS8FD3
	7+zg2CnlMc5XTvMBEtp6fSDjaKZyQmfVR5KDR7BkddTjb7pMds4lmkHz1y2NCkUe
	NFBGJiaSfiVbFfmRJXvCtzIvOkPcldxDjfkkqoZnBjMWYYoa0mwrkQhAjomL7qBs
	xrAIocX/Qw==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 457yqxqthj-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 21:17:02 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 15:16:48 -0600
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 15:16:48 -0600
From: Erick Shepherd <erick.shepherd@ni.com>
To: <adrian.hunter@intel.com>
CC: <brad.mouring@ni.com>, <erick.shepherd@ni.com>,
        <gratian.crisan@emerson.com>, <kyle.roeschley@ni.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc: core: Wait for Vdd to settle on card power off
Date: Fri, 7 Mar 2025 15:16:48 -0600
Message-ID: <20250307211648.1289714-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <440723b0-a1fa-4f9f-90f4-50dc831c68e5@intel.com>
References: <440723b0-a1fa-4f9f-90f4-50dc831c68e5@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: i498qLKoSWntIP1PPsuWQ1uxXramokdI
X-Proofpoint-ORIG-GUID: i498qLKoSWntIP1PPsuWQ1uxXramokdI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_08,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxlogscore=488
 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070161

> It probably should be dealt with in the ->set_power() callback.=0D
> Is it one of the PCI devices in sdhci-pci-core.c?=0D
=0D
Sure, I can move the delay to sdhci_set_power(). It looks like that=0D
gets called right before the if-statement in the change I proposed=0D
so the behavior should be the same, unless host->ops->set_power is set.=0D
=0D
I believe we saw this failure on devices using the Intel Atom E3930=0D
and E3940, which are Apollo Lake. It looks like there is an entry in=0D
sdhci-pci-core.c. Does that change what we should do?=0D
=0D
Regards,=0D
Erick=
