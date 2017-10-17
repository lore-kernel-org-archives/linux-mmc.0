From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] mmc: renesas_sdhi: fix kernel panic in _internal_dmac.c
Date: Tue, 17 Oct 2017 10:11:14 +0200
Message-ID: <CAMuHMdUx+4PpZ6vzRjqV0gtknMBT7VHV=dW4wqt=8s8HZRrkuw@mail.gmail.com>
References: <1508225421-25405-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1508225421-25405-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45859 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759234AbdJQILQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Oct 2017 04:11:16 -0400
In-Reply-To: <1508225421-25405-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Shimoda-san,

On Tue, Oct 17, 2017 at 9:30 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Since this driver checks if the return value of dma_map_sg() is minus
> or not and keeps to enable the DMAC, it may cause kernel panic when
> the dma_map_sg() returns 0. So, this patch fixes the issue.

Thanks for your patch!

Indeed:

 * dma_maps_sg_attrs returns 0 on error and > 0 on success.
 * It should never return a value < 0.

A quick grep shows there are 4 more offenders:

  - drivers/crypto/qce/ablkcipher.c
  - drivers/crypto/qce/sha.c
  - drivers/hsi/controllers/omap_ssi_port.c
  - drivers/mailbox/bcm-flexrm-mailbox.c

> Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
> Fixes: 2a68ea7896e3 ("mmc: renesas-sdhi: add support for R-Car Gen3 SDHI DMAC")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
