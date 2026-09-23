Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210353C3CA;
	Wed, 23 Sep 2026 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190195; cv=none; b=MIttRHRKHH6kp+An6TGbVYrbX0R13+XGX3xGBVlqMuDQLQ0BtNjDed5U9tTYq6g4/U/HorIWdWw/P3UMKvMZGVxVWw1coAsug8Be9WM4HZP4syLZEluKCPQFr5ChaEJJTZKAF8IKow/BlpvSdGYbs8Mw2LoUFhGAV2FpZCuDtJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190195; c=relaxed/simple;
	bh=zY87RtlLPK8yIdO0NkWUdPlj4zkrNvjshGOoPe2ast4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gm6obq5zDsfroVcwTz3YvEHIeQ4DqD6d8p1+gz6wPkTW97qaP4R5NNy24IXSV1Ks/YgsSnlL4yVuh8cVikHikPb3+hVrXg9IhEdMv+u8fmPqw4W69DGcJKbq6ECllfxOTNFuwrJ3D5ewJZnOwqzxGSppQUsOidIgVjLm9r6++8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IDRkDSoJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nD4RaA0f; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IDRkDSoJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nD4RaA0f"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.stl.internal (Postfix) with ESMTP id F2F641301215;
	Wed, 23 Sep 2026 15:01:03 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 23 Sep 2026 15:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790190063;
	 x=1790197263; bh=hcQ0zZYFtOWbyNLllffwwJ/lu4ZJG+97VXa6lE7SnM0=; b=
	IDRkDSoJ0PsJcN0kahnvE1FolgvnKt82Ru7o65AFx38GmCSpgcfQ/O7Yp2Eh8hdY
	ldddrR8ECxO2BGN1U3h2eEvq+eCaPtOwY8mqGFXQGLV9LSroKU31zTNNYFrg0yrp
	4ogATQBj6iq/DqQUwXGo73m7DbsTBRV9nFP+cT+ppv6p9XHBPkMOU7J4TO3vL2NX
	rBAR/pL9H96xrJPCUgvYqs2DXnNFsexccBOxrneUubThrfvncrE7KLd4ze+XWjau
	vnQCzYQxfU1hg3K6QoePzENxk6oGfc1qAqdozeb6Z0ny5mvVFUZWK6gO6fS+6Dv0
	ftVbpxeXpVAUSNm7UPNLwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790190063; x=1790197263; bh=h
	cQ0zZYFtOWbyNLllffwwJ/lu4ZJG+97VXa6lE7SnM0=; b=nD4RaA0fiigl8oPUu
	U5nViYsdzXJwxIW1IxdXujRi6W/kJVkK2V8Ow5XlJ+ndbNP3AkdsBqiMLzWrdAD6
	1Ji+ORk1NmH3VnqIsGSMCmjtXm3MqVLRQ0fU4QWg4MU2cfXdGxc82piTpl9OB0I3
	IE9HwyWwscVh8y5OQzyn40CseQQVYa/j2D9yjUWawWL9T4+4WLJzjpZv6lS2TrPv
	dfuUBzmLUNLhTTDzpdH4Sb3YTc5qXiRupi6unu10r5vczg1jimg1HrHdO1s7gzk6
	veXmdNt9cuLuiqpwRReDOBEuVt4voarH3gAPaNkgO/6zD0KTbOJ+su4kkyzxtgkK
	M7svQ==
X-ME-Sender: <xms:2yG0alZ50BYR_r0sz7fnTMFA_3B6_O34h-7MDfKDru8Dmeig5ztTMw>
    <xme:2yG0anPBnU6_DSCQgPmXXoUMrtAfavMurSyaO0jZrAiShTpdySgd04rqz23dsEoGN
    1pnxEEwYi9lFBZdEI10hwSjAIfnNguubTi4RZR14woIY8H3SH_3V5Zp>
X-ME-Proxy-Cause: dmFkZTF5vzQ5F/0RiBISLP5Lbl3Sev9i6TdoIZvw8erxqaoyTywLbMHgcUY8elqXtV34xH
    qmkdS1AQCbTLGhICpeDlpu2qBQRmSQI3rpCZDlfJUgeUeMfAInrSyh8wqmZCQemkgeYWBA
    E9k1kJv0R9XvRbF2AfysPR0H8QMrK23PQ4l3smKVsUbLjANEwjrJUNa3mElGtSzUOQIs+G
    v5CNzka35ypQqEId8xIig2v28UzaNGzxso9y45lOkNQRn6VqNv8cDtwCDcR+azcq8Gl1T/
    eW02P8hyCbpbWhJc51sNJEGlIjQqXiTPH8juj0WL6gn4bjiwea0UVWI2qAfzwcM0C7WgNq
    Whwe9NQ62/g2YNE2nx4vpLCbqSBDNvnlpo63TzWNeD8UTB9WWbq1IBQ3/0/nXPi3UIRzRn
    QGl+K8j8yFqjDukdyj11t2QUjWpUUDXZJLw79Zx6oSU53bz55M7iIaAUJRoYp6vcig/+si
    6wnQvGunknjGYI73+10hTN1hsUlDEc6SHuu1HyFPlq0tiC3VvexxmVbaBk/NrJoYjnDz5r
    BfYrszuSVeu4GnPhYPnsmJyjba2fmhf4iNlGZo8KaPgQlaIUiLrCP3WmexLNIMq0vYIkRx
    xSshkUyrGSwzmIIF8uGrjyh78SP77fnQRwsuE+z358/nfTt8QcCbNNJ9Glww
X-ME-Proxy: <xmx:4yG0agL59bxWuppHYsUKnPlC44-lqlBFHyC3d2JdZ6uWMe_V2Nv1Ew>
    <xmx:4yG0aiPuLt7iYqBkqJB6GjrxJlMzsulxiU4obdn4oSNI-1EexLSxtg>
    <xmx:4yG0ahOM1HB8N5yrKJyUcbPWszL2TCN68Tddc3CHw_Jvwl4oTafFqg>
    <xmx:4yG0aiJpCxZujGK0WG4nSUqdZdyjz6ILmAHhen7jDoHa9XFF0RnPHA>
    <xmx:7yG0anUuvv93AHS7q9Im3hwhcnP55GfFiJf1fNS1mgtO74jxlfyHwFST>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id BCB2732A0087; Wed, 23 Sep 2026 15:00:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARoswzXc42gB
Date: Wed, 23 Sep 2026 20:57:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Frank Li" <Frank.Li@oss.nxp.com>, "Ulf Hansson" <ulfh@kernel.org>,
 "Aubin Constans" <aubin.constans@microchip.com>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Paul Cercueil" <paul@crapouillou.net>,
 "Russell King" <linux@armlinux.org.uk>, "Frank Li" <Frank.Li@nxp.com>,
 "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 "Manivannan Sadhasivam" <mani@kernel.org>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "Jesper Nilsson" <jesper.nilsson@axis.com>,
 "Lars Persson" <lars.persson@axis.com>,
 "Johan Hovold" <johan@kernel.org>, "gordon.ge" <gordon.ge@bst.ai>,
 "Vinod Koul" <vkoul@kernel.org>,
 "yangzh0906@thundersoft.com" <yangzh0906@thundersoft.com>,
 "Jared Kangas" <jkangas@redhat.com>, "Brian Masney" <bmasney@redhat.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
 "Linus Walleij" <linusw@kernel.org>, "Fan Wu" <fanwu01@zju.edu.cn>,
 "Rosen Penev" <rosenp@gmail.com>, "Pengpeng Hou" <pengpeng@iscas.ac.cn>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 "Pedro Demarchi Gomes" <pedrodemargomes@gmail.com>,
 "Zhan Xusheng" <zhanxusheng1024@gmail.com>,
 "Pan Chuang" <panchuang@vivo.com>, "Khalid Aziz" <khalid@kernel.org>,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 "Rakuram Eswaran" <rakuram.e96@gmail.com>,
 "Takashi Sakamoto" <o-takashi@sakamocchi.jp>,
 "Runyu Xiao" <runyu.xiao@seu.edu.cn>,
 "Matthew Wilcox" <willy@infradead.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Microchip (AT91) SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:INGENIC JZ47xx SoCs" <linux-mips@vger.kernel.org>,
 "open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..."
 <imx@lists.linux.dev>, Linux-OMAP <linux-omap@vger.kernel.org>,
 "moderated list:ARM/ACTIONS SEMI ARCHITECTURE"
 <linux-actions@lists.infradead.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:ARM/ARTPEC MACHINE SUPPORT" <linux-arm-kernel@axis.com>
Message-Id: <eebb66fa-12e2-4553-8edf-d131b84a8aba@app.fastmail.com>
In-Reply-To: <20260923184612.3583132-1-Frank.Li@oss.nxp.com>
References: <20260923184612.3583132-1-Frank.Li@oss.nxp.com>
Subject: Re: [PATCH v4 1/1] mmc: use dmaengine_get_dma_device() instead of
 chan->device->dev
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 23, 2026, at 20:45, Frank.Li@oss.nxp.com wrote:
> @@ -214,7 +214,7 @@ config MMC_SDHCI_OF_AT91
>  config MMC_SDHCI_OF_ESDHC
>  	tristate "SDHCI OF support for the Freescale eSDHC controller"
>  	depends on MMC_SDHCI_PLTFM
> -	depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE || COMPILE_TEST
> +	depends on PPC || ARCHMXC || ARCH_LAYERSCAPE || COMPILE_TEST
>  	select MMC_SDHCI_IO_ACCESSORS
>  	select FSL_GUTS

This looks like an accidental bug that should be removed from the patch.

> @@ -961,7 +961,7 @@ static void atmci_dma_cleanup(struct atmel_mci *host)
>  	struct mmc_data                 *data = host->data;
> 
>  	if (data)
> -		dma_unmap_sg(host->dma.chan->device->dev,
> +		dma_unmap_sg(dmaengine_get_dma_device(host->dma.chan),
>  				data->sg, data->sg_len,
>  				mmc_get_dma_dir(data));

Since you have the exact construct in a lot of drivers, would
it make sense to take this one step further and introduce
a new set of helpers in drivers/dma/dmaengine.h, such as

unsigned int dmaengine_map_sg(struct dma_chan *chan, struct scatterlist *sg, ...);

      Arnd
