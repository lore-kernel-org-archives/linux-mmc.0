Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4695D485CDE;
	Tue, 25 Aug 2026 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676779; cv=none; b=DOZw0RY5hikxJcqpDTJN1Pvy/sMXIglSBljsvPhqRZ7STVu/FHHZ1x4HE2gtYkVdLPU/5sbtBGF45vJ8cAzkI/2mmVrOTPfxrgG80b4XuQdVlcfCgmP68FjEAsgmosYKYdcXcLjYXoSVQY0lCl1o2aLQgkEEOY+O27NvDv9PFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676779; c=relaxed/simple;
	bh=HjieGlJw0OlOa7SroUpJpWqwKNLKUQ3aGf1GvOxvhmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1eVJsGwqLPO8F5TMYvJxHHMAcvd+Lk4zNNGB+dMI3mOCh+pEvTcIujuctwbxga27M1Ix9Yx4P8Ps8rmSaP4ku+g9iXO+tJXa6I1u6nChoOAeXzbMBfidZqPdxqWF0fGg29T4naqm2Gq30arDZjJf5H2SJEXoz98HA8g2mqo6Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/p/k17/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/p/k17/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83B01F000E9;
	Tue, 25 Aug 2026 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787676777;
	bh=HjieGlJw0OlOa7SroUpJpWqwKNLKUQ3aGf1GvOxvhmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j/p/k17/FSHFZe8XcJU5+IuKppeJz1DUjenoVeKnQ7BeRswBsi/qDV47G1necKLlt
	 7Dw8WQchykjWg/L1HtDdPNp4jg2UbSV/Sd2almeKwan/wCTrNsS+dqQS1/GqCpeV1a
	 lgzk874Ycaqoo5iBOLkJtuwDKCuDFQkAhxKGljcj/d9vIMGqrAy8biTo5QawSadE2X
	 hEkzPdzyWnR309Y4f5NJSaiooInNLp367GjzrUtx8Ok7YVUi1Spe+5NGP4vhR54VFc
	 uilbyrGMNnLc+DZVmo/qDKg1RWxSxeRmPFnrxKhRlVAY6b7yh4FGWRvlA1xjMR758T
	 IT3gF1ZlidLWQ==
Date: Tue, 25 Aug 2026 17:52:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, ulfh@kernel.org,
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH V2] dt-bindings: mmc: sdhci-msm: Document the Maili
 compatible
Message-ID: <20260825-feminism-shabby-bd6e45560b5e@spud>
References: <20260825083702.3931016-1-nitin.rawat@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wu5+p+D39NNDzxrF"
Content-Disposition: inline
In-Reply-To: <20260825083702.3931016-1-nitin.rawat@oss.qualcomm.com>

--Wu5+p+D39NNDzxrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Wu5+p+D39NNDzxrF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCao3IZQAKCRB4tDGHoIJi
0vzgAP9xVD0qZIZjlPhj/3QI+/xZJCBXvc91AFVzD54gRd4siwEAlnRda7KdiXqR
pph7qhrTOGAGllv/UWSog35Tg/jGAQk=
=V5dJ
-----END PGP SIGNATURE-----

--Wu5+p+D39NNDzxrF--
