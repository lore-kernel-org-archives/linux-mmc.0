Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B201D9A49
	for <linux-mmc@vger.kernel.org>; Mon, 31 Mar 2025 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743409677; cv=none; b=cZLBDjPirGMuOFvVRbUfUNUA8DiFezBJuqfD8Lg06Q6AT8prT9agFFrmc9Vc3VMtRAAphdIOagB06HL2UBgzxzYwgIrfLgC0evqJcGL8rpJaRz7IleOtPewVEZn2V9VbGkogPM0ZmyL50YY6NtX7XQ06xl+7t9E4FAvktzjRztU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743409677; c=relaxed/simple;
	bh=LuRdzgXoM5Lbx5Q2Cf31vnPHyJv2y3gMctlPirZoxFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CE2zeLRX2ffZs8xlgvqE9BXulxVA14UhyMkBiWo495FmYzBhR73A4GR73mfzhDYB0IzFGYeJR0LNv8SNUEv7zIEGnaF+tvuLUkYNFZhEuX++SltBEgfXgc+8sI18s2y5WaOsDgWAVljAcRWdHKxzrKyeq5kRy1dXTLWv1cEOUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Cg8MQ1T8; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Cg8MQ1T8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Ov13
	fAx0VmUgZ8UrJlqsFp4uH1FjdZjiZpzlllgz1Jo=; b=Cg8MQ1T8+rDh+2TIWyot
	CD1hcJAG65u2dq7OPZhfQl8boxEwk0KDELMnBtBoFSETuFjW9PD8af9lfoyeDxg4
	LFS9GpqTP4nZS668Wun55Or8MVXwHdZo5pjSg9NDVsJu6T1V56DqMv1kopkZ0IaX
	9dlFieAG7d/vy1qgc7v0nFOLXbOduMqAtCY6mpgCsxDk6t8stW4CbrTqiJR/tdDl
	tOceOPQw9l258AlMCaeYr0Ssaq6wJCvqZpTnLeazsEb+7CwboJq+bfdEtG/BXHRM
	aJiA1zdAZzARutISeMDltq0Cwo62me9TXkwLgIvcTmoTd0RAfMY1kepS/RX9Rivr
	HQ==
Received: (qmail 1156542 invoked from network); 31 Mar 2025 10:27:53 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 31 Mar 2025 10:27:53 +0200
X-UD-Smtp-Session: l3s3148p1@eOJDMp8xEpNQ8qei
Date: Mon, 31 Mar 2025 10:27:53 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Avri Altman <Avri.Altman@sandisk.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] mmc: core: Add support for graceful host removal for
 eMMC
Message-ID: <Z-pSCVf9OJfCzKbS@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250320140040.162416-1-ulf.hansson@linaro.org>
 <20250320140040.162416-5-ulf.hansson@linaro.org>
 <PH7PR16MB61960D396B3E5B61571F7F82E5A02@PH7PR16MB6196.namprd16.prod.outlook.com>
 <CAPDyKFreJu8jZXoBJ2J1Mgj+OOAJX5rjzX0D4ZfbTj_uVrPKPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J4VU7rKJoav/psgs"
Content-Disposition: inline
In-Reply-To: <CAPDyKFreJu8jZXoBJ2J1Mgj+OOAJX5rjzX0D4ZfbTj_uVrPKPw@mail.gmail.com>


--J4VU7rKJoav/psgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > +     _mmc_suspend(host, MMC_POWEROFF_UNBIND);
> > Couldn't find how _mmc_suspend handles this new power off flag?
>=20
> Right. You need to look closer at mmc_may_poweroff_notify() as it
> should return false if MMC_POWEROFF_UNBIND, unless
> MMC_CAP2_FULL_PWR_CYCLE.

And this is what we need for Renesas SDHI which only has
MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND. What this means is:
For suspend, we have some blackbox firmware (PSCI) handling the power
cycle. But for unbind, we cannot trigger the firmware, so we can't use
the notification but need mmc_sleep().

--J4VU7rKJoav/psgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmfqUggACgkQFA3kzBSg
KbZUCQ/8DQrGwjqvlKJSVu4Hon73aaH2GS5pG8nuib2zvLrRhg5EPX83bbgchSyB
mG3yOmwPjsHbEjKh57LTnkbRKNPjt9jijYYstKsGuaw8opvqE0JwlO/kBEzMdllz
UnVDQHQsZwjHvgmFaUaiIh8S8JoYRXuGKBoUm7jOp1wwPhjZTEu6WGYQobmAQQaB
IzfVf9lv2CYZR2taIRD0s58Q9UMrwmRhJXGj/+4OKIoN7HY6iKK50tFyY6dz2H6t
bSRwZZOmBHu1Jbz5KFvJaL5TR/6hQ1GzH7Cc4hXkHFyDEUeaTYlw4tII4gIdQYu1
Iq0tBJJxgcKYd4M+EyTFC3JMSF8jvKkdVbyRzx+GDKFn1hIE6Dtkfn5O7/2kTnTa
3o6MxG6LoN5nzIxLCP6uhSecTvIV22zwagF7YPoPNKevoZZIW8291ca25Tv/7fNC
YaHR5poh2S1AzV2Z0sSzqvYe8N6xnoo8Q59Hp8U8B81GffAr5dERzZ8aVYliCKSO
QxOAxn7h4ApkxzpsJ3eqfGc8RCSxYi1t2l5HrNLw8BwM/yGDopkYAvgcm5bo0ydD
Rt1+OAPrRaWY8qO36Xs78YydNCfCIiGwt5TtJ9C73yEdFIP2O6+nI+FUYMaKNdNG
kaDZIlXh6zoljQpyN73D207I4YAx/wQNI1mvdZAqd8iZkXD1PnA=
=dGnG
-----END PGP SIGNATURE-----

--J4VU7rKJoav/psgs--
