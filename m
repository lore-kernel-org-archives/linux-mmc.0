From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 0/6] UHS-I support for sh_mobile_sdhi
Date: Sun, 14 Jun 2015 09:36:53 +0200
Message-ID: <CAMuHMdXdKWKQshRk9QzAncGy1zyDYRMbhjYYEg2CPYc=PtD6QQ@mail.gmail.com>
References: <1433892104.12074.49.camel@codethink.co.uk>
	<CAPDyKFq+fZrH1hMdMd8FEzy8h1U9pu8PbaMQtBDOEe+UySqJkA@mail.gmail.com>
	<1433980677.12074.74.camel@codethink.co.uk>
	<20150611024938.GB6904@verge.net.au>
	<1434034924.26252.10.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1434034924.26252.10.camel@codethink.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Simon Horman <horms@verge.net.au>, Ulf Hansson <ulf.hansson@linaro.org>, Ian Molton <ian@mnementh.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 11, 2015 at 5:02 PM, Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>> I may be misunderstanding the above, if so I apologise, but I would
>> strongly prefer to avoid an arrangement where the kernel and device tree
>> blob (DTS/DTSI -> DTB) need to be upgrade in lock-step as this tends not to
>> lead to a good experience for users.
>
> I agree.
>
>> My preference would be to maintain
>> backwards and forwards compatibility and if appropriate schedule removal of
>> such compatibility.
> [...]
>
> The problem is that the 'sd-uhs-sdr50' property is interpreted by the
> MMC core, so I think it will start trying to use this mode even if the
> driver hasn't implemented the necessary operations.  I don't see any way
> around that.

Can't the core check for driver capabilities?
I'm not familiar with the MMC core, but e.g. the SPI core only tries modes
that match both SPI master (spi_master.mode_bits) and slave (spi_device.mode).

> The regression is relatively minor as I think the MMC core will fall
> back to a lower speed after failing to enable SDR50.  But it will slow
> down probing of a card.

So it does fall back (after a while). That's good.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
