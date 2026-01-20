Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661C2882B2;
	Tue, 20 Jan 2026 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895740; cv=none; b=a2awAVeUESCqooypNPwTW5Gd5k8q5eN4s8Qrg5mSnWuUnjTlhrwVdnTiIAPkvd+NFdN6+lQRAwZEUxCQI4Cx59mpYZzjohPH1ukn6vMIUnxju2Fo17+IkvqrCN+ASuz/sdsoTKZkn/fVp4J25lKCBCfmdgL/R26pjwYY7Ds8vBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895740; c=relaxed/simple;
	bh=BBTRxbnKPyoh+nTPUz7ZafUr9MPEx37RGzF8gtkMZ6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyjrwnSjqk4+FBiltQNVIZEjxsYdpOIZsM4teIntImIVvEB/6FjC0zgdDD+oAxQaSCuohA0K1Xn9FPcpCcNORJc8UUlrO/AAEztsFINUhGQ6tD40VtcecdhWY7QV+FRLl6WAE44/WXlSpfax0rJYdN9cnAhCgUhfCHauUGIY/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3I6E/Nl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3I6E/Nl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33330C16AAE;
	Tue, 20 Jan 2026 07:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768895739;
	bh=BBTRxbnKPyoh+nTPUz7ZafUr9MPEx37RGzF8gtkMZ6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3I6E/Nl/zHSfUZCfHsYpca4lxQuvK8u9O3KqSQo4iypJgrx3Wo0qJe34m2sIVG/9
	 e0Y8DpX1UTtGvizfEVk8c71JXlnAXmCEcpdMvLFuKf3L1JF/v7M6W10Gbsjw3zSx7d
	 mpbjMZP9HYVmaQz7MABdgd5q8hWPOSZwGGgUl2Iq+DhASzqwB4AcHpERlGj44nxL7G
	 Y70OCPuwVTrbEcHb/xLMU0v8Skp1PEXS1nRkR1nLpLjsQRYMZEo9u7uXrL9fN1BY1O
	 rZd/dCgwmMzvrJINFlGtVIeEHeGcGltIu2PKY07HOpo9NOLcGn0fOyMKvUBetmSahN
	 uYODJ+I0qRgTw==
Date: Tue, 20 Jan 2026 08:55:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, 
	William Zhang <william.zhang@broadcom.com>, Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Simon Glass <sjg@chromium.org>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Roger Quadros <rogerq@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 06/10] dt-bindings: mtd: partitions: Drop
 partitions.yaml
Message-ID: <20260120-ingenious-auk-of-enrichment-eae4f9@quoll>
References: <20260119-dt-mtd-partitions-v2-0-77ebb958a312@kernel.org>
 <20260119-dt-mtd-partitions-v2-6-77ebb958a312@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119-dt-mtd-partitions-v2-6-77ebb958a312@kernel.org>

On Mon, Jan 19, 2026 at 07:48:27PM -0600, Rob Herring (Arm) wrote:
> The partitions.yaml schema is an unusual structure in that it includes
> all possible partition types, and it disables the normal matching by
> compatible strings. As partitions.yaml has nothing to match on, it is
> only applied when explicitly referenced. The use of "oneOf" also results
> in misleading warnings which are difficult to understand. Drop
> partitions.yaml and rely on the standard compatible matching instead.
> 
> The "mmc-card" case previously allowed any partition type, but now only
> allows "fixed-partitions". There aren't any users and the original
> intent appeared to be only for "fixed-partitions".
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/mmc/mmc-card.yaml          | 20 ++++--------
>  Documentation/devicetree/bindings/mtd/mtd.yaml     |  2 +-
>  .../mtd/partitions/arm,arm-firmware-suite.yaml     |  2 --
>  .../mtd/partitions/brcm,bcm4908-partitions.yaml    |  2 --
>  .../partitions/brcm,bcm947xx-cfe-partitions.yaml   |  2 --
>  .../mtd/partitions/linksys,ns-partitions.yaml      |  2 --
>  .../bindings/mtd/partitions/partitions.yaml        | 36 ----------------------
>  .../devicetree/bindings/mtd/ti,davinci-nand.yaml   |  4 ++-
>  8 files changed, 10 insertions(+), 60 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

