From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: FW: [PATCH 0/3] mmc: Use runtime pm for blkdevice
Date: Thu, 7 Mar 2013 01:12:11 +0800
Message-ID: <CADz5_gLDMUYNEz32z+BANYdDid5ANPx5t48m=1bgTDjV52FK3A@mail.gmail.com>
References: <ED64882F200EF5419CDAC2E6B5C4B3A2097FC4412E@SC-VEXCH1.marvell.com>
	<25B60CDC2F704E4E9D88FFD52780CB4C0BDE9E0DE9@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:38159 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab3CFRMM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Mar 2013 12:12:12 -0500
Received: by mail-oa0-f49.google.com with SMTP id j6so12729547oag.22
        for <linux-mmc@vger.kernel.org>; Wed, 06 Mar 2013 09:12:11 -0800 (PST)
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C0BDE9E0DE9@SC-VEXCH1.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

> From: Ulf Hansson <ulf.hansson@stericsson.com<mailto:ulf.hansson@stericsson.com>>
> Date: Fri, Mar 1, 2013 at 8:47 PM
> Subject: [PATCH 0/3] mmc: Use runtime pm for blkdevice
> To: linux-mmc@vger.kernel.org<mailto:linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org<mailto:cjb@laptop.org>>
> Cc: Johan Rudholm <johan.rudholm@stericsson.com<mailto:johan.rudholm@stericsson.com>>, Ulf Hansson <ulf.hansson@linaro.org<mailto:ulf.hansson@linaro.org>>
>
>
> From: Ulf Hansson <ulf.hansson@linaro.org<mailto:ulf.hansson@linaro.org>>
>
> SDIO has been using runtime pm for a while to handle runtime power save
> operations. This patchset is enabling the option to make the sd/mmc
> blockdevices to use runtime pm as well.
>
> The runtime pm implementation for the block device will make use of
> autosuspend to defer power save operation to after request inactivty for
> a certain time.
>
> To actually perform some power save operations the corresponding bus ops
> for mmc and sd shall be implemented. Typically it could make sense to do
> BKOPS for eMMC in here.
>
> Ulf Hansson (3):
>   mmc: core: Remove power_restore bus_ops for mmc and sd
>   mmc: core: Add bus_ops for runtime pm callbacks
>   mmc: block: Enable runtime pm for mmc blkdevice
>
Ulf,

sdhci.c has added pm_runtime which also protect between request and
task finish. And some sdhci.c based host drivers has provided
pm_runtime_suspend/resume functions like sdhci-pxav3.c. From the
powersave viewpoint, I think adding pm_runtime in driver level is
better than doing that on bus level since the control granularity is
even smaller. And adding pm_runtime in both block.c and sdhci.c will
call pm_runtime twice. How do you think?

Thanks
Kevin
