From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 02/22] mmc: renesas_sdhi: remove wrong depends on to
 enable compile test
Date: Tue, 5 Dec 2017 13:16:37 +0900
Message-ID: <CAK7LNAQ6bQ98nYj4+7js2f2HOMN1_A0GALYWXLXqabFnvVCUpQ@mail.gmail.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-3-git-send-email-yamada.masahiro@socionext.com> <20171204152533.w5ykfqtkk6kzydet@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-02.nifty.com ([210.131.2.81]:42150 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbdLEER2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Dec 2017 23:17:28 -0500
In-Reply-To: <20171204152533.w5ykfqtkk6kzydet@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

2017-12-05 0:25 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Sat, Nov 25, 2017 at 01:24:37AM +0900, Masahiro Yamada wrote:
>> ARCH_RENESAS is a stronger condition than (ARM || ARM64).
>> If ARCH_RENESAS is enabled, (ARM || ARM64) is met as well.
>>
>> What is worse, the first depends on line prevents COMPILE_TEST from
>> enabling this driver.  It should be removed.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Because COMPILE_TEST now works, buildbot spotted something:
>
> https://www.spinics.net/lists/linux-i2c/msg32556.html
>
> Likely, we should include linux/io.h in the header?
>

Yes.  Can you insert a patch before this one?


-- 
Best Regards
Masahiro Yamada
