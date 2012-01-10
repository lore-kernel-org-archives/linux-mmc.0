From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH V3] mmc: Set suspend/resume bus operations if CONFIG_PM_RUNTIME
 is used
Date: Tue, 10 Jan 2012 09:47:44 +0100
Message-ID: <4F0BFB30.9040204@stericsson.com>
References: <20120109180858.C5AAB3835D@ushik.mtv.corp.google.com> <CANQgH-buXcVF3Oy1+8=C-OZ3RfC1c=4fiwK9613ccL73gDKMaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:60424 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752684Ab2AJIsD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2012 03:48:03 -0500
In-Reply-To: <CANQgH-buXcVF3Oy1+8=C-OZ3RfC1c=4fiwK9613ccL73gDKMaw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@google.com>
Cc: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Datta, Shubhrajyoti wrote:
> Hi Dmitry,
> 
> 
> On Mon, Jan 9, 2012 at 11:34 PM, Dmitry Shmidt <dimitrysh@google.com> wrote:
>> Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
>> ---
>>  drivers/mmc/card/block.c |    4 ++--
>>  drivers/mmc/core/bus.c   |   27 +++++++++------------------
>>  include/linux/mmc/card.h |    2 +-
>>  3 files changed, 12 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 1e0e27c..5724ae1 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1676,8 +1676,8 @@ static void mmc_blk_remove(struct mmc_card *card)
>>        mmc_set_drvdata(card, NULL);
>>  }
>>
>> -#ifdef CONFIG_PM
>> -static int mmc_blk_suspend(struct mmc_card *card, pm_message_t state)
>> +#ifdef CONFIG_PM_SLEEP
>> +static int mmc_blk_suspend(struct mmc_card *card)
>>  {
>>        struct mmc_blk_data *part_md;
>>        struct mmc_blk_data *md = mmc_get_drvdata(card);
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index 6be4924..f325aa6 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -122,18 +122,19 @@ static int mmc_bus_remove(struct device *dev)
>>        return 0;
>>  }
>>
>> -static int mmc_bus_suspend(struct device *dev, pm_message_t state)
>> +#ifdef CONFIG_PM_SLEEP
>> +static int mmc_bus_pm_suspend(struct device *dev)
> Was the name change intentional.

I believe there should be no reason for changing these names (same for 
mmc_bus_resume). Otherwise, great! You will have my Ack!

BR
Ulf Hansson
