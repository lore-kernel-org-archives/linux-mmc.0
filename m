Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF22421420F;
	Mon,  3 Mar 2025 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014497; cv=none; b=nPSkG7jfAV4I0lN/0hoKUQqng3RNQaAuffu02gWZKfKqibc5pcK0rJjlFRnCN41IntEmBKsAQ1T9lnA1Pl8Jhf7xZ7HEiuXhApEsp/bJihCoDLvamoJ3QXxLcjZyOprGsjTNcD+ey/J7zG60jL6UZpOB/gY5j9QhLaOynmpggz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014497; c=relaxed/simple;
	bh=wxHNAItkFHIncMThkMK3x96fLiyJc6WQRTjToXorc8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoE6ZIBrgjI7zXV0IPW+luyzmEwXpmtTYqLhj8Ka/bN2mIt+G9yTGVz44AzDsBgejP38VJy2EAs0jSqKb7LVbr7mBxp4Tm87n5RzkH8Gky+ofO6TbYcX+4iASz5KZBRIC8Y7y9EMN2cALkysmjtdGgewzMM47ohPwak8TiKKMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWtGk6wm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWtGk6wm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1CBC4CED6;
	Mon,  3 Mar 2025 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741014497;
	bh=wxHNAItkFHIncMThkMK3x96fLiyJc6WQRTjToXorc8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XWtGk6wm+ybrOTF2kYZjc74q2++XFn6YSLPvBiSLIHKYwonzQoe9rIG9MkZeQeI0i
	 9kA7Qbt7FwITNhJRIKd1t3lcKguy8eqX6COl2wI+Px5cnZgJJa49JM3I9zqtKxyLbv
	 5TMqlaLHhJPCLq+fDu4h3yGDhIdxPxBwG6V6EOpA1MkixHN0hm9qXMEY+2GrCBeyt+
	 jDy0VwSSkmVnof2xU9oc3LnZu77kj1ZztDybehJPtcewmbkaERYfg40QXhlqxrESDy
	 5dQ8xYobvzN6aRx7YUsZqilxAaLIQAalok9cMSI88/N1ga33n6tZNGXltdISPZ4sl+
	 bICiNAEKV+7Tw==
Date: Mon, 3 Mar 2025 09:08:15 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: devicetree@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
	linux-arm-kernel@lists.infradead.org,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	linux-kernel@vger.kernel.org,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 3/8] dt-bindings: mmc: rockchip-dw-mshc: Add compatible
 string for RK3528
Message-ID: <174101449502.1860172.16789001197573661761.robh@kernel.org>
References: <20250301104250.36295-1-ziyao@disroot.org>
 <20250301104250.36295-4-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301104250.36295-4-ziyao@disroot.org>


On Sat, 01 Mar 2025 10:42:45 +0000, Yao Zi wrote:
> Add RK3528 compatible string for SD/SDIO interface.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

