Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F85B665;
	Thu, 26 Feb 2026 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131545; cv=none; b=sevv5dBwzXl42XgSjCD7qCyy2caCBWk3rIhRGRC+WzIJX+0aWE7+JwzdWF1gUEQ2eAHfN5Ih8Z2ybijeFyu+HsoMUKKh/ODJrCjpJ8CjO/j5FWlAUpxyLkGPYwMsMvUZSPvf1p+IrR1HuR1/rXwtej+Yjeb1XeKdN/I4iE7+OzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131545; c=relaxed/simple;
	bh=+XmMDl7uCbRKR3318DO8mEx+wybNcT9pkDfZRO/1ZEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PniicSrr0FrLUwpJRrLKt+nymvR142Wi7seazXxwtNFaIuSicbpJxHpvjgzZL4mVgPXWYcVBbf9ems6EX3iB/5Xu/aqo/i4o6GWpA73NuUb8+sY51SdblNFsvI2SYAMAzpE+YfiMAN9qdbWGkIETR98xEl8KqX7dbFMNZDm8i6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWY1MReC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWY1MReC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27B9C116C6;
	Thu, 26 Feb 2026 18:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772131544;
	bh=+XmMDl7uCbRKR3318DO8mEx+wybNcT9pkDfZRO/1ZEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWY1MReCHxFvBWfsFxu+426MyT6Hr3QNQIa6cHjgVIciTEmfZSKN0EEdTXu+tu+38
	 0tYvLxm66fH4LQPHVR3Ua396uUAXU1CIJVV0AKwTLZmuto6kLw1lECC4b1RB3IUeRI
	 DJVXVEHt3aUZ4JoBl8kEkoau2HLCYlkrrZqd2NCVjLgbpXu3CjL5WB5kmgJ0wcHZwm
	 trBDsQCYrFqVRv8ZLgtXuw4744JOvsFEvFcsN5lQuBW8RF5tgyKiP8SiXkLzf7Eihg
	 4A6mpN10bTf88GPJRMuXgld7LW7l8mvAvPmRACE8D2qrqC28+Oflh9M6dFdN4GSe7L
	 MgaNlhee/H8xQ==
Date: Thu, 26 Feb 2026 18:45:39 +0000
From: Conor Dooley <conor@kernel.org>
To: hehuan1@eswincomputing.com
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jszhang@kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, xuxiang@eswincomputing.com,
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: Re: [PATCH v4] dt-bindings: mmc: dwcmshc-sdhci: Fix resets array
 validation
Message-ID: <20260226-overhaul-perennial-f1c6f88f1a20@spud>
References: <20260226092614.435-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yfEZskxdjFDqFRNx"
Content-Disposition: inline
In-Reply-To: <20260226092614.435-1-hehuan1@eswincomputing.com>


--yfEZskxdjFDqFRNx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--yfEZskxdjFDqFRNx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaCU0wAKCRB4tDGHoIJi
0qIsAQCIPZEqAcM41f1Fw9sLs+n2QDukfsUwM+1gpnzWLJaQKQD8CBNfViWDMyXl
t/43WcZsD/JRcRErKeuapiyF+mUzGwM=
=I5MG
-----END PGP SIGNATURE-----

--yfEZskxdjFDqFRNx--
