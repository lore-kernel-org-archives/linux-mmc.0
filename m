Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1AB30BF70;
	Fri, 12 Sep 2025 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688669; cv=none; b=pArZVRuFEl505EwjCac7hrvj0ITjsrh/oqXPx/IbZyYWdolTCcmwlZCvDgA0EcQYiv+5FUKnxWW3RZn9lXmT+oR2cGUDMSJckFbs02C4ZRa8Ptd05wS3KSdUypJZRX2l7XCX/LXXjyRtxPhFptQh6X650O5NA6YQXMCtagt+Rzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688669; c=relaxed/simple;
	bh=pjiKtCwXWOKUFR/yWHahWoIYUXEZUqB1rmTFrhYAD0w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Fm/RV3XQLEGFe1Gft8Rg/+1ixO7yQFsrGI82r0V8GbozYe3EuetoIqtSzcntoaIEPCwHZAA3lhbfaAAJX/y8oFN5Zv1LYrZP4f/tReMykr4TovgcwnLu4tWlPHAsYwp3yL7i4fWE7gAtw7YnnDlroC0cmEWtIfW2nMDmH2qImt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gnU2eH8w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jLlZ4r98; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gnU2eH8w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jLlZ4r98"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 249F17A02CC;
	Fri, 12 Sep 2025 10:51:02 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 12 Sep 2025 10:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757688662;
	 x=1757775062; bh=ErqpAN/VeWHGab4PfaTUUko/tIV1QAA4gpHmNW5wQEY=; b=
	gnU2eH8wQ4NARYe3w4fzx8/rGRn803aeSnNp29jjuu0XIuzzDLcsD9/WWd9fY+YW
	mj1aNGwCtu3EXXlxw3d9wn4O4Q5oUFyxJz9aMI54AEJZ+1WIJaVxH8Ywi6AvTLLs
	XYsBFk0xQ4mTlOHGkg7t1/X/J9mHS3wRLD98B03U9r2Mu3XCMcFj9y+dpFPPoe3v
	BtNj9hhUodtd18A+KF4tf+1epr5K+SJ4YjWQHrBKUtp250eJl6TvT2WkHnPtmm4E
	yp/YVcfLz+69xETG6VOQqOM6e+RW5btZ6jws7ues8bSKJhqqaZvtVK8iZHYbWCgF
	nuKNAiC6Y3qoxwkpBgMP7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757688662; x=
	1757775062; bh=ErqpAN/VeWHGab4PfaTUUko/tIV1QAA4gpHmNW5wQEY=; b=j
	LlZ4r98O6JM7uG4MjI7DZ6o4BYgYemF+xRB8g3z8DswsSltpEDW6PX6XboqzVkSo
	dMTBbkenGVfzvIK50D/fxy7tFUgqfX1j3RHB48wb2TnRyJJqKRuzvf+hs05QpJ71
	KxdiNVQMVzeNgK9qz20RXylBS4AJgm+cRvSzmZ9QZD3o8rrAVvhq98TePBbDGz+D
	Eu8cEsjn7c4ggMdJwCyIFjN9fZ/SR8C2PWSxVJq9jBmpKRCRhaGn/zaKYduLZCkk
	7Wzm+FUU2JrjG9SuUnFmwQJcXzsOr+6jNI8ZoLEE14aIWOccut2xROlfPp31bJbR
	wnTtLC3Y50OxWe+nFgaFA==
X-ME-Sender: <xms:VDPEaMKaDuj6YNUnJyb5fmdg07q1nws99GUT3Gl85Qbmwm-DQQJ8ag>
    <xme:VDPEaMJMEByUCZX609tZgganSiROLMa0LYknS2tSTlx65ODNFP9vPwlB5W7YRgRKI
    e3ApELmfhDv2SbiKGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestg
    holhhlrggsohhrrgdrtghomhdprhgtphhtthhopegsvghnrdgthhhurghnghesghgvnhgv
    shihshhlohhgihgtrdgtohhmrdhtfidprhgtphhtthhopehvihgtthhorhdrshhhihhhse
    hgvghnvghshihslhhoghhitgdrtghomhdrthifpdhrtghpthhtohepughlrghnsehgvghn
    thhoohdrohhrghdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhiuggvrh
    drsggvpdhrtghpthhtoheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdp
    rhgtphhtthhopehmihhkkhhordhrrghpvghliheslhhinhgrrhhordhorhhgpdhrtghpth
    htohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepiihh
    ohhusghinhgsihhnsehlohhonhhgshhonhdrtghn
X-ME-Proxy: <xmx:VDPEaEn_poDkwgGNhrTJtUFDYQRl7bog2Xg5PiyASRiR5NzmhrVmlg>
    <xmx:VDPEaN5SrA7fTWOw1CN5MPRLTS9_SR_q4hwGSPhTJ7OMV_UJ26x6CQ>
    <xmx:VDPEaHkIJQhTp8QAFYtkqYcQWkkKHWcPD_ZneZ3429DQKQSWhuf1wQ>
    <xmx:VDPEaIU02_Qd78PRCivK4UxTG5vEydiOgkA_Bj8C1Z8h12DAWL44oA>
    <xmx:VTPEaBB2IOugOE8B3c-yguYVb0o2KPIiUmZ1mjLnEm4rio9GNcFRolXO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1D659700069; Fri, 12 Sep 2025 10:51:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aemw4uuOSQoZ
Date: Fri, 12 Sep 2025 16:50:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mikko Rapeli" <mikko.rapeli@linaro.org>,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>
Cc: "Ulf Hansson" <ulf.hansson@linaro.org>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, "Adrian Hunter" <adrian.hunter@intel.com>,
 "Victor Shih" <victor.shih@genesyslogic.com.tw>,
 "Ben Chuang" <ben.chuang@genesyslogic.com.tw>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Yixun Lan" <dlan@gentoo.org>, "Binbin Zhou" <zhoubinbin@loongson.cn>
Message-Id: <413a49f5-91f3-4334-9128-29297293f953@app.fastmail.com>
In-Reply-To: <20250912142253.2843018-4-mikko.rapeli@linaro.org>
References: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
 <20250912142253.2843018-4-mikko.rapeli@linaro.org>
Subject: Re: [PATCH v3 3/4] mmc: remove COMPILE_TEST from MMC_LOONGSON2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 12, 2025, at 16:22, Mikko Rapeli wrote:
> It fails to link due to undeclared dependency
> to regmap which is not enabled for COMPILE_TEST:
>
> ERROR: modpost: "__devm_regmap_init_mmio_clk"
> [drivers/mmc/host/loongson2-mmc.ko] undefined!

Nice catch! I assume my normal randconfig builds never
run into this because there is always something selecting
REGMAP_MMIO.

>  config MMC_LOONGSON2
>  	tristate "Loongson-2K SD/SDIO/eMMC Host Interface support"
> -	depends on LOONGARCH || COMPILE_TEST
> +	depends on LOONGARCH
>  	depends on HAS_DMA

I would instead add 'select REGMAP_MMIO' here, which is what
we do for other drivers using this.

     Arnd
