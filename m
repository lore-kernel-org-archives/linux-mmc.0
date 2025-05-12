Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA33E2571C1;
	Mon, 12 May 2025 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036606; cv=none; b=THcDCAppe9lCzxfJacrIL8guC5qIW3YE83m8HpecVyhLbqmrwLNW12zilhwT6UuJVmNRBQLQiuWQD4McuVSqsI6DANyfHS/JUr0bJoCzGP7isfraX1/w++e0tSuEYYDE1Dkrj0skDrDJt61sxfh9dpAn/xN9ZbbIBOonREQkM5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036606; c=relaxed/simple;
	bh=PgXCrcSqbmGKQgd+vDtbz7ViPzj24hgYgF8x853UbYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfTA2NdfU5ODTBDqCpQ6zUA0tAHnfvUVvwZO9YiSqxKd8PFI/UireUWdxl+ERKVwbfY1QOdUwS8qZNPyyhjWThpuU72JgmIWn1odWHtiHOSvwl8dKGhA+IByGfW1jANtJmp/QvB+rdIV8gd0j9iM05dRnoQNjoPF3lPiHAZNQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 867583430F3;
	Mon, 12 May 2025 07:56:42 +0000 (UTC)
Date: Mon, 12 May 2025 07:56:31 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@riscstar.com>,
	Inochi Amaoto <inochiama@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-k1: add support for SpacemiT K1 SoC
Message-ID: <20250512075631-GYA517379@gentoo>
References: <20250509-20-k1-sdhci-v3-0-526c35feaa20@gentoo.org>
 <20250509-20-k1-sdhci-v3-2-526c35feaa20@gentoo.org>
 <4cee9284-8f71-4214-8bc2-48bcb4030e40@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cee9284-8f71-4214-8bc2-48bcb4030e40@intel.com>

Hi Ulf,

On 09:04 Mon 12 May     , Adrian Hunter wrote:
> On 09/05/2025 16:22, Yixun Lan wrote:
> > The SDHCI controller found in SpacemiT K1 SoC features SD,
> > SDIO, eMMC support, such as:
> > 
> > - Compatible for 4-bit SDIO 3.0 UHS-I protocol, up to SDR104
> > - Compatible for 4-bit SD 3.0 UHS-I protocol, up to SDR104
> > - Compatible for 8bit eMMC5.1, up to HS400
> > 
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 

If this isn't too late (as v6.15-rc6 is tagged), I'd like to seek
the opportunity to queue for v6.16 as no big changes during these
two review cycles..

I also know people who would expect to have a full rootfs support,
and this driver is sufficient to bring eMMC up and will make their
life of development easy..

But if you have different opinion, then I'm totally fine to delay
it to next merge window, thanks

-- 
Yixun Lan (dlan)
