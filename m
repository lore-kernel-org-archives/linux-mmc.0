Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2A249E5;
	Fri, 12 Sep 2025 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683490; cv=none; b=OndzRjcBu2uk7MPtu26wjyqVMVghya80dxcwJyDng7bEqVneMScHJj3owIDXWM5khEK+QwaxBUOk10Br+4OsNTATpOSmhWTso9UbMh2d2BVVoWDXRxSrLRKVf/5+8xUDDIf9eRPvlH/P4rXwvkw3SmK+K3MthBpde3Y99Qj0iDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683490; c=relaxed/simple;
	bh=4rNLBR8Upg4ZrbCVRyBH/yDBONUT3eiZqdnUTvjhE/s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=f/esGuw7DPqlzqoq6Jc4dmS1VkUw5tziP5UoALB2TVdFsYLSWtjvI+FDKVWiaWDiGbK9bKEU62MZFSCE86pwZ8uXZ2CoDULvDnFieXDM7iaEdCrEg9SfUhX0Zys+drDLeHgRc9l6Li/4Bdi7EQHX5tP3ogw5O50WC14hbAwd6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BMtWMfMS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GBrRQ/pl; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BMtWMfMS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GBrRQ/pl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8626B1D004E4;
	Fri, 12 Sep 2025 09:24:45 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 12 Sep 2025 09:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757683485;
	 x=1757769885; bh=6KZ3evzHd0jMHwprrzgXlCgpdKsD3TU8bNk1cnRINdw=; b=
	BMtWMfMScvjRRHN4lZ5+SxhDrLoe8ViG79wH4rmFIyydLBJqmdvdFK6c19xBWobW
	2oabqe5bXoCvPdabnoU+fokhgoYryavomnRIPJK8opa803KVgzXTxKTb55JHNtiE
	GJ1eY8sX8nZ5ydB7YT3o3XSs0SCy/BRyq4nS4ohoYsAj6nC0Prd+hM6tVznh3l8Z
	mu+0uweQEhVKDaoGfOSsoMn6fP1VysZAqd9ZeIg2G3N9mJySx2zfcU76r13KLUe+
	flnIriEDfWikQbTaecZVtM7j5laAUmtd7NrHMVfwv91Y5XEpcdF05Dqygzb8+bPA
	RQAq5k1JeGkdRh/ovN/RJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757683485; x=
	1757769885; bh=6KZ3evzHd0jMHwprrzgXlCgpdKsD3TU8bNk1cnRINdw=; b=G
	BrRQ/plvFwYVEW9Jz6iNWKKn4g7t0pSJJ2O7daQUEVPVaPFoe2OvukHI8NL/5DkN
	AR1Apk+5HQKKMMAHVPB9q6r9rrBdHP04o2UhOwPxK6Kvd4zsGvI2G9Fp+rEJBBy9
	mPmzlSFqWVydh8SlDnAWXjtrd9a3x6tq4HZpdzonMDyFJ320PHxpEyTsBEkpG+k0
	tg07+9FkxJH+DbsICeIrS0NswFLRvSal0vn5B+cBskxNb67WPzpn65rDtElKoFEg
	V2HbheedFhZVAvTLkW37p9+ExuPF5fhWBN8jCsVJ69puGfE/4F1x5y+RnIL2gRFd
	rG9vKsUQTecG9QpROhRxw==
X-ME-Sender: <xms:Gx_EaMbRJ60j31zTG2MqZpqYKtA9xgPXXUJYqxFrNAQT0qS22Dw7eg>
    <xme:Gx_EaHZR6t4-h5qjnHbsAciVCb_3k3lay4Kq-TwIuEvPnwnJ-Yko0fwbYQGzsOVSe
    vnMWi4SrXqmGpDO4gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
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
X-ME-Proxy: <xmx:Gx_EaO1soN_PdTt7MvIqKxrrGib6VGcyThUcZhLyg0Uvi03HtS8_7Q>
    <xmx:Gx_EaLJZkeK-WAGNJ1BBhGsVuJ9d3kjsY53xgMl8br8dyzRBGYK_hQ>
    <xmx:Gx_EaL1oOyi7TFRowu02Q9l8GB13nD6h2fVDancfLC2U-S5VWoZ1ew>
    <xmx:Gx_EaHlJj2_DriJdFp22gbM-2ubESgPagiPBOAyFuH6I69ug-afSpA>
    <xmx:HR_EaCQrZbnCYhqoX5090l_f5n5TQjw2ituBwsV22mBIgXrMvEiih3ff>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 83630700065; Fri, 12 Sep 2025 09:24:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ab0invGq7VjZ
Date: Fri, 12 Sep 2025 15:24:23 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mikko Rapeli" <mikko.rapeli@linaro.org>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 "Ulf Hansson" <ulf.hansson@linaro.org>,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "Adrian Hunter" <adrian.hunter@intel.com>,
 "Victor Shih" <victor.shih@genesyslogic.com.tw>,
 "Ben Chuang" <ben.chuang@genesyslogic.com.tw>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Yixun Lan" <dlan@gentoo.org>, "Binbin Zhou" <zhoubinbin@loongson.cn>
Message-Id: <4479d851-33be-4559-b998-fdd0480d9f78@app.fastmail.com>
In-Reply-To: <aMQEO7tmvSY5thC-@nuoska>
References: <20250911144313.2774171-1-mikko.rapeli@linaro.org>
 <CAPDyKFqLag_WkxqOCebvBCJy4TzZEqt-rFD_Z30sajUxgSpcaA@mail.gmail.com>
 <1813054.X513TT2pbd@diego>
 <acbc46c8-30df-47bb-9d3d-91ba477f6029@app.fastmail.com>
 <aMQEO7tmvSY5thC-@nuoska>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: add dependency to ROCKCHIP_PM_DOMAINS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025, at 13:30, Mikko Rapeli wrote:
> On Fri, Sep 12, 2025 at 10:47:29AM +0200, Arnd Bergmann wrote:
>> On Thu, Sep 11, 2025, at 18:05, Heiko St=C3=BCbner wrote:
>>=20
>>       depends on (ARCH_ROCKCHIP || COMPILE_TEST)
>>=20
>> after you check that this actually builds on x86 with COMPILE_TEST
>> enabled, as there may be other compile-time dependencies.
>
> Ok so a lot of mmc driver set this correctly but few don't:
>
>  * MMC_PXA
>  * MMC_OMAP
>  * MMC_ATMELMCI
>  * MMC_MXC
>  * MMC_MXS
>  * MMC_DW_ROCKCHIP
>  * MMC_WMT
>
> Maybe there are good reasons why these are not part of COMPILE_TEST.
> I can try adding MMC_DW_ROCKCHIP. Did not yet find out how to start
> the COMPILE_TEST build. Hints welcome. Which top level Makefile
> target or script to run?

I see that Krzysztof went through the subsystem five years ago
and enabled everything he could in commit 54d8454436a2 ("mmc: host:
Enable compile testing of multiple drivers").

The set you found above is probably a combination of drivers
that were added after that without the COMPILE_TEST check,
and drivers that fail to build on x86.

>> I think in this case a 'default ARCH_ROCKCHIP' in the
>> ROCKCHIP_PM_DOMAINS definition is sufficient to have it
>> normally enabled, and still allows someone to try turning
>> it into a loadable module later, which would be a requirement
>> e.g. for Android GKI.
>
> Ok I can test this out.

Thanks!

> kernel.org defconfigs have ROCKCHIP_PM_DOMAINS
> enabled so they don't see any issues but when users/distros configure
> kernels, then ROCKCHIP_PM_DOMAINS is needed for MMC_DW_ROCKCHIP to wor=
k.
> To me a warning is sufficient from kernel config tooling since yocto
> side tooling picks this up but enabling by default is even better.
> These runtime dependencies hard to track down. Kernel modules would
> be sufficient if support was there since in my case there is always
> an initrd with udev and modules.

There is no good answer in general here. Adding a lot of
dependencies for each run-time requirement would make Kconfig
overly complicated and introduce circular dependencies
everywhere, so generally I recommend to only have either
compile-time dependencies specified, or dependencies on specific
platforms that can then be turned off when you know you are
building for another one,

     Arnd
