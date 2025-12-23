Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7BA23505E;
	Tue, 23 Dec 2025 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497772; cv=none; b=OvgGqqysaY3HalR74sHG4wD9aXzlcTgSe6dOwsFeYsmXwl5ShMePg1apoxDJu8rDPPEATTGC89UJBh4GHckV0wTUSyrYNkWy9lbWMzBLrqLhdBZNOKb1kWFRpDlFZUG/y72+B1Q75J5cOynwaBE/WtmWDZ641wvSus7WdoOaFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497772; c=relaxed/simple;
	bh=LP9Z5o7yi79FN2SK/0EC/YZ6R6r1WQyV9Or8AKfEtvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ec4sVq4x6j0qZKsOWTwY3B1VoN8vo4htkQEdA/cq09T6jyleD3jqdhbL4LlndVxiBVpDyISaXkdxqqpZwrtj/3TXon+WFbMkrWNyfejs0iM/3xoU5SsuEI8fSm+3WTMbKo0hUmTzcijsyzD4ad5d4zhb1irDydiox8/c/2zDrCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEAyTQ6m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEAyTQ6m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E62AC113D0;
	Tue, 23 Dec 2025 13:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766497772;
	bh=LP9Z5o7yi79FN2SK/0EC/YZ6R6r1WQyV9Or8AKfEtvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEAyTQ6myK2KnxFepTTbdpaQpKGbh93LnSrNBArV/EeC0O614blICVIzT3ETZOM45
	 swJQTl7BJ9vuQQFS25RpFOenhWK2uFEOQH7U/OokTjgU6crXJWPRL4WplVevfIp9FO
	 MwV3ns8BPhryvu0JOQHqB6aNthvxov+HCDf2Tf4IcAf1IM3oAn/+AiXFTHJEeAvNLl
	 Nzu4JUEzBlO7+0rkw9mt1wpxV/Qiy5J2/pAIcgjp1EDk1dYA/8D8u4bXUeXRhmm2qB
	 CvGoshRElij4almUSa+ZIVARPsD/diRNniIB6+Rmbu95OeOPDuXP9x1mF54fulBNYK
	 t0lOWN5qEZM6w==
Date: Tue, 23 Dec 2025 14:49:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Iker Pedrosa <ikerpedrosam@gmail.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: spacemit,sdhci: add reset
 support
Message-ID: <20251223-great-ambitious-piculet-bbdecc@quoll>
References: <20251223-07-k1-sdhci-reset-v2-0-5b8248cfc522@gentoo.org>
 <20251223-07-k1-sdhci-reset-v2-1-5b8248cfc522@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251223-07-k1-sdhci-reset-v2-1-5b8248cfc522@gentoo.org>

On Tue, Dec 23, 2025 at 10:24:49AM +0800, Yixun Lan wrote:
> The SpacemiT SDHCI controller has two reset lines, one connect to AXI bus
> which shared by all controllers, while another one connect to individual
> controller separately.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

