Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5F930FF3F;
	Fri, 12 Sep 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688851; cv=none; b=nEVAtLMhNDc7d5FoBYtHoRy4/2oHmU8BpkzO3xQDbHl8EJbJkSC6ONZ5qxh0/2fYlGUXM3lf0uHVCNn9K4ht6bVVwvOZWD8X1j8NkvAI3CjrybaUp9vkweF69eXVDEdeFsAmzczlo61RwlrEcK2Yddhq2GkeBehS/RYLiL4Eluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688851; c=relaxed/simple;
	bh=6WyxyhHOcZbwQsS2R2NfYe8aaidx01RzRgbFYmoJ+TY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FZXOKQQuoiUr3fZAqsTyXxAuNnzvHiLxBPUXXXKJBL/Q9DdO3n6CFTi7ihhvZRhucb4PI7LSQkhkwrEvYEIWLS1DOBCNMciy/6gne9WBg1s4eCdlaOMZouBIe1OUN5pQTU6l9cMTIVwygw2qaFRj1zHfp1XXJDFnNn7/9G0sx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OAoxXzIh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDIRO9WA; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OAoxXzIh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDIRO9WA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E0FC01D0027F;
	Fri, 12 Sep 2025 10:54:08 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 12 Sep 2025 10:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757688848;
	 x=1757775248; bh=atfgFJYJMGSaG1gGCv3n+BLUhT0FWGhcmbYsCXsjALM=; b=
	OAoxXzIhmoy8RtxffZihLGEttl+6kRVdtzfofEGaXcufRfwpjuryhQn0CYZFBTv7
	xinn+UPyztBaUNQRR799If7PBSGj9EcnC0kLfo6IrYwmv/Z4Dxjetn0guTAQID29
	D8t6VxL5QMCzMDVpSYlrjzUDg8or/jMvs9AL22Vgx6FkIAr7eJaRwg1Dl34tewh/
	OcvqKySv8QkhUDqMzaag8UaIuWEEPiBMaTmX2wRpi+ukXljGg34E3xmMkPEloyWn
	SxcC4E5chDO0YXQMtPNj2HGsPFSwHafOtrg+NKyQdsxP37uCPn/ngmiZYHoBtQHu
	8GXMgsaNPfM+ImYNHAycLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757688848; x=
	1757775248; bh=atfgFJYJMGSaG1gGCv3n+BLUhT0FWGhcmbYsCXsjALM=; b=g
	DIRO9WAj1d3bl0UCrMUqHeG9QwTZMNM+4PDDu2W8Q4E8wHferBcS4jtTeXQicy9l
	b0F9R5C74tE6FgKCqymGZsWybIGJ+8HgIDQZugY8br6KNSuDX9DDj8DUmzZRgvuo
	D/8Lb+bX7c5/F6M/aE/8XAVRGOz9LTAxDQIYDhPFBB9yTKCbbwj8OEYwvo+uBpyw
	nMECD7fs++I8n7bC8rw37HuaS/r0vT9N/2E3tAMOGZhRVsHx+ytyxmpG6GOpVlpf
	N/h9eaIjesRskfgOednvDyJd9ak6B3AxApeVjfPRWcNWaX07KwsZRU/ZapERrDfy
	2TXnwSd0aV9YwwuryBa0w==
X-ME-Sender: <xms:EDTEaK0AL5WV5kodKPWghWA4YCifnv_9bEnujS12bYOp50D7X0Nd2A>
    <xme:EDTEaNHTEK39dAdhBODVHsCootCH4-pMyF3-dmXwASLs0O9JMLfkqvqeTE-NJlra9
    -jVSPIg0rVQ3YnasMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
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
X-ME-Proxy: <xmx:EDTEaGz0j01dt0yP6Z9t5a5ydckOxRJs2bKyaUQApJKurLobIeQlbQ>
    <xmx:EDTEaMUkXvAZxTR31z3PZluByb99EQvgNShbXKOGwduJJmo3GwmD8w>
    <xmx:EDTEaNTxZLb1tvSRhvFpC9pTiBy-7oFILlq17nSThn7XZ2Z1qrSVDA>
    <xmx:EDTEaERSnZtUJZtrqW0eVUfiMWGsKHxAvjCv9mB-WXTgY3ET5hwP0g>
    <xmx:EDTEaLco3xumt4FvCVW7pJaM2ZHuuOMCA49EC6bsKL0e6YgocpdZZY2k>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7CF80700065; Fri, 12 Sep 2025 10:54:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5_QdNO605ZZ
Date: Fri, 12 Sep 2025 16:53:48 +0200
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
Message-Id: <2fe14494-6fde-451b-b345-13f0e85caddb@app.fastmail.com>
In-Reply-To: <20250912142253.2843018-2-mikko.rapeli@linaro.org>
References: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
 <20250912142253.2843018-2-mikko.rapeli@linaro.org>
Subject: Re: [PATCH v3 1/4] pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with
 ARCH_ROCKCHIP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 12, 2025, at 16:22, Mikko Rapeli wrote:

> diff --git a/drivers/pmdomain/rockchip/Kconfig 
> b/drivers/pmdomain/rockchip/Kconfig
> index 218d43186e5b9..17f2e6fe86b6f 100644
> --- a/drivers/pmdomain/rockchip/Kconfig
> +++ b/drivers/pmdomain/rockchip/Kconfig
> @@ -3,6 +3,7 @@ if ARCH_ROCKCHIP || COMPILE_TEST
> 
>  config ROCKCHIP_PM_DOMAINS
>  	bool "Rockchip generic power domain"
> +	default ARCH_ROCKCHIP
>  	depends on PM
>  	depends on HAVE_ARM_SMCCC_DISCOVERY
>  	depends on REGULATOR

Acked-by: Arnd Bergmann <arnd@arndb.de>
