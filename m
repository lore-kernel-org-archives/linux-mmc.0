Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7246C18A95A;
	Fri,  7 Mar 2025 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.142.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382276; cv=none; b=h/UgUgMw+UXl9Dh5nuemVTTee7dfDySqZIDm/AmNyGRyGxIXcW4UcR1n4/Oe3I4Ml0ID3AybYrhT0qP/woo3qidqxFRmyNZSgee/vUoIV+y8YrZ1h4Sdi20/t/1r5DW/beSWy3WtTJeQK3s7kmalBSCup/sNGKMGTemGQp9nb28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382276; c=relaxed/simple;
	bh=9nqsUliP7VaF84mGly7RCjKUjk1uHgnRm+GdjGl+ogs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nriNps4u0Szr/YE9BDFWcPXfGeCgRCv0/MD2wwhndepapvntThV6TQyCIkqGTQvubxf7OhFzfIAwZcrr7TuK8XV3cuZs6CaheNUTv5fyBaeEaaf/deoN7oorm1qaAPU5bD5l1ajKgKAv6XoeoQTf0bCvbtQH55vmu+tAe31yvY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=hX8zxLAZ; arc=none smtp.client-ip=148.163.142.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="hX8zxLAZ"
Received: from pps.filterd (m0144091.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527Jsh3I016327;
	Fri, 7 Mar 2025 21:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=evfmT0wKrye5QUCPV7QKE75lidrnU57zijRq3rZQTdA=; b=hX8zxLAZ0kEv
	Vh/S4b05aT82vAu7bn/v4MJQT3OnracBL9Zt3/8UETql6tUzxqAvvybZbfhipi3D
	gWDcIz+5wOwEJYYrDIvBcbA9AODiKQBP+UI3RSKByQDpMx6ZOGQKkUBrJIenPs2X
	oOusJWL1mC0nSH/sgR7a5AjAWq4KVIF4sIoiBL0YGRltL4B/JgQX8EAorBU95wXk
	K2CALer0w/RIE7IwYWR4wYB8EyQoPe5972JWAzBeEN0qg9riB4G8m/1a2i+HwP9B
	61/TQH4s6Ww1t8vLAMLxwsyt9JtiazluEJ62XtKTBG49gHV18HxT/FISUXUNFuR5
	jtQvLccVIA==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 4587c9100d-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 21:17:21 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 15:17:11 -0600
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 15:17:11 -0600
From: Erick Shepherd <erick.shepherd@ni.com>
To: <adrian.hunter@intel.com>
CC: <andy-ld.lu@mediatek.com>, <avri.altman@wdc.com>, <cw9316.lee@samsung.com>,
        <dsimic@manjaro.org>, <erick.shepherd@ni.com>, <keita.aihara@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <quic_jjohnson@quicinc.com>, <ricardo@marliere.net>,
        <ulf.hansson@linaro.org>, <victor.shih@genesyslogic.com.tw>,
        <wsa+renesas@sang-engineering.com>
Subject: Re: [RFC PATCH V2 2/2] mmc: allow card to disable tuning
Date: Fri, 7 Mar 2025 15:17:11 -0600
Message-ID: <20250307211711.1289730-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4030ee60-b607-4ddf-99d9-5348a741f7d5@intel.com>
References: <4030ee60-b607-4ddf-99d9-5348a741f7d5@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tSA50LPNpK80ZniGPDLIewM5dJCNaMms
X-Proofpoint-GUID: tSA50LPNpK80ZniGPDLIewM5dJCNaMms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_08,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=648 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070161

> Does it tuning at all?  Maybe MMC_QUIRK_NO_UHS_DDR50_TUNING is a better=0D
> name, then at the top of mmc_execute_tuning()=0D
=0D
> 	if ((card->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING) &&=0D
> 	    host->ios->timing =3D=3D MMC_TIMING_UHS_DDR50)=0D
> 		return 0;=0D
=0D
The card doesn't need to tune at all so I think this would work for us.=0D
I'm not very familiar with using card quirks. What would be the best=0D
way to set MMC_QUIRK_NO_UHS_DDR50_TUNING? Would it be set based on the=0D
model of the card or should it be set after the initial tuning times=0D
out?=0D
=0D
Regards,=0D
Erick=
