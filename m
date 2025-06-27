Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600221CFF4;
	Fri, 27 Jun 2025 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055985; cv=none; b=HG0zBcmdwLncZO0ILGw/BgAtdD+iwyPWQvEOYMhx899GloyTHMq1aaAlge1MLHJD+lo34vNt/jN+MA4APL6B+nqpzuflh0JcsWzPh+EmocGyFsJGKnKULW4YfaDsYFnRwPufDVsBO8paRp7jkRuqWAbgpH1/ZOWMLGHYxx7Gg4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055985; c=relaxed/simple;
	bh=xiXaILIEtvdfMijC9n0nmMDCB4bsijR8COa326qvLUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2aVzcdE8i9LY0Nwb+Tce/s+YU7Jmuzsyp2ZP+XcNuImR6Bplx9tH2GeuUdpmXeRcZi+/KrWbHZMhHHhFqHgNOIhqEzUiJ6OG2SZfgbE7S0YM9lGk76/hSlYlZxaH+Ar+5WNCGYFmKqhULTROtVf5FaVQo4SZa/qzxif1Sl4HOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZmoX9n2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZmoX9n2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C797C4CEE3;
	Fri, 27 Jun 2025 20:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751055984;
	bh=xiXaILIEtvdfMijC9n0nmMDCB4bsijR8COa326qvLUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZmoX9n2SxjvsVU0mt0+IyyHnt4zsT02TnmrAcUyPxzY41tnk/I3tkc4hMIUH6BM7
	 b/PgpUGBNgPUr9/Yf1FlQZ6TssuhvMh/uLaThLaYP2fL5LVH0fhhNVv3IHqCYwI9A8
	 fkEplNXulb3BJOWdzILpJ9WswhUw5RXjn7p5qNHmaD1pF0TDQoLWGX8Qo+7gyIJmQY
	 pEd8LB5xo/iMEScxyrZzeJpOnngDVbDxgukHze4KI0SGef1bQiDGhkSER77s0eH9C6
	 jNg+hp5BXLMZGUedEE7Uy7BwPIP1zIPbzLnUS6o4ewGXqtey5ePfbGIy0tbbv6PGkE
	 vtfDLiLPSrEYw==
Date: Fri, 27 Jun 2025 15:26:23 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: devicetree@vger.kernel.org, wanghongliang@loongson.cn,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Binbin Zhou <zhoubb.aaron@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v4 1/4] dt-bindings: mmc: Add Loongson-2K SD/SDIO/eMMC
 controller binding
Message-ID: <175105598309.27283.7574752844130118767.robh@kernel.org>
References: <cover.1750765495.git.zhoubinbin@loongson.cn>
 <949c55be120a806ea3d74b47fa2cc96ced2905fc.1750765495.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <949c55be120a806ea3d74b47fa2cc96ced2905fc.1750765495.git.zhoubinbin@loongson.cn>


On Tue, 24 Jun 2025 19:58:10 +0800, Binbin Zhou wrote:
> Add the Loongson-2K SoC's SD/SDIO/eMMC controller binding with DT schema
> format using json-schema.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../bindings/mmc/loongson,ls2k0500-mmc.yaml   | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

