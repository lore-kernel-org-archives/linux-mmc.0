From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 02/18] mmc: meson-gx: remove code for unsupported CMD23
Date: Sun, 19 Feb 2017 20:36:28 +0100
Message-ID: <21c65efc-ce84-16b9-7bd6-e773788526fd@gmail.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
 <642a46aa-416c-32a3-f9ef-3feafca72636@gmail.com>
 <m2wpcrbdjr.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36390 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbdBSTle (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Feb 2017 14:41:34 -0500
Received: by mail-wm0-f68.google.com with SMTP id r18so11021670wmd.3
        for <linux-mmc@vger.kernel.org>; Sun, 19 Feb 2017 11:41:34 -0800 (PST)
In-Reply-To: <m2wpcrbdjr.fsf@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Am 15.02.2017 um 17:54 schrieb Kevin Hilman:
> Heiner Kallweit <hkallweit1@gmail.com> writes:
> 
>> CMD23 isn't supported on meson-gx and therefore the "set block count"
>> command isn't used. So remove this dead code.
> 
> I'm admittedly a bit unfamiliar with the MMC spec and wrote this driver
> mostly by looking at the vendor driver, so forgive the silly
> questions...
> 
> Why isn't CMD23 supported, and should we support instead of deleting
> this support?
> 
After clarification by Ulf that CMD23 is not a host feature but a host
driver feature I added this feature to the driver.
I will submit it once the smaller refactorings are applied.

Heiner

> Kevin
> 
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index 1ad66f84..e89bdf5f 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -555,11 +555,7 @@ static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>  	writel(0, host->regs + SD_EMMC_START);
>>  
>>  	host->mrq = mrq;
>> -
>> -	if (mrq->sbc)
>> -		meson_mmc_start_cmd(mmc, mrq->sbc);
>> -	else
>> -		meson_mmc_start_cmd(mmc, mrq->cmd);
>> +	meson_mmc_start_cmd(mmc, mrq->cmd);
>>  }
>>  
>>  static int meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
>> @@ -690,7 +686,7 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>>  	}
>>  
>>  	meson_mmc_read_resp(host->mmc, cmd);
>> -	if (!data || !data->stop || mrq->sbc)
>> +	if (!data || !data->stop)
>>  		meson_mmc_request_done(host->mmc, mrq);
>>  	else
>>  		meson_mmc_start_cmd(host->mmc, data->stop);
> 

