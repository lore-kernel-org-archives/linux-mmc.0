From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: fix controller busy issue and add 24bits segment support
Date: Wed, 21 Aug 2019 17:07:17 +0200
Message-ID: <CAPDyKFofoJKqnchJT-Bty9MMLDviiBWupf+MPmMtv+mRemVXLw@mail.gmail.com>
References: <1558252637-10556-1-git-send-email-chaotian.jing@mediatek.com> <1559438591.25015.0.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1559438591.25015.0.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: srv_heupstream <srv_heupstream@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, 2 Jun 2019 at 03:23, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> Hi Ulf,
>
> Gentle ping for this patch.

For some reason these patches didn't reach the patchtracker, hence I
have just not seen them.

Could you please re-post this so we can get this merged?

Kind regards
Uffe

>
> On Sun, 2019-05-19 at 15:57 +0800, Chaotian Jing wrote:
> > the below 2 patches fix controller busy issue when plug out SD card
> > and add 24bits segment size support.
> >
> > Chaotian Jing (2):
> >   mmc: mediatek: fix controller busy when plug out SD
> >   mmc: mediatek: support 24bits segment size
> >
> >  drivers/mmc/host/mtk-sd.c | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> >
>
>
