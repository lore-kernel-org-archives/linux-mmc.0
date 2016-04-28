From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/6] mmc: sh_mobile_sdhi: remove obsolete irq_by_name registration
Date: Thu, 28 Apr 2016 10:03:05 +0200
Message-ID: <CAMuHMdW=CRZ-EY0+2aq90JYKkYyfLhWt8o=Anpjb9JxD5TDkpw@mail.gmail.com>
References: <1459934734-3613-1-git-send-email-wsa@the-dreams.de>
	<1459934734-3613-3-git-send-email-wsa@the-dreams.de>
	<CAPDyKFqixO2EGxdx4ERy=DSTR+KBunrYyfR26+AYN0k5_dVHiw@mail.gmail.com>
	<20160419093713.GC1521@katana>
	<20160427225457.GV21636@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160427225457.GV21636@brightrain.aerifal.cx>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rich Felker <dalias@libc.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Ulf Hansson <ulf.hansson@linaro.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Rich,

On Thu, Apr 28, 2016 at 12:54 AM, Rich Felker <dalias@libc.org> wrote:
> Hi! Sorry I didn't notice this before. I saw sh_mobile in the subject
> lines and guessed it was not making changes in arch/sh.

Yeah, it's confusing that "SH-Mobile" was used for both SH (only) and
ARM (+SH ;-) SoCs.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
