From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: SD8686 fast power-cycle problems
Date: Fri, 24 Jun 2011 23:38:54 +0800
Message-ID: <BANLkTi=81-67hrgpeUoXdgemdmTLSM5Hsw@mail.gmail.com>
References: <BANLkTimsjb_cvcDKQpuqN_GxNWnyA0ebRg@mail.gmail.com>
	<BANLkTim1rai5pv+hW3mMxXieq5289oYJSg@mail.gmail.com>
	<BANLkTimoOXZvNt_GR4EHcSX_YecOubLPbw@mail.gmail.com>
	<BANLkTinQNA8+Wkto_Hkwo_kKrXg6EGKidQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40588 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab1FXPiz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jun 2011 11:38:55 -0400
Received: by vxb39 with SMTP id 39so2068692vxb.19
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jun 2011 08:38:54 -0700 (PDT)
In-Reply-To: <BANLkTinQNA8+Wkto_Hkwo_kKrXg6EGKidQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: zhangfei.gao@marvell.com, bzhao@marvell.com, bchau@marvell.com, linux-mmc@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>

On Thu, Jun 23, 2011 at 10:29 PM, Daniel Drake <dsd@laptop.org> wrote:
> On 19 June 2011 14:10, zhangfei gao <zhangfei.gao@gmail.com> wrote:
>> How do you power off 8686 now?
>> Use RESETn, PDn, or directly control regulator?
>> Assume RESETn is kept high as Ohad mentioned before, do you control PDn?
>
> We use mmc_power_off(), which calls mmc_set_ios() which is implemented by sdhci.
>
> We don't make any effort to control the specific pins, we just rely on
> what sdhci does for us, which presumably is a standard way of removing
> power from SD cards.
>
> Thanks,
> Daniel

Thanks Daniel,
But mmc_set_ios does not mean can't access PDn pin.
At least, in drivers/mmc/host/omap.c, set_ios->set_power->pdata->set_power.
Whatever, if directly controller regulator, the time is required for
voltage go to certain level.

/Zhangfei
