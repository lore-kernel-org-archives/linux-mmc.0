From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH mmc/next] mmc: sh_mobile_sdhi: remove support for sh7372
Date: Thu, 24 Nov 2016 11:53:30 +0100
Message-ID: <CAMuHMdU4Pj99NF4xLHqa4fjEVSyMtFDqN8Y2jKpGU+BsGrQ+vg@mail.gmail.com>
References: <1479984534-25468-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1479984534-25468-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 24, 2016 at 11:48 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Remove documentation of support for the SH7372 (SH-Mobile AP4) from the MMC
> driver. The driver itself appears to have no SH7372 specific code.
>
> Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy file")
> removes this SoC from the kernel in v4.1.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
