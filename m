From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 0/3] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Thu, 12 May 2016 14:53:46 +0200
Message-ID: <CAMuHMdWP3d20+gQ8Ma78FOk3B1vnwaTcQHHuHDiQs_m6jOF6vg@mail.gmail.com>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
	<SG2PR06MB09190A986DDC6D2220603AA6D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
	<CAMuHMdWKu7wLDthh2QXKJBS_a7yz38HFbi4wSLMnWV0Y5qbbbQ@mail.gmail.com>
	<SG2PR06MB0919A06B80C8231816200645D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
	<CAMuHMdVmA7t3k+56yP9n++WGRqLy1pkbtmpe+SmJRaDJmU04zA@mail.gmail.com>
	<SG2PR06MB0919E39A668AD2ECA9DEE018D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
	<CAMuHMdWaZ-sbx3JXc2h59R6OzkiKnmbmPDaSKZ+4aRie0YMYuA@mail.gmail.com>
	<SG2PR06MB0919824AFCAE20C395E50738D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
	<CAMuHMdW_VkpjoLyXOvbdwwm=h5L8A8JrGKf_P6ig_pBqM-tGtw@mail.gmail.com>
	<20160512124139.GC1638@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160512124139.GC1638@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

On Thu, May 12, 2016 at 2:41 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> As the sdhi0 MSTP clock is still enabled, there must be an unknown clock that's
>> needed for proper operation, but that's currently not controlled by software.
>
> I'd guess the SCC needs a seperate clock?

Probably, but this is not documented in the datasheet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
