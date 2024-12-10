Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20A22ACFF
	for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2024 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733811666; cv=none; b=Re9b8qnkNE/gy0g4chpl/AyuXeqQol1dlXGyzIOqvtGHv8rdChfSHl/BbOwyf7cwE2DY5pstF+dsa+EL/aTBEvDHDxS5MVS97QK/3/153KLIZOgDZpBeBT/2qL4ivnc2eMhq4SEnBQMe2LDAIKgUidnryjwRxBqUzQjX/hzF/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733811666; c=relaxed/simple;
	bh=h1J9Zz9SFJg/t2V+4o8zsFLVW+QM+rpVZalbWQM4auA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=sFBgJAI+GwW/qOtU+sHZCvvBmu7OI//hjwkUyLifyQ8JwyGg0tnPbd6yiMWr8DqxzxqakU3sqFUTtlLKmlLinq90vOEMX+YDrox5BubcvnxbO49CrMOfWieHyGl7ZplkmHxyWSnR7Eit0SlAtHeO91aFEEL0aoKDQSCveZKlYRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dNowIjCi; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dNowIjCi"
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241210062100epoutp03448309f136dc7166434922d39b0649d3~PvITsxVNJ2782527825epoutp03l
	for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2024 06:21:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241210062100epoutp03448309f136dc7166434922d39b0649d3~PvITsxVNJ2782527825epoutp03l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733811660;
	bh=0pntiW2qj943ljh4dAMm43hUmNNuzxP36dFj8iYz4qA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=dNowIjCie6fjmrB1kcTCCF2627cGxE687KsD/fvZcAhnQ9lKBkHjeQ1qzH0VLlDr8
	 j8Jn2H+Ex9o+4lE6NJX38cqxxpeIqig1EbhBd5SnqzkmD2AOlGN05bp9/XANlDc4BB
	 l3HqMd6vSNJpXmFgeVnNV7fs73IS/QT2KxD+qmAw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20241210062100epcas1p302f78d2af0527ae76c5148a53dd34ffd~PvITT06kp0632406324epcas1p3G;
	Tue, 10 Dec 2024 06:21:00 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.247]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y6pWw0qjDz4x9Q0; Tue, 10 Dec
	2024 06:21:00 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.97.23379.BCDD7576; Tue, 10 Dec 2024 15:21:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241210062059epcas1p19ab985f229a143b2f2c387adfaaa3952~PvIS21_Gn1249912499epcas1p1l;
	Tue, 10 Dec 2024 06:20:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241210062059epsmtrp143ff70bce2d692c961390b4f53430756~PvIS2LJgl1947519475epsmtrp1S;
	Tue, 10 Dec 2024 06:20:59 +0000 (GMT)
X-AuditID: b6c32a37-171e970000005b53-38-6757ddcbe81a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.E9.18949.BCDD7576; Tue, 10 Dec 2024 15:20:59 +0900 (KST)
Received: from jangsubyi03 (unknown [10.253.100.135]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241210062059epsmtip148f20c994ae6d1d0034ab987dd2f0574~PvISq93Ut2507625076epsmtip1h;
	Tue, 10 Dec 2024 06:20:59 +0000 (GMT)
From: "Jangsub Yi" <jangsub.yi@samsung.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <junwoo80.lee@samsung.com>,
	<sh8267.baek@samsung.com>, <wkon.kim@samsung.com>
In-Reply-To: <Z1fRaeTMz241A8FN@infradead.org>
Subject: RE: [PATCH] mmc: Add config_host callback to set a mmc queue
Date: Tue, 10 Dec 2024 15:20:59 +0900
Message-ID: <023901db4acb$adfb84c0$09f28e40$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH5zy9MrK58XqKdq8KPmuKMwnV7FAHbhmEtAfVDB6QBL9uedwJ0SwfJAz6GnnUB3YO3xgJLMHLPsisXbnA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmnu6Zu+HpBle+MFmcnrCIyWLX32Ym
	i8u75rBZHPnfz2hx7cwJVovja8MtNl/6xuLA7rF5hZbHnWt72Dz6tqxi9Pi8SS6AJSrbJiM1
	MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdov5JCWWJOKVAo
	ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKxArzgxt7g0L10vL7XEytDAwMgUqDAhO+Pkoham
	gibWilsHXrE3MP5h7mLk5JAQMJF41HOMqYuRi0NIYAejRMfaBcwQzidGia7DW6Ay3xglzs34
	xwLTsnzlM1aIxF5GiW09BxkhnFeMEp/mLWMHqWIT0JY48m05G4gtIqArcXbhC7AiZoE1jBLt
	lzYygiQ4gRLfXiwHaxAWcJV4tOwCUJyDg0VAVeLdBAeQMK+ApcSyWbNYIWxBiZMzn4BdwSxg
	IPH+3HxmCFteYvvbOVAPKUj8fLqMFWJvksT9T/uh6kUkZne2QdX0ckgsuSkOYbtI/Pp5iA3C
	FpZ4dXwLO4QtJfGyvw3KLpY48OwR1Pc1EjsavjJB2PYSza3NbBDz+STefe1hBTlfQoBXoqNN
	CMJUkdjapwYzceOeaVAXeEhMPXeFfQKj4iwkj81C8tgsJI/NQvLAAkaWVYxiqQXFuempxYYF
	xvDYTs7P3cQITpta5jsYp739oHeIkYmD8RCjBAezkggvh3douhBvSmJlVWpRfnxRaU5q8SFG
	U2BQT2SWEk3OBybuvJJ4QxNLAxMzIxMLY0tjMyVx3jNXylKFBNITS1KzU1MLUotg+pg4OKUa
	mLJFHrC7z2q6/ftduq/xL9X2l643At73zXlTpO58TKlcei3Tpe8zPt7wMlwayRtsa+PM/nHf
	zVfrd913P6mQvt7p2krNlnf52XeVPlWmc4WXH0tUFC31c+BLmdO0jfMR17wsFclHx0MXMQU/
	X12RdbJk45Obyzx/irV8+PSfz0dbQsBmSm6Q/wfzP+6p/lcqvkn677mXuF7IvW/VpfO/7699
	VXHGc/36jpOWn8O2HDmZx7+CK53vKm/+lvXdIuE1/cVvC75HbRNJPe28+/fm55c2ZS87/MHs
	Qvy5+Sv8a57GCj8sf7GBf3+M3rGX53rVPIM4zOImWN/YIbxwza9Mx74Z+qavzOvCSlsXh339
	FKTEUpyRaKjFXFScCAC/LrcMJAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSnO7pu+HpBgfOqlucnrCIyWLX32Ym
	i8u75rBZHPnfz2hx7cwJVovja8MtNl/6xuLA7rF5hZbHnWt72Dz6tqxi9Pi8SS6AJYrLJiU1
	J7MstUjfLoEr4+SiFqaCJtaKWwdesTcw/mHuYuTkkBAwkVi+8hlrFyMXh5DAbkaJHceeMHYx
	cgAlpCQ+fEqBMIUlDh8uhih5wShxYc9bdpBeNgFtiSPflrOB2CICuhJnF75gBCliFtjEKPH2
	33qwBUICP5gkNu02A7E5gYq+vVgO1iws4CrxaNkFsF0sAqoS7yY4gIR5BSwlls2axQphC0qc
	nPmEBcRmFjCSOHdoPxuELS+x/e0cqPsVJH4+XcYKcUOSxP1P+6HqRSRmd7YxT2AUnoVk1Cwk
	o2YhGTULScsCRpZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjB0aOltYNxz6oPeocY
	mTgYDzFKcDArifByeIemC/GmJFZWpRblxxeV5qQWH2KU5mBREuf99ro3RUggPbEkNTs1tSC1
	CCbLxMEp1cC0zG+z387yT+vVZA8/8Ek42VD9+ZVzlZFEf21cWkjQBQGLGZ/il4ld2BBle5pR
	PXtFtqpZtC/3jsjrv68cszn4tujCbg2fhzM3B62RbTk64e7E6X+/2RrPuR03g9+t2F5lbeWK
	2fEcWiurVp2YqMj0Y+aPuh53A551bDFH2XznmC5RZlotzirOMY+ZNbT8Rm8a1zQ39tWX7utJ
	Js5ldew5PuGW6p+ExvPnvS2fBd8oKexMOyCtGm5Ud0kxfw3DT8H5cou5v+7avt11o2KFnPzh
	RRG7rguU9kRMSuT1FVX3Pmm/q8dJa/26U1q6SVN7Xky9wZfvnTXltIbCmuxd5Wc2Xnuld9a4
	ZNUpnS28h9qUWIozEg21mIuKEwH9wZCcDQMAAA==
X-CMS-MailID: 20241210062059epcas1p19ab985f229a143b2f2c387adfaaa3952
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241106051403epcas1p29e983006930bd7b8364b1a1f858ad21c
References: <CGME20241106051403epcas1p29e983006930bd7b8364b1a1f858ad21c@epcas1p2.samsung.com>
	<20241106051347.969-1-jangsub.yi@samsung.com>
	<ZyxelKdmXXiSVL1g@infradead.org>
	<000001db30f4$4a749770$df5dc650$@samsung.com>
	<ZyzYnw0PgpyViFdf@infradead.org>
	<0b2e01db3410$a05f41c0$e11dc540$@samsung.com>
	<000001db4ac3$b5584260$2008c720$@samsung.com>
	<Z1fRaeTMz241A8FN@infradead.org>

> On Tue, Dec 10, 2024 at 02:23:55PM +0900, Jangsub Yi wrote:
> > This is necessary to have separate policies for each device.
> > I will also implement the host modifications related to this content
> > and try to upstream it. Please review the core modifications.
> 
> It is not reviewable without a user and your insistance to waste everyones
> time for a patch that as is adds dead code is highly offensive.  Stop it.
> 
 I'm sorry but I couldn't understand your intention clearly because 
it's my first time reflecting on the mainline. I will include the
modifications 
made to the host (user) and upload the review again.

