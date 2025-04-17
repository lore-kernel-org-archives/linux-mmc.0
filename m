Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA9C1FF610;
	Thu, 17 Apr 2025 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917749; cv=none; b=UTfF8cUhjCe5r9n6yeh+VgQk7xn6RgEYRGLfqtAdIedew0Y8yneSnzvGV9O+CLNCzT0XSWBAnFqJAQL2ZtP/dF3/QeJ6X2+Q0x5SVkocNzyP5KpkDTQn2ks+9Yp1XHfkadiZyVs0VU5YYeSgNt/9WVR8CjmU9llsKY/6PKuLcLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917749; c=relaxed/simple;
	bh=erzSqX42u86Pu0QutiQ6JSyJ1eLwKyc4t7HHtCGZOG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrQuX6eBQp85KWsGp0WyGw6T+eZ2CfLOV5fxD90r5aL1tnQW2q0ruC2I0K8K9faoe7LzEN6gs1fPN2sxgrRQ0Oh9ZftHcsRnwFFInCzMhKkoZFw+yVevnIk9JGKxBN1zxFaZuB49/Y8XKUm0Dt4BWWT7/KFphn/VJktA75NDqnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=OIAJMk6k; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="OIAJMk6k"
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1D3801F92A;
	Thu, 17 Apr 2025 21:22:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744917745;
	bh=erzSqX42u86Pu0QutiQ6JSyJ1eLwKyc4t7HHtCGZOG8=;
	h=Received:From:To:Subject;
	b=OIAJMk6k3f7HE3QqoyRCE33tRQylqAzRmLQJ1xkRGMyigwieSNZLLl7YVWqxUGCaJ
	 6hBW7bgpqfoTpVL5q19dRyMa1+vdJ9C9uYy+Oe/5pWk8aepzDtiUJz3D/gCO2gHhoH
	 HqDFIqeBghsOBFyGeeoPyuhllPrBNGjo6+KJNFbSXsJdF8ZgITqDq1aqCRh2uCHMRJ
	 ucfBC4Fnh3Ugle18oNie1N83NG65kkUkz1laHGXGsYCxkw4jRq86jA8XZlC9O2j8By
	 jqZwHLMx6jrWTxLQwXUINwXnWpwDtTX0rYsBAvOiM1D6lZK2NR5GnfS9Dlgu6qkbDm
	 5KhZAyNZt72bg==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id C0D4B7FD18; Thu, 17 Apr 2025 21:22:24 +0200 (CEST)
Date: Thu, 17 Apr 2025 21:22:24 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Judith Mendez <jm@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josua Mayer <josua@solid-run.com>, Moteen Shah <m-shah@ti.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Hiago De Franco <hiagofranco@gmail.com>
Subject: Re: [PATCH v2 0/2] Fix V1P8_SIGNAL_ENA
Message-ID: <aAFU8K9j4fZ-njwP@gaggiata.pivistrello.it>
References: <20250417182652.3521104-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417182652.3521104-1-jm@ti.com>

On Thu, Apr 17, 2025 at 01:26:50PM -0500, Judith Mendez wrote:
> There are eMMC boot failures seen with V1P8_SIGNAL_ENA on Kingston
> eMMC and variouse types of SD cards on Sitara K3 SoCs due to the
> sequencing when enumerating to HS200 mode. Since V1P8_SIGNAL_ENA is
> optional for eMMC, do not set V1P8_SIGNAL_ENA by default for eMMC.
> For SD cards we shall parse DT for ti,suppress-v1p8-ena property
> to determine whether to apply the quirk.

I assume this ti,suppress-v1p8-ena should be added to some SoC dtsi, am I
wrong?

Francesco


