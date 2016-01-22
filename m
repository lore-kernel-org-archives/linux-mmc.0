From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH 2/2] mmc/sdhci-acpi: enable sdhci-acpi device to
 suspend/resume asynchronously
Date: Fri, 22 Jan 2016 12:38:53 +0800
Message-ID: <56A1B25D.7070307@linux.intel.com>
References: <56815841.80901@linux.intel.com>
 <CAPDyKFp49fQomB-yoWwcu54KfHyPL3ibHTPiMHknwsrZVvhdhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50136 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbcAVEi5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Jan 2016 23:38:57 -0500
In-Reply-To: <CAPDyKFp49fQomB-yoWwcu54KfHyPL3ibHTPiMHknwsrZVvhdhw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Michele Curti <michele.curti@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 1/12/2016 10:43 PM, Ulf Hansson wrote:
> On 28 December 2015 at 16:41, Fu, Zhonghui <zhonghui.fu@linux.intel.com> wrote:
>> Now, PM core supports asynchronous suspend/resume mode for devices
>> during system suspend/resume, and the power state transition of one
>> device may be completed in separate kernel thread. PM core ensures
>> all power state transition dependency between devices. This patch
>> enables sdhci-acpi devices to suspend/resume asynchronously. This
>> will take advantage of multicore and improve system suspend/resume
>> speed. After enabling the sdhci-acpi devices and all their child
>> devices to suspend/resume asynchronously on ASUS T100TA, the system
>> suspend-to-idle time is reduced from 1645ms to 1089ms, and the
>> system resume time is reduced from 940ms to 908ms.
> Same comment as for patch 1.

I have updated the change log according to your comments and resent this patch - "[PATCH 2/2 v2] mmc/sdhci-acpi: enable sdhci-acpi device to suspend/resume asynchronously".


Thanks,
Zhonghui


>
>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>> ---
>>  drivers/mmc/host/sdhci-acpi.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>> index f6047fc..3d27f2d 100644
>> --- a/drivers/mmc/host/sdhci-acpi.c
>> +++ b/drivers/mmc/host/sdhci-acpi.c
>> @@ -388,6 +388,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>                 pm_runtime_enable(dev);
>>         }
>>
>> +       device_enable_async_suspend(dev);
>> +
>>         return 0;
>>
>>  err_free:
>> -- 1.7.1
>>
> Otherwise, looks good!
>
> Kind regards
> Uffe

