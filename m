From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 00/22] mmc: tmio: various fixes and cleanups
Date: Tue, 28 Nov 2017 11:18:04 +0900
Message-ID: <CAK7LNAQggGy8xMdURXMNEd_vHCWBVpUYp=H2jP=KGt63HBT5tg@mail.gmail.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com> <20171127171324.sprmzsu4dkeo3gon@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-02.nifty.com ([210.131.2.81]:17340 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753527AbdK1CSt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Nov 2017 21:18:49 -0500
In-Reply-To: <20171127171324.sprmzsu4dkeo3gon@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Wolfram,


2017-11-28 2:13 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> I am getting more and more patches for TMIO.
>> I put all in a single series to clarify the patch order.
>
> Hmmm, that makes reviewing harder in my opinion.


I think this depends on people.

You are the maintainer of TMIO MMC, so
I will try my best to adjust to your opinion next time.



> I really liked the small serieses which could be improved, acked, and
> applied. This big one will take much longer to review and resending will
> cause quite some noise.
>
> For clarifying patch order in small series, it should be enough to state
> the dependencies in the cover letter. Super helpful is providing a
> public git branch where ppl can pull from.
>
> Also, can you state what kind of testing you did on what platforms?

I have no Renesas boards.

I tested this series on UniPhier boards.
(arch/arm/boot/dts/uniphier*.dts,  arch/arm64/boot/dts/socionext/uniphier*.dts)


> My
> gut feeling says that the card detect changes might be easy to catch
> regressions on old platforms, so we'd need to be extra cautious. I/we
> can do testing on some Renesas platforms, too.
>
> Other changes like moving stuff from tmio_core to renesas_sdhi is less
> critical. Either it works or not, so that is easy to spot :)
>
> Which might be another argument for multiple smaller patch series.
>
> Nonetheless, I'll try to get this reviewed in the next days...

Thanks!


> All the best,
>
>    Wolfram
>
>
-- 
Best Regards
Masahiro Yamada
