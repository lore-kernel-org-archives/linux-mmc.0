Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D53C2DC793;
	Fri, 12 Sep 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666877; cv=none; b=LCUuJR7s41Q5iYpJuAJE+4UXxJJCFnnT4zZZU5uPMhdMj68S6ETgfLoGAtD4FPs+Opbs/RlRCDclPOM0YD/E6ebeCmBeUZDxMyxT89azrGVcBLR7l8LxkkTsVaWMmsZ1HhCdpY5n1ICRLvFEBhCLN5sCFFtvDMtjy1fWkmSENjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666877; c=relaxed/simple;
	bh=eo9w2VnFL3j83P+C9TJyZoTFiiG3GBq2PqaLoXMCu5I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=t8kuDg0KiLdFaQhdxt3qi/nGW6ED+T8DzW+9M0bUcoKNtcEnPEowZEpHsbit9+JP0+1pfK8d7JAlibEs0YRlruvqHvgjj7ORf0a3uI+K4FG7EP+tPW9lVxi0Ut3V4wTcu8IE1y0Gph6XBvUyt1NZN+uHZgwe1m/A9eDX9C5ZP7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=muBTD1ha; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ld9ZQCjh; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="muBTD1ha";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ld9ZQCjh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 000ED7A03A6;
	Fri, 12 Sep 2025 04:47:51 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 12 Sep 2025 04:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757666871;
	 x=1757753271; bh=iDgdGFvPVafirg3SrUddyH198xBsq9KMfs20+2Svn60=; b=
	muBTD1hahwMhNUaNwK28ttQNJbGdOcpgk6DxpsXQuab3tUaCykcETQQ5BaTXYDy7
	E9zldZ18KRRV5Trd5JuUMl7enoeCSu+CjcqWSj8XlkufJrgQBoINxK+DeA7CU7bO
	6y3ycJQxDHTvLETyZHiTJ9qrnFg+qq2I/Bc8N2G5zuayXfU3C3d6a7IFH6FWysX5
	uVcIGGz+efaLyi4oo0N2SmZtP+OrNv1N37JQ1R3rxaCe2PaEUCz62OH4jBZvk6Q7
	/GebSd6FCn82pS8vcJ7mwIud92ijjJmodC4MVcq4anAsvpOvu+1+xBI6LcKIdggB
	yK9hA5XuLvkIKwpP5anuFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757666871; x=
	1757753271; bh=iDgdGFvPVafirg3SrUddyH198xBsq9KMfs20+2Svn60=; b=l
	d9ZQCjhDRSNCac5T3Cmzqo9+troRqzUTGrdApG113OykShJ62UjytxwYMYel1md0
	PHSUIspMFewbRjW3xIRnydTgFc0yhzfSGFU8CGgLWwmTys5U6xUKBtEgoU2jpk9Y
	/p8FjyRq8uGnfM/1Y7ObZkRHFWefFCNhnjMwDChvlPNJi8eoMmJ/v4kAsi5IV9uh
	WtU+tb06T2RLHma1GCrkYz8oVldJBHRwx5h1PaLY5vxeuG9N0u66gpBufSRnpF4i
	wXVStOXcM+dsr368fmtpVhYfVSLTzsgRABtzvriNz2dSwLnuhCXMwki5VKF/Hqah
	3nKJZQC04u/gazWF/z2vA==
X-ME-Sender: <xms:Nt7DaHa3ACbyA-SqO1QiGQNN8fy6tdb47GQva02MkTxViI1x7FjZHg>
    <xme:Nt7DaGY94I89-xyE1XDoa5FTfhUrVYMu2Xw_q3DdVpq3tQ7G6Nhf5a9pWTjKeeUM2
    vO_R5XII579Y4EsCVk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvkeeiudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Nt7DaB3eG7KUd06J5zP01Lig6qQhuR6NizMonnppkI5_iRX1ykURSA>
    <xmx:Nt7DaCKrEWHNDDdAQmsP0HG7WHsRMpSWHQ1WiABlL_3hIwiewm2Hpg>
    <xmx:Nt7DaG21SIEHcSKeL8_NFEcBxcdh5OHUFbmWbuAwA_emY66vbLtqKw>
    <xmx:Nt7DaGkQX58TeH2VOoyAX-BUESZ6QRT9mlNeKPIn5gbbN_uFaGD0XA>
    <xmx:N97DaJT_xaVpi35cYxUeQpT3OZhuMkWKHgWCGA9wFX1Hz8ak32lrHEmr>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2093A700065; Fri, 12 Sep 2025 04:47:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ab0invGq7VjZ
Date: Fri, 12 Sep 2025 10:47:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 "Mikko Rapeli" <mikko.rapeli@linaro.org>,
 "Ulf Hansson" <ulf.hansson@linaro.org>
Cc: "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "Adrian Hunter" <adrian.hunter@intel.com>,
 "Victor Shih" <victor.shih@genesyslogic.com.tw>,
 "Ben Chuang" <ben.chuang@genesyslogic.com.tw>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Yixun Lan" <dlan@gentoo.org>, "Binbin Zhou" <zhoubinbin@loongson.cn>
Message-Id: <acbc46c8-30df-47bb-9d3d-91ba477f6029@app.fastmail.com>
In-Reply-To: <1813054.X513TT2pbd@diego>
References: <20250911144313.2774171-1-mikko.rapeli@linaro.org>
 <CAPDyKFqLag_WkxqOCebvBCJy4TzZEqt-rFD_Z30sajUxgSpcaA@mail.gmail.com>
 <1813054.X513TT2pbd@diego>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: add dependency to ROCKCHIP_PM_DOMAINS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025, at 18:05, Heiko St=C3=BCbner wrote:
>
> Am Donnerstag, 11. September 2025, 17:03:14 Mitteleurop=C3=A4ische=20
> Sommerzeit schrieb Ulf Hansson:
>> On Thu, 11 Sept 2025 at 16:43, Mikko Rapeli <mikko.rapeli@linaro.org>=
 wrote:
>> > @@ -866,7 +866,7 @@ config MMC_DW_PCI
>> >
>> >  config MMC_DW_ROCKCHIP
>> >         tristate "Rockchip specific extensions for Synopsys DW Memo=
ry Card Interface"
>> > -       depends on MMC_DW && ARCH_ROCKCHIP
>> > +       depends on MMC_DW && ARCH_ROCKCHIP && ROCKCHIP_PM_DOMAINS

The hard dependencies are usually only for compile-time requirements.

Ideally this should go the other way and use

      depends on (ARCH_ROCKCHIP || COMPILE_TEST)

after you check that this actually builds on x86 with COMPILE_TEST
enabled, as there may be other compile-time dependencies.
=20
>> Rather than "depends on", I think a "select" is better to be added
>> from the platform's Kconfig. Probably drivers/soc/rockchip/Kconfig is
>> where to put this.
>>=20
>> Assuming that ROCKCHIP_PM_DOMAINS is a critical piece for most
>> Rockchip platforms to work.
>
> I'd think
> - arch/arm64/Kconfig.platforms
> - arch/arm/mach-rockchip/Kconfig
> would be the correct positions.
>
> And as Ulf suggested, this should be a "select"

I think in this case a 'default ARCH_ROCKCHIP' in the
ROCKCHIP_PM_DOMAINS definition is sufficient to have it
normally enabled, and still allows someone to try turning
it into a loadable module later, which would be a requirement
e.g. for Android GKI.

    Arnd
