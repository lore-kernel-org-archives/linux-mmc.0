From: Paul Parsons <lost.distance@yahoo.com>
Subject: Re: [PATCH] mmc: tmio: Fix build errors
Date: Mon, 16 May 2011 22:49:04 +0100 (BST)
Message-ID: <642193.81570.qm@web29001.mail.ird.yahoo.com>
References: <Pine.LNX.4.64.1105162306110.29373@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from nm4-vm0.bullet.mail.ird.yahoo.com ([77.238.189.211]:45367 "HELO
	nm4-vm0.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755136Ab1EPVzT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 May 2011 17:55:19 -0400
In-Reply-To: <Pine.LNX.4.64.1105162306110.29373@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, ian@mnementh.co.uk

> NAK. Are you trying to use DMA with TMIO on your platform?

Not that I am aware of.

> Then this is a 
> wrong fix. Otherwise tmio_mmc_dma.c shouldn't be compiled
> on your arch at 
> all.

Then this must be is a config or Makefile bug, because the build is certainly trying to compile tmio_mmc_dma.c

Looking at drivers/mmc/host/Makefile:

ifneq ($(CONFIG_MMC_SDHI),n)
tmio_mmc_core-y                 += tmio_mmc_dma.o
endif

My config doesn't define CONFIG_MMC_SDHI at all, thus the Makefile adds tmio_mmc_dma.o to the build?

Regards,
Paul
