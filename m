Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191881;
	b=GXS1i+wmc9glAcC8w/fDntipyI+kDu3qF1pTsqhGjWvMSyxXy8PBfrcVh4b73DeluMfq
	 3KKvVtVIfFtI6rKibhPN2/LHMJwDv5NadNzXkMaLGoq0p/rwywUx0ZJN2tGdkRlFZw25j
	 jXqCR09kZHLjYYCjbqwPNuC5aR3j+tDeADTdhe2iV4UPhfFgvQF7MqTWs6lEg+fnOYfBQ
	 8Y7Tdgt1RciAuQK3OZwJqw8NKSuF6hdNL4zMdoevxvbD/DF1xoe+dm8kjo6PEOzFnnMnt
	 7lk8gzmrJBD+j0exCmWkdRlyolYL4DpHrIXbK4mH3ixDPyDXL7mI9qHF/SwJDlRx5Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191881;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PF9hqOY7SlmHr6Mu13sbIIqaN/HmWKK+iSj3xcxtqik=;
	b=rCQz3/uq5h+04efzX0Z/F67gMagb2fwmFuiiOGZe2+UAjlleYGvAbANR6hK6o9I5YKw8
	 0djovnguZdIAh58j58iyQ6bDLvW0KtIDg86wpTvGq4qZ4LiHfnrHJZntSad1YpteOJcp8
	 nFwWSMpnd2unxRNBmEZL1G5fIIdUJtpZATFwmYkS6w4z3u8ZEigSnz95U92LgL1tfC/Lx
	 L8XAdcbOLj5D9VwVW4jf/6Cqep6yHVQrOOtc/ijC4uQRXb8jeizmI/opDXn6LA3WlHOly
	 NA1dNsw5CItH48SEjNOrKy/VcsmY6jqXPPIaNeGel2h1izeGpWUKDSXMVboRTW/mhMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOpHduCW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66566606A31E;
	Wed, 28 Oct 2026 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOpHduCW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000A51F01825;
	Wed, 28 Oct 2026 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793191881;
	bh=PF9hqOY7SlmHr6Mu13sbIIqaN/HmWKK+iSj3xcxtqik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AOpHduCWZ0pL+wQdwiF5zWiQ38s36anq3OoP27DBHDx50y1QhIMeNOezKqpwqi+ur
	 IXsIwrFPDu0Ejmq42RHm2jpkX1yW1I6OZ+exlAFmKx6tPRrSJy57ymtNZgWJPVfqlh
	 Bu1kghbNdHXOuk8bz85smbLnZU8bFaY3QH7ey4Je1ID2+YOmMYybNInq29/+j1uwc8
	 bsp0YbWCAbCaWSHu6UJUQ6j0ZvMj+24Y6cIIji+h8lq9X9RgIvsBHydUrAprq26Kr1
	 +rPLMJHaiwinKOyAxG/+6PHtL7UN8OcwiCbEnerqaloZic8ly09FrQe0HvdDQDvsA8
	 HL/goimzwSY8A==
Date: Wed, 28 Oct 2026 13:51:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, 
	Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Document support for
 Airoha AN7581 SoC
Message-ID: <20261028-academic-blue-earwig-72d3d1@quoll>
References: <20261027144002.10606-1-ansuelsmth@gmail.com>
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
In-Reply-To: <20261027144002.10606-1-ansuelsmth@gmail.com>

On Tue, Oct 27, 2026 at 03:40:00PM +0100, Christian Marangi wrote:
> Add dedicated compatible for Airoha AN7581 SoC integrated MMC controller.
> The MMC controller is based on the MT7988 with the difference that it does
> have a single clock controlling it.
> 
> Add the dedicated compatible to describe the 2 register requirement and
> permit to define only 2 clock (the main one and a fixed clock for HS)
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Also add compatible to restrict clock-names for source and hclk
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Your driver part suggests it's fully compatible with other variant. Why
not expressing it with fallback?

Best regards,
Krzysztof

