From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH V2 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to
 handle regulators
Date: Mon, 25 Aug 2014 08:06:50 -0700
Message-ID: <CAD=FV=U-izXxh2DcBs=ZmS5vhvByHYL9yX7xOsDq-0te=dmC8Q@mail.gmail.com>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
	<1408715272-13833-2-git-send-email-yuvaraj.cd@samsung.com>
	<53FB2CC2.9070905@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:44602 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755846AbaHYPGw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Aug 2014 11:06:52 -0400
Received: by mail-vc0-f181.google.com with SMTP id lf12so15446659vcb.12
        for <linux-mmc@vger.kernel.org>; Mon, 25 Aug 2014 08:06:50 -0700 (PDT)
In-Reply-To: <53FB2CC2.9070905@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Prashanth G <prashanth.g@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Abhilash Kesavan <a.kesavan@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, CPGS <cpgs@samsung.com>

Jaehoon,

On Mon, Aug 25, 2014 at 5:32 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 08/22/2014 10:47 PM, Yuvaraj Kumar C D wrote:
>> This patch makes use of mmc_regulator_get_supply() to handle
>> the vmmc and vqmmc regulators.Also it moves the code handling
>> the these regulators to dw_mci_set_ios().It turned on the vmmc
>> and vqmmc during MMC_POWER_UP and MMC_POWER_ON,and turned off
>> during MMC_POWER_OFF.
>>
>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>> ---
>> changes from v1:
>>       1.Used mmc_regulator_set_ocr() instead of regulator_enable() for vmmc.
>>       2.Turned on vmmc and vqmmc during MMC_POWER_UP.
>>       3. Removed the flags DW_MMC_CARD_POWERED and DW_MMC_IO_POWERED which
>>          added during the initial version of this patch.
>>       4. Added error message, if it failed to turn on regulator's.
>>
>>  drivers/mmc/host/dw_mmc.c  |   72 +++++++++++++++++++++-----------------------
>>  include/linux/mmc/dw_mmc.h |    2 +-
>>  2 files changed, 36 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 7f227e9..aadb0d6 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -936,6 +936,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>       struct dw_mci_slot *slot = mmc_priv(mmc);
>>       const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
>>       u32 regs;
>> +     int ret;
>>
>>       switch (ios->bus_width) {
>>       case MMC_BUS_WIDTH_4:
>> @@ -974,12 +975,38 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>
>>       switch (ios->power_mode) {
>>       case MMC_POWER_UP:
>> +             if (!IS_ERR(mmc->supply.vmmc)) {
>> +                     ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
>> +                                     ios->vdd);
>> +                     if (ret) {
>> +                             dev_err(slot->host->dev,
>> +                                     "failed to enable vmmc regulator\n");
>> +                             /*return, if failed turn on vmmc*/
>> +                             return;
>> +                     }
>> +             }
>> +             if (!IS_ERR(mmc->supply.vqmmc) && !slot->host->vqmmc_enabled) {
>
> Can't use the regulator_is_enabled() instead of "slot->host->vqmmc_enabled"?

I think we mentioned this before, but regulator_is_enabled() won't do
what you want with shared regulators since they are refcounted.  You
need to keep track of whether you've enabled the regulator yourself.

-Doug
