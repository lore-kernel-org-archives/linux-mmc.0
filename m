Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204587;
	b=y/cUXjBSelRxS//Kw8iH6qYxALSx8T43cvs74IBmIxQZKq1IZGnEVGRgXVAbykoNQdxd
	 Q1hF9w2ygTWcB0cZHlDpaQOtH0aIeKl7z6PHwik/lHGzVcxHtT86pUJ+NxwApskhQIdTm
	 aXb7Isks3DpbbY8zYzcpsKSAHQav1iT7bQBJzVUmKwAQmLqlvY//Z5MeodFLc5Pb8QWw9
	 0swm4C3l2MAakWTO/R8N71ptguEKcso4ntreVFnpicjFopbTRV6Ft8ZpjYqGhvR/d7VgD
	 yaCt2bGBn237gV04NOGbX8v+O71GiyK+EkKwuXwXF5BcRV3GZgdCtTYfcmZUeTdL8GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204587;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=jttWHcN3Lx/YqX8MrbxqckD48EazTafTDyqhRLhuIs0=;
	b=2rngTLZpyiQT/KMFoWNsP2sz5Q0UeKdtLbtYk4u4aHiUI9o6L7hprfBZdVwZqoibi/Om
	 JaMUhA0AlmKw79zD8ivcVW9MYXY2l6oCG/OV/7GXrnZZxpxSDCbdWFn8OEO/Q7Mc4Howd
	 igPeWTVESKVc6BHJaXwcayZOa4/c6dITiVvgsh6rOzaWXMyJ+/jpHdjsp2N2H1/1BlEBw
	 pIjY62V5tAK9feduibrZYMiyDyVGAhcY6n5xtqQyqBiEFeIvmFYDWGSWtRan9EpZWPC+c
	 t4dG+/pwVwb9gFGgs5WBe3a54OnC4GFfimSORyjQc7y8Glz1JQeLCzeA0b0f2h2LXZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=56QyAMft;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E841606A6E8;
	Fri, 20 Nov 2026 19:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E841606A6E8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=56QyAMft
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jttWHcN3Lx/YqX8MrbxqckD48EazTafTDyqhRLhuIs0=; b=56QyAMfteX5gb32fdPnkmUy7fY
	DMW8mpXWCenxb+reYE9o2DxAL4Fhmrwq82GeG3M8wCnKAiUcNDSyZgAycBlyNIX7lx63ydcyLMnsL
	Htzvj0bKh+YG+4fMXw7FVaqJs+bQ5HoSMbtwYWgcW2JBatuVFihlxLpBIKU2c+21CsgI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xUUi5-000MvO-DG; Fri, 20 Nov 2026 20:55:49 +0100
Date: Fri, 20 Nov 2026 20:55:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Heidelberg <david@ixit.cz>
Cc: Karel Balej <balejk@matfyz.cz>, Brian Norris <briannorris@chromium.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org, Jeff Chen <jeff.chen_1@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [DONOTAPPLY RFC PATCH v2 0/4] WiFi support for
 samsung,coreprimevelte
Message-ID: <20374af8-2f50-4637-b92a-4fa5c5192c20@lunn.ch>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <DEJL1ATTQMVE.120JV9YW59I27@matfyz.cz>
 <aSnWYS2g5slVFaSk@gaggiata.pivistrello.it>
 <DI5L100Q1RKO.1A68EJIPWYSRC@matfyz.cz>
 <afI8y70U7wFT_07h@google.com>
 <DLQ9LXDE2P29.248MPYCJMT0DL@matfyz.cz>
 <787950f1-ff2f-4b49-b164-61da3c9971c6@ixit.cz>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787950f1-ff2f-4b49-b164-61da3c9971c6@ixit.cz>

On Fri, Nov 20, 2026 at 03:47:48PM +0100, David Heidelberg wrote:
> On 27/09/2026 19:12, Karel Balej wrote:
> > Brian,
> > 
> > Brian Norris, 2026-04-29T10:15:55-07:00:
> > > > Brian, what are the options here now? Would it be possible to make an
> > > > exception and accept the patches without the firmware being in
> > > > linux-firmware? This is an old device with no mainstream audience

Why even bother, if it has no users?

We have to look at it from the perspective of Maintenance. If it gets
merged, you have to expect a hoard of LLM script kids descending on it
and submitting patch after patch fixing theoretical problems. Is
reviewing and merging such patches a good use of time for a driver
with no mainstream users?

Does openwrt support it? How do they solve the firmware problem?

     Andrew
