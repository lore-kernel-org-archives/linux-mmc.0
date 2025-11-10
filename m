Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A82121E098;
	Mon, 10 Nov 2025 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782252; cv=pass; b=lk2m7t+XCVnE0PllzMD99FoQj7m6byCP00DQzV/bn493ZTVvrm0Ji7wfw8pEyjGSUZ1ulr6TwpZy7jJE2tDS7indPY/Ysm32ezT31BLAAY6B2d9yzBXbmUucj8zqTYm+zURcf7O8ni1dJT12Znf/N59vdISmjx+WToeBPFUjHIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782252; c=relaxed/simple;
	bh=wK41s9TTPsH+XSrQvGcL1ScrZIeDVdkh9D+PCpggJgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srTLTU7FhtgGobXN0hfmagaNUEVffu5ADinAFt/A3y3ibYBMoCSEoRRA0tuA5Gq5pPuomP2O6j07Wkni3uvw34wWf/JHSe/pwRgL+78ql/ZELpDvbO4gDaead6AYSWZt9I/VJfc4t/IeacJQiQfvatEP9faO9J7CJWcuYvESIyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=g2wP67Cz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="g2wP67Cz"
ARC-Seal: i=1; a=rsa-sha256; t=1762782225; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HSdRTwjaAi6bgsxuRDSbZsLF0DPeI+LOlnd1y9igvc4gNPWWf4KKlKpPdEAOfTaQstq/Elrkm4nlxsua8YS7r7TQxGzcIUoGFmye99W2XQCDmhFlZL65IHe2jlJ6uXaeHnPfVprdqTJExRxDG4IsmXGErXhcno5ygCrqceoO4G4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762782225; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NaQSEtGafus0sgJYl14H1AHyjnLimFCe/otE/1Mn3kw=; 
	b=gSarWGs90VIKXpnYnCyXBQUZ1/4+5W7W9NV0vwShHeZv7ylmf6NpN8vejvFMXe7Umw9ZBIvlETJNJYjYD642RIKS5sf/TDqS8LPPdl19sj70wSBxCoL0kU0QFGdIfHpCshg5gxXEpjiT5BbV8kp7ycPF9soTskb2PS4EAzXMJ6w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762782225;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=NaQSEtGafus0sgJYl14H1AHyjnLimFCe/otE/1Mn3kw=;
	b=g2wP67Cz3+CvMMmpD6hniCswHIQj5NnpT7xiqlt6FzX71FphZCGERnSiHweKixQ4
	ws7tgOQ/wENJ3VHs3Ta3tls2Lw5z6dK6AoaEpYV26oedR9I5DvnUyCjreOa6+5cMfJf
	Gpnsfu5X6FF82r/e8Vf5k0I6Bv8G3+gFJvTYmnXQ=
Received: by mx.zohomail.com with SMTPS id 1762782223271450.25151316746724;
	Mon, 10 Nov 2025 05:43:43 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id D8FC2180735; Mon, 10 Nov 2025 14:43:32 +0100 (CET)
Date: Mon, 10 Nov 2025 14:43:32 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, kernel@collabora.com, 
	Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-of-dwcmshc: Add command queue support
 for rockchip SOCs
Message-ID: <hjxwedwtwksog67mz4unm4jita2q5vvp4vkdrtpznc6mllz7q4@7a7nn3c5l7fv>
References: <20251031-rockchip-emmc-cqe-support-v2-0-958171f5edad@collabora.com>
 <20251031-rockchip-emmc-cqe-support-v2-1-958171f5edad@collabora.com>
 <abb4a253-6f4b-4547-a238-db6f60ee3244@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ladnhwyx55vra2te"
Content-Disposition: inline
In-Reply-To: <abb4a253-6f4b-4547-a238-db6f60ee3244@intel.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/262.770.93
X-ZohoMailClient: External


--ladnhwyx55vra2te
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] mmc: sdhci-of-dwcmshc: Add command queue support
 for rockchip SOCs
MIME-Version: 1.0

Hi,

On Mon, Nov 10, 2025 at 09:58:24AM +0200, Adrian Hunter wrote:
> On 31/10/2025 17:58, Sebastian Reichel wrote:
> > This adds CQE support for the Rockchip RK3588 and RK3576 platform. To
> > be functional, the eMMC device-tree node must have a 'supports-cqe;'
> > flag property.
> >=20
> > As the RK3576 device-tree has been upstreamed with the 'supports-cqe;'
> > property set by default, the kernel already tried to use CQE, which
> > results in system hang during suspend. This fixes the issue.
> >=20
> > Co-developed-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> > Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> One question below, otherwise:
>=20
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks,

[...]

> > @@ -687,6 +757,9 @@ static void rk35xx_sdhci_reset(struct sdhci_host *h=
ost, u8 mask)
> >  	}
> > =20
> >  	sdhci_reset(host, mask);
> > +
> > +	/* Enable INTERNAL CLOCK */
> > +	sdhci_writel(host, MISC_INTCLK_EN | extra, DECMSHC_EMMC_MISC_CON);
>=20
> rk35xx_sdhci_reset() is in sdhci_dwcmshc_rk35xx_ops.
> sdhci_dwcmshc_rk3576_pdata also uses sdhci_dwcmshc_rk35xx_ops but isn't
> supporting CQE ops.  Is this change OK for rk3576?

How did you come to the conclusion, that rk3576 does not support CQE
ops? Have you read the cover letter? :)

Greetings,

-- Sebastian

--ladnhwyx55vra2te
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmkR7AAACgkQ2O7X88g7
+poq/g/6Av018KZfLynGwjZMNoFxVnLTbPCij+47pv7hWC/61IeB3Wo3ZKuWOZaT
mJgj8ttbiE8caqUP8EusAjZpnLwmYIeoEfewsXr7mlhwzzKR1wR8xtKzkSYvSOPg
2vjagIjI0QWubTnuyrvBihngKhpXjl9wSgWKBeY3o4PmYB5b9kHuqjBs1hoa8445
fCu0u4zt+2BsxNQYFjCeGbM06pa4kzD00SyNW+Zl3uGPX64SaaUnGeo1k+GFyVzw
h6Q7QmJFLY0kkXr5H5fysSQMWxuMgWyBp/hrcVrdYEx8/EaWddQVOXRIJHK7MVgB
uTi3zilX/3+8Hx8ij+4k2Elp8ywBdoAL92ufUeaZm9va2r+iB1V0kO7YznDU4L3N
AeDqFOG75McYdgKYD/HATaQ9gjut+13TBCvNmajPyFtu0iPww8Tg55lgvfBNOmxF
ZTw2L3OAcfFiVpDzOZ2P5kzQ6S54yMHUE8El7OHQCvfRD3kaLXSJYBswahfh4hW6
1Rq5uosLvZ/59EG6eGkA66xQLEam6Fgq+LmvS7XMagRZdR9EbdFHht5myxXF6lXs
GWwqjJkHBaXFYdUa2jzF7hitnpJBMFOmwh9DjzbyVNPJKSG3504lOyb1UC+2L70R
AMnnkw1ljj57dHDPZ+26sJZA3a37eaWbWjfPiTG/zavQCYzjaLw=
=iosp
-----END PGP SIGNATURE-----

--ladnhwyx55vra2te--
