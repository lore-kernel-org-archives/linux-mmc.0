Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212FC1D7E4E
	for <linux-mmc@vger.kernel.org>; Thu,  7 Nov 2024 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970379; cv=none; b=OJb4vPezrfvckbyejx+57GjUdN6YX+hbYEEGrUgsN0fOE2xRTVeka1cWaCHhKjeDlg+GVupnw2TFYDNZ5MDgcFP+R8ygb82C/REexUXNn/u+5lNIPBb0swH/EhBocu4yGKIIKQyYl0/sp/xQ8si+0wSTR1n+YntMzma+uZFcHCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970379; c=relaxed/simple;
	bh=bN3mzRF8CNzos9XmGraREi5v2QGaaOW3HmAT6PZsdk0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=l4dNAVtkEHewcJex6WqkinBq9a1qPaKNXR+r903b4orIH4aovTXXlctabxxLh+IsSx/EhR2OluS8oASe6Jv/wYNyK+T5XHT3HbtKXWIpdsolAlDqWbJPASgDRtKwHuBbzhp+hScGtbvwCB+2Re9+zCCfYm2hDKx6vFBB24B0UbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ub8tWipb; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ub8tWipb"
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241107090613epoutp03f1afd5c30539ed342a4e6a80d890dc48~FpGIXjh1U2248422484epoutp03G
	for <linux-mmc@vger.kernel.org>; Thu,  7 Nov 2024 09:06:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241107090613epoutp03f1afd5c30539ed342a4e6a80d890dc48~FpGIXjh1U2248422484epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730970373;
	bh=JpLAukNeiMEzR5m7gPRVGbXL1gM2R7NAa2tSdIk0+84=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Ub8tWipbrqaNjJHkjqnD4TbN6j4Tx4FrvCWKaFAIt49CG9TUJ/6Pg/QzpFyor+EAr
	 3hOYVs4diFkp+jq8kgptBbxEbU84I8ikHX4Toq1GjdaGqpJHLk+pBA+H+kFPF85ETI
	 pjr8RgEcH/U+tKXsntiksesU/hVgbZwMBdYxroe8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241107090612epcas1p138eb0444d64175f1ad94686c27d5c0dc~FpGICRTUh3022630226epcas1p1B;
	Thu,  7 Nov 2024 09:06:12 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.226]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Xkblm1pLXz4x9Py; Thu,  7 Nov
	2024 09:06:12 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	1F.20.09398.4038C276; Thu,  7 Nov 2024 18:06:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20241107090611epcas1p31994e0df204941e07a3b2da78818a3c8~FpGHWuM9G0971909719epcas1p3N;
	Thu,  7 Nov 2024 09:06:11 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241107090611epsmtrp1d388819330bba1fc79bd35f4ccee5540~FpGHWGTyJ0191801918epsmtrp1c;
	Thu,  7 Nov 2024 09:06:11 +0000 (GMT)
X-AuditID: b6c32a39-5f9f8700000024b6-a8-672c83044a5d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	97.39.18937.3038C276; Thu,  7 Nov 2024 18:06:11 +0900 (KST)
Received: from jangsubyi03 (unknown [10.253.100.135]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241107090611epsmtip2063278b5db7039ad8c8fdc0304f6507e~FpGHJBeEX3091630916epsmtip2R;
	Thu,  7 Nov 2024 09:06:11 +0000 (GMT)
From: "???" <jangsub.yi@samsung.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <junwoo80.lee@samsung.com>,
	<sh8267.baek@samsung.com>, <wkon.kim@samsung.com>
In-Reply-To: <ZyxelKdmXXiSVL1g@infradead.org>
Subject: RE: [PATCH] mmc: Add config_host callback to set a mmc queue
Date: Thu, 7 Nov 2024 18:06:11 +0900
Message-ID: <000001db30f4$4a749770$df5dc650$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH5zy9MrK58XqKdq8KPmuKMwnV7FAHbhmEtAfVDB6SyT7dXEA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmri5Ls066wfRNnBanJyxistj1t5nJ
	4vKuOWwWR/73M1pcO3OC1eL42nCLzZe+sTiwe2xeoeVx59oeNo++LasYPT5vkgtgicq2yUhN
	TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHar6RQlphTChQK
	SCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fLSy2xMjQwMDIFKkzIzlg88xhT
	QQt3xbRZ8Q2MHzi6GDk5JARMJD6+vMraxcjFISSwg1FiV28PG4TziVGiY8lKFjjnVc8qVpiW
	GdeeQCV2Mkoc2LebCcJ5xSixeM4rJpAqNgEViZdzv7GD2CICuhJnF75gBCliFljDKNF+aSMj
	SIITKNH4ehEbiC0s4CrxaNkFsDgLUPPrp0fBmnkFLCVeXpsGZQtKnJwJspoTaJCBxPtz85kh
	bHmJ7W/nMEOcpyDx8+kyVojFThJbH0xigqgRkZjd2cYMcoSEQCuHxIXDv4CGcgA5LhLL99dC
	9ApLvDq+hR3ClpJ42d8GZRdLHHj2iAXCrpHY0fCVCcK2l2hubWaDmM8n8e5rDyvESF6JjjYh
	CFNFYmufGszEjXumQV3pITH13BX2CYyKs5A8NgvJY7OQPDYLyQMLGFlWMYqlFhTnpqcWGxaY
	wmM7OT93EyM4bWpZ7mCc/vaD3iFGJg7GQ4wSHMxKIrz+UdrpQrwpiZVVqUX58UWlOanFhxhN
	gWE9kVlKNDkfmLjzSuINTSwNTMyMTCyMLY3NlMR5z1wpSxUSSE8sSc1OTS1ILYLpY+LglGpg
	WnHxduEhiSrmB/LzNs49JWnhqHVGr3vGZtHsvlnrTGP5rhry6i9N9k1dbzF7OcNzyRUee68E
	VPHd2f1TyD54HVvr7tX1ko0/nrnmZ5kujpzOvyPGcbtM8uM26yUOAVUVK/86hpnovTFQ4JL5
	OWvlkq0ei2xlAq+mXVL7q6hi7r7hxePl21JOMk9L6k+ZHjfpRHpG/MQAw4eTP++5tbT26HFt
	tpRFAZOeh1jO7zGTO1sZcDa0/uf2/daxB6v6+hXuebFv7DXT8XOKOVb37r+39MPoubpvl4Ql
	Gt+sSdroP31me+ccdhORKf2T22er1zbpzMjS7RPjmJK773S6am+3snLqFd+q6Am7O1qjWAqV
	WIozEg21mIuKEwFGpupBJAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSvC5zs066waE7+hanJyxistj1t5nJ
	4vKuOWwWR/73M1pcO3OC1eL42nCLzZe+sTiwe2xeoeVx59oeNo++LasYPT5vkgtgieKySUnN
	ySxLLdK3S+DKWDzzGFNBC3fFtFnxDYwfOLoYOTkkBEwkZlx7wtLFyMUhJLCdUaL7xHa2LkYO
	oISUxIdPKRCmsMThw8UQJS8YJbZf2M8O0ssmoCLxcu43MFtEQFfi7MIXjCBFzAKbGCXe/lvP
	DNGxhlHi0LUmFpAqTqCqxteL2EBsYQFXiUfLLjCC2CxAk14/PQo2iVfAUuLltWlQtqDEyZlP
	wHqZBYwkzh3azwZhy0tsfzuHGeIDBYmfT5exQlzhJLH1wSQmiBoRidmdbcwTGIVnIRk1C8mo
	WUhGzULSsoCRZRWjaGpBcW56bnKBoV5xYm5xaV66XnJ+7iZGcNxoBe1gXLb+r94hRiYOxkOM
	EhzMSiK8/lHa6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5lXM6U4QE0hNLUrNTUwtSi2CyTByc
	Ug1Mk+Neuk67r+36XPnwt1JXzqa2lDMiLEd3+Kw8zfDrwo05l8p1X/WzPhb6GuB79kXczenb
	ZT58+bXtifzN6nJNnYyN5pLmE/82Lmn1XbQ8ac/xKxNDHz4/IF7sul9206SZC/d2953oq5vJ
	ERZf+mXe6h/ZNle/vJKcffB8s+SlkO1ipiuul212m5npHvb2Qqr6qfXlzsLuL9Y+mBh48kCs
	ZzbnZsaHmtNZPT+eYvTu2eIb/ErM7jfLiYtzLcTl5aPOX1lYFv2Pf4dgtU6ZyazJhzedXng8
	iuGWOtuUGffaTDZnOdROVLNbohZVnb87Sfm75ZkDxiVrBGX1GuevVdM2PaBQaswg+TbOiFv+
	9L+p/5VYijMSDbWYi4oTAS1GEyMKAwAA
X-CMS-MailID: 20241107090611epcas1p31994e0df204941e07a3b2da78818a3c8
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241106051403epcas1p29e983006930bd7b8364b1a1f858ad21c
References: <CGME20241106051403epcas1p29e983006930bd7b8364b1a1f858ad21c@epcas1p2.samsung.com>
	<20241106051347.969-1-jangsub.yi@samsung.com>
	<ZyxelKdmXXiSVL1g@infradead.org>

> On Wed, Nov 06, 2024 at 02:13:47PM +0900, Jangsub Yi wrote:
> > From: "jangsub.yi" <jangsub.yi@samsung.com>
> >
> > Currently, there is no way to set up a host-dependent MMC queue.
> > In UFS driver, it is possible to configure the request queue in
> > ufshcd_slave_configure.
> >
> > There are cases where we need to configure and check the current state
> > of the request queue on the host operation. For example,
> > mmc_queue->in_recovery, in_flight, mmc_queue->queue->queue_flag, etc.
> >
> > Additionally, since the timeout setting may be longer depending on the
> > device, block layer settings such as timeout are also required.
> >
> > To add the configuration for the MMC queue, I will add the
> > corresponding code and initially try to add it during initialization in
> block.c.
> > The detailed implementation will be done on the host side.
> 
> This seems to lack an actual user and thus just creates dead code.
> 
Currently, there is no way to configure a request queue on the host side.
Although there are various exported symbols in kernel/block/blk-settings.c
that can be used to configure a request queue, users cannot utilize them
as needed.
 For example, I want to change the timeout setting by calling 
blk_queue_rq_timeout(). Because 60 seconds is too long depending
on the device. Therefore, we need a method for independent configuration
for each host.

