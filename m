From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2] mmc: mmci_qcom_dml: include mmci_qcom_dml.h and fix #ifdef
Date: Sun, 6 Aug 2017 11:58:38 +0900
Message-ID: <CAK7LNAR8Kqnb18D2UYto5R1CLrMx_YgJMmKOm7OsiOgd7XcWbA@mail.gmail.com>
References: <1501853664-10752-1-git-send-email-yamada.masahiro@socionext.com> <CAK8P3a0r7jPBF_eAMrm7u-3N224zPsd4k=SeAqXFVViXBUOhnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0r7jPBF_eAMrm7u-3N224zPsd4k=SeAqXFVViXBUOhnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Arnd,



2017-08-05 7:10 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Fri, Aug 4, 2017 at 3:34 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Include mmci_qcom_dml.h from mmci_qcom_dml.c to fix the following
>> sparse warnings:
>>
>>   CHECK   drivers/mmc/host/mmci_qcom_dml.c
>> drivers/mmc/host/mmci_qcom_dml.c:57:6: warning: symbol 'dml_start_xfer' was not declared. Should it be static?
>> drivers/mmc/host/mmci_qcom_dml.c:122:5: warning: symbol 'dml_hw_init' was not declared. Should it be static?
>>
>> Fixing them causes redefintion of dml_start_xfer error, revealing another
>> problem in the header.  #ifdef CONFIG_MMC_QCOM_DML is wrong because this
>> driver is tristate.  (CONFIG_MMC_QCOM_DML_MODULE is defined when it is
>> built as a module)
>>
>> Since dml_hw_init() is called from mmci.c, IS_REACHABLE() is needed to
>> cater to all the combinations.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> I think this is still not a good solution, it will just turn a link error into
> an unusable system at runtime when the DML code is a loadable module
> but not used. Also, the symbols are not exported, so it won't work when both
> are built as modules.
> How about linking the DML code into the mmci module and making that
> Kconfig option a 'bool'?


You are right.
My patch does not solve the root of the problem.

It turned out not so trivial as I had first expected.

I'd like somebody else to take care of it
because I am not familiar with this driver.

(My first motivation was clean-up sparse reports,
and I thought it was easy to fix it, but it was not.)




-- 
Best Regards
Masahiro Yamada
