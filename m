From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC v2 06/11] mmc: tmio-mmc: define device-tree bindings
Date: Thu, 24 Jan 2013 16:34:45 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1301241630160.7826@axis700.grange>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
 <1358955158-1510-7-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1358955158-1510-7-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

After an internal discussion it occurred to us, that this binding

On Wed, 23 Jan 2013, Guennadi Liakhovetski wrote:

[snip]

> +- toshiba,mmc-cap-sdio-irq	: SDIO IRQ signalling should be used, if
> +	supported by the hardware, i.e. set MMC_CAP_SDIO_IRQ if
> +	TMIO_MMC_SDIO_IRQ is also set

actually isn't tmio-mmc specific, so, it can be moved to [1] as

+- cap-mmc-sdio-irq: SDIO IRQ is supported on this hardware

Chris, what do you think?

[1] http://www.spinics.net/lists/linux-mmc/msg18625.html

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
