Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225B7146D55
	for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2024 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731312402; cv=none; b=sSvI6L40A2VZ719Ey+iwSwOXzFXus8YvtT6/RL7aUsOECEEh0WxQXA5p/JPW3rq/DGIIsfn0iYXNgfh735E1E/w6dTwx3MvXKJJrfgc+/+BfJ3uyuGv5UEf+UyCzv4jnB3E0gbtBjM/vtQDU1DrWEik16GS4NNkU2N+rNj8DXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731312402; c=relaxed/simple;
	bh=aeNy0DuaGFVuo5k3rdPwp5gTQmzmV5Dq7lW1ynUi704=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=AufByDAHQC1CxsIJH9isH9lOWsLiVzZZY/Z4g1VkS8/emftZsHncVF2hDwIeu6J4CL1UA7w+FOhN4jbdr4+ZaRWG8JAAz2EzkiuEP6kGjMmmyyQbrbaH2qvf2dTFUaXMf60KxeDfXIIYGhJtqb+tYmR9xIb4aria8d6lJf5LV60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=leevOo8C; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="leevOo8C"
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241111080636epoutp015644b57129a41aafdd55a6f8e617e992~G23O7Gkgp0967509675epoutp01B
	for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2024 08:06:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241111080636epoutp015644b57129a41aafdd55a6f8e617e992~G23O7Gkgp0967509675epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731312396;
	bh=flaFcwJald/rkzEebnMVSU7S4KyWdSWn/CtTa251TKc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=leevOo8CuAeO9cRQe9jIF9VlSyahNDl+/VO0ZF6bU9OCLHyzmzs6EImPdHqBQAyog
	 Th/U+EWSIgyNiukOXsl5oTh1GSqr7r8sC8msrelrpi60etjMkZ7tiDVE8AxeS2nh+L
	 6Idab4N0RgEtwgQuKuvud1XccmH+F9zSU1JfUaP8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241111080636epcas1p1698e5d20a7b2dd1c7bc0620447c8c980~G23OeZJRk0041500415epcas1p1Q;
	Mon, 11 Nov 2024 08:06:36 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.242]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Xn2F809Z9z4x9QM; Mon, 11 Nov
	2024 08:06:36 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E9.A9.08588.B0BB1376; Mon, 11 Nov 2024 17:06:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20241111080635epcas1p3ac1df881f67c49f065302c231615cff8~G23NoMxmY1583615836epcas1p3T;
	Mon, 11 Nov 2024 08:06:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241111080635epsmtrp2f41731602b10d7b9c74f5c07c1148d19~G23Nm0WG42626226262epsmtrp2T;
	Mon, 11 Nov 2024 08:06:35 +0000 (GMT)
X-AuditID: b6c32a33-a57ff7000000218c-33-6731bb0b1d6b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	20.FF.08227.B0BB1376; Mon, 11 Nov 2024 17:06:35 +0900 (KST)
Received: from jangsubyi03 (unknown [10.253.100.135]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241111080635epsmtip2f4d5f0e8fb0f8b80910bca86b6ce6156~G23NcSIX92026320263epsmtip2h;
	Mon, 11 Nov 2024 08:06:35 +0000 (GMT)
From: "Jangsub Yi" <jangsub.yi@samsung.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <junwoo80.lee@samsung.com>,
	<sh8267.baek@samsung.com>, <wkon.kim@samsung.com>
In-Reply-To: <ZyzYnw0PgpyViFdf@infradead.org>
Subject: RE: [PATCH] mmc: Add config_host callback to set a mmc queue
Date: Mon, 11 Nov 2024 17:06:35 +0900
Message-ID: <0b2e01db3410$a05f41c0$e11dc540$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH5zy9MrK58XqKdq8KPmuKMwnV7FAHbhmEtAfVDB6QBL9uedwJ0SwfJsjjaF+A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmri73bsN0g0+zLSxOT1jEZLHrbzOT
	xeVdc9gsjvzvZ7S4duYEq8XxteEWmy99Y3Fg99i8QsvjzrU9bB59W1YxenzeJBfAEpVtk5Ga
	mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0X0mhLDGnFCgU
	kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFagV5yYW1yal66Xl1piZWhgYGQKVJiQnfHu/xO2
	gjNsFZe7TjM1MM5m7WLk5JAQMJH41HeOrYuRi0NIYAejxMnDc9khnE+MEqemtrJCON8YJVo2
	3mGDaTnyfj5Uy15Gif1LzjFBOK8YJc7d3gdWxSagLXHk23IwW0RAV+LswheMIEXMAmsYJdov
	bWQESXACJZbv388MYgsLuEo8WnYBLM4ioCrxek032IW8ApYS9xo/QNmCEidnPmEBsZkFDCTe
	n5vPDGHLS2x/O4cZ4jwFiZ9Pl7FCLPaTmPfhCztEjYjE7M42ZpAjJAR6OSR69t5ih2hwkXg2
	4xxUs7DEq+NboOJSEp/f7YX6uVjiwLNHLBB2jcSOhq9MELa9RHNrMxvEAj6Jd197gBZzAMV5
	JTrahCBMFYmtfWowEzfumQa1yUNi6rkr7BMYFWch+WwWks9mIflsFpIPFjCyrGIUSy0ozk1P
	TTYsMITHd3J+7iZGcOrUMt7BeHn+P71DjEwcjIcYJTiYlUR4Nfz104V4UxIrq1KL8uOLSnNS
	iw8xmgIDeyKzlGhyPjB555XEG5pYGpiYGZlYGFsamymJ8565UpYqJJCeWJKanZpakFoE08fE
	wSnVwJT8LnZHbvp5NwORt+t/uR+/WdIbLODMlcIss12sqdLstOfx/652So+bNP7UP1jc93pd
	ufOfb4s2WK7eXi3W+n3r57933rz4d+EuC99+8a2P8vc8TIl1EU+XdRL9se7ChWXu3zcKZCwq
	/XF430//TWs4r7lNyw5ina2YU8WxcMfs8EPPZTuXXOJWY29Z+H3l6Sa2adqnH5gHTbkXG/f2
	k8h0tUUXtSQNpPdubvzRL1juPUOQMXO5gMKprdHf8x27W3t281ybqvWia8KjvU4TjoVmPvg8
	YdWiU+f37pP3zz7r8/LGuZWz/fdfS6/59WHSNLa6WtWCKMcP19kjN39ctYOxbubcPZkv5dIu
	GlkpXDQUUmIpzkg01GIuKk4EAK5IQdImBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvC73bsN0g22vxC1OT1jEZLHrbzOT
	xeVdc9gsjvzvZ7S4duYEq8XxteEWmy99Y3Fg99i8QsvjzrU9bB59W1YxenzeJBfAEsVlk5Ka
	k1mWWqRvl8CV8e7/E7aCM2wVl7tOMzUwzmbtYuTkkBAwkTjyfj4biC0ksJtRonGGQRcjB1Bc
	SuLDpxQIU1ji8OHiLkYuoIoXjBItp14zgpSzCWhLHPm2HKxVREBX4uzCF4wgRcwCmxgl3v5b
	zwzR8ZtRYvfC+2BVnEBVy/fvZwaxhQVcJR4tuwA2iUVAVeL1mm6wg3gFLCXuNX6AsgUlTs58
	wgJiMwsYSZw7tJ8NwpaX2P52DjPEAwoSP58uY4W4wk9i3ocv7BA1IhKzO9uYJzAKz0IyahaS
	UbOQjJqFpGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg+NHS2sG4Z9UHvUOM
	TByMhxglOJiVRHg1/PXThXhTEiurUovy44tKc1KLDzFKc7AoifN+e92bIiSQnliSmp2aWpBa
	BJNl4uCUamBiuB+yI2dq3h53zZPqDd2/LRJzzVIX2izTtLPWEXy/f8Ziqwf7TskaLZ3n88Vo
	944OtfWHQp+byhpUri3fWGTO8Jd136sWzfkXV4anWJ0r+Sih+vLx303rzSL5bVjcJcLv3w59
	E6L0d5fLcu3r3ycErjq/mbUjbekNo/W5kRUzX/DtOzm9IrDO+BGzy7LsyXz/XzhylzhsE6rY
	8H+t+MmdLCe+Bm87yf2p/Vpi2ItVWryJD2dISKgLZr22+Lr9REq064/7+xM2Om5dF/fw6+Qn
	P/dvnlhync3TzW9PA2MwX9W8vlcdzUmuyT/aH55Vf7jJhs/jmsGNxOgtzvfS1wtFhAiqzXnt
	zZT9MSJx6kUpJZbijERDLeai4kQA2ZbDXQ4DAAA=
X-CMS-MailID: 20241111080635epcas1p3ac1df881f67c49f065302c231615cff8
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

> On Thu, Nov 07, 2024 at 06:06:11PM +0900, ??? wrote:
> > Currently, there is no way to configure a request queue on the host
side.
> > Although there are various exported symbols in
> > kernel/block/blk-settings.c that can be used to configure a request
> > queue, users cannot utilize them as needed.
> 
> If you actually provided a user and didn't just try to offend the kernel
> maintainers by submitting dead code I could explain you in detail why
> youre idea is flawed.
> 
If a machine uses both SD and MMC simultaneously, how should timeouts be set

for each? And if different timeout values need to be used depending on the
manufacturer of the SD card, how can this be implemented? I believe it is
not appropriate to make such changes in the core code. There needs to be
a way to configure these settings per host.

