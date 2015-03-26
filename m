From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: omap_hsmmc: stop using .enable and .disable method.
Date: Thu, 26 Mar 2015 09:05:28 +0100
Message-ID: <CAPDyKFr0qOuF09eUjMk0ndqyVU1xh+Kq66zV1pFi2sX3Xv96ow@mail.gmail.com>
References: <20150325213419.11463.33321.stgit@notabene.brown>
	<20150325214337.11463.93489.stgit@notabene.brown>
	<20150326121823.148da0f4@notabene.brown>
	<CAPDyKFoOSn7-fx=8o-DBcYnHeA0vD6Y9CVtx8zbS+9Je2+W2rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoOSn7-fx=8o-DBcYnHeA0vD6Y9CVtx8zbS+9Je2+W2rQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: NeilBrown <neil@brown.name>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>, Chris Ball <chris@printf.net>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 26 March 2015 at 08:38, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 26 March 2015 at 02:18, NeilBrown <neilb@suse.de> wrote:
>> On Thu, 26 Mar 2015 08:43:37 +1100 NeilBrown <neil@brown.name> wrote:
>>
>>> enable and disable are only used to get and put
>>> runtime pm references.  .set_ios already does this
>>> itself, and other drivers just do it in set_ios
>>> and .request without using enable/disable.
>>>
>>> So add pm_runtime get/put to omap_hsmmc_request(),
>>> and discard the enable/disable methods.
>>>
>>> Signed-off-by: NeilBrown <neil@brown.name>
>>
>> Sorry, that patch wasn't much good.  This one I have really tested properly
>> and checked that the 'put' match the 'get's and  that the device to regularly
>> go to sleep as expected.
>>
>> NeilBrown
>>
>>
>> From: NeilBrown <neil@brown.name>
>> Date: Thu, 26 Mar 2015 08:28:43 +1100
>> Subject: [PATCH] mmc: omap_hsmmc: stop using .enable and .disable method.
>>
>> enable and disable are only used to get and put
>> runtime pm references.  .set_ios already does this
>> itself, and other drivers just do it in set_ios
>> and .request without using enable/disable.
>>
>> So add pm_runtime get/put to omap_hsmmc_request(),
>> and discard the enable/disable methods.
>>
>> Signed-off-by: NeilBrown <neil@brown.name>
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index f84cfb01716d..2cb81538a612 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -882,6 +882,8 @@ static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, struct mmc_req
>>                 return;
>>         host->mrq = NULL;
>>         mmc_request_done(host->mmc, mrq);
>> +       pm_runtime_mark_last_busy(host->dev);
>> +       pm_runtime_put_autosuspend(host->dev);
>>  }
>
> How about adding a function like this:
>
> _omap_hsmmc_request_done(struct omap_hsmmc_host *host, struct mmc_req)
> {
>   mmc_request_done(host->mmc, mrq);
>   pm_runtime_mark_last_busy(host->dev);
>   pm_runtime_put_autosuspend(host->dev);
> }
>
> Then just invoke it from those places were needed?
>
>>
>>  /*
>> @@ -1305,6 +1307,8 @@ static void omap_hsmmc_dma_callback(void *param)
>>
>>                 host->mrq = NULL;
>>                 mmc_request_done(host->mmc, mrq);
>> +               pm_runtime_mark_last_busy(host->dev);
>> +               pm_runtime_put_autosuspend(host->dev);
>>         }
>>  }
>>
>> @@ -1537,6 +1541,7 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
>>
>>         BUG_ON(host->req_in_progress);
>>         BUG_ON(host->dma_ch != -1);
>> +       pm_runtime_get_sync(host->dev);
>>         if (host->protect_card) {
>>                 if (host->reqs_blocked < 3) {
>>                         /*
>> @@ -1553,6 +1558,8 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
>>                         req->data->error = -EBADF;
>>                 req->cmd->retries = 0;
>>                 mmc_request_done(mmc, req);
>> +               pm_runtime_mark_last_busy(host->dev);
>> +               pm_runtime_put_autosuspend(host->dev);
>>                 return;
>>         } else if (host->reqs_blocked)
>>                 host->reqs_blocked = 0;
>> @@ -1566,6 +1573,8 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
>>                         req->data->error = err;
>>                 host->mrq = NULL;
>>                 mmc_request_done(mmc, req);
>> +               pm_runtime_mark_last_busy(host->dev);
>> +               pm_runtime_put_autosuspend(host->dev);
>>                 return;
>>         }
>>         if (req->sbc && !(host->flags & AUTO_CMD23)) {
>> @@ -1778,25 +1787,6 @@ static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
>>         set_sd_bus_power(host);
>>  }
>>
>> -static int omap_hsmmc_enable_fclk(struct mmc_host *mmc)
>> -{
>> -       struct omap_hsmmc_host *host = mmc_priv(mmc);
>> -
>> -       pm_runtime_get_sync(host->dev);
>> -
>> -       return 0;
>> -}
>> -
>> -static int omap_hsmmc_disable_fclk(struct mmc_host *mmc)
>> -{
>> -       struct omap_hsmmc_host *host = mmc_priv(mmc);
>> -
>> -       pm_runtime_mark_last_busy(host->dev);
>> -       pm_runtime_put_autosuspend(host->dev);
>> -
>> -       return 0;
>> -}
>> -
>>  static int omap_hsmmc_multi_io_quirk(struct mmc_card *card,
>>                                      unsigned int direction, int blk_size)
>>  {
>> @@ -1808,8 +1798,6 @@ static int omap_hsmmc_multi_io_quirk(struct mmc_card *card,
>>  }
>>
>>  static struct mmc_host_ops omap_hsmmc_ops = {
>> -       .enable = omap_hsmmc_enable_fclk,
>> -       .disable = omap_hsmmc_disable_fclk,
>>         .post_req = omap_hsmmc_post_req,
>>         .pre_req = omap_hsmmc_pre_req,
>>         .request = omap_hsmmc_request,
>
> Finally, I think you have forgotten to deal with pm_runtime_get|put*()
> in omap_hsmmc_enable_sdio_irq().

No, _me_ totally forgot that SDIO IRQ is a special case and from the
above mentioned function we mustn't deal with runtime PM, since that
function is executed in IRQ context. :-)

Also, since omap's runtime PM ->suspend() callback disables regular
SDIO IRQS and enables wakeups, this case is already covered. Please
ignore my comment above and sorry for the noise.

Kind regards
Uffe
