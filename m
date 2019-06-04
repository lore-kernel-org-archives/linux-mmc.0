From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/2] mmc: meson: update with SPDX Licence identifier
Date: Tue, 4 Jun 2019 10:36:53 +0200
Message-ID: <CAMuHMdWHnyTWMToXU_DSezwYs_Lkxj+v0BC8PKXHZgX=e1N3ww@mail.gmail.com>
References: <20190520143647.2503-1-narmstrong@baylibre.com> <CAPDyKFoOHnYiYogjogRr=7PBjqHOseDDS6L0eirTo7Y+F449ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoOHnYiYogjogRr=7PBjqHOseDDS6L0eirTo7Y+F449ow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf, Neil,

On Tue, May 28, 2019 at 10:53 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Mon, 20 May 2019 at 16:36, Neil Armstrong <narmstrong@baylibre.com> wrote:
> > Update the SPDX Licence identifier for the Amlogic MMC drivers.
> >
> > Neil Armstrong (2):
> >   mmc: meson-gx-mmc: update with SPDX Licence identifier
> >   mmc: meson-mx-sdio: update with SPDX Licence identifier
> >
> >  drivers/mmc/host/meson-gx-mmc.c  | 15 +--------------
> >  drivers/mmc/host/meson-mx-sdio.c |  6 +-----
> >  2 files changed, 2 insertions(+), 19 deletions(-)
>
> Applied for next, thanks!

Please note this conflicts with commit 2874c5fd28426836 ("treewide:
Replace GPLv2 boilerplate/reference with SPDX - rule 152") upstream,
which added (different) tags.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
