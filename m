From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Possible regression due to "arm64: renesas: salvator: set driver
 type for eMMC"
Date: Mon, 4 Dec 2017 10:04:05 +0100
Message-ID: <CAMuHMdV8OYFq_EdO2fw-KZJP6qPuCpFGO0ZkueSKOGZXnC9HRg@mail.gmail.com>
References: <20171130161759.47tjyfqefoffpus3@verge.net.au> <20171201110632.odbk2iocniyiiqek@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171201110632.odbk2iocniyiiqek@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Simon Horman <horms@verge.net.au>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Dec 1, 2017 at 12:06 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> While I think it could be that the early ES1.0 boards might have different eMMC
> chips...

FTR, my boards have:

Salvator-X with H3 ES1.0:
    mmc0: new HS200 MMC card at address 0001
    mmcblk0: mmc0:0001 BGSD3R 29.1 GiB

Salvator-X with M3-W ES1.0:

    mmc0: new HS200 MMC card at address 0001
    mmcblk0: mmc0:0001 eMMC   28.8 GiB

Salvator-XS with H3 ES2.0:

    mmc0: new HS200 MMC card at address 0001
    mmcblk0: mmc0:0001 BGSD3R 29.1 GiB

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
