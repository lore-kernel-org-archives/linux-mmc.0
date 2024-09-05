Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFC218E058;
	Thu,  5 Sep 2024 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518177; cv=none; b=TZE8b8DXSMPoJyN9gYlBcLPDsRrcYlyKRzHjonFKp3mn7OQInqcxsbx/wKDHqryTD92ATG/wZSWCEUJG6VPDdVdb+VuxBZd5sI16IECfzt3sDzuE163PeLCDtUEQJs4FDXxBsjKtggS81be/t7+Q0RsV611RdktLBE3owNIBqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518177; c=relaxed/simple;
	bh=BBxX1J53cPDA4zrPTJvQp9YzrjmHuB+WUCPgvWXB5mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nvw0UIZp2BBUIXZlnm3Hze5AMZQOn6INgegkRJlhowzTzpYtJ9c0odmov78YSYduuH9hDMVnUZua1bkPfieWV8QNl1EzddIPbK1RXniSY66HM7tUgLnny7kOY7V0Fpy0g6jRbNHMx30eOYxyth0eR4iv48F/AiZLR9DHvLauiAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sueI+HZc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sueI+HZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E567CC4CEC7;
	Thu,  5 Sep 2024 06:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725518176;
	bh=BBxX1J53cPDA4zrPTJvQp9YzrjmHuB+WUCPgvWXB5mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sueI+HZcYs1PPd/mR72IkV7gLD5ylIl2fXV9BYnG+8bOU03vqJL4GbRWC0ySm2qNo
	 goyy+eH348jXnKeA54GL+rWfOEttbgj/DjzeqzxpVzMuH6iJeoOGeFllGUB6HEsxS8
	 80MEfoWYTSf/ZAc0IioZ2KvANoNdPWPy7Ssl+VAPetKBok9A5eK2XEY1xLRVXzdTI/
	 Nd5dUquWPPnNoBJJCtBUdEm31zfnN/ZiF+qyIWQuO0GFkKK1jLs1U1pXj7qhGu/PyT
	 9fqpVg81vbxzuBzkifFan8KqE4BTdDmEnO9W8v9Ml8wUkDJZ0BvC/xp2KWZajQ/ygE
	 dsGAFsHnHIwKw==
Date: Thu, 5 Sep 2024 08:36:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v4 1/1] dt-bindings: mmc: Add support for rk3576 eMMC
Message-ID: <rapoucqtnoetxcnx5u2z6k3tulgovi66syd2qtgpt6v72srwgj@tf6f662gw4vr>
References: <20240904203154.253655-1-detlev.casanova@collabora.com>
 <20240904203154.253655-2-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904203154.253655-2-detlev.casanova@collabora.com>

On Wed, Sep 04, 2024 at 04:30:58PM -0400, Detlev Casanova wrote:
> The device is compatible with rk3588, so add an entry for the 2
> compatibles together.
> 
> The rk3576 device has a power-domain that needs to be on for the eMMC to
> be used. Add it as a requirement.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 37 +++++++++++++++----
>  1 file changed, 29 insertions(+), 8 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

