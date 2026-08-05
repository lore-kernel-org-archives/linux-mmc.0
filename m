Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0FF3E0226;
	Wed,  5 Aug 2026 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913093; cv=none; b=lERRSmO/wpxqepOPcXkHM2W9vEJibhvawGg3teyp/kYBQF3OSy709UYIKhjpMGUjB6b9+5o47VI4o8yJqxccxqlDUymd9XlsH7bsFzQUVYHBP9hRubHxxvbsdBBiih3ho/2MtHs9bMRSx1AlGzqzppSNYfVnhfZXizrMYFTXn9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913093; c=relaxed/simple;
	bh=Qkvwid0xbq+DgdrDUTlRtZp74ulhJtXG93s8d2LG3lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YewgSMXkwizl2ruuDICUzKAP/wYaepdA6sAeeLmXz3qFr8D1Bxq8CxR7CpVpNyVE8smtcdCpFFp9Ts+hXcx2FGGqsCGHWYiIJ2tN9SFVIX3Vp13BACUWG/6hYOBNzxuKSyyLn2ib+pVUuAzKvDs02ea7dtjCp0KqgfTjoLa6JGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHUgeEjV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHUgeEjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225DC1F000E9;
	Wed,  5 Aug 2026 06:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785913090;
	bh=84dFTyZ+Q7xlWQx1Wxm8D4J0k4h2sBLqxYncH52fX3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iHUgeEjVlpSaoEQjiQ1KgL6bbTHh19o+14nc+J5RE0rk61H6HM9l4988Kl6kIfZUg
	 Mg+AfKMXKBDvhs+rMa31I5eN1m2gVX83bqauLnpL9Zy+m0aogAtxy4+EjIxDnfsIZk
	 XzwolbkjOF/t+CjVlsdJE1emfxvB7lHNHF6DA4PPtwg1+8bPJglR4K87CMzuaThRDd
	 USunvyDVX8aMDFKHkU4TSSmAaYFVKZmrmVk0w5zZopQ4lztTcB9X1Qpbv16o5G2l1y
	 a5+bplHmpEDjFTAVj0hZEzrATm6twO2/1ug/Yv+ivjMDCXWHw1Lam5dvvbWGK6TicV
	 Kz7o0t5SSeEiQ==
Date: Wed, 5 Aug 2026 08:58:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Ulf Hansson <ulfh@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Avri Altman <avri.altman@sandisk.com>, 
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>, Erick Shepherd <erick.shepherd@ni.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: mmc: Extend keep-power-in-suspend
 beyond SDIO
Message-ID: <20260805-thankful-heavenly-meerkat-d8bd8d@quoll>
References: <20260804203818.881765-1-kamal.dasu@broadcom.com>
 <20260804203818.881765-2-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260804203818.881765-2-kamal.dasu@broadcom.com>

On Tue, Aug 04, 2026 at 04:38:16PM -0400, Kamal Dasu wrote:
> keep-power-in-suspend is currently documented as SDIO-only, but the
> requirement it describes -- preserving card power across a
> suspend/resume cycle -- applies just as well to any card type. Drop
> the SDIO-only restriction so eMMC and SD platforms can use it too.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

