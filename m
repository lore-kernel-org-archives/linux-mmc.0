From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/3] mmc: correct some exclusive card state to clear
Date: Thu, 07 Nov 2013 12:51:12 +0900
Message-ID: <001d01cedb6c$9a16f5f0$ce44e1d0$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <003501ceda2a$d7ae2980$870a7c80$%jun@samsung.com>
 <CAPDyKFr2wWQFQbY0VmZj4T-aoH3uxFOnt5=xBt2JAh4kckS05Q@mail.gmail.com>
 <001301cedad3$7de1fcc0$79a5f640$%jun@samsung.com>
 <CAPDyKFpRWSNfz-2EUjxf32xZsAEGF_JnFSfmtN6t-g4FSQbnWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:23930 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab3KGDvP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Nov 2013 22:51:15 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MVV00MV5K1CH680@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 07 Nov 2013 12:51:13 +0900 (KST)
In-reply-to: <CAPDyKFpRWSNfz-2EUjxf32xZsAEGF_JnFSfmtN6t-g4FSQbnWg@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'linux-mmc' <linux-mmc@vger.kernel.org>

On Wed, November 06, 2013, Ulf Hansson wrote:
> On 6 November 2013 10:35, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > On Tue, November 05, 2013, Ulf Hansson wrote:
> >> Hi Seungwon,
> >>
> >>
> >> On 5 November 2013 14:27, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> >> > Card state related to speed mode should be in non-overlapped.
> >> > Consideration for all cases is required when being cleared.
> >> > Also, MMC_STATE_PRESENT and MMC_STATE_REMOVED are same.
> >> > It's exclusive state which cannot be set at the same time.
> >> >
> >> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> >> > ---
> >> >  drivers/mmc/core/core.c  |    1 -
> >> >  drivers/mmc/core/mmc.c   |    4 ++--
> >> >  drivers/mmc/core/sd.c    |    5 +++--
> >> >  drivers/mmc/core/sdio.c  |    5 ++++-
> >> >  include/linux/mmc/card.h |   37 +++++++++++++++++++++++++++++++------
> >> >  5 files changed, 40 insertions(+), 12 deletions(-)
> >> >
> >> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >> > index 57a2b40..b183d56 100644
> >> > --- a/drivers/mmc/core/core.c
> >> > +++ b/drivers/mmc/core/core.c
> >> > @@ -2281,7 +2281,6 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
> >> >                 }
> >> >         }
> >> >
> >> > -       host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_DDR);
> >> >         if (mmc_host_is_spi(host)) {
> >> >                 host->ios.chip_select = MMC_CS_HIGH;
> >> >                 host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
> >> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >> > index f4f8991..1668ea4 100644
> >> > --- a/drivers/mmc/core/mmc.c
> >> > +++ b/drivers/mmc/core/mmc.c
> >> > @@ -1597,11 +1597,11 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
> >> >                 err = mmc_sleep(host);
> >> >         else if (!mmc_host_is_spi(host))
> >> >                 err = mmc_deselect_cards(host);
> >> > -       host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
> >> >
> >> >         if (!err) {
> >> >                 mmc_power_off(host);
> >> >                 mmc_card_set_suspended(host->card);
> >> > +               mmc_card_set_ds(host->card);
> >> >         }
> >> >  out:
> >> >         mmc_release_host(host);
> >> > @@ -1727,8 +1727,8 @@ static int mmc_power_restore(struct mmc_host *host)
> >> >  {
> >> >         int ret;
> >> >
> >> > -       host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
> >> >         mmc_claim_host(host);
> >> > +       mmc_card_set_ds(host->card);
> >> >         ret = mmc_init_card(host, host->card->ocr, host->card);
> >> >         mmc_release_host(host);
> >> >
> >> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> >> > index 6f42050..b19a8f4 100644
> >> > --- a/drivers/mmc/core/sd.c
> >> > +++ b/drivers/mmc/core/sd.c
> >> > @@ -1082,10 +1082,11 @@ static int _mmc_sd_suspend(struct mmc_host *host)
> >> >
> >> >         if (!mmc_host_is_spi(host))
> >> >                 err = mmc_deselect_cards(host);
> >> > -       host->card->state &= ~MMC_STATE_HIGHSPEED;
> >> > +
> >> >         if (!err) {
> >> >                 mmc_power_off(host);
> >> >                 mmc_card_set_suspended(host->card);
> >> > +               mmc_card_set_ds(host->card);
> >> >         }
> >> >
> >> >  out:
> >> > @@ -1191,8 +1192,8 @@ static int mmc_sd_power_restore(struct mmc_host *host)
> >> >  {
> >> >         int ret;
> >> >
> >> > -       host->card->state &= ~MMC_STATE_HIGHSPEED;
> >> >         mmc_claim_host(host);
> >> > +       mmc_card_set_ds(host->card);
> >> >         ret = mmc_sd_init_card(host, host->card->ocr, host->card);
> >> >         mmc_release_host(host);
> >> >
> >> > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> >> > index 4d721c6..7c6c43c 100644
> >> > --- a/drivers/mmc/core/sdio.c
> >> > +++ b/drivers/mmc/core/sdio.c
> >> > @@ -968,8 +968,10 @@ static int mmc_sdio_suspend(struct mmc_host *host)
> >> >                 mmc_release_host(host);
> >> >         }
> >> >
> >> > -       if (!err && !mmc_card_keep_power(host))
> >> > +       if (!err && !mmc_card_keep_power(host)) {
> >> >                 mmc_power_off(host);
> >> > +               mmc_card_set_ds(host->card);
> >> > +       }
> >> >
> >> >         return err;
> >> >  }
> >> > @@ -1075,6 +1077,7 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
> >> >         if (ret)
> >> >                 goto out;
> >> >
> >> > +       mmc_card_set_ds(host->card);
> >> >         ret = mmc_sdio_init_card(host, host->card->ocr, host->card,
> >> >                                 mmc_card_keep_power(host));
> >> >         if (!ret && host->sdio_irqs)
> >> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> >> > index c119735..f2c2620 100644
> >> > --- a/include/linux/mmc/card.h
> >> > +++ b/include/linux/mmc/card.h
> >> > @@ -260,6 +260,11 @@ struct mmc_card {
> >> >  #define MMC_STATE_HIGHSPEED_200        (1<<8)          /* card is in HS200 mode */
> >> >  #define MMC_STATE_DOING_BKOPS  (1<<10)         /* card is doing BKOPS */
> >> >  #define MMC_STATE_SUSPENDED    (1<<11)         /* card is suspended */
> >> > +#define MMC_STATE_SPEED_MASK   (MMC_STATE_HIGHSPEED | \
> >> > +                                MMC_STATE_HIGHSPEED_DDR | \
> >> > +                                MMC_STATE_ULTRAHIGHSPEED | \
> >> > +                                MMC_STATE_HIGHSPEED_200)
> >> > +                                               /* Mask for default speed(DS) */
> >> >         unsigned int            quirks;         /* card quirks */
> >> >  #define MMC_QUIRK_LENIENT_FN0  (1<<0)          /* allow SDIO FN0 writes outside of the VS CCCR
> range
> >> */
> >> >  #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)   /* use func->cur_blksize */
> >> > @@ -431,19 +436,39 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int
> data)
> >> >  #define mmc_card_doing_bkops(c)        ((c)->state & MMC_STATE_DOING_BKOPS)
> >> >  #define mmc_card_suspended(c)  ((c)->state & MMC_STATE_SUSPENDED)
> >> >
> >> > -#define mmc_card_set_present(c)        ((c)->state |= MMC_STATE_PRESENT)
> >> > +
> >> >  #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
> >> > -#define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
> >> > -#define mmc_card_set_hs200(c)  ((c)->state |= MMC_STATE_HIGHSPEED_200)
> >> >  #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
> >> > -#define mmc_card_set_ddr_mode(c) ((c)->state |= MMC_STATE_HIGHSPEED_DDR)
> >> > -#define mmc_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
> >> >  #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
> >> > -#define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
> >> >  #define mmc_card_set_doing_bkops(c)    ((c)->state |= MMC_STATE_DOING_BKOPS)
> >> >  #define mmc_card_clr_doing_bkops(c)    ((c)->state &= ~MMC_STATE_DOING_BKOPS)
> >> >  #define mmc_card_set_suspended(c) ((c)->state |= MMC_STATE_SUSPENDED)
> >> >  #define mmc_card_clr_suspended(c) ((c)->state &= ~MMC_STATE_SUSPENDED)
> >> > +#define mmc_card_set_highspeed(c) \
> >> > +                       ((c)->state = \
> >> > +                        ((c)->state & ~MMC_STATE_SPEED_MASK) | \
> >> > +                        MMC_STATE_HIGHSPEED)
> >> > +#define mmc_card_set_ddr_mode(c) \
> >> > +                       ((c)->state = \
> >> > +                        ((c)->state & ~MMC_STATE_SPEED_MASK) | \
> >> > +                        MMC_STATE_HIGHSPEED_DDR)
> >> > +#define mmc_card_set_hs200(c) \
> >> > +                       ((c)->state = \
> >> > +                        ((c)->state & ~MMC_STATE_SPEED_MASK) | \
> >> > +                        MMC_STATE_HIGHSPEED_200)
> >> > +#define mmc_card_set_uhs(c) \
> >> > +                       ((c)->state = \
> >> > +                        ((c)->state & ~MMC_STATE_SPEED_MASK) | \
> >> > +                        MMC_STATE_ULTRAHIGHSPEED)
> >> > +#define mmc_card_set_present(c) \
> >> > +                       ((c)->state = \
> >> > +                        ((c)->state & ~MMC_CARD_REMOVED) | \
> >> > +                        MMC_STATE_PRESENT)
> >> > +#define mmc_card_set_removed(c) \
> >> > +                       ((c)->state = \
> >> > +                        ((c)->state & ~MMC_STATE_PRESENT) | \
> >> > +                        MMC_CARD_REMOVED)
> >> > +#define mmc_card_set_ds(c)     ((c)->state &= ~MMC_STATE_SPEED_MASK)
> >>
> >> I have a feeling of that this "card->state" has become a container for
> >> a lot of mixed stuff. So your clean up is definitely justified.
> >>
> >> I have a suggestion for how we can improve simplicity, how about
> >> dividing the state into two variables instead:
> >>
> >> -> One part are actually used in the mmc core code to track a state
> >> and to make certain decisions during execution, like
> >> MMC_STATE_SUSPENDED, MMC_STATE_PRESENT, MMC_CARD_REMOVED.
> >>
> >> -> The other part is more to be considered as the current operational
> >> state, for example the bus speed mode. The information in this "state
> >> variable" will be re-negotiated as a part of mmc_sd|sdio_init_card and
> >> can therefore always be reset in the beginning of these functions.
> >>
> >> Does it make sense?
> > Thank you for suggestion. I also feel that.
> > Hmm, but when considering there is no case we access 'card->sate' directly,
> > splitting into two types of state doesn't seem to give much.
> 
> Actually, on a second thought, why are we even caching the bus speeds
> in the card state? The bus speeds are already reflected in the
> "ios->timing" struct, which moreover also is available through
> debugfs. Can we remove the bus speeds entirely from the card state
> instead?
You point out redundancy of existing state for speed mode.
Yes, I agree with you on that point. It could be replaced.
I will consider for next.

Thanks,
Seungwon Jeon

