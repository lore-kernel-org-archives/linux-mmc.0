Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727E481257
	for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2026 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431435; cv=none; b=GKUTK+C5peqeQhcytGHQx5Rt4exOF/1xr6zrtz6HuLwtlbvFozoWe0ArRu4FB7/Ra93F0IQXk345pqJM4nVVEodUD8c6mmWb9H92RNKU5aHMQHRlHKvgfkk511Q501VTZubqxXTUVeVJfi9C3a+iyuOnwJS0m3EvRlUqsbvQYPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431435; c=relaxed/simple;
	bh=i4XmDCjXkn59ZVUkKiXrN08n8fp2zjPNWvkJx/a1/IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYpgnGkp7mzn+DbpqMaIUO/ZMq19afMkuYXZOIU09TQXKcfxTBgKwiuTWUby893Tyc+LpK/waMH9GZ1J0AxvzSKotiZqy5im9JNFtRisIGeSRzD3XUw3Op7JnVPlQHc+gbvQ4I6uZhafLQkXhgRo/CBvuHnfLGhwvj/t8IMWpfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=B0yMxSbv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="B0yMxSbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=sU0t
	HS5UGwhb0TZkzSFiUQVjiIgLv8Y7NkvNB3Tv+UM=; b=B0yMxSbvHs23kgSns6cB
	tbc/HXAj0De7xyVY3CbzvWSFk3v7IS4875KOMW6KQK2JbfWuwqoN3XG6FHIOB/9J
	2SjKXeyEUc+NyjTxzJ6YtD2ZAFbIJEkfcUomOVQ15LVHh3RKDy4BiWQJwwr3Qws/
	4rQgO9HhuA8kar5JfOh86NmrNXKnjeWNHBakXkzqw5jc+gXhaJ7wCrSjsMu9zwvg
	lAz/NevZAMlv5CQv4C6nOjSef1Iw8Oi/EOIi/I+yhGlhqV0gX/c8qqKXLkK7Inyi
	SXpTVqD5qy4lmjAhJw/AvIm02GG8CJWDhELkYArgbGSvRY3GNYYjeb/iH8XrBh5u
	9g==
Received: (qmail 1009339 invoked from network); 3 Sep 2026 12:30:18 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Sep 2026 12:30:18 +0200
X-UD-Smtp-Session: l3s3148p1@Trxfo5FaxOAujntC
Date: Thu, 3 Sep 2026 12:30:17 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 10/15] mmc: renesas_sdhi: Add write32_hook for
 CTL_SD_CARD_CLK_CTL register writes
Message-ID: <aplMNoRlIYbVZH5-@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-11-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I9oGEfjpYOistGFg"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-11-biju.das.jz@bp.renesas.com>

--I9oGEfjpYOistGFg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 06:16:40PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Add a write32_hook, analogous to the existing write16_hook, so that
> sd_ctrl_write32() can wait for the SD bus to become idle before
> certain 32-bit register writes.
>=20
> renesas_sdhi_write32_hook() checks whether the target register is
> CTL_SD_CARD_CLK_CTL and, if so, waits for TMIO_STAT_SCLKDIVEN via
> renesas_sdhi_wait_idle() before the write proceeds. Other registers
> are unaffected. As with write16_hook, the write is skipped if the
> hook returns a non-zero error.

While technically correct, the commit message is totally not helpful
because it misses to say WHY the change is needed. It only says WHAT is
done but I can see that. G3L exceeds the 16-bit width, this is why we
need to change the code here. I know you use AI to assist with commit
messages but please keep a suspicious eye on the results.

> +	host->write32_hook =3D renesas_sdhi_write32_hook;

Have you checked that all SoCs handled by this driver support 32-bit
access to this register?


--I9oGEfjpYOistGFg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqZTDYACgkQFA3kzBSg
Kbby9A//RumI6iNFibcLj68lexEHIaMWAwDK99MpeSja5J6fOQQiHtqIDI9MD5vI
Qew4SfFBapqs47od/38urBcHKonWxVqVNCOdKsjO/z3e3Bs2SeIbIp/NFTFeUVeu
6TTyMzr3z4dfdivay9GwWAG3qGB/1sfP1baRcwE3pajocuSQz3Zt35Y21sDFI/2U
bnFNrK1OPlpA/ha7Vcdi8fa1xDz9LO871gS+3qS1ZCX4q6nTd7/cwCG5ajKsbzbE
EtctPgZiuWBhT8mfIZ5XnSeRjNv90fBd4LhuYyJsvPs2QDwjFd5B9c2OG2si8Ua7
b3N/vss8AiiB1tLjlT41e8MU4Cmiga6vB/ojVPFwD0S3NjyG4eKwEosa4I3m1SNB
p9Dux895G+m3ixwLHs/5DE/hC3wG0LBf37ZLs9Gfe/eCcHKAKxqOPurZwbnwTH0S
HujLvkf58P2rf+DOaYXcHe7S6OC5mjB2cOt3Fqo4u7nQ7S/LW20kbaYJq6cIiujP
xHXdoiC8049AFHOyx4ksRnKnV17zgcB+WpDno3HC1pRA1Xe7PlAuI2J4DpWjTLRz
T6b/tTi3fIxDDQfsJIirZkiCnNwJgUQ6JNpLTzGwf/7o7HF74IEJ4r1bGFd7xX+p
TSTMSP6eTjCJTfIVC3XVoQSWbKcrGh1sorZSpuwubFk586uR1lg=
=3pni
-----END PGP SIGNATURE-----

--I9oGEfjpYOistGFg--
