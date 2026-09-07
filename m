Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328F351FCBB;
	Mon,  7 Sep 2026 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788802463; cv=none; b=dbdXj2jJ0FA0xfRLMX3fCuLrqLea7Azg9LQJcSrSH36gYo6onM2HZ89YAVJ3B2ZGJ2199MFF6DQZk8rA2v98RSxQ6Qh5NA9+yTGLCtY5jzSPIyroienwT0wBmwh1RR+OpRtSzBEflIbOoQwOcUlzaf11tizmD1tqVqpMepjHXnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788802463; c=relaxed/simple;
	bh=h7+6vonuTo/YtbxMNn6QXoxeFA6rMnEkdHoOHKAsPwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwBGI6zNQ1KPbKuo6ZSPCfUeL0+TxP7UWsPv7I/65SF4PDL9f8O3e97i4U9hjF4q17jSz1ZvELmGi67iE6kb9Cd4MWeLmO4TkbJWoOz7huM3k5Kw+fH/I+KolYZZq1Ert7UQUM/jVkAEfUsC3Om45tWzQbZ2Vl2g+f9JMVjKqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4N/as2Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4N/as2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1610C1F00AC4;
	Mon,  7 Sep 2026 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788802461;
	bh=h7+6vonuTo/YtbxMNn6QXoxeFA6rMnEkdHoOHKAsPwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R4N/as2ZBJAAo3a5nxIodQZ993qPWVf3Zfsb53ragSDHywYnC1pVDxeZvSMYU7HBf
	 xX/eHzeRBhIxCdyqQLrrjiGAGB5K0obTosVd9d3wwvoRRQpYZuTbN3cjKe+vGy1kih
	 hdOPOQQ0gs5ewfRndINWZvjS9WXp/DeChTRXdqwlxomxffOJ1B2Ww5NxFLmR3dMM4t
	 dj2/Wi+h+1VH4QStCiResiIcxMunjIbw+wzJ3rw9mtZANVC+tbUgBdGhbockVwYLJf
	 QaucK6IuTmd1DjbEE40FIRhcu96yD5fiSYhSK6m7uwRvyjxG/4J4QS0h7hJsFlSBVs
	 PMwrpcezJVw2w==
Date: Mon, 7 Sep 2026 18:34:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Lucas Tanure <tanure@linux.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Chuan Liu <chuan.liu@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
	Ronald Claveau <linux-kernel-dev@aliel.fr>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: mmc: amlogic,meson-gx-mmc: document
 the T7 pipeline clock
Message-ID: <20260907-commute-number-b2648457cf3b@spud>
References: <20260905153234.133217-1-tanure@linux.com>
 <20260905153234.133217-2-tanure@linux.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y9wvMkw8fwCVflBn"
Content-Disposition: inline
In-Reply-To: <20260905153234.133217-2-tanure@linux.com>

--Y9wvMkw8fwCVflBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Y9wvMkw8fwCVflBn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCap71lwAKCRB4tDGHoIJi
0pcLAP4ng1dRPHZcitmCBSSlCvIQwzxhMkILiN1Uhxcx5OAiGAD8Dk28O/iv7sPo
8wsW+AsDNlaahZW9weiof6Xxs2njpAg=
=6NKD
-----END PGP SIGNATURE-----

--Y9wvMkw8fwCVflBn--
