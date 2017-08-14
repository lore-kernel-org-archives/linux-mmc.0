From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: renesas_sdhi: use extra flag for CBSY usage
Date: Mon, 14 Aug 2017 17:00:04 +0200
Message-ID: <CAMuHMdW+HtXwtYbOrHToWc80q+B=v_4s-8Vb8WhP4akeFY31uQ@mail.gmail.com>
References: <20170809190041.1052-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170809190041.1052-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>, Chris Brandt <chris.brandt@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

On Wed, Aug 9, 2017 at 9:00 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> There is one SDHI instance on Gen2 which does not have the CBSY bit.
> So, turn CBSY usage into an extra flag and set it accordingly. This has
> the additional advantage that we can also set it for other incarnations
> later.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Tested on a M3-W Salvator-X and H2 Lager (with both SDHI instances). I could
> move large files around without problems. Note that on the special incarnation
> without the CBSY bit, the old code still worked, so there might be a CBSY bit.
> But it is not documented, so we better play safe.

Is this supposed to have any impact on the issue on Magnus' r8a7794/alt, where
tuning failed before?

    sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
    sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
    sh_mobile_sdhi ee100000.sd: Tuning procedure failed
    mmc1: tuning execution failed: -110
    mmc1: error -110 whilst initialising SD card

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
