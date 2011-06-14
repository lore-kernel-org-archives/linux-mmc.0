From: Olof Johansson <olof@lixom.net>
Subject: Re: Resume issue with brcmfmac *not* loaded
Date: Mon, 13 Jun 2011 18:12:32 -0700
Message-ID: <BANLkTinAXsHYBZ0uSY4ZtTd=f=7LNQM+_9o_FcLLYs1iPfL=YQ@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF04992C026B@HQMAIL01.nvidia.com>
	<BANLkTimJXtFB5Qi9sjVOWhrKVfuE5O1p-uhGMq_WmnJPJcugpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:63771 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab1FNBMd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2011 21:12:33 -0400
Received: by fxm6 with SMTP id 6so4770078fxm.11
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2011 18:12:32 -0700 (PDT)
In-Reply-To: <BANLkTimJXtFB5Qi9sjVOWhrKVfuE5O1p-uhGMq_WmnJPJcugpg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Stephen Warren <swarren@nvidia.com>, "cjb@laptop.org" <cjb@laptop.org>, "Greg KH (gregkh@suse.de)" <gregkh@suse.de>, "vrao@broadcom.com" <vrao@broadcom.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Olof Johansson <olofj@chromium.org>, Sukesh Srikakula <sukeshs@broadcom.com>

Hi,

=46irst, the below were pure guesses on my behalf, but browsing around
the sources for a few minutes seems to confirm that caps are... well,
caps. flags are currently active flags.

On Mon, Jun 13, 2011 at 5:26 PM, Grant Grundler <grundler@chromium.org>=
 wrote:
>> When the driver is loaded, suspend and resume (echo mem > /sys/state=
/power)
>> work fine.
>>
>> However, without the driver loaded, resume works, but 10 seconds lat=
er,
>> the kernel hangs a little, and spits out the errors quoted at the en=
d of
>> this email. The hangs interfere with other devices on the system; e.=
g.
>> audio DMA gets starved and causes audible artifacts.
>>
>> I tracked this down to brcmfmac's suspend function wl_cfg80211_suspe=
nd()
>> calling sdioh_sdio_set_host_pm_flags(MMC_PM_KEEP_POWER).
>
> Broadcom and/or Olofj might have insight in this. It's not clear to m=
e
> why loading the driver on resume would break this. =A0Loading the dri=
ver
> at boot time works fine for me and should essentially be exercising
> the same code path from the driver PoV.

Sounds to me like loading the driver isn't what is breaking things,
it's the suspend/resume without a driver at all.

That slot lacks a CD GPIO, which means that the MMC code will poll for
cards present. It seems like one of those polls are what's causing
problem in this case.

The wifi adapter will stay powered across the suspend/resume (external
power feed, not part of MMC). So the MMC interface will go down but
the card will remain powered.

>> I note that the MMC controller suspend/resume path are influenced by
>> MMC_PM_KEEP_POWER, but only when the driver for the attached SDIO de=
vice
>> specify that flag, hence it's in host->pm_flags and not just in
>> host->pm_caps.
>
> Sorry, I don't know the difference and assume Olof does.
>
>
>> If I hack all the MMC core code to look for (host->pm_caps &
>> MMC_PM_KEEP_POWER) instead of (host->pm_flags & MMC_PM_KEEP_POWER), =
then
>> suspend/resume works fine even without the brcmfmac driver loaded.
>
> Olof (just walked by) suspects pm_caps means it's supported and
> pm_flags indicates state (enabled).

Right -- it sounds to me like checking caps at resume time is the
wrong way to go about it -- caps are just caps, and flags are the
current actual setting.

>> I imagine such a change isn't blanket appropriate for the MMC core. =
Can
>> anyone clue me in on:
>>
>> * Is the call to sdioh_sdio_set_host_pm_flags() just something that =
masks
>> a somewhat unrelated problem that should be investigated, or a direc=
t fix
>> for this issue?

Sounds to me like there's another problem going on here. I wonder if
the card gets confused if the host goes away and comes back without it
having been power cycled as well.

This should be simple for Broadcom to reproduce, and they are the ones
with the knowledge of how their adapter behaves. So I'd like to hear
from them about this.

>> Note that the call to sdioh_sdio_set_host_pm_flags() was introduced =
to
>> staging-2.6.git in commit 6b5a5a3eb77ea69382da9d2a64d74107e49cedaa
>> "STAGING: brcm80211 v2 keep power on in suspend state".

Reverting that change won't make a difference in this case, will it?


Sounds like the solution here might instead be:

* Specify the power_gpio properly for the slot in question (it does
have one wired up if I'm reading the right schematics, it's just not
specified in the board file)
* Add a suspend/resume function to the sdhci-tegra driver currently
not in use, that disables power to the slot during suspend if the
pm_flags don't have MMC_KEEP_POWER set.


That should take care of this issue, but it would also be good to hear
from Broadcom above as to why the current behavior causes problems.


-Olof
