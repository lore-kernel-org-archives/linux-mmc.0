From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: sh_mmcif: Use platform_get_irq_optional() for
 optional interrupt
Date: Wed, 2 Oct 2019 11:14:02 +0200
Message-ID: <CAMuHMdXo0knrst754b7rvBRGC8kBxO7PLJ2XR6E2-q6wumBSGQ@mail.gmail.com>
References: <20191001180834.1158-1-geert+renesas@glider.be>
 <20191002081553.GB1388@ninjato> <TYAPR01MB454472C76E03930717A2898BD89C0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CAMuHMdWBghL8Em0OoCKjJdU7OiY_pV3Lmc=SXhV2yY=sKJJ-aw@mail.gmail.com> <20191002085805.GA10270@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002085805.GA10270@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jiri Slaby <jslaby@suse.com>, Stephen Boyd <swboyd@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

On Wed, Oct 2, 2019 at 10:58 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > Please cherry-pick the top commit from renesas-devel:
> > 6e47c841329eb9b0 ("ARM: fix __get_user_check() in case uaccess_* calls
> > are not inlined")
>
> Thanks a lot, Geert. I can confirm this patch fixes the issue I was
> seeing:
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Could you kindly forward this tag to Yamada-san or bounce me the patch
> so I can do it?

Please check your linux-renesas-soc folder.  I CCed the list when providing
my own Tested-by yesterday.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
