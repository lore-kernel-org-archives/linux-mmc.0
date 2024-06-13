Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9973E2F50;
	Thu, 13 Jun 2024 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309320; cv=none; b=r3z6oRjY6dwuKBVGrfXo9FLCLtykWUqzrTuG6OBhQNkCOvYI8IhOHfYALaAHRtJhkeN3ng7/5SmAaJS3WeH5CmfGqoLzTMrSIl73OEBHzYx4R7ffzSoxcDVoZ0sd5/d0MBE77a/nkLFlZLpNyToZ11XqwC+0hzDlAEB2zcucjc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309320; c=relaxed/simple;
	bh=ygqYGRp7qazQZCtbOT5FAGb8ulegaXFd8LoNaGXhais=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzTctHS0PvYaAehha5ntXs1oyiTvptgdRyM3jTM44QktjScNG098QdXK/e3Oy7it0wYDvzi1uHfGVWiTpmIRBM1AGWtgKu28XBWTIp6rRddkaCIqTA/GDlFmFEreE1MbiOhyd3LvwCbYf7P6q7WlL/3uoC4+T9PHsuNnS6wLXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6dR/5Oh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6dR/5Oh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A439AC2BBFC;
	Thu, 13 Jun 2024 20:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718309320;
	bh=ygqYGRp7qazQZCtbOT5FAGb8ulegaXFd8LoNaGXhais=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6dR/5OhG8kuPCJVgGNWx5iZ3GsM87EOFD4n1u2bwFIiLrIuWhtrw2lnTkQq0ijf4
	 peZ/851Qqtnlfo0SKPzZWCWxHPiFiH21Y4/weZ54HBvGB96oEwnTS9p3O2Y5LNDHT/
	 406VK23CIGB+VeJRlxqxYGWhP4CD3DUJuGb4mpLzeQjUNldJqb13/ywitKjS6RFJYc
	 vG3wbZnfZC1+ZQIftxbTlAZVLKelQUlZweKAenPHjldo8rsaAKzrgA02J7Z4IsOYYw
	 wciqae9vYmmgypCL8AX/0tFiP8t58OslcEC4dvbiXtK4b/+ZpCTyCQ7y8mwaIE/XKX
	 NVJVjjcyfh+BA==
Date: Thu, 13 Jun 2024 14:08:37 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v5 1/3] dt-bindings: mmc: mmc-spi-slot: Change
 voltage-ranges to uint32-matrix
Message-ID: <171830931400.2391260.17890560707264408523.robh@kernel.org>
References: <20240613-ls_waring_esdhc-v5-0-36644e2fe21c@nxp.com>
 <20240613-ls_waring_esdhc-v5-1-36644e2fe21c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613-ls_waring_esdhc-v5-1-36644e2fe21c@nxp.com>


On Thu, 13 Jun 2024 10:32:05 -0400, Frank Li wrote:
> According to common mmc core, voltages-ranges should be matrix.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> ---
> Change from v4 to v5
> - Change maxItems to 1
> 
> Not sure why it impact other mmc yaml's voltage-ranges.
> Rob's answer:
> 
> It's a quirk of the tools. When decoding properties, the tools only know
> all possible types. Types are global, not per binding. Sometimes it can
> be figured out, but cases like this cannot be.
> ---
>  Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

