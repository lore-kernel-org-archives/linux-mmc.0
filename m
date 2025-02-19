Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7701B25A2CD;
	Wed, 19 Feb 2025 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004657; cv=none; b=Ul/fd1z10qS1fqZl7fZTyp0be301VXsGVQXZvSerFbf17RxJI69ZJjwEwlljwAHNbYdjGWLMnkmXKxxhg8ZclLh8iAZj+s8KaeD/mQnHBtXNsiaQOisCEXnXYhhC5QSolGlMXdKPjxfzBB/Nuy2WUDtBOhL0wvIWs3LejQGho6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004657; c=relaxed/simple;
	bh=d4I+/dbOHaSeZthBV2q6Z411QDo6FQ08GXJOnck9qbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5FOjvZdgUchjR2DNKnrj0Qz3uvckpoDMKT6cGi03di6KPtkOgMRMB4UEVSvbC2ejCYjpsaWcZNXAmDVh03fesKoD4xcPUCz0D8rsTyeYFERPfouiTEvxWhiuyS+kziiLTK+mSdinantGeI/Wnb1t08ughuzaacn0k6HAXDR9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv+gLefW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv+gLefW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FF9C4CED1;
	Wed, 19 Feb 2025 22:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740004657;
	bh=d4I+/dbOHaSeZthBV2q6Z411QDo6FQ08GXJOnck9qbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dv+gLefWfY2jrPLivnYgsCm4f1DuV8/EmGcIURHVr7w4J8vei0IppHEY42BraKdCm
	 oeXpD/LCX4Hm4L9qcTxQ6nvPfQIB3y8J65D1mi3AxFmIyWJFU+Jwue4gq7zyfVzf3a
	 86oPwly8pCJazf4hwq86gNkd6NFpo6x21KXoxrGWA9zmEVbcFSbn8TE81ty1W+44ud
	 AtqlMplWx66aQT6hc6EbN5RNniNlzanPPmJbz5blsFigOTcLNNm/v4v70fFjAK/Vtj
	 N4dSkVaE1q5ZONx//lzz1wiJR0Jz3VSBBeHsoG88HHUJ1/ibdxQlMMrH/KwUPW4S2D
	 rEpjPI1OEntWw==
Date: Wed, 19 Feb 2025 16:37:35 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dt-bindings: mmc: spacemit,sdhci: add support
 for K1 SoC
Message-ID: <174000465542.3097183.7038527174083018186.robh@kernel.org>
References: <20250213-20-k1-sdhci-v1-0-1f4362a980cd@gentoo.org>
 <20250213-20-k1-sdhci-v1-1-1f4362a980cd@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-20-k1-sdhci-v1-1-1f4362a980cd@gentoo.org>


On Thu, 13 Feb 2025 18:58:24 +0800, Yixun Lan wrote:
> Add support for the SD/eMMC Host Controller found in SpacemiT K1 SoC,
> The controller supports data transmission of MMC, SDIO, SD protocol.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  .../devicetree/bindings/mmc/spacemit,sdhci.yaml    | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

