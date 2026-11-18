Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795033038;
	b=DmTogyFNKI8mx++8fD7w66U6amcHd9x1qcKJy+yFpLVkvLytcHq2Vaa745a7Y7JF/DBZ
	 4BE5SDXCOUga0xbMpJPJ0TkWDirIA2EXbzVkm0642vtmwAzqkKhBseLRHyUFv9PZnRfn2
	 JYH7zbzg80LqzEd3wMmpnVauLI51Y7uuKCJ21OH9RAMW0/nm31hwTHRuKyp2QALL5Ewg5
	 m6WE1Oe+Im32wKpK3Be8gwvH2QXeeE5IOeOYNC9eh8jTF7XKTmo0sGmuD8I1WE+eAwfUF
	 m1z9XRnFZoLfviJF21/T9wCvYydKBn6TXu88Aakl1Civxev0uOyMeci8ewiZC6u65OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033038;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=HbY4g/YaMvNTowGnC6MUmcHqiwGPxXP3zNLZX21jEEE=;
	b=Y6A2LtkOtVu22PKfl+Zh2suO+HROsNyJMzq1ALQwJPTDNb8fbHuLOW1JyHZvPoIZBEoU
	 /VcgmEeWQifBtPuo6GXUg8AMamvV7gcSENdLEdzGQgaSrl+vlFF5kk4qwy29fIeMrA+WQ
	 Ddb68UYovy0Mmg4wFu0IWrqikxECPRDg1sflHNKEgxywqu63N4F+eyoRzK+qebFBseKc1
	 gOBMAGrNDdHbpJA+Wo7jlbMo5zG9qa6elpCfGmG9wyDzxNKDxjw7DQr6Gv9GuaeuqE1kH
	 C3evT9K+KSl7CdH4kN/3iRd36MtocjbenqSuYMzvsmbLPL3+2BKuGIXf5YagQMjnPgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=YtnId6Aj;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C5606A32F
	for <linux-mmc@vger.kernel.org>; Wed, 18 Nov 2026 20:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB3C5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=YtnId6Aj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=HbY4
	g/YaMvNTowGnC6MUmcHqiwGPxXP3zNLZX21jEEE=; b=YtnId6Aje+DfnmCbpsck
	MsjfG9mVMCN9KE3npRRDuk/YkskwxBKUTTdAK7o87ROI5h9hBr+jDbZUAEXtmSK0
	hq5574rQhAV7k47xj2ThnP6CB7fPECYSdZUuZ1x8OAieUPqZBtGioDVN+U4FLM4O
	YVTZMw9qPEe6Kd/2uSr8vpuiA7Knd1JqJ4+lU9vzoqfiIamfiywjH727wGgDi5CQ
	D3ahA3hH/h+BvBEI8o4aVzbvaIVaeL80zCckYzjv3GqhvjPlXnqKivb2v2fHA17J
	qBXglOjxw6oQ+lmZWXHKEK+gLhb4B9sGMi9eSBROmnSHDfqivRiP6+wrk+mIihaq
	hw==
Received: (qmail 796052 invoked from network); 18 Nov 2026 21:17:12 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2026 21:17:12 +0100
X-UD-Smtp-Session: l3s3148p1@AL09spJgrpoujnsi
Date: Wed, 18 Nov 2026 21:17:12 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linusw@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sh_mmcif: rework sg_miter handling
Message-ID: <av4HwyjnxYYGnsK7@shikoro>
References: <20261118134445.2909283-1-arnd@kernel.org>
 <CAD++jLnMxxtrtDMm6rYxB1_5jn-FpnrO3Jrb0=SmBmFWFkCTdA@mail.gmail.com>
 <bf5fcc4b-05cb-4f11-8f6c-0f94fafd65b9@app.fastmail.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9i3qkAFQzuI78HwQ"
Content-Disposition: inline
In-Reply-To: <bf5fcc4b-05cb-4f11-8f6c-0f94fafd65b9@app.fastmail.com>

--9i3qkAFQzuI78HwQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd, Linus,

> I'll post a v2 tomorrow with the bugs addressed that Sashiko found,
> no point testing this version. Maybe Wolfram can still take a look.

I surely can do testing, the Lager board I have should be suitable.
Reviewing - I'll try my best with v2, this is all ages ago...

Thanks for taking care of this!

   Wolfram


--9i3qkAFQzuI78HwQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr+B8MACgkQFA3kzBSg
Kbb7eQ/+LqBlUi86Xlmyh0vPR2K/rbEduXBxJntUncTCbXR2MOU9jYap1N8vvakz
LVyB6Z94bjeVW0+cJBY4YRm9Yn6djB56EtIld8VWOObyGx3M5Ul0FEET3uxhAJ9/
iuiOuvuFBNdpuj7nBFTx7s+qEaYN5brb2cSsTWNUZJ/IhHyYEZgpY4Qx3wla5Z/N
WCDddYCBWTEKZZyrxsIM5Q+4J0Krzuf61r+lU/6M8Eq3CrxUoLAE86aeTDd11FIi
9BYNzLB2YsrootDCV9t4GK7lpE5tG7ZRbPUDNN04dmwMS9b7QkU7Q86lXy2O0rDl
v6ajpJMNlp3bM2Zibg+2oHifZjtJG+zf0azrQoATRK6xK6aWPCieDhMMFoWo+dKz
Ay1s/kcAxfCDWjseQuBw32mfgyKp5gyTRchqagwC4EM36iGGUlIcEwWWYevLjd1E
Zy6IXeC887bvebVBS2jmIRtrKqWI8fBNWnol1Tu5DLGXCl0pWt06s+FNPJQuejA7
GA+PgDp0/5Wr9ivfB/Z94IXsd2dRPwCBVaJ/ZHibG6JrOZJnAjr5fuSOegTOGeBq
j5hlKkOR95u2gp+sUmrJUhvsxg8x1RvH6JaUqfzOxt9t9mgeV5jxFj9K8YQsFCsJ
RBQDD2NuJ6eltWU1HRmTidRwNEYU05rZqfICmlI0pEe2PjqkZXk=
=2xHZ
-----END PGP SIGNATURE-----

--9i3qkAFQzuI78HwQ--
