From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/9] mmc: tmio, sh_mobile_sdhi: Add support for
 variable input clock frequency
Date: Tue, 26 Apr 2016 12:18:24 +0200
Message-ID: <CAMuHMdUccqGDWRqKhoHO7ED7X_uOk7nX8dKGTJDzTGjLZx-7+Q@mail.gmail.com>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
	<1459525479-20842-3-git-send-email-wsa@the-dreams.de>
	<CAMuHMdWdJ2AoCrwC5K2QEfuf=w=q8=XnJRzoyg99EurJBDwbTg@mail.gmail.com>
	<1460477978.32355.14.camel@codethink.co.uk>
	<20160415202803.GA3105@katana>
	<20160415204156.GB3105@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f196.google.com ([209.85.213.196]:33497 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbcDZKS0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2016 06:18:26 -0400
In-Reply-To: <20160415204156.GB3105@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>, Linux MMC List <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org

Hi Wolfram,

On Fri, Apr 15, 2016 at 10:41 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> > That seems like a bug in the clock driver.  If it doesn't have
>> > independent dividers for each clock client then it shouldn't allow any
>> > client to change the frequency.
>
> So, we need MSTP clocks which do not use CLK_SET_RATE_PARENT on r8a7740.
> Probably the best way is to use the "renesas,r8a7740-mstp-clocks"
> compatible entry to determine the difference? Geert?

To fix this regression in the short term, can we just enable this feature in
the sh_mobile_sdhi driver on SoCs where we know it's safe to change the clock,
i.e. on R-Car Gen2 and H3?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
