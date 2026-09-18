Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748EB282F16;
	Fri, 18 Sep 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753844; cv=none; b=ZqBJxgIYJU9JfkKmwgS/gbmkXMpZzAdh7oHsX/uBmIKUL+E3Y42NcUfrDfq3DFmOI/1Ga/jAJMWH2g4vKkpRMysORy1YHX2HyeSIBBjjfgpO0iQhrojJ6q+xHI+NeTLij314zaO0xJmlhlZ0jhHb3PEEhHso/Y7ISKBuBD/mIRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753844; c=relaxed/simple;
	bh=jwqUH2/fnxblnjXYIcNTOs95dG3nDY4ZG5hOAciLubI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+UMswfsXOqNqnUYYbQhzxdsPzo5d2wMrswSOHpov/pst6dwjyLvL6glqByORo88lYNKIqSpK3eHqcUsMKu2I5eYm505XmytHRvtdB/j2IOdouxPtPAKJ5gKZ0/IdgqR1h1T3Or2CWNzoSMgwKinsWIuaoQ2Qg8fxc4AcIOS6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jvtw5OGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jvtw5OGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B751F000FF;
	Fri, 18 Sep 2026 17:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789753837;
	bh=TG2xvNJBCXx1WTpRAKtFtjW+qEDTB07eN3TryfDzbiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jvtw5OGw0qgxCGGmNESlcbfLK2iqnqleBg0SZDDtuoGuy78On8VzRlf5agdDYe+aU
	 D6fKMdGPGu7vRSVE6n19/ak5jN+gjUEEsJiZWAp+R6AcU36ncJQ2YmcNHh2BdV2jls
	 lW4iilLjgjTT/9jjNUn/+Sw/SSB0acL/5kXk21rl3MJvDnGoszcdb2gW1s3X28f9Gy
	 JJLm3W9SWzbxgAVFkyPJaWtMf9t6tXYLrwRFxYKc08K498LyrxQs+yjQc7dHjkZauV
	 Dur9aZKISUJ/kR5yNKl4bmrQEr8tdm1OlVy1NnuMJ7WaQo98QZGYMeSTsH6hq2y092
	 XceuyyBfUgXdg==
Date: Fri, 18 Sep 2026 23:20:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Paul Cercueil <paul@crapouillou.net>,
	Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Linus Walleij <linusw@kernel.org>, Fan Wu <fanwu01@zju.edu.cn>,
	Rosen Penev <rosenp@gmail.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Rakuram Eswaran <rakuram.e96@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INGENIC JZ47xx SoCs" <linux-mips@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..." <imx@lists.linux.dev>,
	"open list:OMAP HS MMC SUPPORT" <linux-omap@vger.kernel.org>,
	"moderated list:ARM/ACTIONS SEMI ARCHITECTURE" <linux-actions@lists.infradead.org>,
	"open list:TMIO/SDHI MMC DRIVER" <linux-renesas-soc@vger.kernel.org>,
	"open list:ARM/ARTPEC MACHINE SUPPORT" <linux-arm-kernel@axis.com>
Subject: Re: [PATCH v2 1/1] mmc: use dmaengine_get_dma_device() instead of
 chan->device->dev
Message-ID: <aq156IdeXdaE4Fqg@parshuram>
References: <20260918152349.2101305-1-Frank.Li@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918152349.2101305-1-Frank.Li@oss.nxp.com>

On 18-09-26, 11:23, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace direct dma_chan::device::dev access with the proper
> dmaengine_get_dma_device() for consumer API
> 
> chan->device->dev is not always the device used for DMA mapping.
> Some DMA engines support per-channel IOMMU mappings, so different
> channels may use different DMA devices.  dmaengine_get_dma_device()
> returns the correct device for each channel.
> 
> This also prepares for making the DMA engine provider data structures
> private. DMA consumers should not access DMA engine internals directly.
> 
> Assisted-by: LLM
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
