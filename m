Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDEB342151;
	Tue, 23 Dec 2025 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500398; cv=none; b=fV3ts88SREfwKpSAnGI696nY9XMhhlWt85twrRkz7qDmNE6XWqwsIuB0QKpAuBW+MPOuk6DIC2G0VyP58meviuMUK7fvGw9hV7Tawaxa0AnO6kdUOwpjogAsM90ooiHyM+pLt1daQDlYylub7PudAFmORGLeS4/PfkzKsuEiWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500398; c=relaxed/simple;
	bh=SrHPMnHEpJgZWnZhkf17/F6xjv4J13mhWyZ8J187vH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0VFIcocylmlLSCiXS8r04G98jscwa7xSin6GUc5x0nPYn9BZkkoiiSsiZue2T/BYpbGTzJ6S6DFuVXB1PcUXCM7StKYbGZr6XQ91kUj5f5yBghR/gvFFA+HWJ6tmkMFUszb8S8jY59DxyOusgMc5psK6Hl5mF26Xi1eQaedBkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUenk+a4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUenk+a4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C817FC113D0;
	Tue, 23 Dec 2025 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766500397;
	bh=SrHPMnHEpJgZWnZhkf17/F6xjv4J13mhWyZ8J187vH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUenk+a4AkQksDjJCRiPo3D45DzMbOOiFQKKjUALAdCOf+Qyn2yX64yaHImzrzVmc
	 WAwuSDFFbCrzbj8aCWi20dSYT2zcX6VbQMUWy8WKbWqgM7hs0ocI38LCUfYXV/8XEv
	 sL1q0hU4qobhO7sl74CeuV4p/OcPX/k98pS/T4PfBZXWILlp8/5PpansFmeH/1BVH7
	 vUq7nKEEMOeMxcsiPnUyg26fF/j4EllgSFP0WEGTpNwSEXe+Hg9OERwCAmQbj/HxUT
	 XrwJIxRyAqZ5KLMrbWhiJq0/R0kdjJ4CplOV8r8YvbW31KC0GSiX/MNOKQN6QDBkW0
	 sO3/BdAyopmFw==
Date: Tue, 23 Dec 2025 15:33:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tzu-Hao Wei <twei@axiado.com>
Cc: SriNavmani A <srinavmani@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Harshit Shah <hshah@axiado.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@amd.com>, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 0/8] Add Axiado AX3000 eMMC Host Controller Support
Message-ID: <20251223-black-auk-of-priority-8b48ae@quoll>
References: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>

On Mon, Dec 22, 2025 at 04:44:59PM +0800, Tzu-Hao Wei wrote:
> This patch series adds support for the eMMC host controller found on
> the Axiado AX3000 SoC. The implementation includes support for an
> external Arasan eMMC PHY that enables HS200 mode operation at 200 MHz,
> significantly improving performance over the default 25 MHz operation.
> 
> Hardware Details:
> 
> Arasan eMMC host controller on AX3000 SoC
> External Arasan eMMC PHY (different from internal PHY supported
> by the standard sdhci-of-arasan driver)
> Support for HS200 mode (200 MHz) operation
> Integration with existing SDHCI framework
> Implementation Overview:
> The series adds support for the external eMMC PHY required for HS200
> mode. The existing sdhci-of-arasan.c driver supports internal PHY
> configurations, but the AX3000 uses an external PHY that requires
> different configuration. The PHY driver was implemented based on the
> reference code in sdhci-pci-arasan.c as recommended by the Arasan team.
> 
> This series includes:
> 1. Device tree bindings for the eMMC PHY
> 2. PHY driver implementation for the external Arasan eMMC PHY
> 3. Integration of PHY support into the sdhci-of-arasan host driver
> 4. Device tree bindings for the eMMC host controller variant
> 5. Device tree source files for the SoC and EVK board
> 6. MAINTAINERS file update

You completely disorganized the patch.. dts is mixed all over driver
code, you combined two or three completely independent subsystems into
one.

Read submitting patches in DT dir to understand how DTS must be sent.


Best regards,
Krzysztof

