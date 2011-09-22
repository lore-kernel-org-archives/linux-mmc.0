From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v3] mmc: core: Add default timeout value for CMD6.
Date: Thu, 22 Sep 2011 11:15:30 +0900
Message-ID: <005601cc78cd$80c71020$82553060$%jun@samsung.com>
References: <1315466232-27487-1-git-send-email-tgih.jun@samsung.com>
 <m262kl6b7y.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <m262kl6b7y.fsf@bob.laptop.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

Hi Chris Ball,

Chris Ball wrote:
> Hi,
> 
> On Thu, Sep 08 2011, Seungwon Jeon wrote:
> > EXT_CSD[248] includes the default maximum timeout for CMD6.
> > This field is added at eMMC4.5 Spec. And it can be used for default
> > timeout except for some operations which don't define the timeout(i.e.
> > background operation, sanitize, flush cache) in eMMC4.5 Spec.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> >  drivers/mmc/core/mmc.c   |   19 +++++++++++++++----
> >  include/linux/mmc/card.h |    1 +
> >  include/linux/mmc/mmc.h  |    1 +
> >  3 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 5700b1c..a72d879 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -410,6 +410,15 @@ static int mmc_read_ext_csd(struct mmc_card *card,
> u8 *ext_csd)
> >  	else
> >  		card->erased_byte = 0x0;
> >
> > +	if (card->ext_csd.rev >= 6)
> > +		card->ext_csd.generic_cmd6_time = 10 *
> > +			ext_csd[EXT_CSD_GENERIC_CMD6_TIME];
> > +	else
> > +		card->ext_csd.generic_cmd6_time = 0;
> > +
> >  out:
> >  	return err;
> >  }
> > @@ -668,7 +677,8 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
> >  	 */
> 
> The patch is corrupt at this point:
> 
> patching file drivers/mmc/core/mmc.c
> patch: **** malformed patch at line 39: @@ -668,7 +677,8 @@ static int
> mmc_init_card(struct mmc_host *host, u32 ocr,
Oops.
It's mistake. I'll resend.
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
