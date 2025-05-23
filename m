Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D936214286;
	Fri, 23 May 2025 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015054; cv=none; b=ZJlhoUakpty6VzN7r6zuEz4ugKuBgykE7XAe89ErHlhAJ1nabwqxKnlLceUJ93Q8oVk0klpKmjyXDcxBmL43oXb0QzJceu0znpHDw4O1Uqmn9Q9oCHcMCvyYffYZUjFyqN3AuQKPJZgbSvVhMEMujDbwmcDCaTCf2TY8sAKKA3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015054; c=relaxed/simple;
	bh=5ZhTYIXzwKX+uad7EpnHarDETCV3rDSAuCZHcLP0BXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUMirhC6Stk3mHEhvxTWUqgJS1kTvvZpBPeAA0CmLFfbH9cnCcW+PbKpin4YRgDOLlTk6gSI3isqLhk+DFCxkm1ZTCFAIx6xaJMaSrIqz7C+sW7MRkwnSa+CHa+H0uu5Ghg+jbw9PMr3d4AMfa+d9yvbRzSKvFAlJNUqonPY6go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6fqtUA4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6fqtUA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8106C4CEED;
	Fri, 23 May 2025 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748015053;
	bh=5ZhTYIXzwKX+uad7EpnHarDETCV3rDSAuCZHcLP0BXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I6fqtUA4o+lm1caEChR24iCuSWLJnvmpcqhWSKf+ksHK1E3F1fSrPF5HQa49R9sVk
	 xP9T+sInNlAjJFUnIO66ZplZ7MjXVrUnLh0sRP8VswJYsagi+IOOaAEIpkf/pB3dO0
	 H/c87U9IIFjPGx2pH7hpCZspGdROUGmxlUw9ENszPCVQJjCj09JZs2nfCqd1aY8tCU
	 JVi9lJYXoeAuFsfZ1eEx12J4SBbr7Xwht4JN2ThPxyJYJj6YzuqW5Ef0YEK1EvI+Kz
	 XCNMvZY90AgP/ru6sxrzbGQ4DeMRA9aeg9P8E8MLBppC0YzoWUQMJCsZ1C8xuc0lnT
	 H0GEUEAZMgtCg==
Date: Fri, 23 May 2025 16:44:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: ti,da830-mmc: convert text based
 binding to json schema
Message-ID: <20250523-declared-recycler-6b512294e74c@spud>
References: <20250523-davinci-mmc-v1-1-ceebd8352d9c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iEpSSjW/JvBRj22u"
Content-Disposition: inline
In-Reply-To: <20250523-davinci-mmc-v1-1-ceebd8352d9c@gmail.com>


--iEpSSjW/JvBRj22u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 01:34:10PM +0000, Charan Pedumuru wrote:
> Convert TI Highspeed MMC host controller binding to YAML format. Add
> 'clocks' property to resolve errors identified by 'dtb_check'.
>=20
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--iEpSSjW/JvBRj22u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDCXyQAKCRB4tDGHoIJi
0iZNAQDXxxURqJT5LuI+oAjBm5K3HBriLjimRU/mKHJhl6TLMAD/Wi+zXpzE9EKx
Sr4GjtmlHNeOn7XkgqF1psBMQW91Rgs=
=x8kf
-----END PGP SIGNATURE-----

--iEpSSjW/JvBRj22u--
