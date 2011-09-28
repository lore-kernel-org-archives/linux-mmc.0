From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/3] mmc: mmci: Provide option to configure bus signal direction
Date: Wed, 28 Sep 2011 07:25:49 +0200
Message-ID: <CACRpkdbUO96VerVShwWfd99245T90JcEGcO0PXCy80PLPLygQg@mail.gmail.com>
References: <1317123738-29867-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:47504 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab1I1FZu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2011 01:25:50 -0400
Received: by pzk1 with SMTP id 1so19423687pzk.1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2011 22:25:49 -0700 (PDT)
In-Reply-To: <1317123738-29867-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Lee Jones <lee.jones@linaro.org>, Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>

On Tue, Sep 27, 2011 at 1:42 PM, Ulf Hansson <ulf.hansson@stericsson.co=
m> wrote:

> @@ -30,6 +43,8 @@ struct dma_chan;
> =A0* @cd_invert: true if the gpio_cd pin value is active low
> =A0* @capabilities: the capabilities of the block as implemented in
> =A0* this platform, signify anything MMC_CAP_* from mmc/host.h
> + * @sigdir: a bit field indicating for what bits in the MMC bus the =
host
> + * should enable signal direction indication.
> =A0* @dma_filter: function used to select an appropriate RX and TX
> =A0* DMA channel to be used for DMA, if and only if you're deploying =
the
> =A0* generic DMA engine
> @@ -52,6 +67,7 @@ struct mmci_platform_data {
> =A0 =A0 =A0 =A0int =A0 =A0 gpio_cd;
> =A0 =A0 =A0 =A0bool =A0 =A0cd_invert;
> =A0 =A0 =A0 =A0unsigned long capabilities;
> + =A0 =A0 =A0 unsigned int sigdir;

u32 again, no big deal. Can be fixed when submitting it to the patch tr=
acker.
Acked-by.

Yours,
Linus Walleij
