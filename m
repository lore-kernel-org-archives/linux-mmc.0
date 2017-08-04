From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] mmc: mmci_qcom_dml: include mmci_qcom_dml.h and fix #ifdef
Date: Sat, 5 Aug 2017 00:10:29 +0200
Message-ID: <CAK8P3a0r7jPBF_eAMrm7u-3N224zPsd4k=SeAqXFVViXBUOhnw@mail.gmail.com>
References: <1501853664-10752-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501853664-10752-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 4, 2017 at 3:34 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Include mmci_qcom_dml.h from mmci_qcom_dml.c to fix the following
> sparse warnings:
>
>   CHECK   drivers/mmc/host/mmci_qcom_dml.c
> drivers/mmc/host/mmci_qcom_dml.c:57:6: warning: symbol 'dml_start_xfer' was not declared. Should it be static?
> drivers/mmc/host/mmci_qcom_dml.c:122:5: warning: symbol 'dml_hw_init' was not declared. Should it be static?
>
> Fixing them causes redefintion of dml_start_xfer error, revealing another
> problem in the header.  #ifdef CONFIG_MMC_QCOM_DML is wrong because this
> driver is tristate.  (CONFIG_MMC_QCOM_DML_MODULE is defined when it is
> built as a module)
>
> Since dml_hw_init() is called from mmci.c, IS_REACHABLE() is needed to
> cater to all the combinations.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I think this is still not a good solution, it will just turn a link error into
an unusable system at runtime when the DML code is a loadable module
but not used. Also, the symbols are not exported, so it won't work when both
are built as modules.
How about linking the DML code into the mmci module and making that
Kconfig option a 'bool'?

Another small problem I found is the use of writel_relaxed() that might
be unsafe here and is not explained anywhere.

Finally, I can't find any record of the 9cb15142d0e3 ("mmc: mmci:
Add qcom dml support to the driver.") patch in the archives of the relevant
mailing lists I'm subscribed to (linux-mmc, linux-kernel or linux-arm-kernel).

Was it posted there recently? Was Russell on Cc on the patch?
The only record I find using google is for the patch from 2014, in
https://patchwork.kernel.org/patch/4638221/ Ulf said he queued the
patch for linux-3.18.

      Arnd
