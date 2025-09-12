Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E955230BF70;
	Fri, 12 Sep 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688826; cv=none; b=L1nm3FI+jbPR8PRM9f9k13OZdoX9DpK5l27kZlsIp0rY7ZU22T+LcbuzRnltuKwK2rIWezvqCxQBQuCHdu6oveJoRK/xzhpqy/Gxeu9xYnSFN9sgezlaEq5jXkyRbTlnYcxsmalPXGVrgwlR6hSJZh6Bh/W6LhqLumcYZBBhI9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688826; c=relaxed/simple;
	bh=BIlhRV48fPKqsipGmoak8LTRG/SLanEuVPCtpJko/xA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GAMX1+T3tNnxf1wZTYF1ur7HZdtjvi0Q5xmOsDGIKtopfLaTZFdZJ/zEadr/XUhaL8cAmLm2d8GI2aRK0wGIy+0tt6ejPSUyEk/zMogzvn7wW9Co8rf1TeuHxvduW7/PB/C5p5z6lwh9rxYr7yvGBFkmwlPq2A+7SZ9k45wLDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WyIXASc6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JarJXD+u; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WyIXASc6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JarJXD+u"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C52F57A0273;
	Fri, 12 Sep 2025 10:53:43 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 12 Sep 2025 10:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757688823;
	 x=1757775223; bh=pcibMtIgJrhePAx+xpu3a2SLNr56hjA5Z1xpe4qOMnw=; b=
	WyIXASc6rDCmttNAt/oUeI8glgE4eXXFJ4babI4LN39XL2j2WEwTrms9/tVm6LT2
	jmcwaeW4FhCR+pFURmubrHfBYK8XxvrB8r92+Prs2Cg7Cxkqrn5pnT8C3C5C7S1x
	T0/g7L92ZIzX20DrT9UMcMIBVxisSpu4gX6MP2mJv5CECbCt8C7K9/MZP5WczXvr
	4MevmZgVUiWvckk4pXEFrIphwr4xRgGs1J/1T7oRSG1l/QJ/ERZeo4GEf/5IojUD
	fZno7u03M6fLTxeLnKBzWav/jhj3LgiPw++eaFRBGPfRza5IILZX9c09QpUu0WfW
	f78J/XelsmikzBfsI5tcwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757688823; x=
	1757775223; bh=pcibMtIgJrhePAx+xpu3a2SLNr56hjA5Z1xpe4qOMnw=; b=J
	arJXD+u459f+c2aFQVl84IOVQ2IUDWsX+p/QQ1LUY6pAcdaPs8N3hBSSoFSiAe0T
	oCQeexsKfro0hgwanS2Y7ZB2QIpWauIcrQ1rvQalxuKFtar2p6u/u4/TH7nWWWRI
	q0tVmGKm/Wh0uXtI/MpDde3WOQ8u7ojJP1i5c/Q0J5zrAUB2GgCWX9kHolGkwwjI
	m1nKb2tQm9i/75PsuvFbg0a1MmmQh6KfiijySw4vZehVKBt2g/uPtpAIVEFStftz
	6BIHlyw2ZR6kZu3fcapAoYXwwjK6zFGAUYRtGGgFfxfAqi7l3GYfAdSskq84afI8
	6FJKux+81wAE11Vwxlh3g==
X-ME-Sender: <xms:9jPEaM_o1-bp8Dn3akiYnjeYtei-X_htrI5xzci28B_u5CAbkyn5Xw>
    <xme:9jPEaEs24q2w8klpujJxHjLHY743VI0SY8FDvzIhow0Sza_oNM6uVPDQ2eeAfwLEc
    ZbkMfMKJVAM2SrKpis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleefgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:9zPEaN6gy9QONEfXC9H4T_OpaDwnTZurDoK0PdTpkrOQvcs8XzrjJA>
    <xmx:9zPEaE_9zPaQMUs91ltkWUALJ6XCZrl5a8uSqxVCin0wWB_zmL4kDQ>
    <xmx:9zPEaJYgW1UbX5DsFfLoSa_d-2Qdh3k9ExkHjwDveFkJjQezlzVt3g>
    <xmx:9zPEaN6GSc8ttCEo6snuynxzMc0eGaF001wLRhB0U0QfFmMK-agASA>
    <xmx:9zPEaNEqjHL1DPdGWUrqsjWlEMUJD8ta7vn6IoN9LfODCP6psIKu18Cz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E711E700065; Fri, 12 Sep 2025 10:53:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0_c9MmsCFWw
Date: Fri, 12 Sep 2025 16:53:22 +0200
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
Message-Id: <8cd0eaae-08b0-49a3-8a04-2e808e7f1632@app.fastmail.com>
In-Reply-To: <20250912142253.2843018-3-mikko.rapeli@linaro.org>
References: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
 <20250912142253.2843018-3-mikko.rapeli@linaro.org>
Subject: Re: [PATCH v3 2/4] mmc: add COMPILE_TEST to multiple drivers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 12, 2025, at 16:22, Mikko Rapeli wrote:
> These compile on x86_64 with =y and =m.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I'll also add this to my randconfig tests to see if something
comes up.

> -	depends on MMC_DW && ARCH_ROCKCHIP
> +	depends on MMC_DW && ( ARCH_ROCKCHIP  || COMPILE_TEST )
>  	select MMC_DW_PLTFM

The whitespace is unusual here, I would make this either

        depends on MMC_DW && (ARCH_ROCKCHIP || COMPILE_TEST)

or

        depends on MMC_DW
        depends on ARCH_ROCKCHIP || COMPILE_TEST


    Arnd
