From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] mmc: enable mmc host device to suspend/resume asynchronously
Date: Mon, 21 Sep 2015 14:27:15 +0800
Message-ID: <55FFA343.7000200@linux.intel.com>
References: <55BF60F5.8040602@linux.intel.com> <CAPDyKFpRpGyCCoOU44CwiUxsJW1fMs8FxShvVga+uFHKvy7BBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:65379 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587AbbIUG10 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Sep 2015 02:27:26 -0400
In-Reply-To: <CAPDyKFpRpGyCCoOU44CwiUxsJW1fMs8FxShvVga+uFHKvy7BBQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Markus Niebel <Markus.Niebel@tq-group.com>, Lars-Peter Clausen <lars@metafoo.de>, Sascha Hauer <s.hauer@pengutronix.de>, =?UTF-8?B?S3Jpc3RpbmEgTWFydMWhZW5r?= =?UTF-8?B?bw==?= <kristina.martsenko@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 2015/8/27 21:05, Ulf Hansson wrote:
> On 3 August 2015 at 14:39, Fu, Zhonghui <zhonghui.fu@linux.intel.com>=
 wrote:
>> Enable mmc host device to suspend/resume asynchronously.
>> This can improve system suspend/resume speed.
> Can or will?
>
> It would be nice to see some statistics of this to justify the change=
=2E
> Can you share that?
>
> Moreover we already have the runtime PM support, which enables the
> reinitialization sequence of the mmc/sd card to be postponed from the
> system PM resume path. Instead that's done when the next
> pm_runtime_get_sync() for the card's device gets called. You my tried
> that feature by enabling MMC_CAP_RUNTIME_RESUME for the mmc hosts.
This "will" improve system suspend/resume speed. I have resent this pat=
ch with updated commit message - "[PATCH v2] mmc: enable mmc host devic=
e to suspend/resume asynchronously".

The original suspend time is 1645ms and resume time is 940ms on ASUS T1=
00TA machine. After enabling "wiphy device", "SDIO device", "mmc host" =
and "sdhci-acpi device" to suspend/resume asynchronously, the suspend t=
ime is 1096ms and resume time is 908ms. The test environment is listed =
as follows:

OS: Ubuntu 14.04
Kernel: mainline v4.1
Machine: ASUS T100TA(Baytrail-T platform)
Tool: analyze_suspend
=E2=80=9Canalyze_suspend.py =E2=80=93f =E2=80=93m freeze=E2=80=9D to su=
spend system
Press power button to resume system

System PM is independent from runtime PM. Now, PM core supports asynchr=
onous suspend/resume mode for devices during system suspend/resume, and=
 the power state transition of one
device may be completed in separate kernel thread. PM core ensures all =
power state transition timing dependency between devices. This patch en=
ables mmc host device to suspend/resume asynchronously. This will take =
advantage of multicore and improve system suspend/resume speed.


Thanks,
Zhonghui
> Kind regards
> Uffe
>
>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>> ---
>>  drivers/mmc/core/host.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index 99a9c90..85f2bbb 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -577,6 +577,7 @@ struct mmc_host *mmc_alloc_host(int extra, struc=
t device *dev)
>>         host->class_dev.parent =3D dev;
>>         host->class_dev.class =3D &mmc_host_class;
>>         device_initialize(&host->class_dev);
>> +       device_enable_async_suspend(&host->class_dev);
>>
>>         if (mmc_gpio_alloc(host)) {
>>                 put_device(&host->class_dev);
>> -- 1.7.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

