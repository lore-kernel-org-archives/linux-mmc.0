Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C55F3BF696
	for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2026 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847154; cv=none; b=S9sP6vj7o1QvkFArlpQmwodBzKyKvnESk7kYTLmKrPOf+ODwz0wwTGIYauWlpCsVtakktN49+ZI0Ypxlp3zp2Q22gBAlgzW8bIZ41RpaXML1vJ8UkYvwy07kYYuqaE1cBa9xQRHW9IyeupEUwJ5+Ngre2a1KsogOWWoUb+4cDZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847154; c=relaxed/simple;
	bh=aD5ZKvzwCJWOAYfguqrWQTS2cpGeKYz2zFLAh1cyFuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Km7Z0mzr0B6ZZ9vKJgJ57OIiFmwRT9L3LcuoSSuCoSg1NVyRNspArbbYNrJmstGVectSnWlTSISwjAroEaR9nEpS3OhvixRZhFuPAjVgjfe2iy22ZC8u/88QgEmZSByV91UUhADeFXHuRQHU2jNYjBcunM/eIzNUJ7stFn3gLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=v1YTomew; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="v1YTomew"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso70613495e9.3
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2026 01:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776847152; x=1777451952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aD5ZKvzwCJWOAYfguqrWQTS2cpGeKYz2zFLAh1cyFuE=;
        b=v1YTomew26XxGa7wn6+QxxofnmzDY8MG8Q6rSlhbD8KbXbHX3swtg4/aqHuKZEt5Ml
         5orPpH3A2YbkTX3LYpLEkerb58BPIUXoi+kYvqmVcgE/6QGws87PHA8mbzxqfVBLLihO
         GFXGG0HV2wRSCNebZG7x1mB6lZ8pamVNKzxYgwGcr5lAEQccQYtCNnwFlWrTCTU+3yOD
         n+2asT2SpzYDKVgGMCpnHu24R1rhDkcIqSL/6DE+q3ogCvfIPhS/gTpKhm9T9AVPIEBa
         KXMaWwS4onPU15IoQv4TVWG2sEILmc5unmE+wcltWJ95wMM8f/RmGQE0KlCYjxgVQHJx
         uQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776847152; x=1777451952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aD5ZKvzwCJWOAYfguqrWQTS2cpGeKYz2zFLAh1cyFuE=;
        b=BZB6C/yC0VQMDtTCbWBXobamB3kk5/hcrJU4cSr6t6vdHF1hi0EpwZLY3Ch3MCZMGJ
         WBqSiRXrNVqMo/zgB13HEsn69f9F+3dJMO18G8XaoysE/T/MLYiqeADtBdAFY28fWkxu
         qWv1AOBAcODcq0r3bvr2PV8lhM2SSWGFvDRp46IufEvWcFNDxBLRU/za/iFgwGbFRXzx
         OgdB+EruR72J6o2BIIJT43jkqD876wsclcD0PeEODcqJbji4ATEI/sC0cPlTc00goTpC
         QNuON2JVdKfPu86kmK8n3UT6lS8IUrrxJngd+j79s2Qp/bSyO8xuzoQrqQD3MX+UAymd
         lueA==
X-Forwarded-Encrypted: i=1; AFNElJ8037ggayGy+E7UGHRM+6N9uXiqOMNkLYzR/ZrD3vy8B0Tjnb2iAsNIOg73NRz4x9RacElX+aui2qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2vJECojOAGenp7QDCaWpY48HKNvgQpx6ytrnyzvBHgL7wvMiB
	8K2mL3cNHNz7YSNOrZDjA1tMFZCMW28RMu/fJCQ6hcWIy1sU9CGNovslLr/H//7cr9Y=
X-Gm-Gg: AeBDieu3ru7MbQXfv35hd0Kgr88g6R5XnIP2iotdIga7B1RPhzy/qzYrzX0OUu2wTV0
	p2mCHcejn4l+3RVkOc0gxy3cowX9YCVgZlh68H8Ma5d3NuHfl9Fnd1xHpJplRrpohXH/FZmDWJA
	6uR2T3h8m9aq+YrMPrX2Zsmc1IWIBnrx3ZbqUqvM8V5ZRjQijQmuYmK3RAKBDrVVzNCpORy6JFr
	ZFSYTHrsUwp5aNQ97R/IhfD+C+0Zm8C9PRs5kzoev97oheIXFdK+wQSrhsYuQsfogXY2y6tPTGj
	Sg+pNyS2jyPxjCfdCXKOx9yqgwP2QNy8DhHAQSo5sG5imbD7Ud1zOs0hnS/FeX//EGlHyGK3UV6
	Key4qdUE1LuJkxqf7bgU3Qhc60QoYBgH2v9DK5Gf9nDkevO/BUErTSXQKGir8kjveLDUa2AKNg7
	N8JwhOU6JeMBR91lu54viTePpsM40PXj1udH55OY0+MKWf/QMz1tRqcLICs/iT+ekn68MINW9c0
	ZKZROl5OjaoKyS2zOC64eow9w==
X-Received: by 2002:a05:600c:890c:b0:487:1108:48af with SMTP id 5b1f17b1804b1-488fb7389a6mr245381575e9.4.1776847151437;
        Wed, 22 Apr 2026 01:39:11 -0700 (PDT)
Received: from localhost (p200300f65f114e08a760282010012dc7.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:a760:2820:1001:2dc7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fc0f8188sm455887645e9.2.2026.04.22.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 01:39:10 -0700 (PDT)
Date: Wed, 22 Apr 2026 10:39:09 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
	linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org, 
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
Message-ID: <aeiHTPOA9jQrNWkX@monoceros>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
 <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
 <aeaMkfk_1t98e7SU@monoceros>
 <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>
 <aecu1ixyHP2hQvgE@monoceros>
 <aehwG2Egt93-sPVB@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vqsqetyrnjrxwten"
Content-Disposition: inline
In-Reply-To: <aehwG2Egt93-sPVB@ashevche-desk.local>


--vqsqetyrnjrxwten
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
MIME-Version: 1.0

On Wed, Apr 22, 2026 at 09:52:11AM +0300, Andy Shevchenko wrote:
> On Tue, Apr 21, 2026 at 10:12:41AM +0200, Uwe Kleine-K=C3=B6nig (The Capa=
ble Hub) wrote:
> > On Mon, Apr 20, 2026 at 04:46:56PM -0400, Luiz Augusto von Dentz wrote:
> > > On Mon, Apr 20, 2026 at 4:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Ca=
pable Hub)
> > > <u.kleine-koenig@baylibre.com> wrote:
> > > > On Fri, Apr 17, 2026 at 03:10:47PM +0200, Uwe Kleine-K=C3=B6nig (Th=
e Capable Hub) wrote:
> > > > > On all current Linux architectures sizeof(long) =3D=3D sizeof(voi=
d *) and
> > > > > this is used a lot through the kernel. For example it enables the=
 usual
> > > > > practice to store pointers in sdio_driver_id's .driver_data membe=
r.
> > > > >
> > > > > This works fine, but involves casting and thus isn't type-safe.
> >=20
> > To be honest, with the involved void* this isn't really type-safe
> > either, but at least the data keeps being a pointer which is really
> > helpful on CHERI. FTR: The alternative would be to use uintptr_t instead
> > of unsigned long, which also has proponents in the CHERI community and
> > which is used in the current vendor patch stack.
>=20
> FWIW, Linus categorically told that it has to be no uintptr_t in the Linu=
x kernel.

Then I'm lucky that this patch set doesn't introduce uintptr_t and so we
can delay the discussion with Linus about that. (And we will have to
hold that discussion at some point, because on CHERI we have
sizeof(unsigned long) =3D 8 < sizeof(void *) =3D 16. I didn't check, but I
think also unsigned long long cannot hold a void*.

Best regards
Uwe

--vqsqetyrnjrxwten
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnoiSsACgkQj4D7WH0S
/k74eggAtKiYZRohFpdNo44fvylrlq/Mfus5ZHYrI8EWLZuC+qMr7/LiHwZ8cxVQ
atxZNwrK0qRyfjUM/lFUKvVOSQwTQzqaMGF0dNjfTVALktKCe6sLNr+gOXDqofhx
UZn90knvTDOO5WfcrIf1K/ojUlgsGJ/4r63JkF3ZXPn8I3zd3NFFjhgn/ZzJkx74
5CJywELP1+kmz3pLRw0rHztfMl3gmPTsxCWqHmxLNsNtSVskl2dRZH9FMfvNKCQo
KwuE7hCxtAWO4py/igcaNXz/fS0nMSCqIo3IbxAzqfJAnHgPpGrvAKSOB4GLVCoc
hmaPoy6M67vqAg5NjGB4uniPlgvymw==
=8Fwl
-----END PGP SIGNATURE-----

--vqsqetyrnjrxwten--
