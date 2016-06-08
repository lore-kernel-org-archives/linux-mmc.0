From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH] mmc: core: Fix mmc_select_hs200() regression in v4.7-rc.
Date: Wed, 8 Jun 2016 11:20:44 +0100
Message-ID: <20160608102044.GB25004@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1465304543-23988-1-git-send-email-peter.griffin@linaro.org>
 <20160607133839.GH18047@dell>
 <20160607135702.GA19771@griffinp-ThinkPad-X1-Carbon-2nd>
 <CAPDyKFrvuDrNwUmZQw2UN+Ke-DFyW9eCNc+nhQ7cmpYWdn+rMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrvuDrNwUmZQw2UN+Ke-DFyW9eCNc+nhQ7cmpYWdn+rMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel@stlinux.com, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Tue, 07 Jun 2016, Ulf Hansson wrote:

> On 7 June 2016 at 15:57, Peter Griffin <peter.griffin@linaro.org> wrote:
> > Hi Lee,
> >
> > On Tue, 07 Jun 2016, Lee Jones wrote:
> >
> >> On Tue, 07 Jun 2016, Peter Griffin wrote:
> >>
> >> > mmc_select_bus_width() returns bus width (4 or 8) on success or
> >> > zero if unsupported. If bus width is set successfully we then wish
> >> > to switch to HS200 mode.
> >> >
> >> > This avoids the following error message in v4.70-rc2
> >> >
> >> > [    2.523674] mmc0: mmc_select_hs200 failed, error 3
> >> > [    2.528516] mmc0: error 3 whilst initialising MMC card
> >> >
> >> > With this patch card is enumerated correctly
> >> >
> >> > [    2.468065] mmc0: new HS200 MMC card at address 0001
> >> > [    2.468335] mmcblk0: mmc0:0001 P1XXXX 7.20 GiB
> >> > [    2.468441] mmcblk0boot0: mmc0:0001 P1XXXX partition 1 2.00 MiB
> >> > [    2.468552] mmcblk0boot1: mmc0:0001 P1XXXX partition 2 2.00 MiB
> >> > [    2.468651] mmcblk0rpmb: mmc0:0001 P1XXXX partition 3 128 KiB
> >> > [    2.469269]  mmcblk0: p1
> >> >
> >> > Fixes: 287980e (remove lots of IS_ERR_VALUE abuses)
> >> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> >> > Cc: Arnd Bergmann <arnd@arndb.de>
> >> > ---
> >> >  drivers/mmc/core/mmc.c | 4 ++--
> >> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >> > index c984321..aafb73d 100644
> >> > --- a/drivers/mmc/core/mmc.c
> >> > +++ b/drivers/mmc/core/mmc.c
> >> > @@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card *card)
> >> >      * switch to HS200 mode if bus width is set successfully.
> >> >      */
> >> >     err = mmc_select_bus_width(card);
> >> > -   if (!err) {
> >> > +   if (err > 0) {
> >> >             val = EXT_CSD_TIMING_HS200 |
> >> >                   card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
> >> >             err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> >> > @@ -1583,7 +1583,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> >> >     } else if (mmc_card_hs(card)) {
> >> >             /* Select the desired bus width optionally */
> >> >             err = mmc_select_bus_width(card);
> >> > -           if (!err) {
> >> > +           if (err > 0) {
> >> >                     err = mmc_select_hs_ddr(card);
> >> >                     if (err)
> >> >                             goto free_card;
> >>
> >> Looks like this has already been 'fixed' in -rc2.
> >
> > Ah, it seems I was on -rc1, not -rc2
> >
> >>
> >> Although, this patch does not work for me.
> >>     mmc: fix mmc mode selection for HS-DDR and higher
> >>
> >>     When IS_ERR_VALUE was removed from the mmc core code, it was replaced
> >>     with a simple not-zero check. This does not work, as the value checked
> >>     is the return value for mmc_select_bus_width, which returns the set
> >>     bit width on success. This made eMMC modes higher than HS-DDR unusable.
> >>
> >>     Fix this by checking for a positive return value instead.
> >>
> >>     Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
> >>     Cc: Arnd Bergmann <arnd@arndb.de>
> >>     Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >>     Acked-by: Hans de Goede <hdegoede@redhat.com>
> >>     Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >>     Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> >>     Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> >>     Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> >>     Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>
> >> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >> index c984321..5d438ad 100644
> >> --- a/drivers/mmc/core/mmc.c
> >> +++ b/drivers/mmc/core/mmc.c
> >> @@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card *card)
> >>        * switch to HS200 mode if bus width is set successfully.
> >>        */
> >>       err = mmc_select_bus_width(card);
> >> -     if (!err) {
> >> +     if (err >= 0) {
> >
> >
> > This patch looks wrong to me, as if zero is returned by mmc_select_bus_width() it
> > means setting the bus width failed, and you most likely don't want to switch to
> > hs200 mode.
> >
> > Ulf - what is your opinion?
> >
> > regards,
> >
> > Peter.>
> 
> The commit above (mmc: fix mmc mode selection for HS-DDR and higher),
> simply restored the old behaviour and that was sufficient to solve the
> regressions.
> 
> Nevertheless I agree, that if mmc_select_bus_width() returns 0, that
> should likely mean that we shouldn't try to switch to hs200. If we
> want to change that, let's do that in a separate patch on top.

OK, I will send a v2 patch in a moment.

> So, do you see a problem in rc2?

No, despite what the commit message says, I wrote & tested the patch on
v4.7-rc1. A stock v4.7-rc2 enumerates the card correctly on my STi platform.

I think my patch is now only useful if setting the bus width were to fail.

regards,

Peter.
