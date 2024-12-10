Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C3226198
	for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2024 05:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733808248; cv=none; b=of0Tvq+dmlZBy+2LtXsle8awfo9BBLjONvtbNzjKRU26bdLpekVuZzHBYp1LAdXxgY6wu2P7qASHGc7rF8dJwdjAP4oLSSpdFLNYVrp0apirRf8OcdvX7TVBM8OkJMDRgZrNMVMWHlG9pNCVaZPlflBqeviz+ZtOCh7mIlYIqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733808248; c=relaxed/simple;
	bh=DIDLzmhhdG7Cj3vMico3q0yUsMaturujWZ978YKG+J4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=fzZ9k4T04HLb4MobcAyuYLgXjAx7fwhcaRmYAbtk1hlPDtR47fo90JnEvkHMZYYdXSd0Mjovj67vIBf8uQv44FYKqIvMlR0/9kkq3W0qHTF9jMCg2b/1Nj9hA3PdmS3ePrK/UhitUZWDLAesMlJY4akkiJznWNBUg8GkpA18Poo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XKQwlzaM; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XKQwlzaM"
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241210052357epoutp01928069add3abd6755806af6fedfe5503~PuWfmvUWs1450714507epoutp01J
	for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2024 05:23:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241210052357epoutp01928069add3abd6755806af6fedfe5503~PuWfmvUWs1450714507epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733808237;
	bh=3x+mO/N8Ow4miHRZs3X7DBaWTWDY5T1WFfneEzHHml0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=XKQwlzaMPwdFxWSZu28rwJ+rIrJ/FJezOMRq0usX6RFOcS4vC7OGGz2g1bt2YrA2u
	 a6s8aOPTjMLI985hqQOAF5qWu+QFBRoQN1mMRhtjlOxG9BR4cTofmZ5aedrfGq5h/s
	 Nljut9HLJE3uclAZsZXe5MUSqkH6mhjqFtP7icNc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241210052356epcas1p19d95176afcd50615d8f05dd809025f1e~PuWfDZTpT0391203912epcas1p1W;
	Tue, 10 Dec 2024 05:23:56 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.225]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Y6nG43WYsz4x9Py; Tue, 10 Dec
	2024 05:23:56 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	9C.CC.24218.C60D7576; Tue, 10 Dec 2024 14:23:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20241210052356epcas1p3f6a073d2525d6d441e348434363f30fa~PuWeTdLJo0146501465epcas1p3K;
	Tue, 10 Dec 2024 05:23:56 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241210052356epsmtrp2ca71df2d4ef4e5af4626e0ce64ac1883~PuWeSktmL1281712817epsmtrp2Q;
	Tue, 10 Dec 2024 05:23:56 +0000 (GMT)
X-AuditID: b6c32a38-580dc70000005e9a-0d-6757d06c2969
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2D.31.33707.B60D7576; Tue, 10 Dec 2024 14:23:55 +0900 (KST)
Received: from jangsubyi03 (unknown [10.253.100.135]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241210052355epsmtip18d75139c76f80faca7d716e6c219cbe4~PuWeJYlNc2141621416epsmtip1O;
	Tue, 10 Dec 2024 05:23:55 +0000 (GMT)
From: "Jangsub Yi" <jangsub.yi@samsung.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <junwoo80.lee@samsung.com>,
	<sh8267.baek@samsung.com>, <wkon.kim@samsung.com>
In-Reply-To: <0b2e01db3410$a05f41c0$e11dc540$@samsung.com>
Subject: RE: [PATCH] mmc: Add config_host callback to set a mmc queue
Date: Tue, 10 Dec 2024 14:23:55 +0900
Message-ID: <000001db4ac3$b5584260$2008c720$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH5zy9MrK58XqKdq8KPmuKMwnV7FAHbhmEtAfVDB6QBL9uedwJ0SwfJAz6GnnWyTEy0kA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmvm7OhfB0g2+/JSxOT1jEZLHrbzOT
	xeVdc9gsjvzvZ7S4duYEq8XxteEWmy99Y3Fg99i8QsvjzrU9bB59W1YxenzeJBfAEpVtk5Ga
	mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0X0mhLDGnFCgU
	kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFagV5yYW1yal66Xl1piZWhgYGQKVJiQnbHt7zum
	gu0cFeuvVjYwnmfrYuTkkBAwkdjz8ziQzcUhJLCDUeL1liOMEM4nRomHe2czIzhHG5hhWhZO
	2sUCkdjJKLH70luolleMEn8/32YHqWIT0JY48m052BIRAV2JswtfgBUxC6xhlGi/tJERJMEp
	YCWx+PpzMFtYwFXi0bILQDYHB4uAqsSqjSEgYV4BS4nlR6+wQNiCEidnPgGzmQUMJN6fm88M
	YctLbH87B+o6BYmfT5exQuwNk3hxdjtUjYjE7M42sHckBHo5JJ7POMII0eAisbdtNwuELSzx
	6vgWdghbSuLzu73QUCqWOPDsEVRNjcSOhq9MELa9RHNrMxvEAj6Jd197WEHulxDglehoE4Iw
	VSS29qnBTNy4ZxrUmR4SU89dYZ/AqDgLyWezkHw2C8lns5B8sICRZRWjWGpBcW56arFhgQk8
	tpPzczcxgtOmlsUOxrlvP+gdYmTiYDzEKMHBrCTCy+Edmi7Em5JYWZValB9fVJqTWnyI0RQY
	1hOZpUST84GJO68k3tDE0sDEzMjEwtjS2ExJnPfMlbJUIYH0xJLU7NTUgtQimD4mDk6pBiZu
	wdtJjHuTPVYYPNLmV+y1vMnJ3q78OeyzYeKR6jubG7clCO18Il7b/lvP9PSOSbJ/J896bOpw
	Vkv/A+/fO2Kl0Zq+/WY3Hh2XX+u9tdwnblFQQvcDrpy2NBWZBZc9pmSpXb3yfEvypiUtO37P
	uOW456nd+vDzd/QesxdZpy5xmLQ/0HrqA2GOly73D3E+mfKqombljr07WXc3PJro3N/le/fs
	tiu5xqHuz6682mfy/8qa5RxXz/PYPbE8JSH1I+7UkpQfS/64p13rmXnoyIOkM+te/0iMMoxJ
	0TfftPJ59sWdVms+abe9F5X7lz4hom5GBPvX+M4nWYesEp9N+1z65t+PZx47GMs2L9s1Z8qi
	I0osxRmJhlrMRcWJAOon9QokBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnG72hfB0gxVfbCxOT1jEZLHrbzOT
	xeVdc9gsjvzvZ7S4duYEq8XxteEWmy99Y3Fg99i8QsvjzrU9bB59W1YxenzeJBfAEsVlk5Ka
	k1mWWqRvl8CVse3vO6aC7RwV669WNjCeZ+ti5OSQEDCRWDhpF0sXIxeHkMB2Rol/71YydTFy
	ACWkJD58SoEwhSUOHy6GKHnBKLH67SQWkF42AW2JI9+Wg80REdCVOLvwBSNIEbPAJkaJt//W
	M0N0rGSSOHGyiRmkilPASmLx9eeMILawgKvEo2UXGEE2sAioSqzaGAIS5hWwlFh+9AoLhC0o
	cXLmEzCbWcBI4tyh/WwQtrzE9rdzmCEeUJD4+XQZK8QRYRIvzm5nhqgRkZjd2cY8gVF4FpJR
	s5CMmoVk1CwkLQsYWVYxiqYWFOem5yYXGOoVJ+YWl+al6yXn525iBEeNVtAOxmXr/+odYmTi
	YDzEKMHBrCTCy+Edmi7Em5JYWZValB9fVJqTWnyIUZqDRUmcVzmnM0VIID2xJDU7NbUgtQgm
	y8TBKdXAtEMphof7XKsqP8cnkYbs7Xtrp6zqKsx1W2CgJrt+8rk7+3a9mbS1ZJkrW8e8+m2z
	525n6Vqqf1k2sqNJMOSSZ9rLtQHx4kk2Abs6vv3qXbf7tJXF09xvVpmzHDccPm53+Map02wl
	oh8/XppinND6cifr5qpnCU9cdx6bbj3NUG921Eshzg7hb4lvE5kPfUxNeC6vZNXzo7Slfl+1
	8P8d0+eampccnr+/s+ZGgwbr5P1n5xYv7dQ7ePqAeN6Zr9s2vpM9ueOc+EfLrb/3794Yt7mn
	YfpE+0v9pyZIvLQLde2N3D7t3nxJg7sVTlOb+9Is0x/81ZHr3Vp2lXn5l7QdHyZsenxMY5PE
	xO+Cd8V4rnMrsRRnJBpqMRcVJwIAZf8s/gkDAAA=
X-CMS-MailID: 20241210052356epcas1p3f6a073d2525d6d441e348434363f30fa
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

> > On Thu, Nov 07, 2024 at 06:06:11PM +0900, ??? wrote:
> > > Currently, there is no way to configure a request queue on the host
> side.
> > > Although there are various exported symbols in
> > > kernel/block/blk-settings.c that can be used to configure a request
> > > queue, users cannot utilize them as needed.
> >
> > If you actually provided a user and didn't just try to offend the
> > kernel maintainers by submitting dead code I could explain you in
> > detail why youre idea is flawed.
> >
> If a machine uses both SD and MMC simultaneously, how should timeouts be
> set
> 
> for each? And if different timeout values need to be used depending on the
> manufacturer of the SD card, how can this be implemented? I believe it is
> not appropriate to make such changes in the core code. There needs to be a
> way to configure these settings per host.
> 
This is necessary to have separate policies for each device.
I will also implement the host modifications related to this content 
and try to upstream it. Please review the core modifications.

