From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 4/6] mmc: tmio: move mmc_host_ops to struct tmio_mmc_host
 from static data
Date: Thu, 23 Nov 2017 13:18:57 +0900
Message-ID: <CAK7LNAT7FR1Eu3MuzO32vESB7y0xqgwHfggkS0dkjGOgFudz9Q@mail.gmail.com>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
 <1510042172-27220-5-git-send-email-yamada.masahiro@socionext.com> <20171120204834.c4ckog3rxeeojh2b@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171120204834.c4ckog3rxeeojh2b@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

2017-11-21 5:48 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> +     struct mmc_host_ops     mmc_host_ops;
>
> Just came to think of it: maybe a shorter name?
>
>  host->ops
>
> is still nicely readable, I'd think...
>

I just thought it should be clear which ops,
but nobody would be confused with "dma_ops".

OK, I will rename it to "ops" in v2.



-- 
Best Regards
Masahiro Yamada
