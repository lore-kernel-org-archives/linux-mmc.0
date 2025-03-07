Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C224A079;
	Fri,  7 Mar 2025 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373671; cv=none; b=A+gyxnTCwDKSKhU8eEqPy6ER0gr9qiv1S3B7vM+HXtn/60YPvvrcMnvbjFNGOTWF/K1te255RjtY3JRJn1FPfzTF2noSnyL3dj4+iX99a+CekCMYIoQGS+BIQlVUecHYxnReA+o0uDvifMdi4wmUrdH0oC02kN6hXNFvO22x2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373671; c=relaxed/simple;
	bh=oq5xy01+AXvyb6eiVxbLm+lZNHabk0wkUBGp91reAVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkkYyp2hL4ybxkvRRQeFxfQw6MSIq0Rqku+mDXrkQ6YRsCF67MQW3l8jZHLei1qC3Hu6mtHn+gpMJiz0f8ta6TV8KGevjI4sHKvokDnwQOMLaa8LE8S+QC4ajWvk0DAnwG/b2kULWDxLBsOd3OjNrA8QL0dbKYU3+X25v9oAe6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=QT2WukPJ; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="QT2WukPJ"
Received: from pps.filterd (m0359308.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527GpBcT029929;
	Fri, 7 Mar 2025 17:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=oq5xy01+AXvyb6eiVxbLm+lZNHabk0wkUBGp91reAVc=; b=QT2WukPJ2Hs5
	emKakF/TdlTAeb8hLwjl+CYDb2s1I+yu++5xPDwuiuxov8D1LcDlXQ1/gs4TpxFR
	2HPhR5hCKX3pd4YFjZw1hYvqZbO7/UI0SBsIXAr2g8YN3ZAJt6yeqHoNnkxHvJhc
	sYOjgNkSj1VPmL0+fInvc/Gtsl9UBiN8uaq1m6KPSYt9FbQPIX19Y1uU9ghy24xd
	oV/2hBFiVjUsC9uyphCerDJJJeB0pTwRZCbFC1RHOOfNH7jc3oux2fHyCBvMuNkz
	zVX51gIWkQOIksuov6sx7YS52Wn9Vc681SPUDMViljFYekQYQMsWA3Futg2i5TKY
	BLmqsFzlyQ==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 4584p8grd2-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 17:45:48 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:45:45 -0600
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:45:45 -0600
From: Erick Shepherd <erick.shepherd@ni.com>
To: <adrian.hunter@intel.com>
CC: <andy-ld.lu@mediatek.com>, <avri.altman@wdc.com>, <cw9316.lee@samsung.com>,
        <dsimic@manjaro.org>, <erick.shepherd@ni.com>, <keita.aihara@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <quic_jjohnson@quicinc.com>, <ricardo@marliere.net>,
        <ulf.hansson@linaro.org>, <victor.shih@genesyslogic.com.tw>,
        <wsa+renesas@sang-engineering.com>
Subject: Re: [RFC PATCH V2 2/2] mmc: allow card to disable tuning
Date: Fri, 7 Mar 2025 11:45:45 -0600
Message-ID: <20250307174545.1288682-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9e34fea2-6bdd-4673-a75d-837d9b793c3d@intel.com>
References: <9e34fea2-6bdd-4673-a75d-837d9b793c3d@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: ewpqn5bGYgAo8mxZXzxg--z0XCKdR418
X-Proofpoint-ORIG-GUID: ewpqn5bGYgAo8mxZXzxg--z0XCKdR418
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=913
 mlxscore=0 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070132

> Sorry for the slow reply.=0D
=0D
> I would expect if there was a general problem with DDR50 SD cards,=0D
> it would have come to light before now.=0D
=0D
> Does the card work with any other host controllers with linux?=0D
=0D
> If it is specific to a particular kind of card, a card quirk=0D
> could be added, say MMC_QUIRK_BROKEN_DDR50_TUNING=0D
=0D
No worries. I have not tested this with other host controllers but=0D
can try to get something set up. This issue has only appeared on=0D
one particular SD card model for us so I would not be surprised if=0D
the I/O errors we see on subsequent tune requests are specific to this=0D
card. I can put together a solution using the card quirk you suggested=0D
if you think that is the best way forward.=0D
=0D
My fix is currently spread across two commits, one to return the error=0D
code thrown by the tune request timing out, which prevents the card from=0D
retuning, and this one that prevents the initial card tuning if it has=0D
already failed. Should both parts be controlled by the new card quirk?=0D
=0D
Regards,=0D
Erick=
