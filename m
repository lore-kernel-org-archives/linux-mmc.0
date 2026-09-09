Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18BC36C9C0
	for <linux-mmc@vger.kernel.org>; Wed,  9 Sep 2026 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974700; cv=none; b=UBFvmzfTxYBrx6enIRL0LdxIKRVBgsNKLWpTd9Zbpp6Dm87kwsxKu6efuUoLzjWHMaZHtGk3pbq4EPBGba1noqIekdwFpD76kAOkvMB/An4PypL0+K0qTan7l+IldZgJmiKTYMaSaBS9bCfOCx4SiJvqgei6FIuPA4XHsrLEOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974700; c=relaxed/simple;
	bh=RFYNTAqUToVh2KLGlT9lZApmJK4JV3QG4xSSPel1Pgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQVLD8I0APtsFMcxYAyW339/QLblMzEFCtKXKTpQ0XbuhSX1Uyr9LxH0IVT5Cxo7t33RKenp0s7/mmKEppX5RN1BqHitmvjLdNZ1C1yUrXxEb70NhxmgnJE/vdrKDNzlvnhwkeF6Muf+QxqEa7QLdv5Jzq3lX3nz7NNWVQDsyP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=h0lITbxA; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="h0lITbxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=RFYN
	TAqUToVh2KLGlT9lZApmJK4JV3QG4xSSPel1Pgo=; b=h0lITbxANl+00DXgfBzq
	4xouj3G5aUAgi6vaRjKkD544ADWqyJ8B/Jrgp2SmW40zZQh0qlFcvU7XJSu0SQWe
	jD0SZ6dzMeuRO8i70sxd/VEEB94noHVpCfAXPKoXc8Nijc5B3Us4kt5BOWoEgQLd
	smH7jTflt1gZO+PdTx+zjbSfot3jQtirdNvjrKILj2W0+/SRkvCD1RZDJ9cBB6+y
	H9MBx2FyPE50eODl5TVCUPN0vh+RuvoMSHn6SKw6Vyx1FyM8/Y3pj7joYVn27FbF
	7gc8eWeKt2gfDbNQlSpwSESgTCl4pPztrs7C6ADEc3HTl+QYuxfmQ+HQBjVV+QYM
	ow==
Received: (qmail 3213779 invoked from network); 9 Sep 2026 19:24:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Sep 2026 19:24:47 +0200
X-UD-Smtp-Session: l3s3148p1@qbi6IBBbVuVtKXCo
Date: Wed, 9 Sep 2026 19:24:46 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulfh@kernel.org>, Jakov Novak <jakovnovak30@gmail.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Shuah Khan <skhan@linuxfoundation.org>,
	syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com
Subject: Re: [PATCH] mmc: vub300: fix sleeping function call from invalid
 context in vub300_inactivity_timer_expired
Message-ID: <aqGWWhvL5CKH2mgx@shikoro>
References: <20260816153809.7067-1-jakovnovak30@gmail.com>
 <aoLCr8JEYaYxcJcQ@hovoldconsulting.com>
 <CAMuHMdU_Rx4ZGi9SsNxKUDyYmV-GbD8rD9NMVzYginBMXdZDMg@mail.gmail.com>
 <ap7CaVj82BJZgjf6@hovoldconsulting.com>
 <CAMuHMdX6JfqpLMGDQJSQ8E8XNobRwr16LOzuphPt3Afs-OZdJA@mail.gmail.com>
 <aqEDb0THnCM-Q_Vy@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qeK+evd3f53v2KhN"
Content-Disposition: inline
In-Reply-To: <aqEDb0THnCM-Q_Vy@hovoldconsulting.com>

--qeK+evd3f53v2KhN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Sure, but should you be scheduling rescan work before all resources h=
ave
> > > been set up and the host has been registered?
> >=20
> > I would like to defer that question to the TMIO experts.

=46rom a high level view, independently of TMIO/SDHI...

> Are they on CC?
>=20
> Ulf, perhaps you can take a look at this? It seems wrong to enable
> interrupts and trigger rescans before the host controller has been set
> up and registered.

=2E.. it is always a good practice to enable irqs only when the device is
fully set up. From a glimpse, this seems to be the case here as well.

It needs serious testing, though. SDHI is a complex, organically grown
mass of code. There might be subtle side effects. It should still be
worth it IMO. I can put it on my todo list, but no promises...


--qeK+evd3f53v2KhN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqhlloACgkQFA3kzBSg
KbYQzg//U9Y5plRaRLelGnT5ulvobKWdqSDrrq6AnhuHgNVoFhLoNsKBpwaSXoFx
MLdn0ZcZsDV49zVme6/Nuh8Gi4WvA17eKzXpL8jHfZy0xH4/uKvaAMKovaDjQYWd
Obn18H+tU7wSqT0MspemzuhWHTAjzYUpKJipEhI3lgNj9S7szR7X19EGUnfqq+MA
yJC5qdcQF1CakxQvxQwkswPXK1pt15nunqLdZt5yPnhm55vDy602LJXOrzbhrIVL
umDS1TvEj9cMkIYV3ZQZQ+dep/D6VTJJh3L7xEycIDHYsi7xYOBhDh/AsVUaVDWI
Fb9OI/4UQcwvJacww+QvJWwaMnb3x6rXLjN47YaI1ASIuytJP3DFv/ymHD/N+LAj
VsgsT90ihZF1jIacKgEOlmJ+hixVBQZR6QRqVLBMFllOu1o6+fTxthZaN0NXCcNT
CuAYRJP5/falyurWn1PgbjspiPbIRdnzssn0oxr9eecGQMJX/F+7LEFQABJZupEA
rSVo2LXNDBNehIWlB+8+K9g3S2PWgUdiLRb+ATvwzXqSR856+2MX/pamTJqHr7LL
ZKN9DpbT5Djx/s8YoI34w/FjFWZACcNqkaNfTFN6OV1YdmUhUM0Rpw4ywk7F6xzD
U4vy7+NCghQheTmVAtdmnFm1QbSQwdBKU31ST5oO7mIhguFRp4A=
=lnBq
-----END PGP SIGNATURE-----

--qeK+evd3f53v2KhN--
