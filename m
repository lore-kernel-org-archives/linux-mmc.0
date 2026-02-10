Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED22522A1;
	Tue, 10 Feb 2026 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770686967; cv=none; b=hLK8eqiOmPo08Lgitj5Lc9lJnrT0Upw8ti1LBSnKn8NaQ45egE4ueS1j3nrlPJeoXfLohEvcXrd0i1F7wsQjw+pIRGhc575HojXlSoBGAwAFg/2n0Hj/tI6RHR7dm/8W/UqoO24fJQmHaWzb9Sv8fEpHN1a6VfPNYgZdLL2wqas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770686967; c=relaxed/simple;
	bh=vPtgEERLhI7QUhtgMm5j4VLfBY7NaUFPnI8j3SoVhu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDzaScalDrr+S5x9dcA90appj6M98YopAJLzIwCK57Q6SVGF16sOcHGwN1e0cc4WvHJUP83g2Q+Ci4swAyHomYv4oKShDsG7L6yo6mPx1cwAmYB1y0A9wfCkkW3Lh4P4l+ymHF3CThFDGrf27FFiWuC9lTJPEkoZZhDk8/aucwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/9YaCNw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/9YaCNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B6DC116C6;
	Tue, 10 Feb 2026 01:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770686967;
	bh=vPtgEERLhI7QUhtgMm5j4VLfBY7NaUFPnI8j3SoVhu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N/9YaCNww/VWJbyiYoqyRb2mg1WyMEGE331TuoF3q6kCtscpxoFiKym7AiVTaA3Ic
	 kk0S4qsyjWPSS2mKxAomH7M3IofnkyDsiRxBHSVOlF+kkwpnmNRg0b0L2rFNzQfpPz
	 s7o6Vj9NH6hf7e2QfCn/C/ziJ1M+NMWrQpMRCbXEsO/2JHYdgmocs92lp5wrUti6Gg
	 sqtixfIpF7vjzADDCJOHXtgxyHquG+hcReZGEXAklmygby+9UiTgXSIG3Jmjmxmkst
	 KWYNxWG/xNSABTeHxniwtMDSERXkFWnL5xDxaw3tbThZXBptRHhVkBQIXKLfSqXkQc
	 gDs4jTdxv5Qmw==
Date: Mon, 9 Feb 2026 19:29:26 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tzu-Hao Wei <twei@axiado.com>
Cc: openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Vinod Koul <vkoul@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	SriNavmani A <srinavmani@axiado.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-phy@lists.infradead.org, linux-mmc@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: arasan,sdhci: Add Axiado AX3000
 SoC
Message-ID: <177068696529.2278295.8145891834285711544.robh@kernel.org>
References: <20260206-axiado-ax3000-add-emmc-host-driver-support-v3-0-ef83b09325be@axiado.com>
 <20260206-axiado-ax3000-add-emmc-host-driver-support-v3-1-ef83b09325be@axiado.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-axiado-ax3000-add-emmc-host-driver-support-v3-1-ef83b09325be@axiado.com>


On Fri, 06 Feb 2026 16:23:07 +0800, Tzu-Hao Wei wrote:
> From: SriNavmani A <srinavmani@axiado.com>
> 
> Add compatible strings for Axiado AX3000 SoC eMMC controller which
> is based on Arasan eMMC controller.
> 
> Signed-off-by: SriNavmani A <srinavmani@axiado.com>
> Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

