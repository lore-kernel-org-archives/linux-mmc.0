From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] mmc: tmio: enable odd number size access
Date: Wed, 10 Sep 2014 09:11:24 +0200
Message-ID: <CAMuHMdW_xLeP6gxdqs9vx6HnwDUQe_DV31j5Pqd6vZ387+ychw@mail.gmail.com>
References: <8761gwz2jb.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <8761gwz2jb.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Shinobu Uehara <shinobu.uehara.xc@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Morimoto-san,

On Wed, Sep 10, 2014 at 3:29 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> +       if (is_read) {
> +               extra = sd_ctrl_read16(host, CTL_SD_DATA_PORT);
> +
> +               *buf8 = (u8)(extra & 0xff);
> +       } else {
> +               extra = (u16)(*buf8);
> +
> +               sd_ctrl_write16(host, CTL_SD_DATA_PORT, extra);

The casts to "u8" resp. "u16" are not needed.

You can even avoid introducing the "extra" variable:

if (is_read)
        *buf8 = sd_ctrl_read16(host, CTL_SD_DATA_PORT) & 0xff;
else
        sd_ctrl_write16(host, CTL_SD_DATA_PORT, *buf8);

Technically, the "& 0xff" is also not needed, but I'd keep it for clarity.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
