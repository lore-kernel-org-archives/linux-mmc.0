Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397717;
	b=GfLzRKQOhG+CzVRM1j7c3St1PYGH4z5X0tDkD7yW8gnM18mWZKmdNRqtwPdJiCIXQqMF
	 7bpMUEB9lyPR/L25m72ACUtcrMN2GV95HpAK/DW1Bhn60hIKdOA2nt1JZrDHDza4G0Rlb
	 GaOSFQ4XDadCB9GjvuBFU2EkHy8CtSeHBLdk70Dk72qRUaRm8n4lVhuyuhpEv7hijG8e7
	 SQOrVHhX1Yy8c0CWLm+/jV/PFph9ptBXsPqrzfoOBL5s4B1tPsHOQpmuQJx/titvmgH4A
	 7HK3Rq/fRyStS5wLbQvLMdSbiuFQ/zrEg5RnOceGcuNuTeZDiVtIK8T1SM1f67Ugf5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397717;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=CY7wMtMqvjq9EHixuVLhnrITTo0ITK/tiq+5GxWmBNk=;
	b=DChEHo+IQ9YYDsx05M4JavkIM3e9F9tZ3nM9TSzGUqo+sKrNA1IR2iE5iTDe48QJXs6p
	 Uk2+QrvUsQYBD88CcE0/D69sw2Q+K9OcReoNpw/pLe5d/xl2lZ6yD3b/LyxlY+2W/B+mh
	 SRiw8lB8cTz+zUz833oDsktvwVJUN7fHPBw95aMQLO/jprClBnLEuWwGC3RqvgXL2ciRy
	 QxdmI19FFahxx0g6YB/7N/1bioaFKbGhEx9GlUuUuUQKDeTkBESAHFSWJgkqVwout75t6
	 eCpe8o5eg+XbsOxiwtVK85j1eagyKzKl2rbKY84GCySiG/4uPH5xWM11OM28Sd2QC6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=JG5z7lvi;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3DF606A31C
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB3DF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=JG5z7lvi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=CY7w
	MtMqvjq9EHixuVLhnrITTo0ITK/tiq+5GxWmBNk=; b=JG5z7lvimNrZx0mVLYWX
	Y/hRCe4vE08yRzmZooYP5BVrsXBlTIVBCVTPMUThB+EiNu3cFH5QIAWbGKMUC064
	lfyev7DOU2igxxI1PsXfF1IFJ1SGuovoEq2rBXEBmb+H/KRfiqDjIBjpvD4N114/
	qIXiwIrajtPQm1UAlGN+P+pQBwU9CBB8teED/hhQRJKizk3XdrxpIzz3k73aSTzP
	6EKMvDQislrw6QSfxhW3O4biFsHQChx+GtvjRGQsYBLVRW7Hu9QQf7bScpBBqQTf
	v1sQ7nEaewtTGvK2M3u2Cb4yxN+Drq55/ShQM9chiR/8jqVkrghEtQFvcERqiov0
	Nw==
Received: (qmail 597096 invoked from network); 11 Nov 2026 12:48:33 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Nov 2026 12:48:33 +0100
X-UD-Smtp-Session: l3s3148p1@TrFJxv5f3Ioujnun
Date: Wed, 11 Nov 2026 12:48:33 +0100
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
	Biju Das <biju.das.jz@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v25 00/11] Add Renesas RZ/G3L SD/eMMC support
Message-ID: <avRWDN43k3LcFVRa@ninjato>
References: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
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
	protocol="application/pgp-signature"; boundary="A8I0l+X9w89eWS8f"
Content-Disposition: inline
In-Reply-To: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>

--A8I0l+X9w89eWS8f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 12:51:17PM +0000, Biju Das wrote:
> Hi All,
>=20
> The Renesas RZ/G3L SoC has:
>=20
> Channel 0 supports SD and eMMC (including HS400/HS400ES).
> Channel 1 supports SD and eMMC (except for HS400).
> Channel 2 supports SD.
>=20
> The SoC supports a maximum frequency of 150 MHz. The SD0 interface does
> not support IOVS and PWEN in the SDHI register (no internal regulator),
> unlike SD1 and SD2. It has an internal divider for all modes except HS400.
> It also has a 2048-bit divider compared to 512 on others. Moreover
> RZ/G3L supports HS400 enhanced strobe mode.
>=20
> This patch series support all modes except HS400. HS400 support will be
> added later.
>=20
> This patch series tested on smarc-rz{v2l,g2l,g2lc,g2ul,g3s,g3l,g3e},
> rz{v2h,t2h}-evk and hihope-rz{g2h,g2m,g2n} boards

Tested with a Renesas Salvator-XS board (R-Car M3N). I don't see bugs or
performance regressions. I think the series is good to go!

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you!


--A8I0l+X9w89eWS8f
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr0VgwACgkQFA3kzBSg
KbbhKg//WgV01398alqqFtiGlZ6zl9AbafPAbhuQ+yMTZS8WnX6z9Dq3f4jW2WRP
1O/VtUbduz0PZCw65b2UvGZxeEfO04heW+HfKWlCFUrZtmqSmJ5XHCo3Fb26+cYo
+D+fe+arXT1zRdLKQOTzeCk8tJz8UNKBZjpqJLLjoT5l1O+PJgr93YusJ+KlV4JR
EarER4dx2dusqyblPigbqRJO2RBQ0c1UVj2981HpCh6sSJ/LOk5vbus4S6GL2SIp
6+eevkHM2Z6DM00L86CNtAdWVW8A4EEhZMa1ui0yLCbaDz51k3WG4GRvoj9wBLfL
hKZgSNc7W07WAOvVtizVpZvqoEUIFevewZMnjtdY5lg2OAQxISgMfCEIy/dRd4jJ
QOJoGD5ZCTTYS5C1X4g4RPrOaxVlxKq8xSQIaNToXPd9klXPZr9VniGtp7f5QKEw
5vEw16bdb/OTAtNv/jHJ4p+K2gd60Rz8hDq0JufFzORO2RCF8fpk14auNM+yogSk
I9BlPtrpeaEot4QbQ79I5Lb2IWX3r7cISc/Ae/Bs77NgU7AM3QksnONy9ACl8aqj
w1z8Pr14rEFLpsxMqTvgmbrtYYGHU9baZ4tqDZvGPoRjQxZZai2T7cYfykbxI1oO
EDlt4JcK4UWnkMlGTGD3ETbZnJq36IaRvZpRYJ9/n5I3iAzHtzk=
=3Hq2
-----END PGP SIGNATURE-----

--A8I0l+X9w89eWS8f--
