Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDC71CAA76;
	Fri, 28 Feb 2025 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773723; cv=none; b=Qn2weOLJ7m+L9i6bPn2AxDn9dhZ2/zFTqbh8EZmnKLFqStvma7imISXXc7vCl0gSS4lNdMZUt8jFUuh0URK8VyKXwtm6lltEnm+22dG4PTBTwIr7iPTx5GfLu/XLTbKdxKLJSu4+bV+amRKTp/SjxP/YWphY9T2Xl52CJJ+bXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773723; c=relaxed/simple;
	bh=c8FPeGSP6yNbq4Iymm89F9EMYWrWSKialrTbBJJWFSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2KBfEODGG0NkpdWP9y7QvhsQHthzaCibtsgQxUg2f8WS1a0pTBZ5oiiDNkvGpMdcYZOKmKyiOa88vvZ4e36IkyNIbX1QId5FIX5usSfE35nxDWZlUO+J18dw7s9nCD6IyCqipL0oCZNNUP50SjJmeMtIaTUnn07hUpPkd/1/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9i6iPqS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9i6iPqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1E7C4CED6;
	Fri, 28 Feb 2025 20:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740773722;
	bh=c8FPeGSP6yNbq4Iymm89F9EMYWrWSKialrTbBJJWFSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9i6iPqSvQ+0eYWoznOC0s+nNhNdhs1FOSWSpMR3ykEQB5EkCKQ2gn30v9cykSZVQ
	 tUBrG9y+NvM4xhxyhTNpXcOqbKMVDV8qEvxj0zStGD7Th5Iwc8sZ+NJ380zSIYhyRb
	 8kcPp3xNKC16Nw5MaaCibtfFpgk72xN2hcIvD55MYAt4Yj2qqcfptu5hSN6AtpvV26
	 b7leJ6LtINjHA6MscOqjo9zu55KLBij+CLvXIrbiTnKmhXDc+9Wf4NPbyt5vizptWy
	 dABUyHTzIg5sKgdLYqESWk8ERUDjWkSx108PiJh2xZnw17fabtLocPt26Y6k/wIyW4
	 Gzl3Si/3GBHEw==
Date: Fri, 28 Feb 2025 14:15:20 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org, heiko@sntech.de
Subject: Re: [PATCH v3 02/15] dt-bindings: mmc: Add support for rk3562 eMMC
Message-ID: <174077372022.3568137.13331273937640122917.robh@kernel.org>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
 <20250227111913.2344207-3-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227111913.2344207-3-kever.yang@rock-chips.com>


On Thu, 27 Feb 2025 19:19:00 +0800, Kever Yang wrote:
> The eMMC core on Rockchip's RK3562 is the same as the one already
> included in RK3588. Extend the binding accordingly to allow
> 
> 	compatible = "rockchip,rk3562-dwcmshc", "rockchip,rk3588-dwcmshc";
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v3:
> - Updae to fix dt_binding_check fail
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

