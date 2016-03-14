From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 01/10] pinctrl: sh-pfc: r8a7790: Implement voltage
 switching for SDHI
Date: Mon, 14 Mar 2016 10:47:23 +0100
Message-ID: <CAMuHMdXhw6bPBruU8CLXm72mq6_c6a_8ZPGukdyuMi=HQ4eACA@mail.gmail.com>
References: <1457774112-16958-1-git-send-email-wsa@the-dreams.de>
	<1457774112-16958-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1457774112-16958-2-git-send-email-wsa@the-dreams.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>, Dirk Behme <dirk.behme@gmail.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Mar 12, 2016 at 10:15 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> All the SHDIs can operate with either 3.3V or 1.8V signals, depending
> on negotiation with the card.
>
> Implement the {get,set}_io_voltage operations and set the related
> capability flag for the associated pins.
>
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-gpio@vger.kernel.org

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
