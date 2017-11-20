From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 2/6] mmc: tmio: set tmio_mmc_host to driver data
Date: Mon, 20 Nov 2017 18:30:12 +0900
Message-ID: <CAK7LNARsiyNegE-jFg1hi66+eW_jeK2h+QKWpoUs6RLweQVTKQ@mail.gmail.com>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
 <1510042172-27220-3-git-send-email-yamada.masahiro@socionext.com>
 <20171119194930.npqfzqvmh4zbcb34@tetsubishi> <CAK7LNAQZQ13O1pSd5Ah7VDWrZF1MSkLT_QoTDS+uT7C-r09b+g@mail.gmail.com>
 <20171120092023.nc3oxnawxqwa3ofs@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:61759 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdKTJa5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Nov 2017 04:30:57 -0500
In-Reply-To: <20171120092023.nc3oxnawxqwa3ofs@tetsubishi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

2017-11-20 18:20 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> Yamada-san,
>
>> My best guess is unnecessary if-conditional was added
>> and overlooked in the review process.
>
> I agree.
>
> So, from visual review, most patches look good to me. I will give them
> testing on HW this evening and add my Reviewed-by tags then. I'll also
> reply to the driver rename thread later today.
>
> Thanks!
>
>    Wolfram
>

Last week I was working on the TMIO driver
and I have more bug-fix and clean-up patches in hand now.
(about 20 patches)

The patch order is getting a mess,
so I am planning to put all patches in one series.

If not in hurry, can you wait for a little?





-- 
Best Regards
Masahiro Yamada
