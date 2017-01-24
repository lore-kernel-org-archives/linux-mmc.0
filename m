From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 3/3] mmc: Checking BKOPS status prior to Suspend
Date: Tue, 24 Jan 2017 16:36:36 +0200
Message-ID: <650522d8-dd54-6856-d50c-798d97a82001@intel.com>
References: <1484655337-32562-1-git-send-email-uri.yanai@sandisk.com>
 <1484655337-32562-4-git-send-email-uri.yanai@sandisk.com>
 <7a21bfe1-9eef-0f6f-56ce-4fc34d628ac0@intel.com>
 <037111DC0C584A4DB9F38021EA3CBDA506103F51@ULS-OP-MBXIP04.sdcorp.global.sandisk.com>
 <5DA5AA2A-DC61-4CC6-9548-AB648657C732@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:59048 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbdAXOmT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Jan 2017 09:42:19 -0500
In-Reply-To: <5DA5AA2A-DC61-4CC6-9548-AB648657C732@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>, Uri Yanai <Uri.Yanai@sandisk.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 23/01/17 19:07, Alex Lemberg wrote:
> Hi Adrian,
> 
> I would like to add several notes on top of Uri’s answer...
> I agree with you, by the spec, PON Sleep_Notification should be
> set before calling Sleep command.
> As you probably remember, we have tried to implement it
> in the past and even submitted a patch – “[PATCH] mmc: sleep notification”
> https://www.mail-archive.com/linux-mmc@vger.kernel.org/msg30906.html
> As you can see from the thread, one of the main issues in Sleep_Notification
> is a SLEEP_NOTIFICATION_TIME (defined in EXT_CSD [216]), which need to be
> considered in implementation…

Does it?  I would tend to assume SLEEP_NOTIFICATION_TIME will be acceptable
during _suspend until proven otherwise.

> Thus, I think postponing Sleep during suspend requires a different from current
> AUTO_BKOPS implementation, and I suggest to handle it in separate
> patchset, if possible.

Not at all sure what you mean by "postponing Sleep"?

> 
> 
> Thanks,
> Alex
> 
> On 1/22/17, 5:55 PM, "Uri Yanai" <Uri.Yanai@sandisk.com> wrote:
> 
>     Hi Adrian
>     
>     Thanks for your review.
>     Ulf rejected our approach in the first patch submission calling pm_schedule_suspend()
>     
>     " If I understand correctly, you would like to abort the runtime suspend
>     and allow the background operations to complete. That seems
>     reasonable, although in such case you need to return -EBUSY from this
>     function."
>     
>     If I understood Ulf correctly, instead of suspending he suggest aborting the suspend altogether returning -EBUSY.
>     
>     If I understood you correctly, your approach is similar to the one taken in the first patch submission.
>     Instead of calling pm_schedule_suspend(), you suggest calling  mmc_poweroff_notify(host->card, SLEEP_NOTIFICATION).
>     
>     Regards
>     Uri
>     
>     -----Original Message-----
>     From: Adrian Hunter [mailto:adrian.hunter@intel.com] 
>     Sent: Friday, January 20, 2017 1:56 PM
>     To: Uri Yanai; ulf.hansson@linaro.org
>     Cc: linux-mmc@vger.kernel.org; chris@printf.net; Alex Lemberg
>     Subject: Re: [PATCH 3/3] mmc: Checking BKOPS status prior to Suspend
>     
>     On 17/01/17 14:15, Uri Yanai wrote:
>     > If asked to do device Runtime Suspend while in BKOPS and auto BKOPS is 
>     > enabled return –EBUSY
>     
>     The spec also says
>     
>     "Before moving to Sleep state hosts may set the POWER_OFF_NOTIFICATION byte to SLEEP_NOTIFICATION (0x04) if aware that the device is capable of autonomously initiating background operations for possible performance improvements."
>     
>     Have you considered that?
>     
>     But I wonder if we shouldn't always use SLEEP_NOTIFICATION before sleep?
>     
>     > 
>     > Change-Id: Ie4b38a32fe98179f0bca5b57edaaa47a02d0a389
>     > Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
>     > Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
>     > ---
>     >  drivers/mmc/core/mmc.c  | 35 ++++++++++++++++++++++++++++-------
>     >  include/linux/mmc/mmc.h |  2 ++
>     >  2 files changed, 30 insertions(+), 7 deletions(-)
>     > 
>     > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index 
>     > f70f6a1..21f5851 100644
>     > --- a/drivers/mmc/core/mmc.c
>     > +++ b/drivers/mmc/core/mmc.c
>     > @@ -1942,7 +1942,8 @@ static void mmc_detect(struct mmc_host *host)
>     >  	}
>     >  }
>     >  
>     > -static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>     > +static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
>     > +	bool is_runtime_pm)
>     >  {
>     >  	int err = 0;
>     >  	unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
>     > @@ -1953,10 +1954,30 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>     >  	if (mmc_card_suspended(host->card))
>     >  		goto out;
>     >  
>     > -	if (mmc_card_doing_bkops(host->card)) {
>     > -		err = mmc_stop_bkops(host->card);
>     > -		if (err)
>     > +	if (mmc_card_doing_bkops(host->card) ||
>     > +		host->card->ext_csd.auto_bkops_en) {
>     > +		err = mmc_read_bkops_status(host->card);
>     > +		if (err) {
>     > +			pr_err("%s: error %d reading BKOPS Status\n",
>     > +				mmc_hostname(host), err);
>     >  			goto out;
>     > +		}
>     > +		if (is_runtime_pm && host->card->ext_csd.raw_bkops_status >=
>     > +				EXT_CSD_BKOPS_LEVEL_PM_SUSPEND) {
>     > +			/*
>     > +			 * We don’t allow Runtime Suspend while device still
>     > +			 * needs time to complete internal BKOPS, returning
>     > +			 * -EBUSY while BKOPS level is above
>     > +			 *  EXT_CSD_BKOPS_LEVEL_PM_SUSPEND
>     > +			 */
>     > +			err = -EBUSY;
>     > +			goto out;
>     > +		}
>     > +		if (mmc_card_doing_bkops(host->card)) {
>     > +			err = mmc_stop_bkops(host->card);
>     > +			if (err)
>     > +				goto out;
>     > +		}
>     >  	}
>     >  
>     >  	err = mmc_flush_cache(host->card);
>     > @@ -1987,7 +2008,7 @@ static int mmc_suspend(struct mmc_host *host)  {
>     >  	int err;
>     >  
>     > -	err = _mmc_suspend(host, true);
>     > +	err = _mmc_suspend(host, true, false);
>     >  	if (!err) {
>     >  		pm_runtime_disable(&host->card->dev);
>     >  		pm_runtime_set_suspended(&host->card->dev);
>     > @@ -2034,7 +2055,7 @@ static int mmc_shutdown(struct mmc_host *host)
>     >  		err = _mmc_resume(host);
>     >  
>     >  	if (!err)
>     > -		err = _mmc_suspend(host, false);
>     > +		err = _mmc_suspend(host, false, false);
>     >  
>     >  	return err;
>     >  }
>     > @@ -2058,7 +2079,7 @@ static int mmc_runtime_suspend(struct mmc_host *host)
>     >  	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
>     >  		return 0;
>     >  
>     > -	err = _mmc_suspend(host, true);
>     > +	err = _mmc_suspend(host, true, true);
>     >  	if (err)
>     >  		pr_err("%s: error %d doing aggressive suspend\n",
>     >  			mmc_hostname(host), err);
>     > diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h index 
>     > 126b8d5..2633274 100644
>     > --- a/include/linux/mmc/mmc.h
>     > +++ b/include/linux/mmc/mmc.h
>     > @@ -445,6 +445,8 @@ struct _mmc_csd {
>     >   */
>     >  #define EXT_CSD_BKOPS_LEVEL_2		0x2
>     >  
>     > +#define EXT_CSD_BKOPS_LEVEL_PM_SUSPEND	EXT_CSD_BKOPS_LEVEL_2
>     > +
>     >  /*
>     >   * BKOPS modes
>     >   */
>     > 
>     
>     
> 

