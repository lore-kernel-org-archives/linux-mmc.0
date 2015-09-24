From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] tmio_mmc_pio: test TMIO_MMC_WRPROTECT_DISABLE earlier
Date: Thu, 24 Sep 2015 09:04:20 +0200
Message-ID: <CAMuHMdUicoDv-MROEVGqsM-o7hiCqBdkjK3Tn45zE0r5Z1hofQ@mail.gmail.com>
References: <1513691.2yatcrs42i@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1513691.2yatcrs42i@wasted.cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Ian Molton <ian@mnementh.co.uk>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 24, 2015 at 1:58 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> There seems  to be no sense in the runtime PM calls when the actual register
> read is suppressed by the TMIO_MMC_WRPROTECT_DISABLE flag.  Check that flag
> before trying to read the register and  thus doing the runtime PM dance...
>
> While at it, kill useless local variable and add empty line after declarations.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
