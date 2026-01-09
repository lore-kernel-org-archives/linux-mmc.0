Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741F355816;
	Fri,  9 Jan 2026 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949012; cv=none; b=f9/bQZkf1CwIFsgIC73Z+xD/WNT6mJT8AuxJIZ6IfaoWHXLqcYYiunaUH1bzQjUcXlp3TN9qIUN31HhEl71SZPEMLeVAoUCyC/VsBhZAetS7m9bpH1EIdtnJeGMrpR91HjDkoit4h5ktI1t03FeQGv2BFro6lMH7DKugLBu0Uu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949012; c=relaxed/simple;
	bh=wyApNeKzNR8bAWt1nSZg/uwaAH7GLDy3BTDew/IwPJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnrWq+HDK5gLh/LBg59hjuC8nEzqbBiNVAUvZAlgYE9pAUz5fQbsQqviErhWdFnkLlqxaG+/oJ0IZsm0UtVO9HL5LneawVAXSvsebhaxCM9khQFtIE8I9Ed16QgY+IV19QMDf11XK+8j/KgW0QF6jDCmfeyyMDE9tobGPkIabOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGGQXVZh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGGQXVZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B0BC4CEF7;
	Fri,  9 Jan 2026 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767949010;
	bh=wyApNeKzNR8bAWt1nSZg/uwaAH7GLDy3BTDew/IwPJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGGQXVZhDKTVj6dkXaQRyXSgA39RMuvlB/5kD++1j+l98uNsRGYS6I9UwJlOe1fXs
	 WePrAu1DVbmpDP3w7JCJKBrbJaYGwgOSmRANbFfiJgTYTHMkCcB3tAR5EkJaZ6gsvI
	 KjZxVbZehBoY8/Mx8pSedNbkfu1iSaaVpTMGRVahllSvwOBQhAjMkqBwvCjg2HxFfY
	 Sgqxl+qeSZiKe2c1vOGDK4WHD6x6IZQTJRWBD8wvxwmn8XwDRZcxeoeljoJwgWEeEI
	 YfrucDPAytxiZozzuPT9yeBEDWGP7J58vjx7y2ybF8NSzjJc1FC0IeXal+O2SK2l9w
	 RvNd0d3fVZJug==
Date: Fri, 9 Jan 2026 09:56:46 +0100
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
Subject: Re: [PATCH 01/10] dt-bindings: mtd: brcm,brcmnand: Drop
 "brcm,brcmnand" compatible for iProc
Message-ID: <20260109-enthusiastic-nickel-mouse-c8d1ea@quoll>
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
 <20260108-dt-mtd-partitions-v1-1-124a53ce6279@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108-dt-mtd-partitions-v1-1-124a53ce6279@kernel.org>

On Thu, Jan 08, 2026 at 11:53:10AM -0600, Rob Herring (Arm) wrote:
> Some users of "brcm,nand-iproc" include "brcm,brcmnand" and some don't.
> The "brcm,brcmnand" compatible is not useful for iProc systems as
> there's a separate driver for iProc. So drop it as a fallback.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

