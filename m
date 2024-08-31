Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930581531F2;
	Sat, 31 Aug 2024 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725085238; cv=none; b=PrI3gz8qd570lO2MEFzFnkUm6MoKBIS9c7eZP/HQDV7cf93LJC8yaIKpkLcc/LAICE34pMWLLnUHyOt6c8osTazgqN7NZs9ofDd7bP3t+fxzQD2vtE4Lxj9LbrcHqzVC2XaYljh8eoOf2q+KDrM0XzS/8apUlUkQ7KibWqSB37E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725085238; c=relaxed/simple;
	bh=YNJVpvPoHgrYf5lFtoCPb60BgybDZKL6rDp195m3bak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzr7IYP0/A3ZSp6uotDaOkwRoFEvS5mx2Hz4LKz+5zGsq2594x4rHX+S+mH2GQY735q7ur5R6qIYZtlBbwshsVl2Krva1kS5QYjRKjYwP/fT3sOluGmYjIYV5sJbVrSJf3HLq/q06De87qTDXRWq4VHb6HDqJwdw4a/odLdV0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRu8rxLK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRu8rxLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDEEC4CEC0;
	Sat, 31 Aug 2024 06:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725085238;
	bh=YNJVpvPoHgrYf5lFtoCPb60BgybDZKL6rDp195m3bak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tRu8rxLKpKT9kvCicA9U9XuTp3xqW+DK1miYOIk7X7G1XeRKamDJM/xwlcPgd6wdU
	 ac7MBKoufON7LhWg3aNAKs+o9uNHOkqUVH6hCLfafoAjiIblVOoNcOF8jJbLSp+deV
	 9Y3U2QUtTSOrBPvEHIR9eFrgcutEqd8Hxt2Qbe0C53z5wzWGcz4ffT+lKc83b0UOrX
	 fcCRLu9a7ZGQjfeTjsZPwkBtK5gmgNhO/bZusmVgyuku2YSKWDSe0HJGR1MwGgmW40
	 Ufp27fYXDHsIFM2rUjfB7kbKuf6zQJehDjITTtg8hmLP2peG9RnuLnct1AmZFHfDr/
	 4WfRYFJiOOl7Q==
Date: Sat, 31 Aug 2024 08:20:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Aubin Constans <aubin.constans@microchip.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: mmc: atmel,sama5d2-sdhci: Add
 sama7d65 compatible
Message-ID: <3wysn3i3syox3n7howwnewuy6h7457goeafbrilptewxyuqitr@cdyjlzp5s7bu>
References: <20240830-atmel-sdhci-v3-0-7c97a0872af4@microchip.com>
 <20240830-atmel-sdhci-v3-2-7c97a0872af4@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830-atmel-sdhci-v3-2-7c97a0872af4@microchip.com>

On Fri, Aug 30, 2024 at 08:21:21PM +0530, Dharma Balasubiramani wrote:
> Add mmc binding documentation for sama7d65.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Where is any user of this? Why are you adding bindings without users?

Best regards,
Krzysztof

