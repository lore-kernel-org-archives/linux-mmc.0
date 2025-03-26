Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C6B19066B;
	Wed, 26 Mar 2025 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976833; cv=none; b=Ddq3U4BMDZS1InxF8Shzn3Q+XgwSue7TGTPIdzNpxMXXYoS6q62KJluv+Jh+hRPya2eoXswXFdCfelx94TxXf+SzN64qwJ//IxbVIBen3ln5di7SaZrEOHKdxEjgsLipbzVLH5uUw/skAuTr6D6rTMeOL7UWCxpAfeg2GuRJiZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976833; c=relaxed/simple;
	bh=v4CYst09Trq8VkiSo2M2aXD4T7YqMP6slaQagB+pQIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEK5UC9Cpqkz8eyyD318yhVSZSYvRIj0XtT8gU+niF0eFtbLFP4afXfIGVfGIAVYp8t/5h3SExZMOWb20SimaMXdteGvZSIH44oU/77i/1e6obe+xCECNAFRgNXDZvFulRNpvCDdFaLCSNVBtJxVJ5eZRsvqWPdcmhcyNb9hzio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGs3PIBv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGs3PIBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85485C4CEE2;
	Wed, 26 Mar 2025 08:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742976832;
	bh=v4CYst09Trq8VkiSo2M2aXD4T7YqMP6slaQagB+pQIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGs3PIBvpiMyofY/XbxhQL8hqjoDRETSRYGuWhEOoE8m0AAXocbFt6gO57xYe0lO6
	 5tP6lZmIkmfbNSewn0p8IxN5NXEcWLjc5kZ7GBwQmH7CJ5NArt2oZrDcZJMe/AgtAl
	 PeXFFZB5MLWAo9rd37fye5bXYhIk03iCguRqpFBzSiO/pM2Gkpe/3c8QWvdJ97dcib
	 XZQcJOO1t5yNrxxXyN1OyoTIK1nKt84P+S1wIeBqc+CqOPV62l7ihn1jXQnDI4uBBt
	 iowypYddiWCO7zddBsRE2sdcGeTyPjDWNzLWPiDVHnXsubNrtaHFuByh+32mELym8R
	 GWunfKxlsbvig==
Date: Wed, 26 Mar 2025 09:13:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: mmc: marvell,xenon-sdhci: Add reference
 to sdhci-common.yaml
Message-ID: <20250326-chocolate-ibis-of-faith-970ccf@krzk-bin>
References: <20250320-dt-marvell-mmc-v1-0-e51002ea0238@kernel.org>
 <20250320-dt-marvell-mmc-v1-2-e51002ea0238@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320-dt-marvell-mmc-v1-2-e51002ea0238@kernel.org>

On Thu, Mar 20, 2025 at 04:35:47PM -0500, Rob Herring (Arm) wrote:
> The Marvell xenon-sdhci block is an SDHCI and can use properties from
> sdhci-common.yaml, so change the reference.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

