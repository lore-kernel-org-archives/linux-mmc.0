From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 0/5] a few fixes for sprd's sd host controller
Date: Wed, 28 Aug 2019 10:01:14 +0800
Message-ID: <CAAfSe-txS9MObU+ygxk5NA-FneDL7ftrDruvuou9PYhvXY0E=w@mail.gmail.com>
References: <20190826031830.30931-1-zhang.lyra@gmail.com> <CAPDyKFrpvtS9mHO7xN=cbrMHWN+ydPw08mF9oXtNW-TOMsP7Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrpvtS9mHO7xN=cbrMHWN+ydPw08mF9oXtNW-TOMsP7Ew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 27 Aug 2019 at 21:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 26 Aug 2019 at 05:18, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > With this patch-set, both sd card and mmc can be setup.  This patch-set was
> > verified on Unisoc's Whale2 and another mobile phone platform SC9863A.
> >
> > Chunyan Zhang (5):
> >   mmc: sdhci-sprd: fixed incorrect clock divider
> >   mmc: sdhci: sprd: add get_ro hook function
> >   mmc: sdhci: sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
> >   mms: sdhci: sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
> >   mmc: sdhci: sprd: clear the UHS-I modes read from registers
> >
> >  drivers/mmc/host/sdhci-sprd.c | 30 +++++++++++++++++++++++++-----
> >  1 file changed, 25 insertions(+), 5 deletions(-)
> >
> > --
> > 2.20.1
> >
>
> Looks like the entire series should be tagged for stable and having
> the same fixes tag as patch1. No?

Ok.

>
> Kind regards
> Uffe
