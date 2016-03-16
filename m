From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH v2] mmc: Add CONFIG_MMC_SIMULATE_MAX_SPEED
Date: Wed, 16 Mar 2016 09:45:13 -0700
Message-ID: <56E98D99.5070807@android.com>
References: <1456161565-24154-1-git-send-email-salyzyn@android.com>
 <CAPDyKFp99i6zOnhLYmnK4mKdx5HRV+RxXKJBHVi9dzp-A10Fsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34442 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932803AbcCPQp1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 12:45:27 -0400
Received: by mail-pf0-f181.google.com with SMTP id x3so81593579pfb.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Mar 2016 09:45:15 -0700 (PDT)
In-Reply-To: <CAPDyKFp99i6zOnhLYmnK4mKdx5HRV+RxXKJBHVi9dzp-A10Fsg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Adrian Hunter <adrian.hunter@intel.com>, Yangbo Lu <yangbo.lu@freescale.com>, Tomas Winkler <tomas.winkler@intel.com>, Andrew Morton <akpm@linux-foundation.org>, James Bottomley <JBottomley@odin.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Grant Grundler <grundler@chromium.org>, Jon Hunter <jonathanh@nvidia.com>, Luca Porzio <lporzio@micron.com>, Yunpeng Gao <yunpeng.gao@intel.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 03/16/2016 06:03 AM, Ulf Hansson wrote:
> On 22 February 2016 at 18:18, Mark Salyzyn <salyzyn@android.com> wrote:
>> When CONFIG_MMC_SIMULATE_MAX_SPEED is enabled, Expose max_read_speed,
>> max_write_speed and cache_size sysfs controls to simulate a slow
>> eMMC device. The boot default values, should one wish to set this
>> behavior right from kernel start:
>>
>> CONFIG_MMC_SIMULATE_MAX_READ_SPEED
>> CONFIG_MMC_SIMULATE_MAX_WRITE_SPEED
>> CONFIG_MMC_SIMULATE_CACHE_SIZE
>>
>> respectively; and if not defined are 0 (off), 0 (off) and 4 MB
>> also respectively.
> So this changelog doesn't really tell me *why* this feature is nice to
> have. Could you elaborate on this and thus also extend the information
> in the changelog please.

Will do. Why is certainly missing ;-}

Basically we have three choices to determine how a system may behave 
when one has an aged out eMMC:

1) wait until we can acquire a device with an old eMMC.
2) increase the temperature on the device and run io activity under a 
controlled level until the number of available erase blocks disappear, 
or the physical device itself slows.
3) we can adjust the driver to behave in the similar manner, but backed 
with a healthy (or rather healthier) eMMC.

#3 is plain just faster and cheaper.

I have one other duty for this driver is to switch out the default 
config parameters with module (kernel command line) parameters. Alas I 
have been swamped for the past little while.

> Moreover, I have briefly reviewed the code, but I don't want to go
> into the details yet... Instead, what I am trying to understand if
> this is something that useful+specific for the MMC subsystem, or if
> it's something that belongs in the upper generic BLOCK layer. Perhaps
> you can comment on this as well?

A feature much like this can be useful in an upper generic block layer, 
in fact I have done so in past lives for spinning media, or RAID 
systems, for private/proprietary/development needs. However, each type 
of system has a different set of characteristics and tunables to 
simulate more accurately their behavior. It is, however, far more 
complex to simulate with a device that allows more than one outstanding 
command, so it is dead simple to add this into the eMMC driver.

This change starts out with some of the basics, but device cache 
behavior is certainly different between this, RAID or spinning media 
(eMMC is simpler to emulate). And if/when we feel the need to expand the 
simulation to incorporate a limited pool of erase blocks due to aging or 
lack of recent fstrim, we certainly will enter device-specific 
territory. It will be easier to build in additional precision to the 
simulation if we keep this inside the eMMC driver.

Spinning media, for instance, would have its own simulation of drive 
head, track and sector position in order to simulate the latencies, 
however I have found adding an average latency works well enough in most 
scenarios. For RAID, _all_ component drives would need to have their own 
mechanical tracking if we wanted to add precision. If I put something 
like this in the block layer, I will be signing up for a quagmire if I 
was to aid the additional development. Do not get me started on solid 
state drives ...

Sadly, I am only passionate about eMMC _today_ since this could work on 
any of the 1.6billion devices on the planet right now, and it is a tiny 
and KISS cut-in ;-} (merged clean from linux3.4 to current)

>
> Kind regards
> Uffe
>

