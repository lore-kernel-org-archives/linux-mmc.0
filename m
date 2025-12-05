Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC0E3161A7;
	Fri,  5 Dec 2025 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925492; cv=none; b=rhEUQg8/OMDo1BH22SAJl+AHKjT4HivugXdEarpLGU7es9ZW11fg1tnCO9SYFUOuAHaVDnfbIyx+gNYkiKLBqjsUtrhUd+SHyyNtm7qVoTtRPlbfN89l9XAmyEg4GG1DFSTb+bc5z2SaYKhvtXIU/hlqgdYfFdI7OFnx4Se6SG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925492; c=relaxed/simple;
	bh=J2ovb+88K42mXDaoJYvkfnX2So3Ncf927h6EI32oRIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy8EcHvxojFHXoBUM4WK0uFjbDN7ehIaxCEWJ3o2tY88+866YwyjoyaRCDfAhCp2WnXKhuqg07grOMf7uWurv5wyuACk6V4KfxV3HqYz3PAnsT2LUAv7NmEf/4pmczrZOio/1LdAkhJcAXOL15NW1YMo6EYQQwJuVshNbuRNrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jky425Lq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jky425Lq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB43C4CEF1;
	Fri,  5 Dec 2025 09:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764925489;
	bh=J2ovb+88K42mXDaoJYvkfnX2So3Ncf927h6EI32oRIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jky425Lq+xqdqknZN+dBqk+kDT1IP2zLRG1WHnvVFHtQsYWzTVG7rqrx0nMG/+IjM
	 cY4Diq4aZ3SvYp2nDTCwnHbwDh0YeWlvClkW3q7ZpoZRf8USSi2H/jaKM86uXnpe8H
	 ayDWr7Okza/mSssjih2k+367tAEGP6AUE7/xD7nAvB0ieSdrzcQnENr3ycmI+rJkuL
	 3eRPBZIjVZ4omPixobm0eE55Ls181cwwd5R1iHtGdvmkRre9DErDQhKl0RNhBj9AVn
	 0c5KUpuYw049LUaHjhAOD2jDs9hDnPN/lQAtGfOZlLBEA0MVCkvYyESKNuM3RApyoX
	 iTcPgrcMaqMvQ==
Date: Fri, 5 Dec 2025 10:04:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wenbin Mei <wenbin.mei@mediatek.com>, kernel@collabora.com, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mtk-sd: Add support for MT8189 SoC
Message-ID: <20251205-funky-coucal-from-eldorado-7f8bea@quoll>
References: <20251203-mt8189-add-mmc-support-v1-0-f5ce43212fe9@collabora.com>
 <20251203-mt8189-add-mmc-support-v1-1-f5ce43212fe9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251203-mt8189-add-mmc-support-v1-1-f5ce43212fe9@collabora.com>

On Wed, Dec 03, 2025 at 12:45:34PM +0100, Louis-Alexis Eyraud wrote:
> Add a new compatible for MMC IP in MT8189 SoC.
> Even though this is partially compatible with the one found in MT8196
> SoC, the MT8189 SoC register layout has some slight differences and
> additional features.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

