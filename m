From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/9] mmc: tmio, sh_mobile_sdhi: Add support for
 variable input clock frequency
Date: Mon, 18 Apr 2016 09:33:57 +0200
Message-ID: <CAMuHMdV9s54iTPdv6kw=J5tdn6N5mp9oKWe4rrQf==hOHhGSyg@mail.gmail.com>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
	<1459525479-20842-3-git-send-email-wsa@the-dreams.de>
	<CAMuHMdWdJ2AoCrwC5K2QEfuf=w=q8=XnJRzoyg99EurJBDwbTg@mail.gmail.com>
	<1460477978.32355.14.camel@codethink.co.uk>
	<20160415202803.GA3105@katana>
	<20160415204156.GB3105@katana>
	<20160417124902.GB4954@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:35127 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbcDRHd6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2016 03:33:58 -0400
In-Reply-To: <20160417124902.GB4954@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>, Linux MMC List <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Sun, Apr 17, 2016 at 2:49 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Fri, Apr 15, 2016 at 10:41:57PM +0200, Wolfram Sang wrote:
>> > > That seems like a bug in the clock driver.  If it doesn't have
>> > > independent dividers for each clock client then it shouldn't allow any
>> > > client to change the frequency.
>>
>> So, we need MSTP clocks which do not use CLK_SET_RATE_PARENT on r8a7740.
>> Probably the best way is to use the "renesas,r8a7740-mstp-clocks"
>> compatible entry to determine the difference? Geert?
>
> Well, I like the idea of a virtual sd clock even better. I sent a series
> doing that a minute ago to the renesas-soc list.

While I don't doubt the "virtual sd" clock will work, this doesn't match the
hardware, so I have to object against it.

Hence I think it should be handled in the driver. This is indeed more difficult
to do with clk-mstp.c than with renesas-cpg-mssr.c...

BTW, this behavior seems to be introduced by
commit e44df332f30bf3040c60c1ed6674d1431fdb48b9
Author: Ben Dooks <ben.dooks@codethink.co.uk>
Date:   Mon Mar 31 18:47:27 2014 +0100

    clk: shmobile: fix setting paretn clock rate

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
