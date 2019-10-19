From: "Ezequiel Garcia" <ezequiel.garcia@collabora.com>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPATCH?==?utf-8?q?_6=2F6?==?utf-8?q?_v2=5D?=
 =?utf-8?q?_MMC=3A?==?utf-8?q?_JZ4740=3A?= Add support for
 =?utf-8?q?LPM=2E?=
Date: Sat, 19 Oct 2019 21:44:38 +0100
Message-ID: <47f6-5dab7580-33-5680128@176712317>
References: <5DA9EE2F.4030603@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5DA9EE2F.4030603@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhou Yanjie <zhouyanjie@zoho.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?utf-8?q?linux-mmc=40vger=2Ekernel=2Eorg?= <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Paul Burton <paul.burton@mips.com>, Mark Rutland <mark.rutland@arm.com>, syq@debian.org, Linus Walleij <linus.walleij@linaro.org>, armijn@tjaldur.nl, Thomas Gleixner <tglx@linutronix.de>, YueHaibing <yuehaibing@huawei.com>, Mathieu Malaterre <malat@debian.org>
List-Id: linux-mmc@vger.kernel.org

On Friday, October 18, 2019 13:54 -03, Zhou Yanjie <zhouyanjie@zoho.com> wrote: 
 

> 
> >
> > I also have a general question. Should we perhaps rename the driver
> > from jz4740_mmc.c to ingenic.c (and the file for the DT bindings, the
> > Kconfig, etc), as that seems like a more appropriate name? No?
> 
> I am very much in favor of this proposal. Now jz4740_mmc.c is not only used
> for the JZ4740 processor, it is also used for JZ4725, JZ4760, JZ4770, JZ4780
> and X1000, and now Ingenic's processor is no longer named after JZ47xx,
> it is divided into three product lines: M, T, and X. It is easy to cause 
> some
> misunderstandings by using jz4740_mmc.c. At the same time, I think that
> some register names also need to be adjusted. For example, the STLPPL
> register name has only appeared in JZ4730 and JZ4740, and this register
> in all subsequent processors is called CTRL. This time I was confused by
> the STLPPL when I added drivers for the JZ4760's and X1000's LPM.
> 

I am very much against renamings, for several reasons. As Paul already mentioned, it's pointless and just adds noise to the git-log, making history harder to recover. Driver file names don't really have to reflect the device exactly. For the compatibility list, it's far easier to just git-grep for compatible strings, or git-grep Documentation and/or Kconfig.

Renaming macros and register names, is equally pointless and equally git-history invasive. Simply adding some documentation is enough.

Thanks,
Ezequiel
