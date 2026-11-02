Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604443;
	b=WiDJUUJnmuzbSu2teryzD/KIaMX3vE+D/xFp9WaTrC8qdUcDR81vk8yCEX9OHClUGrNp
	 v0kvYklXCm0kQInx/EbODPPQF0e4OYqANaA3fWXa4hUVjkhs9lk2DfEQl6XtLeV/3DVb7
	 5zQAJhITkBMyQICehhgFII8PgVVg62koE285sfEdqSKQD3g1E4cW/ahsbmaGtDSE3iHzh
	 1vgpPQ13QPH8xIaSPWb6cZG28MqHjpCkEs4pUsFCYyRFBRxt2Q/r0rSYtaXl8Bc1XMz4c
	 RQnDcNCVREqvH6mA4X9vnfyir25NepInpVEPKvQkB1hRt5LVYfNw9ebtZw6O9kqtpUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604443;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=U5d/OqMUU7ujcPTUgqYcdum+/mhJbuAtN1Av5v/OUNY=;
	b=Vc1VRZKTaRrZgHcEKCqekRXc6W12E3YpggKMVOlVlywuONjwZtFl8O4pzopdDOUulHwk
	 C6e4/ob48r1BOQUaRtm5XffLhgLQ+MKCNPoDteQN21b7TeImgSxFbQat4AqBttD6WQGsV
	 KI2eH7CWo/7VrUF58Xsv/5bbU7fsU/QBEdJjY8bFCKw37+B393s5eOr7vQvkvS6ZAie9p
	 xtu2bZ+It10LI771bI0lg3IBI00BSB2bMBdKCAx76ANcbINipGIxdttfB3b7QAMEUEJJf
	 GbKA6be2LWq7hwsG8EuK7j/5BPYk+ekaHpC5NhLxgx3SwQRcTaFmHt0zBO3xfkylC+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlL86neP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D4F606A324;
	Mon,  2 Nov 2026 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlL86neP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F071F00919;
	Mon,  2 Nov 2026 07:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793604442;
	bh=U5d/OqMUU7ujcPTUgqYcdum+/mhJbuAtN1Av5v/OUNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HlL86nePf0jHe0zn+0px/ON2Il/o4udZUPkHGO25OEZqJ+AfJbmbfod1gfQ1ukRy+
	 hhh1hGgLcItTPW9hDMDnSEK6wOPDbNP8WWIEskTgv526Mf08EyZSyEi/Y2TPYd60r6
	 ODZuIm2chaI6wklBuNtoPxowEDmK6PVTxvSrFu+yyhLNO68bKRMz7Xg+bF9X6CqhlA
	 P3DjlU/QISuzW5yUtzvQY7ALU+GS60s4MpTGPg7vQeBPB66brcPcPNiT2CwniHNB5+
	 Mn48Tj6lbJKJkAjl9MXi86BljI+u0VRou5/1RWNBg4R+wS9RW3rg2NOMOGBUVi5Cmv
	 zQrpHLzFCbmVg==
Date: Mon, 2 Nov 2026 08:27:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Enzo Adriano <enzo.adriano.code@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andre Przywara <andre.przywara@arm.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH] dt-bindings: mmc: describe the Allwinner A733 eMMC
 controller
Message-ID: <20261102-steady-grateful-chimera-e2363a@quoll>
References: <20261031020640-263f7b05-a7s-mmc-binding@gmail.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261031020640-263f7b05-a7s-mmc-binding@gmail.com>

On Fri, Oct 30, 2026 at 10:26:47PM -0400, Enzo Adriano wrote:
> SMHC3 uses a different DMA descriptor format from SMHC0/2: the length
> field is 12 bits and the ownership/control word carries different
> control and high-address fields. An older A100/D1 fallback would claim
> unsupported programming compatibility with the existing sunxi-mmc
> descriptor builder.
> 
> Give SMHC3 a distinct compatible and describe its register range,
> interrupt, bus/module/storage-MBUS/MSI-Lite1 clocks and bus reset. This
> binding permits an accurate disabled hardware description; no
> operational driver match or eMMC functionality is claimed here.
> 
> AI assistance: Codex:gpt-6-astra.

Drop, we do not advertise slop companies anymore.

> 
> Assisted-by: LLM
Drop

> Signed-off-by: Enzo Adriano <enzo.adriano.code@gmail.com>
> ---
> This binding is a separate prerequisite for the disabled MMC3 node in

How this can be a separate prerequisite? Binding without user is not a
prerequisite.

> the A733 DT v2. It does not add a sunxi-mmc driver match or claim an
> operational eMMC path.

Hm? Why?

> 
> The original A733 manual and public vendor implementation distinguish
> SMHC3's descriptor control/high-address fields and 12-bit buffer
> length from SMHC0-2. Its resources are the 0x04023000/0x1000 register
> window, SPI 164, AHB/module/storage-MBUS/MSI-Lite1 clocks and AHB reset.
> The generic A733/D1 MMC0-2 compatible already in the base is unchanged.
> 
> The example uses the public A733 CCU header IDs. The tested standalone
> base is official commit d89e1d186ec9271bf78e62771779e9fc03bf0fc3 plus
> the clock helpers and CCU v6:
> https://lore.kernel.org/r/20260906-sunxi-clk-no-p-v1-0-cbde21c9fe69@pigmoral.tech
> https://lore.kernel.org/r/20261009-a733-clk-v6-0-ae8178fce7e8@pigmoral.tech

...

> 
> base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
> prerequisite-patch-id: 0df2ae41836b86fd868dfa01ddfde57f888f761a
> prerequisite-patch-id: 88f3a431e7c551a9fa732f062188f10fdd362eeb
> prerequisite-patch-id: 3e88bc873c909059d1199f82cda4013765e7a5e5
> prerequisite-patch-id: 0dbc27cd7417352319a0705a051dff35085e8922
> prerequisite-patch-id: 0ed6b92774b5b794761c7ce34db653a5435dc833
> prerequisite-patch-id: 27ed3814dbd0c7ad830532ff125625917c873b4b
> prerequisite-patch-id: 74d03898c5ce14763f4e89fb73e021de59f0fb9f
> prerequisite-patch-id: 9225cb094cf6cbb338b14ac63711d68bed12d24d
> prerequisite-patch-id: 568dae1c91a0d7318d6eb14a18054343b84b603a
> prerequisite-patch-id: ff3806332e741f0e2c8dac1c11f4c71449c16c8c
> prerequisite-patch-id: 39461e0543aefb5c40184664625cbab19ac8408a
> prerequisite-patch-id: 6fc03bfbd343042dd3b660938fcc09c5e7d48314

So this cannot really be tested.

Best regards,
Krzysztof

