Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6444C4E2;
	Mon, 24 Aug 2026 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588845; cv=none; b=Wl2dSSbudj4sBIVzuRCpMlnnRo+Y/dqvTmzomkNu3Xp4H/gsPg4I/yaheTvCvhtcu4fTwfnbvfDtsR8wdrg24eRSoGil17XWwBwCz23w6QQYCAOyDkk0Nfbz4jY/hJyZ4zfgKznEA+LZ9/Nq5jQiRkYrinVRJqdCC0o4daSshBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588845; c=relaxed/simple;
	bh=94H9tymTg5gcpmuYwg9C8lCQ86GSwM9hgbuVfliQ3dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VB1Hx5OGTgerKQkm4GPy+pGAHQqdbr+NZGFsDLG+ZpeFsQCZWrq3ayrj/D8waIPMahD1WwWEMttzENeehYieixyJP5zsstspNzDJi3B3EcPY76EDOGFvi2XsFWMpPyN0oueKZm2xVlrtkPyBQAFOk3KeVdMWdwe7C7mB+/uLsZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxzB5YjI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxzB5YjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9261F000E9;
	Mon, 24 Aug 2026 16:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787588844;
	bh=94H9tymTg5gcpmuYwg9C8lCQ86GSwM9hgbuVfliQ3dU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cxzB5YjICwcf9RcSo0IvxjTr804ZVvgW2TWn2YUARU7mOGM9m2dGdL+sawOE9IES+
	 hcBWTg59UEprG2J5robkoksweAu/DMfKs4OhhUvCbVZctQ4/BiC2E1L+H/EPJLLEhH
	 Tz8Vd20ZHxQCL1W5KyPbb21VBK/ingVMj+iA2h1Urbp1el3bJQ3947naZW2hgGFCBV
	 zDQwEM5lfO/7k7YMhNyVP9YrxUFMhDa14YSuGIrkbf+uYmQdP9Iocw8kHrmV7SQOpR
	 6IIpyLsHn6/phZhalfFjk5tgxokvyLJaq2/YhEcuk+FzKXpcYt5d0vW1JudCGmTaAo
	 EABmHI+2IsBqA==
Date: Mon, 24 Aug 2026 17:27:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: ulfh@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	aubin.constans@microchip.com, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Subject: Re: [PATCH 1/4] dt-bindings: mmc: atmel,sama5d2-sdhci: add LAN969x
 compatible
Message-ID: <20260824-tinsel-dispatch-0cc0edc2b485@spud>
References: <20260824110432.1074136-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g59KPdrPfRxeZu0n"
Content-Disposition: inline
In-Reply-To: <20260824110432.1074136-1-robert.marko@sartura.hr>

--g59KPdrPfRxeZu0n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--g59KPdrPfRxeZu0n
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaoxw5wAKCRB4tDGHoIJi
0qytAP91iDGkB1qoLcibGVhYFFkbYTRY/CmBSda0ePK4DRgIrgD/S43wGpmVXIxk
/6e/Ns192dNJz0y/Cmk39FjaYxm4TAU=
=0m64
-----END PGP SIGNATURE-----

--g59KPdrPfRxeZu0n--
