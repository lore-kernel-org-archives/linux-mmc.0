From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v3] s3cmci: port DMA code to dmaengine API
Date: Mon, 30 Jun 2014 22:03:41 +0300
Message-ID: <CA+E=qVf2QWk+HxPTjwFK8BkD3C+EGbvLDMM4ro1_nYEThe=LtQ@mail.gmail.com>
References: <1401643329-6460-1-git-send-email-anarsoul@gmail.com> <9001585.uuLFNQ0H0y@anarsoul-thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:51739 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbaF3TEC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jun 2014 15:04:02 -0400
Received: by mail-oa0-f53.google.com with SMTP id l6so9334460oag.40
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jun 2014 12:04:01 -0700 (PDT)
In-Reply-To: <9001585.uuLFNQ0H0y@anarsoul-thinkpad>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: arm-linux <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben-linux@fluff.org>

On Mon, Jun 23, 2014 at 2:31 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On 1 June 2014 20:22:09 Vasily Khoruzhick wrote:
> > Utilise new s3c24xx-dma dmaengine driver for DMA ops.
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> > v2: - Don't store async dma descriptor, it's not used
> >     - Request DMA channel via dma_request_slave_channel_compat() and use
> >       hardcoded DMA channel.
> >     - Add dependency on S3C24XX_DMAC (s3cmci uses filter function from it)
> > v3: - Use 'depends' instead of 'select' in Kconfig
> >     - Drop useless controller registers reads from dma completion callback
>
> Ping?

Ping?

> >  drivers/mmc/host/Kconfig  |  10 +--
> >  drivers/mmc/host/s3cmci.c | 180
> > +++++++++++++--------------------------------- drivers/mmc/host/s3cmci.h |
> >  4 +-
> >  3 files changed, 52 insertions(+), 142 deletions(-)
