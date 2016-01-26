From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH 1/2 v2] mmc: enable mmc host device to suspend/resume
 asynchronously
Date: Tue, 26 Jan 2016 10:15:29 +0800
Message-ID: <56A6D6C1.9060805@linux.intel.com>
References: <56A1A2C2.1030106@linux.intel.com>
 <CAPDyKFrKmTfA2GjQDmFnh0hRzeP8kcKGL6oMSzrZihyGL4pQUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20869 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914AbcAZCPd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 25 Jan 2016 21:15:33 -0500
In-Reply-To: <CAPDyKFrKmTfA2GjQDmFnh0hRzeP8kcKGL6oMSzrZihyGL4pQUA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Venu Byravarasu <vbyravarasu@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 1/22/2016 10:51 PM, Ulf Hansson wrote:
> On 22 January 2016 at 04:32, Fu, Zhonghui <zhonghui.fu@linux.intel.com> wrote:
>> This patch enables mmc hosts to suspend/resume asynchronously.
>> This will improve system suspend/resume speed. After applying
>> this patch and enabling all mmc hosts' child devices to
>> suspend/resume asynchronously on ASUS T100TA, the system
>> suspend-to-idle time is reduced from 1645ms to 1107ms, and the
>> system resume time is reduced from 940ms to 914ms.
> Do you really reduce time at all with this patch by its own? I think not.
>
> Moreover, I thought the biggest improvement came from the patch which
> enabled async suspend/resume for the MMC/SD/SDIO device?
> ec076cd226c3 ("mmc: enable MMC/SD/SDIO device to suspend/resume asynchronously")
>
> Similar comment applies to patch2/2, but I would expect it together
> with the $subject patch gives an improvement.
>
> Please update the change-logs one more round.

The reduce time is not contributed by only this patch, please see the change-log: "After applying this patch and enabling all mmc hosts' child devices to suspend/resume asynchronously on ASUS T100TA .......". Actually, the biggest improvement came from the patch - "net/wireless: enable wiphy device to suspend/resume asynchronously(commit 9f0e13546ef5773b7059b531a667ec47a5f897ee)". Wiphy device(phy0) is child device of WiFi card(SDIO card).

Do you mean that I should list the reduce time contributed by only this patch and patch2/2 in change-log?


Thanks,
Zhonghui
>
> Kind regards
> Uffe
>
>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>> Acked-by: Venu Byravarasu <vbyravarasu@nvidia.com>
>> ---
>> Changes in v2:
>> - Update commit message
>>
>>  drivers/mmc/core/host.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index 0aecd5c..1d94607 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -339,6 +339,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>>         host->class_dev.parent = dev;
>>         host->class_dev.class = &mmc_host_class;
>>         device_initialize(&host->class_dev);
>> +       device_enable_async_suspend(&host->class_dev);
>>
>>         if (mmc_gpio_alloc(host)) {
>>                 put_device(&host->class_dev);
>> -- 1.7.1
>>

