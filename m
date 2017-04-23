From: Jiajie Hao <jiajie.hao@mediatek.com>
Subject: Re: [PATCH] mmc: sdio: Fix sdio wait busy implement limitation
Date: Sun, 23 Apr 2017 14:42:26 +0800
Message-ID: <1492929746.18907.9.camel@mhfsdcap03>
References: <1492416571-28843-1-git-send-email-jiajie.hao@mediatek.com>
         <1492416571-28843-2-git-send-email-jiajie.hao@mediatek.com>
         <CAPDyKFrDNBFV=1PtiopXoc+Zd7Tc-MZnR5k4za4Grbbs1aCP4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrDNBFV=1PtiopXoc+Zd7Tc-MZnR5k4za4Grbbs1aCP4Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Yong Mao <yong.mao@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, linux-arm-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

Very appreciated for your comment.
> On Thu, 2017-04-20 at 15:27 +0200, Ulf Hansson wrote:
> On 17 April 2017 at 10:09,  <jiajie.hao@mediatek.com> wrote:
> > From: Jiajie Hao <jiajie.hao@mediatek.com>
> >
> > The host may issue an I/O abort by writing to the CCCR at any time
> > during I/O read operation via CMD52. And host may need suspend
> > transcation during write busy stage in SDIO suspend/resume scenario.
> > From other side, a card may accept CMD52 during data transfer phase.
> >
> > Previous implement would block issuing above command in busy stage.
> > It cause function driver can't implement as proper way and has no
> > opportunity to do some coverage in error case via I/O abort etc.
> >
> > We need bypass some necessary operation during busy check stage.
> >
> > Change-Id: Ib5a4599a2a98cbcf441b564f5f6fbb10c8a59e1b
> 
> Please remove this.
OK.
> > Signed-off-by: Jiajie Hao <jiajie.hao@mediatek.com>
> > ---
> >  drivers/mmc/core/core.c     |    4 +++-
> >  drivers/mmc/core/sdio_ops.h |   10 ++++++++++
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 926e0fd..9c9a4bc 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -234,8 +234,10 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
> >         /*
> >          * For sdio rw commands we must wait for card busy otherwise some
> >          * sdio devices won't work properly.
> > +        * And bypass I/O abort, reset and bus suspend operations.
> >          */
> > -       if (mmc_is_io_op(mrq->cmd->opcode) && host->ops->card_busy) {
> > +       if (mmc_is_io_op(mrq->cmd->opcode) && host->ops->card_busy &&
> > +           !mmc_is_io_bypass(mrq->cmd->opcode, mrq->cmd->arg)) {
> 
> Instead of adding yet another function, let's extend the existing
> mmc_is_io_op() to cover this new cases as well.
> 
> Moreover, to be reflect the purpose of the function, I suggest we
> rename it from mmc_is_io_op() to sdio_is_op_busy().
It's a good suggestion. I'll resend patch in v2 for review.
> >                 int tries = 500; /* Wait aprox 500ms at maximum */
> >
> >                 while (host->ops->card_busy(host) && --tries)
> > diff --git a/drivers/mmc/core/sdio_ops.h b/drivers/mmc/core/sdio_ops.h
> > index bed8a83..9896696 100644
> > --- a/drivers/mmc/core/sdio_ops.h
> > +++ b/drivers/mmc/core/sdio_ops.h
> > @@ -31,5 +31,15 @@ static inline bool mmc_is_io_op(u32 opcode)
> >         return opcode == SD_IO_RW_DIRECT || opcode == SD_IO_RW_EXTENDED;
> >  }
> >
> > +static inline bool mmc_is_io_bypass(u32 opcode, u32 arg)
> > +{
> > +       u32 addr;
> > +
> > +       addr = (arg >> 9) & 0x1FFFF;
> > +
> > +       return ((opcode == SD_IO_RW_DIRECT) &&
> > +               (addr == SDIO_CCCR_ABORT || addr == SDIO_CCCR_SUSPEND));
> > +}
> > +
> >  #endif
> >
> > --
> > 1.7.9.5
> >
> 
> Kind regards
> Uffe

Best regards
Jiajie
