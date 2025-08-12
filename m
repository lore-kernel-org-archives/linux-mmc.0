Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FD8261574;
	Tue, 12 Aug 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005615; cv=none; b=JW6uQjlFkx0d2hJWHdinjetS7x9r7g6DV3bcL4HH5dVrfMfNUyXstmJFO18HdrorRCUCFlAv+o7TwomhXE7gvyyHtqXJf/68v99KMLLtnJVx3WtvsmBD6c9TkRJ+DNgSS6XsDgLQ8FO3gT9ZDlNMs7aO1fmozPizGE04QhtfFPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005615; c=relaxed/simple;
	bh=dS4y36QAOmFxGB3IF5rTASgVCuJo6srS84clRq8Bg1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYUQEuO7WiG+lVsh/P+mwI3yFzaGp5A4kW/+ZuTxARvkS26TyE3Dc9R4E0tdLvo/NYMk5fN3/7GdYdl+5uk96A1Yb4SeDJ6gbqjQP9gDULBO5NyBd7R6hY1fWlvw2X9qUgBvWSQeMqgQzHiYvCfkYRD66TYfOCxrSrzsJ3XlrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSNgCxpW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSNgCxpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43663C4CEF0;
	Tue, 12 Aug 2025 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755005615;
	bh=dS4y36QAOmFxGB3IF5rTASgVCuJo6srS84clRq8Bg1g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GSNgCxpWNzfLytjJp0Y1T36No9Z0k5sKzohw1PUPPYsUuofA9cjlW0leejkQnvCs3
	 BdEiaQZD7XTiCrNmCEE5SLwEHsFs4z0MKscQlPaf4heIYtknhFbCBxcWC7NjDOT3GI
	 ZfD6sDdbGh/sCnsbt+xmkcVaPiR/xYKMCfz0biIBFGs0TlNgO9yTBtTT4tKIk/lBJe
	 pGdzdV+I4jUcdZScGDQbFOBz7VaQ3qwtTKo+Kyde+ztrFPdtfcWYA1d0sj9Tt4nk/c
	 4ezbmx32Z7zi1ERFImujsqEYQne0LpVocgrJNmc0MxYJAqal0tbMrDXzt4WKqI+OZ5
	 K6NOgWC4ACf1Q==
Message-ID: <45ec2fee-9b76-4f36-8476-000fbce775c6@kernel.org>
Date: Tue, 12 Aug 2025 15:33:29 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] MAINTAINERS: add and consolidate Black Sesame
 Technologies (BST) ARM SoC support
To: Albert Yang <yangzh0906@thundersoft.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, ulf.hansson@linaro.org,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
 adrian.hunter@intel.com, robin.murphy@arm.com, ding.wang@bst.ai,
 gordon.ge@bst.ai
Cc: bst-upstream@bstai.top, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, soc@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250812123110.2090460-1-yangzh0906@thundersoft.com>
 <20250812123110.2090460-9-yangzh0906@thundersoft.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250812123110.2090460-9-yangzh0906@thundersoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/08/2025 14:31, Albert Yang wrote:
> Add and consolidate the MAINTAINERS entry for Black Sesame Technologies

I do not see consolidation in the patch, so this part and subject are
incorrect. You only add.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597


> ARM SoC support. This entry covers device tree bindings, drivers, and board
> files for BST SoCs, including MMC, and platform support.
> 
> Signed-off-by: Ge Gordon <gordon.ge@bst.ai>

What does this SoB represent? Who wrote the code?

You added that SoB everywhere so I have worries it was automatic or
manager's decision. That isn't what SoB is about.

And looking at actual M: entry, this should be rather publicly Acked.
That's what Ack is. Not SoB.

> Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
> ---
> Change for v3:
> - No changes
> 
> Change for v2:
> - No changes
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index efb51ee92683..e3236384c28a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2441,6 +2441,16 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/arm/blaize.yaml
>  F:	arch/arm64/boot/dts/blaize/
>  
> +ARM/BST SOC SUPPORT
> +M:	Ge Gordon <gordon.ge@bst.ai>
Best regards,
Krzysztof
