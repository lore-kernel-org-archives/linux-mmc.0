Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A513AF2;
	Sat, 13 Jun 2026 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781377455; cv=none; b=BL7OVB2Gdj8Ku37yv381Tr93e7aAzoU6IOLEKvpxtAGjnqaUx95sItkUjXwbp9+W5bAuvWNMX/cskvu+p4/yvqXlqSXAyKLpk/kzHffU8G5Hfz4dId4b4djeFVhV9KqwVhgQDcwk0zO+Ew2CvavBGbBz6sb3LEaQ4e0fibgIoB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781377455; c=relaxed/simple;
	bh=GxhgfyOu885X2gC+lUCV9hDEVj8rgN5PSlWy6TidNqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAowYdwI7CQLAfmv5umKMlCnhNIC1Vf0bCPvOr/K1Mc3oUTkyBreJDPhsn8vglIL7xZ3PIrCc5kgbNMm13sIzbD9QltENReEAzOoKxtisKeUt9Pk0RwoGWkLvJlbZFJKfiEsF46JCGmZVMaFtVK6eL9oQq4cHJVV17VcmGgm68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9nNUecs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9nNUecs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8607B1F000E9;
	Sat, 13 Jun 2026 19:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781377454;
	bh=Giq5qPPsLXMfxm/YhnvybTapzE95kM59A2+7c6V2t60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y9nNUecsDFh+QQwnTiEXgtsMvlFPhobCTokdVoKUs6tzZW/vYFgPQDnD3/qZOeoss
	 sp4OaEsZhj8Tu/todRXEuBdxPUwwliLoVWOJEFDZIushrmQPLN6cAWMrT+5r68WS4r
	 vXWHDThPrPIBbP5tndSG6GYBbm4aRIK2nnMPcSV83kyx0QzGBFR/miA95T48DEdOaZ
	 m3oy7CVGi1Lrnz24k2/sSuEP4ioamphINRlZYM1HKZetpvVw/eD4yUwJ0yOEqQMTuC
	 YqIhdWI81KHtztQrSNJm8RLUAztKjBn0zOPPxGv4amA6DoJe2lgH4oHxiPDt82g62u
	 NpwLdeft68TkQ==
Date: Sat, 13 Jun 2026 21:04:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Enzo Adriano <enzo.adriano.code@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: arm: sunxi: add Radxa Cubie A7S
Message-ID: <20260613-voracious-lemon-frog-bb2edd@quoll>
References: <20260613-a733-dts-v1-public-ready-v1-0-7787c94681db@gmail.com>
 <20260613-a733-dts-v1-public-ready-v1-1-7787c94681db@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613-a733-dts-v1-public-ready-v1-1-7787c94681db@gmail.com>

On Sat, Jun 13, 2026 at 05:42:13AM -0400, Enzo Adriano wrote:
> Document the Radxa Cubie A7S board compatible for the Allwinner A733 SoC.
> 
> Signed-off-by: Enzo Adriano <enzo.adriano.code@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

