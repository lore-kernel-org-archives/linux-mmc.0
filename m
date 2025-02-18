Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930982356B2;
	Tue, 18 Feb 2025 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904158; cv=none; b=E5iNY/0LOH+V2MMUzxGtRglyEFiN69bn7VdVbSSRCNepaIVHrnibKEj1iKNIMrLXv45kFSZ2gZH167OfyAZt7rXHOuQ9BpfnD/6kN+NAQmsxzYYEzzYygj+Go7oVhg4uqlLAXoO/MZXpWRFD881URnU3+hNGFo7lYOCFbrtcmfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904158; c=relaxed/simple;
	bh=/JM3UKKLHVWC9Y5LDPerXlTR/hpgcqWSxmhaxfDOiLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfeajBw+WFh27J/TOlb04Tl5I3YV2VsD7qcoyCIW0EAdSXQrcf/dE7KyLRSHAKPkh2slUs7v9PhmmRodE6gaLUgeKy/PlnecD4Z60+NRD0CvZL1qK1n5nr5NPIqq0o6bkvPA7gxHb/c2hAKyRO6IVz1GOJar0UnSgc2PcAErOhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=KpYskqMS; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="KpYskqMS"
Received: from pps.filterd (m0359308.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IHfVLh001235;
	Tue, 18 Feb 2025 18:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=/JM3UKKLHVWC9Y5LDPerXlTR/hpgcqWSxmhaxfDOiLo=; b=KpYskqMSrmGz
	djxKfM4u1bn6RISo+SaqPIWZHVrN71J3ZuWY5QNsbdy3gug/VzQRC6k9vhykTTft
	o0PmsH5bzhIzDvVI4UdtX4lh7SNVSWigoWGKmLYR2RcGGTg2hQiDVFCSr924wBt/
	5BPDpfWjXhl2gTIkgn8CYK7gWKqKuTJS/q4+zlrFEsBGJajBA8UV/id7cOkmX6qO
	KHHB1Q6rLjczTMFLKsFBXonkcDNxn+ScZvyFgk54Yp03c9PWzFtRn4R6gBmXYEyQ
	ialVyyYwUhqQye6bJzW4ai5cFlREbGGXvpGSVr5cyqaTleBQzAKzfrSsf/hmG9YC
	R4WuX8fu5Q==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 44vxts8xk8-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 18:41:58 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 18 Feb 2025 12:41:56 -0600
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Tue, 18 Feb 2025 12:41:56
 -0600
From: Erick Shepherd <erick.shepherd@ni.com>
To: <adrian.hunter@intel.com>
CC: <andy-ld.lu@mediatek.com>, <avri.altman@wdc.com>, <cw9316.lee@samsung.com>,
        <dsimic@manjaro.org>, <erick.shepherd@ni.com>, <keita.aihara@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <quic_jjohnson@quicinc.com>, <ricardo@marliere.net>,
        <ulf.hansson@linaro.org>, <victor.shih@genesyslogic.com.tw>,
        <wsa+renesas@sang-engineering.com>
Subject: Re: [RFC PATCH V2 2/2] mmc: allow card to disable tuning
Date: Tue, 18 Feb 2025 12:41:56 -0600
Message-ID: <20250218184156.574787-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c1863075-90bb-486a-bd25-b8ea6b2ae035@intel.com>
References: <c1863075-90bb-486a-bd25-b8ea6b2ae035@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Oq2J6S0J0Cce3TmKqLm9vUYxdlQ5hfK2
X-Proofpoint-GUID: Oq2J6S0J0Cce3TmKqLm9vUYxdlQ5hfK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_09,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 mlxlogscore=578 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502180130

Sorry about that, the context for this change is that I have been=0D
working with a DDR50 swissbit SD card that does not support tuning.=0D
The case I'm seeing is that the first tuning times out and any=0D
further tuning attempts cause an async page read I/O error. I used=0D
this change to prevent the card from attempting to tune again if it=0D
is ever reset in the case where we know tuning isn't supported.=0D
=0D
Regards=0D
Erick=
