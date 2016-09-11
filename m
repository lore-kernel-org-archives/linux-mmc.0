From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Sun, 11 Sep 2016 10:09:42 +0200
Message-ID: <CAMuHMdXihVRcmn2Ep0cRdg2U0=boJohxzzL1=32Ek+17ivTwWg@mail.gmail.com>
References: <20160909155238.17852-1-chris.brandt@renesas.com> <20160909155238.17852-3-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33090 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbcIKIKS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Sep 2016 04:10:18 -0400
In-Reply-To: <20160909155238.17852-3-chris.brandt@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Fri, Sep 9, 2016 at 5:52 PM, Chris Brandt <chris.brandt@renesas.com> wrote:
> For the r7s72100 SOC, the DATA_PORT register was change to be 32-bits wide.

changed

> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h

> @@ -259,4 +265,10 @@ static inline void sd_ctrl_write32_as_16_and_16(struct tmio_mmc_host *host, int
>         writew(val >> 16, host->ctl + ((addr + 2) << host->bus_shift));
>  }
>
> +static inline void sd_ctrl_write32_rep(struct tmio_mmc_host *host, int addr,
> +               u32 *buf, int count)

const u32 *buf

> +{
> +       writesl(host->ctl + (addr << host->bus_shift), buf, count);
> +}
> +

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
