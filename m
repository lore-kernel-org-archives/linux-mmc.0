From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: FW: [PATCH 0/3] mmc: Use runtime pm for blkdevice
Date: Thu, 7 Mar 2013 11:41:22 +0800
Message-ID: <CAPDyKFoHXMkDhmGHQJ88FvT1kv888y8QYBpz0uXMm8Yyk7ZheQ@mail.gmail.com>
References: <ED64882F200EF5419CDAC2E6B5C4B3A2097FC4412E@SC-VEXCH1.marvell.com>
	<25B60CDC2F704E4E9D88FFD52780CB4C0BDE9E0DE9@SC-VEXCH1.marvell.com>
	<CADz5_gLDMUYNEz32z+BANYdDid5ANPx5t48m=1bgTDjV52FK3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:54524 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489Ab3CGDlX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Mar 2013 22:41:23 -0500
Received: by mail-la0-f42.google.com with SMTP id fe20so8246507lab.15
        for <linux-mmc@vger.kernel.org>; Wed, 06 Mar 2013 19:41:22 -0800 (PST)
In-Reply-To: <CADz5_gLDMUYNEz32z+BANYdDid5ANPx5t48m=1bgTDjV52FK3A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Johan Rudholm <johan.rudholm@stericsson.com>

On 7 March 2013 01:12, Kevin Liu <keyuan.liu@gmail.com> wrote:
>> From: Ulf Hansson <ulf.hansson@stericsson.com<mailto:ulf.hansson@stericsson.com>>
>> Date: Fri, Mar 1, 2013 at 8:47 PM
>> Subject: [PATCH 0/3] mmc: Use runtime pm for blkdevice
>> To: linux-mmc@vger.kernel.org<mailto:linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org<mailto:cjb@laptop.org>>
>> Cc: Johan Rudholm <johan.rudholm@stericsson.com<mailto:johan.rudholm@stericsson.com>>, Ulf Hansson <ulf.hansson@linaro.org<mailto:ulf.hansson@linaro.org>>
>>
>>
>> From: Ulf Hansson <ulf.hansson@linaro.org<mailto:ulf.hansson@linaro.org>>
>>
>> SDIO has been using runtime pm for a while to handle runtime power save
>> operations. This patchset is enabling the option to make the sd/mmc
>> blockdevices to use runtime pm as well.
>>
>> The runtime pm implementation for the block device will make use of
>> autosuspend to defer power save operation to after request inactivty for
>> a certain time.
>>
>> To actually perform some power save operations the corresponding bus ops
>> for mmc and sd shall be implemented. Typically it could make sense to do
>> BKOPS for eMMC in here.
>>
>> Ulf Hansson (3):
>>   mmc: core: Remove power_restore bus_ops for mmc and sd
>>   mmc: core: Add bus_ops for runtime pm callbacks
>>   mmc: block: Enable runtime pm for mmc blkdevice
>>
> Ulf,
>
> sdhci.c has added pm_runtime which also protect between request and
> task finish. And some sdhci.c based host drivers has provided
> pm_runtime_suspend/resume functions like sdhci-pxav3.c. From the
> powersave viewpoint, I think adding pm_runtime in driver level is
> better than doing that on bus level since the control granularity is
> even smaller. And adding pm_runtime in both block.c and sdhci.c will
> call pm_runtime twice. How do you think?
>
> Thanks
> Kevin

Hi Kevin,

Thanks for your response!

It seems like we need some more clarification around this area.
Runtime pm for a host device driver shall ultimately be responsible
for taking care of runtime power management of the host device - only.
It should not handle runtime power management of a block device, which
in principle means BKOPS shall be handled in the blkdevice. At least
this is my view.

So, why is this? I will try to elaborate on the runtime pm support in
host drivers here.
The host device driver controls a MMC/SD/SDIO IP. This IP could very
well reside (for some SoC) in what you call a power domain. In
principle, once the IP needs to be used, a host driver has done a
pm_runtime_get of it's device. This will mean a reference to the power
domain has been fetched. Once the IP is not needed any more,
pm_runtime_put is done and the reference to the power domain is
released. Once no reference to the power domain exist the power domain
can enter lower sleep states, which is preferred to happen as soon as
possible and as long as possible - of course.

Hope this gives a better understanding. :-)

Kind regards
Ulf Hansson
