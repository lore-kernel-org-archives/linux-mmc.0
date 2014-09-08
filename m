From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: tmio: enable odd number size transfer
Date: Mon, 8 Sep 2014 09:49:20 +0200
Message-ID: <CAMuHMdVqFvgPBVenEnoRfpDyMSc_z+9EEF19VHM8CESXmBwFMQ@mail.gmail.com>
References: <87wq9eohuc.wl%kuninori.morimoto.gx@gmail.com>
	<CAMuHMdUJK1Mmd_S+-hGFoshgRbpHKG5OH2w7AFHNaQG5qyvNaw@mail.gmail.com>
	<87r3zmo969.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87r3zmo969.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Morimoto-san,

On Mon, Sep 8, 2014 at 9:36 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>  > +       buf8 = (u8 *)(buf + ((count - 1) >> 1));
>>
>> The "-1" is not really needed.
>
> This -1 is needed.
>
> We want to have...
> count - offset
> 1       0
> 2       0
> 3       1
> 4       1
> ...

If count is even, we never get that far, so the even numbers should not
be present in your table above?

If count is odd, "(count - 1) >> 1 == count >> 1".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
