From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v8 6/6] mmc: sh_mobile_sdhi: Add tuning support
Date: Wed, 11 Jan 2017 16:59:41 +0100
Message-ID: <CAMuHMdV5pY+nRC8yd4iVmEJAZkcBgWC2-wDr6UgpmxZSsoPHcA@mail.gmail.com>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
 <1478182564-18762-7-git-send-email-horms+renesas@verge.net.au>
 <20170110210848.GA25542@bigcity.dyn.berto.se> <20170110223043.GA2710@katana>
 <20170111083541.GB25542@bigcity.dyn.berto.se> <20170111150521.GA1486@katana> <20170111155723.GE25542@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36610 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030569AbdAKP7n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2017 10:59:43 -0500
In-Reply-To: <20170111155723.GE25542@bigcity.dyn.berto.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Ai Kyuse <ai.kyuse.uw@renesas.com>

On Wed, Jan 11, 2017 at 4:57 PM, Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
> On 2017-01-11 16:05:21 +0100, Wolfram Sang wrote:
>> I wanted to do some TDSEL testing on other Gen2 boards in Brussels,
>> provided that people could bring some. So, if you could bring that
>> Koelsch board, that would be really helpful.
>
> Sure, can you or someone else bring a power source? I plan to not check
> luggage so everything to conserve space helps :-)

I also have a koelsch, so no need to take one on a plane ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
