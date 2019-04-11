From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Add section for MediaTek MMC/SD/SDIO driver
Date: Thu, 11 Apr 2019 12:48:26 +0200
Message-ID: <CAPDyKFoZS+CL7zXGkNmVfbLo48+oi-pA9jEXGMTEi=qN0d+Z9Q@mail.gmail.com>
References: <20190325122442.30644-1-ulf.hansson@linaro.org>
 <CAPDyKFqNih3kEuRM9HHkmcVOzaT2RZLRjb=0ifq6hGB+OCxUug@mail.gmail.com> <1554979352.18628.0.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554979352.18628.0.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 11 Apr 2019 at 12:42, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> On Thu, 2019-04-11 at 11:49 +0200, Ulf Hansson wrote:
> > Chaotian,
> >
> > On Mon, 25 Mar 2019 at 13:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Cc: Chaotian Jing <chaotian.jing@mediatek.com>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  MAINTAINERS | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 3e5a5d263f29..b43e563b4c95 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9775,6 +9775,12 @@ F:       drivers/media/platform/mtk-vpu/
> > >  F:     Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > >  F:     Documentation/devicetree/bindings/media/mediatek-vpu.txt
> > >
> > > +MEDIATEK MMC/SD/SDIO DRIVER
> > > +M:     Chaotian Jing <chaotian.jing@mediatek.com>
> > > +S:     Maintained
> > > +F:     drivers/mmc/host/mtk-sd.c
> > > +F:     Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > > +
> >
> > Are you fine with this, or do you have any other guys at your side
> > that can help with reviewing patches for the mtk-sd driver?
> >
> Yes, It's fine for me.
> Thx!

Great! I consider that as ack and have applied the patch.

Thanks and kind regards
Uffe
