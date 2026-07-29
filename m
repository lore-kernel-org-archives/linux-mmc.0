Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F21436BF0;
	Wed, 29 Jul 2026 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314323; cv=none; b=pG5saPqtNc4NbNZ5CTApH4png9hQeQ6LL4nS5F51r955LrvKBIWTBEXCRTGRmHs786FiFSo19xWz2wn08LgIa5yjCjTXvVHaTjxxX2XuQA0K4ejLszSaZbEzoD9qKv4/mMCxJ8/xefIKh9cTnFWGU07S0SCpzTlDze2lmSJS8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314323; c=relaxed/simple;
	bh=xxR3BBZQfI3GHNVL8T56Uv5XXQP3o79tuI08L7ai5yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5nAeDVBSzcIGcvzCkT2n1kf68ve2loMlVfmB8H3oeN2z6RYUJV981nSYIGwq7wgBBIMk9uyW0fmR99+49o/Csp+gD0dG4mye3cTLDo2m/+2bI0PAdBpZJckVEp3f+KhD4xBAV/W4O8Tf2GYpe1ELwzXN+3lxJWTx0mYF+VV/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfGoUPSw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfGoUPSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C747C1F00A3A;
	Wed, 29 Jul 2026 08:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314322;
	bh=k2NCALBJJAy6tR2mhsLx6zg/zUETsbxYPP2QMRDNySg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YfGoUPSwnE6nfF78gylxXw8MgMZuc465SE+uyVFPDgwCZ9taYEAVDAufYjggZ71TW
	 4vFeEKmHyVyTl9iTrKkPSalfQzcW3+MBDH3w7cFwfHjcLZNBla8/Jr0LiguiLXjHLz
	 5bbuvWK/BXFjF+dGK6ZhNrXwjBMF2G+MFHWuVI5Ga2vOVyayidPSIDNAeWLqBPcNLp
	 ZkJzuCw/V0deCtWBOc/Du/duVHnmSQwgSVlVExdDC29Ky70Fhql1drdNHMMtYzE7Ca
	 k5ry1SwYkau9z/rGpLhklsj+/u86XTb0kO/OPI1AR1oqV+rU41P7LVzksAuOSgYXcI
	 MAAl53KRVf9CQ==
Date: Wed, 29 Jul 2026 10:38:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Ulf Hansson <ulfh@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Avri Altman <avri.altman@sandisk.com>, 
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>, Erick Shepherd <erick.shepherd@ni.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: mmc: Extend keep-power-in-suspend
 beyond SDIO
Message-ID: <20260729-huge-mink-of-climate-b6e7de@quoll>
References: <20260728190314.2325906-1-kamal.dasu@broadcom.com>
 <20260728190314.2325906-2-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728190314.2325906-2-kamal.dasu@broadcom.com>

On Tue, Jul 28, 2026 at 03:03:13PM -0400, Kamal Dasu wrote:
> keep-power-in-suspend already documents exactly the requirement
> needed on (e)MMC platforms where firmware accesses the card directly
> during resume. Rather than add a separate property describing the
> same contract, drop its "SDIO only" restriction and document the
> (e)MMC use case alongside the existing SDIO one.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
> Changes in v4:
>   - Dropped no-mmc-poweroff-suspend entirely and extended
>     keep-power-in-suspend instead, per Krzysztof: the two properties
>     described the same "don't power off across suspend/resume"
>     contract.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

