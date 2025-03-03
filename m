Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE6214217;
	Mon,  3 Mar 2025 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014463; cv=none; b=RCe/cIUa2raho9rsVD2WVapNJmbtEeuGUWeFgsxs56Qn5fW8VNfjmwxoRO4Kmaa5qX/H2WSOmgbL3Cb2GZvqEbcfgBmoTxQiLbEYXshHRDDjXm7+eXTVktCN1iY2/GHqwVLnuivzdQZ7O7xscvG/X48JW5JlbzI6PBoUEbYv04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014463; c=relaxed/simple;
	bh=HuPOnOviq8r+tHWc9h2eXFiWNQM7CuuwBrKHN13HnOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqwnZ5cJlvfwweTMAer3JwmZ2Tq3bjgmhwyIOxgEasP2bAQkdhFHUVx0Amjua3y9G9+1iQ/PdNawpwrl0b/hC0tQIm3oVMV5Bm2WbjseIMyoEBhQLZZPN3lYrPCndERfp/NyIVDdlF6D5BDAO49TSsQeCKOPDFzYOCUBhx074+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8lsaej9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8lsaej9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C42EC4CED6;
	Mon,  3 Mar 2025 15:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741014461;
	bh=HuPOnOviq8r+tHWc9h2eXFiWNQM7CuuwBrKHN13HnOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8lsaej9A2HXVSBTtk7NEa22kgHyP3MX8CO9eEccqrCx2bictg+yFVDreriVq3Gvk
	 HN1Jo4/Pu7xF/kgCJBQPGB46Z7EyG4nAYRI7ULlQMABBb3iyUgTNqdcDsGPsYqj2Dr
	 q1FAglCF8KP7tT1/JssrxgPw8O1n9cwwlgWorHT+u7Zu5f7+2kAG6A7TrJsXocFIIr
	 ZI+JL/h37Bqvfg/j8Ua6Jx3aOHE8uz/4Mg9OfyeFT2se1iJEXzqXE5NQ15JdGXtRxe
	 h5JJLpwB0IVNFHpfJgyR2VitKa2EPa60FKPTfDl6govGN7YkD8aHAE/ucBNpVuJ8ze
	 O3+dNqs3LQEdA==
Date: Mon, 3 Mar 2025 09:07:39 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: soc: rockchip: Add RK3528 VO GRF syscon
Message-ID: <174101445900.1859153.5372866255768427473.robh@kernel.org>
References: <20250301104250.36295-1-ziyao@disroot.org>
 <20250301104250.36295-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301104250.36295-2-ziyao@disroot.org>


On Sat, 01 Mar 2025 10:42:43 +0000, Yao Zi wrote:
> Add compatible string for VO GRF found on RK3528 SoC.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

