Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8204257821;
	Fri, 10 Oct 2025 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106843; cv=none; b=bgif8FL/X9SsGiDjgHXi8F+GTQCOHKEm28SGqr5g8uerfgR0A9ygbPuU6FLlAjS9fFD/9AEmLBTrI6KwbMfXReANJHdph4E5Ok2iUKdiSgRtUpi/jmX7/J4bfxh2pw2gcPJqq4Rg6zFdi2e9K81UazxRM8mrtZ/B5ucjQmMvH4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106843; c=relaxed/simple;
	bh=FnS23TIvZXoikLOJ5/OdqMUZUwa1vW83VBZi/rmZ3C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skMfdVtIDEELOMITSTrBrIw5xx6bVd8FimajeB2hAFzNLg+Wpsx7btvOkUnV63C6QmYtLM1zoBBsTk3tN5YtbR3YKA4UDImPfPS17TbWgNHmoncbCP9w9uXewXfZDmDFDUuHPDpCOL0LlehP1slT5YCUixlTDOtRqbiPeeJ8Ibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrX3xQa2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrX3xQa2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6633DC4CEF1;
	Fri, 10 Oct 2025 14:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760106843;
	bh=FnS23TIvZXoikLOJ5/OdqMUZUwa1vW83VBZi/rmZ3C8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrX3xQa2NuoaG6xeHmtdqRs9XZKPVFADW2WTdIcOzp8KsraJoRODhRslJhblHfIto
	 TkUHY0IW9eA2wnw+QDkUa+tv//ri8lgEXrvMjdGqlJUODt3RYuFievjERcvcj12I92
	 cUctd0I4EsfnXXrvg6Y+wN5g9AjNgWk+8Ecyb/EOEsI5F2KRzNNo4Q6pKtKc5IR5uY
	 Gb/l16K9c8wwpaqE72OzrTFPJZl5aT2Zyqtr5/ywNOeXh7T3SAYv33ry18vCZsRv8f
	 dujpy9TKuNzFvJ5hhfVYW9u5qkuWsNp/Rk4/4GgKqEHM5hWyCW7BjCMA6I8tVSrD0Y
	 Dc/zzjV20s0mg==
Date: Fri, 10 Oct 2025 15:33:57 +0100
From: Conor Dooley <conor@kernel.org>
To: hehuan1@eswincomputing.com
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jszhang@kernel.org, adrian.hunter@intel.com,
	p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, xuxiang@eswincomputing.com,
	luyulin@eswincomputing.com, dongxuyang@eswincomputing.com,
	zhangsenchuan@eswincomputing.com, weishangjuan@eswincomputing.com,
	lizhi2@eswincomputing.com, caohang@eswincomputing.com
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin
 EIC7700
Message-ID: <20251010-evergreen-scalded-058caa421214@spud>
References: <20251010093807.1579-1-hehuan1@eswincomputing.com>
 <20251010094014.1596-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9apZ3jHtDJ4+bC2k"
Content-Disposition: inline
In-Reply-To: <20251010094014.1596-1-hehuan1@eswincomputing.com>


--9apZ3jHtDJ4+bC2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 05:40:13PM +0800, hehuan1@eswincomputing.com wrote:
> From: Huan He <hehuan1@eswincomputing.com>
>=20
> EIC7700 use Synopsys dwcmshc IP for SD/eMMC controllers.
> Add Eswin EIC7700 support in sdhci-of-dwcmshc.yaml.
>=20
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
--
pw-bot: not-applicable

--9apZ3jHtDJ4+bC2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOkZVQAKCRB4tDGHoIJi
0pugAQDBGEAe3AMxCAoCb7W+/GzL8Bia0+s16TRJiVIfUkkH+QEA3ukBv+q8j6lI
zh1bHI+D2r1dMl3ye+ZzoVBSoDYu2wM=
=Qh/h
-----END PGP SIGNATURE-----

--9apZ3jHtDJ4+bC2k--
