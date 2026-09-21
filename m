Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA127483BC8
	for <linux-mmc@vger.kernel.org>; Mon, 21 Sep 2026 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002938; cv=none; b=V86dOJsZoSExpl5BLvwKm21swA3MjcGCN64OXZxUiZX4eyrtAGd0F9snZHE9hDnpzFORizMOIPhnbx4xNaEBZkYVSWaliG/I+TWGEytEwoGEsnSsy8sfBAVx+ifZlpr0h7PFKCcBIaXzJuDsxpBuVUke9G60PLCOFxpaH7alBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002938; c=relaxed/simple;
	bh=q+k41I23EnF+ywwJVp5opoab61DziI9GqC7O+IBIQuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8+dIM3M+Gf/CNEvB/eeUGg9E9To6z5z1SZ/KNpFyu0O/aU50rcPWOuofZ1Uyv+Wy9DQDy1nmEpMIFfjO4kZo+TiLFkCAbWeEmEPfvDCdSl1KI7igZFXV37anEaqbFRoRcLeqKUs9F+yM8EfMnhjKXU7B9cew0X/80uOYGY7cQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Llj3tjya; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Llj3tjya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=q+k4
	1I23EnF+ywwJVp5opoab61DziI9GqC7O+IBIQuY=; b=Llj3tjyabc9jD3ygIy0d
	v6IykIHu4O7+DHsAEWfmUSj+SVvqYH+b3iih7E5eG/2oyo1RGWJAllD89u0M+rqQ
	QB/9TpXWDY1+AQlo1U4gDfNBNEOkflOdGtk7EEI00ghECrjUX5WlXF2M0GtaOePj
	oZnbTeyYtdjorLwxhj4u8ZtyNFmEg7eKnXTh9x+jtERUdGtzfghvglst+/f4gh3C
	Law6933BB31Wpnc6c2FbSI1zCra8md3JZNMeTnzDhUy/Ixvg90UIcdrlFoaFnpAu
	FhDheS9iwK4JLAzWYiHEDOHTvJ3XVk43FDTxLJx4fKR5mvd7g7TxUMzZ1uYpJIDB
	rw==
Received: (qmail 3690923 invoked from network); 21 Sep 2026 17:02:02 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Sep 2026 17:02:02 +0200
X-UD-Smtp-Session: l3s3148p1@1sZMiP9boMJQT+F6
Date: Mon, 21 Sep 2026 17:02:01 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
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
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Linus Walleij <linusw@kernel.org>, Fan Wu <fanwu01@zju.edu.cn>,
	Vinod Koul <vkoul@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Rosen Penev <rosenp@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Pan Chuang <panchuang@vivo.com>, Khalid Aziz <khalid@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Rakuram Eswaran <rakuram.e96@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INGENIC JZ47xx SoCs" <linux-mips@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..." <imx@lists.linux.dev>,
	"open list:OMAP MMC SUPPORT" <linux-omap@vger.kernel.org>,
	"moderated list:ARM/ACTIONS SEMI ARCHITECTURE" <linux-actions@lists.infradead.org>,
	"open list:TMIO/SDHI MMC DRIVER" <linux-renesas-soc@vger.kernel.org>,
	"open list:ARM/ARTPEC MACHINE SUPPORT" <linux-arm-kernel@axis.com>
Subject: Re: [PATCH v3 1/1] mmc: use dmaengine_get_dma_device() instead of
 chan->device->dev
Message-ID: <arFG6UHs3VRifkBq@shikoro>
References: <20260921144426.1083196-1-Frank.Li@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921144426.1083196-1-Frank.Li@oss.nxp.com>


> eviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Missing 'R' at the beginning. checkpatch would have reported this,
please put it in your loop.

