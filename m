From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] mmc: mmci_qcom_dml: include mmci_qcom_dml.h and fix #ifdef
Date: Sun, 6 Aug 2017 22:41:42 +0200
Message-ID: <CAK8P3a1K7hCejjFQhnS8tbLP0+dZH15W1bzUCZpP-SHtyJaaAQ@mail.gmail.com>
References: <1501853664-10752-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a0r7jPBF_eAMrm7u-3N224zPsd4k=SeAqXFVViXBUOhnw@mail.gmail.com> <3b5755df-b94b-741e-81d1-9a13c6f18fd1@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3b5755df-b94b-741e-81d1-9a13c6f18fd1@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: linux-mmc@vger.kernel.org

On Sun, Aug 6, 2017 at 12:26 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 04/08/17 23:10, Arnd Bergmann wrote:
>>
>> How about linking the DML code into the mmci module and making that
>> Kconfig option a 'bool'?
>
>
>
> Yes, I think making this bool and exporting the two symbols should fix this.
> It does not make sense to make dml helpers a module anyway.
>
> If it sounds okay, I can send a proper patch to fix this.

I would say making dml a 'bool' option is not ok unless you also change
the Makefile to link it into the same module as the base mmci driver.

The alternative is to export the symbols and then always build the
dml code as a module when the mmci driver is a module, as below.

Or even just move all the code into the base driver, and call it only
using an if(IS_ENABLED()) check for the bool symbol.

       Arnd

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 8c46766c000c..5c996cba9f25 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -3,7 +3,9 @@
 #

 obj-$(CONFIG_MMC_ARMMMCI) += mmci.o
-obj-$(CONFIG_MMC_QCOM_DML) += mmci_qcom_dml.o
+ifdef CONFIG_MMC_QCOM_DML
+obj-$(CONFIG_MMC_ARMMMCI) += mmci_qcom_dml.o
+endif
 obj-$(CONFIG_MMC_PXA) += pxamci.o
 obj-$(CONFIG_MMC_MXC) += mxcmmc.o
 obj-$(CONFIG_MMC_MXS) += mxs-mmc.o
