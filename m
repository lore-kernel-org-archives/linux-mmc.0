From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 04/21] mmc: sh_mmcif: Remove unused ->get_cd() platform callback
Date: Mon, 9 Jan 2017 16:48:35 +0100
Message-ID: <CAMuHMdXG_XaoUpvBcrs7SPbTELSz=4qFyEOYcuF0BOdqGDo8Kw@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
 <1483102054-1752-5-git-send-email-ulf.hansson@linaro.org> <CACRpkdb4Dv9i1JqrdrrhoDO6cP=ygyX+zp14A+n-=Ap9ZxmOGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34297 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034754AbdAIPsh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 10:48:37 -0500
Received: by mail-it0-f65.google.com with SMTP id q186so9710615itb.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2017 07:48:36 -0800 (PST)
In-Reply-To: <CACRpkdb4Dv9i1JqrdrrhoDO6cP=ygyX+zp14A+n-=Ap9ZxmOGg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Wolfram Sang <wsa@sang-engineering.com>, Simon Horman <horms@verge.net.au>

Hi Linus,

On Mon, Jan 9, 2017 at 4:04 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> Removing the callback also enables us to remove the sh_mmcif_get_cd()
>> altogether, as we convert to use mmc_gpio_get_cd() to the same kind of
>> work.
>>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Looks correct, would need a Tested-by ideally?
> Geert can you have a quick look at the Renesas patches in this
> series?

I'm not really into MMC. Wolfram? Simon?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
