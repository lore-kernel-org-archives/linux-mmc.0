Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADACE3BF660;
	Wed, 30 Sep 2026 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763355; cv=none; b=l4sW7hwNCpJxiOQyR73avaOkq5yqAJI9G7mGSPvL3Z/C85S0CE/tXV4u0gSGTn31I5jk5iZOg2Ci7XZhiGPtg5QKA8bxQ4Bwg+Tq/OcrSfwHllxsiJ5KF4Cjr2gnHBT0J42+RYJeJsxrwCoK5r7eMF42Lr2vXLJU62HJlU3lZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763355; c=relaxed/simple;
	bh=JqSfPSgjF5PyGS2VuxjAFZemmABS/4Ly7VYBibSekds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMe49XLXYUkFFkuPtE/z8I/+KTqxij/95eeUGw4ibh4fYOvjcIO0ZOLzaFXAWwrWvfW4xghJtTbeivrfJGLEcXh86Z65FsuYBLgOeNg1+g2kFeOrj+GIKjfM+mvPAhNnX+vzhNOXcfKhiaUMdyrzAy2owixIA6qmgkIdGnDcDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VG5b7MNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VG5b7MNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4308E1F000FF;
	Wed, 30 Sep 2026 10:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790763354;
	bh=2+v9UdC3WeSsimkvLm7OPSPWh0Nm4kcvIj5kzanuUhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VG5b7MNdnIeobZc1HIBo3JFB5v7phc+A+upIBve5/3mfft29cZxXSeioIEpmjv4Pk
	 vm3eMEmYkvkFHLo+jA03GHay8fXFo2kvNZh6iYHaKiuV//8eeKcfFQow6HvHj+7mU0
	 R9J36+qboE9T/a7SX7Lm6rEgzZ2gdhSt6R0BDtG8cBH6YGwxet7Xh0aUHvCb3+jp7F
	 47XG7b6x6nFzgJfdTQJeuqgDfzvkNjkbF/lTe+MX41yRG1pv5Q1UIT5zozera6RTtF
	 ikKakkXa3EJM4q+4wLpPB9ro2ErkBb+dECGpvkTDvUKoZn9LW33D+SKiv/uBqJVLEi
	 n22RAXP7/6BRA==
Date: Wed, 30 Sep 2026 12:15:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pablo Mazzini <pmazzini@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Ulf Hansson <ulfh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 08/11] dt-bindings: mmc: sun4i-a10-mmc: add Allwinner
 B288
Message-ID: <20260930-elk-of-strongest-reverence-da4495@quoll>
References: <20260927151016.186493-1-pmazzini@gmail.com>
 <20260927151016.186493-9-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260927151016.186493-9-pmazzini@gmail.com>

On Sun, Sep 27, 2026 at 04:10:13PM +0100, Pablo Mazzini wrote:
> Add the MMC and eMMC compatibles.
> 
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
> ---
>  .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml        | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

