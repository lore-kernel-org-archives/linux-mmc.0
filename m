Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393418;
	b=iuOAH3y6ZdBwyepikEYUAMDeuLB+IVX28TBP0fREtGEbBrnJg6+jYtIxzfTwnxCUGX3r
	 YOty2y80CGipy1gLUu03CcdccswRovTGz10FNNT5NUWlCooyBP7gMaKXzlT+DIIPpzgN7
	 Jrg7VpMhbFxtl8+2IwLNKpOq0VnLvcOhCWqkhUsOqlPdZPsAUUrpbP2QgozcviYQcB1cr
	 t89n8WrK9Zm5dazuB3X2qK1FXmAr7HlFpaoKM9vAA6MXh2H+uAUI3e3cK5uGR1qH96g7V
	 hY0mPs0r/c3UYtv7GfF2lCbKKnMIpuRGfn/OSPlFiB0K10Ws8jLds62VRJcuLRsomvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393418;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=0Cl5WoUjcRrzelzVze5Dmtzimjol4ZnmowLigCEsvEs=;
	b=4ZBcZzkAjJsC97CY0A1nMBQ4LvKsEMep8hlVT7qHSM5V6JXIEylIv+wxYHu0CqaMqb7H
	 f/VGYmAc/avhvACqtWlJbHubC7EWZqb7H50p8HvpgiL2oRuFUt4FA/0jjG3uOgvORO7LC
	 SD+QjfMgq9r8VfwiiS08vliNLbUItl2tpAlA97Yjzo1853nhW8/iPQpnYz2pr959pUQWX
	 wUv35+toP5kjOXIllpIiYXajFjnRB5y6hlBLoQ2ilVQNr0BDhMFDezKojyjtHPyZcwq7N
	 lWUFKgh1X8TW4wveH+WJSuyq270QHbfGB6HPffoLkn6Pzsezoax34FBiY472xZpCqNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=W4MamTg8;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DAD606A327
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 10:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90DAD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=W4MamTg8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=0Cl5
	WoUjcRrzelzVze5Dmtzimjol4ZnmowLigCEsvEs=; b=W4MamTg88wwwFHzwHHb+
	+DmTh7MNDSJfzuplnnj6Ed4S8X7AEb0yQiBiE5DpbeUx/xv0HEg5AF4O2mZwZ2s3
	QPStZCkwPYKbRvEZfAJh+fQdd7FgeTz+vA9PJaqO+tIBZeAQZnmvBUA/hKtiBsKo
	3JnnudqELSIul6qzmncnuB2TbCbH7uQIhf+jLpBkYmpxIb+B2TgZIYfx3oCjWCc0
	L/s7Fky3Qt3tgpfmgZStcj5v7n+Lh1tEGZwhAoSC9JfGJfr1JXAWiz1OnNeAEwfu
	4cr9uCHc5UbAzhu2m+Lq522UgOrKSH0z3Lb1U/7JgFEYJisJQQxBtOWA+fBQcko6
	UQ==
Received: (qmail 573149 invoked from network); 11 Nov 2026 11:36:55 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Nov 2026 11:36:55 +0100
X-UD-Smtp-Session: l3s3148p1@kHEZxv1f/sIujnun
Date: Wed, 11 Nov 2026 11:36:55 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v25 10/11] mmc: renesas_sdhi: Add write32_hook for
 CTL_SD_CARD_CLK_CTL register writes
Message-ID: <avRFRvJw5hyRjzlD@shikoro>
References: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
 <20261028-rzg3l_sdhi-v25-10-57f16691c2ed@bp.renesas.com>
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
	protocol="application/pgp-signature"; boundary="ZNml3XNZlLs9ZYLW"
Content-Disposition: inline
In-Reply-To: <20261028-rzg3l_sdhi-v25-10-57f16691c2ed@bp.renesas.com>

--ZNml3XNZlLs9ZYLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 12:51:27PM +0000, Biju Das wrote:
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
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ZNml3XNZlLs9ZYLW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr0RUcACgkQFA3kzBSg
KbbN2A//WkY5t2HRcq2QZ7p/L6Sd3nCAgzYQwxeHtm8IMY0v/uVWXwQoip+/x9Zv
Oe209Higw98oz5uF1u+yBQBl9dkTrEk8WGM2Dy35WnYxjPjyTkKhC/6rpxywIJZq
S95nT0Mu9XQt0GBdQkVeDDc44WJhYkrKs/JEhhVtwB0j7k/YjbfPu8NQM5alSsTt
QOvTHrgBwfijE6JkU8JJubnJ1abqlLFZXWlsoXSbK9jxLqjmVk69fSjVgTwAfY1z
43vZQcz+4erOb3ZpnbLRvjVW25EQ/40sxxsRLzx9346s5GfYevxTv4g9+SVkcdRT
jqZXoccKvk4pkGA4ZtCKfpjFKubL82kUDHO5qDLsXeSOdH5T6K7AhbdsMC8Z5tPW
/BSpA9zk1+rQ0bj/ZR/CvId8YAQbhu+UUeqGS4WO5nuHij4VqvTAh5kKjIsIfO1H
k1fnyxUbStNUDJqOq5zMrKK6isgahpBqHXUC2OEi7raJW68P8xmzKBX1NntfccPw
ug1jAVNb2Ii3KuwDLezQta9BLJmMpjMUxA43i3FcZtB9UIzNkUZpfWA/pjBEPzV6
ucYYG+4gEoY+vUQGhtvwtpDtZd/QgG57ifbkzbKBKW636z8zn4d4PEaJaMbt4L8r
weJOLyPY36bc/Et4/ee2ChSFU/8OeE3wmP6q6kkjX6IrNM8Byoo=
=diMD
-----END PGP SIGNATURE-----

--ZNml3XNZlLs9ZYLW--
