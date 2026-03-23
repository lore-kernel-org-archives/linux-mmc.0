Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B302D361DC3;
	Mon, 23 Mar 2026 07:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252005; cv=none; b=M4R3a9H/hwpWwSlcDnT312SZiSr09HTcFkrW5PsOUhzf64IAz3e/nuz3GmYEOAqXXw4psHJ61kNQxlrNrQoOzT/bh+3wNDOnxW4G+PALs2m2JWBtuYIrrqWJ/mrZMAViz3ISLyRLhADrJWVBNsuEj2/HWinM4PHW4W27og5MmDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252005; c=relaxed/simple;
	bh=Wio9gMPqHdSGHZEDnEngY8SYE39grryI9XLE6l3oDWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbfoVlZYNHgQfuEMZgOLKttNlW/SV4YbCCedlA6C5NRpmWtZIcc1Wu1FecNglSbCcEtT85h0dBmyrD7wdrtGghFo2QhWUr8kPljOR8LYn8ad7Ms/RS9zvsIolrnSY3eQt27CG7k0RrNpMFNNWPIJOYM3Ackt7M9Pv+zQ/3Sn17c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKBIV45S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKBIV45S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E54C4CEF7;
	Mon, 23 Mar 2026 07:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774252005;
	bh=Wio9gMPqHdSGHZEDnEngY8SYE39grryI9XLE6l3oDWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKBIV45SW7jYRmcJVtvHXKV3XffQQLnB0h0o4rBJ+x8MFpB7spa4sWYcUb9zxJtSR
	 Em44JRqOzEDzoaRis98/wG516c2uGmuUGklH9kmt1y1IzaLaijhkCMRZR2veXVcUH8
	 7h+YLi9Kq/iP4P8oYnFMQvWhEvy1e43lDIUJykhe4ZntsdfJkWZ3SmOMhIFan24bwB
	 gukcErCqbnAR2V2EpMabOvh9Ad7fw59C3pwWL1FmmrXRh9ODcfG/HpGb3wZHbqq2rp
	 lkEvMpfz7OZVB2Cno8KiSZNO83VNnlyJBs8OfPwRDrfysDNJIk0HcRDRB0rlIkbzdW
	 I55lgMa+UJkRQ==
Date: Mon, 23 Mar 2026 08:46:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Andrew Jeffery <andrew@aj.id.au>, linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-aspeed: Handle optional controller
 reset
Message-ID: <20260323-glossy-industrious-dog-63b1e6@quoll>
References: <20260323-sdhci-v3-0-93555b8f6411@aspeedtech.com>
 <20260323-sdhci-v3-2-93555b8f6411@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323-sdhci-v3-2-93555b8f6411@aspeedtech.com>

On Mon, Mar 23, 2026 at 10:07:08AM +0800, Ryan Chen wrote:
> Get the optional reset line for the ASPEED SD controller during probe by
> using devm_reset_control_get_optional_exclusive_deasserted().
> 
> This allows platforms such as AST2700, which require the SD controller
> to be taken out of reset before use, to work with the existing driver.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> Changes in v2:
> - use devm_reset_control_get_optional_exclusive_deasserted replace
>   reset_control_get_optional_exclusive.
> - add include reset.h

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

