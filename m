From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/6] mmc: renesas_sdhc: remove eprobe jump label
Date: Tue, 21 Nov 2017 12:03:33 +0900
Message-ID: <CAK7LNASRK+2vr2TSB-M7OM0NWehEM58pZc_8g2reLHDCx26x1Q@mail.gmail.com>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
 <1510042172-27220-2-git-send-email-yamada.masahiro@socionext.com> <20171120203125.nbtaeqpwk4zg6fxz@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83]:47082 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752262AbdKUDE1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Nov 2017 22:04:27 -0500
In-Reply-To: <20171120203125.nbtaeqpwk4zg6fxz@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

2017-11-21 5:31 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> -             ret = PTR_ERR(priv->clk);
>> -             dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
>> -             goto eprobe;
>> +             dev_err(&pdev->dev, "cannot get clock\n");
>> +             return PTR_ERR(priv->clk);
>
> Why dropping the 'ret' printout? Will it be printed by the core?
>

No.
I just wanted to save "ret = PTR_ERR(priv->clk)" line.


I will restore the printout as follows:

priv->clk = devm_clk_get(&pdev->dev, NULL);
if (IS_ERR(priv->clk)) {
        ret = PTR_ERR(priv->clk);
        dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
        return ret;
}



-- 
Best Regards
Masahiro Yamada
