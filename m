Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A092F83A1;
	Sun, 21 Dec 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766329780; cv=none; b=YzPQo3ZdRNoXgxXTNxGcr/5ngc4yt6Gzcune035U6iY+la2c7gUQOZzCDiNopG/1JsS9kDdKu/woWQ1jwJ3VfePU/EQE+rw41t5kJcyFGFy3WSKQdSLz1d0/DXDxKpdzduV9tRW1iLwposd9Bulumefbjq7/A7XjATOIXyqW58s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766329780; c=relaxed/simple;
	bh=2/gGdRF4YQEY0trDcqIqtagcyDa3bJuflC2YsN5NlPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8DM4nUAEygcvUpjK+eQKeueeZQWHf67fvQtXY83fLYZi6Zvgkpv0dtf97GNWSsxZ1aLiFh8U58EZOOOsh03Wecm9di3F5rFcKG7cXECjA33vq11jL5IwvM0uzxi5bUgv5/DNwLm5H1YaZU9MG0J44BHeTAJmWD9rVNwgMv8soA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuY+iubI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuY+iubI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4F2C4CEFB;
	Sun, 21 Dec 2025 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766329780;
	bh=2/gGdRF4YQEY0trDcqIqtagcyDa3bJuflC2YsN5NlPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IuY+iubIVecBN2Qq68xRboT8/axzkrTeQvFg3tML6oN/nEPttRYLTfO4fXdim8csn
	 DENi+qFlHgY8TEkRrnPpOrydx9FzDX6+xHHmmlKCtDI0+jEe7hFdSQqRIh7MTxrWJr
	 Suu0c2T2OScbdte4a+Ja9/weW+ok/hqhof9CFCnURHGjMbA50mOI48WuQ5Tr8af2wA
	 Piq8dbIp3+CN00qb7QFdzztO8HEwkWqifNxfane8Cw4rVT5LDYq9ek8FsRiqoNB1qZ
	 779kRobuUlBxQA0Qd8TNnbvF+LbMAwQz2r3xBY1HxroGJ2nOILPFpAuaKsGu4BImTX
	 hfQ/NKH9HeqLQ==
Date: Sun, 21 Dec 2025 16:09:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Iker Pedrosa <ikerpedrosam@gmail.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mmc: spacemit,sdhci: add reset support
Message-ID: <20251221-unnatural-resilient-trogon-7b20a7@quoll>
References: <20251221-07-k1-sdhci-reset-v1-0-6780af7fa6e7@gentoo.org>
 <20251221-07-k1-sdhci-reset-v1-1-6780af7fa6e7@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251221-07-k1-sdhci-reset-v1-1-6780af7fa6e7@gentoo.org>

On Sun, Dec 21, 2025 at 04:20:26PM +0800, Yixun Lan wrote:
> The SpacemiT SDHCI controller has two reset lines, one connect to AXI bus
> which shared by all controllers, while another one connect to individual
> controller separately.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> index 13d9382058fb..322c69b056f4 100644
> --- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> @@ -32,12 +32,24 @@ properties:
>        - const: core
>        - const: io
>  
> +  resets:
> +    items:
> +      - description: axi reset, connect to AXI bus, shared by all controllers
> +      - description: sdh reset, connect to individual controller separately
> +
> +  reset-names:
> +    items:
> +      - const: axi
> +      - const: sdh
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
>    - clocks
>    - clock-names
> +  - resets
> +  - reset-names

This is an ABI break without mentioning in commit msg and without any
justification.

Best regards,
Krzysztof

