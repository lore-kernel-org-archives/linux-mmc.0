From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 6/6 v2] MMC: JZ4740: Add support for LPM.
Date: Mon, 21 Oct 2019 16:57:26 +0200
Message-ID: <CAPDyKFqzT5Gf1R_26Hzyt-_xEshk4k-EW3yUSKw1MVi7ayh3QA@mail.gmail.com>
References: <5DA9EE2F.4030603@zoho.com> <47f6-5dab7580-33-5680128@176712317>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <47f6-5dab7580-33-5680128@176712317>
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@collabora.com>
Cc: Zhou Yanjie <zhouyanjie@zoho.com>, Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Paul Burton <paul.burton@mips.com>, Mark Rutland <mark.rutland@arm.com>, syq@debian.org, Linus Walleij <linus.walleij@linaro.org>, armijn@tjaldur.nl, Thomas Gleixner <tglx@linutronix.de>, YueHaibing <yuehaibing@huawei.com>, Mathieu Malaterre <malat@debian.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, 19 Oct 2019 at 22:44, Ezequiel Garcia
<ezequiel.garcia@collabora.com> wrote:
>
> On Friday, October 18, 2019 13:54 -03, Zhou Yanjie <zhouyanjie@zoho.com> =
wrote:
>
>
> >
> > >
> > > I also have a general question. Should we perhaps rename the driver
> > > from jz4740_mmc.c to ingenic.c (and the file for the DT bindings, the
> > > Kconfig, etc), as that seems like a more appropriate name? No?
> >
> > I am very much in favor of this proposal. Now jz4740_mmc.c is not only =
used
> > for the JZ4740 processor, it is also used for JZ4725, JZ4760, JZ4770, J=
Z4780
> > and X1000, and now Ingenic's processor is no longer named after JZ47xx,
> > it is divided into three product lines: M, T, and X. It is easy to caus=
e
> > some
> > misunderstandings by using jz4740_mmc.c. At the same time, I think that
> > some register names also need to be adjusted. For example, the STLPPL
> > register name has only appeared in JZ4730 and JZ4740, and this register
> > in all subsequent processors is called CTRL. This time I was confused b=
y
> > the STLPPL when I added drivers for the JZ4760's and X1000's LPM.
> >
>
> I am very much against renamings, for several reasons. As Paul already me=
ntioned, it's pointless and just adds noise to the git-log, making history =
harder to recover. Driver file names don't really have to reflect the devic=
e > > exactly. For the compatibility list, it's far easier to just git-grep=
 for compatible strings, or git-grep Documentation and/or Kconfig.

I have no strong opinions. What matters to me, is that people agree on
the best option, based on a case by case discussion.

>
> Renaming macros and register names, is equally pointless and equally git-=
history invasive. Simply adding some documentation is enough.

Sounds like documentation is what people prefer here - and the DT doc
seems already fine in regards to that.

Perhaps some more words added to the header in driver's c-file could
be and option to consider, as today it only mentions "JZ4740 SD/MMC
controller driver".

Anyway, it's up to you. :-)

Kind regards
Uffe
