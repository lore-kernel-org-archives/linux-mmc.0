From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: add auto bkops support
Date: Mon, 27 Jun 2016 11:00:07 +0200
Message-ID: <CAPDyKFqehk9Prnz_KM+7w5CzWd-wC51C=Searke-tH7hJqYaKA@mail.gmail.com>
References: <1465182439-27963-1-git-send-email-shawn.lin@rock-chips.com>
 <575E52AC.6000902@intel.com> <8bbb3f13-efb3-e963-e53f-cf2ca796f319@rock-chips.com>
 <575E6C11.8060709@intel.com> <b22ae70d-5128-639d-eef0-8ac9cdd2b8e4@rock-chips.com>
 <575EA651.7060606@intel.com> <CAPDyKFq7Pr1YiacwpeDq3eAYmApydTj8Kbkyh=Cb6+vJC9BV3Q@mail.gmail.com>
 <64ed1ed2-09ff-659e-01f8-87a1071883d1@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38746 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbcF0JAJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jun 2016 05:00:09 -0400
Received: by mail-wm0-f44.google.com with SMTP id r201so104842851wme.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2016 02:00:09 -0700 (PDT)
In-Reply-To: <64ed1ed2-09ff-659e-01f8-87a1071883d1@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Alex Lemberg <alex.lemberg@sandisk.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

[...]

>>>> one possible way is to control it by mmc-utils on
>>>> user space?  So we should add a cmd for mmc-utils
>>>> there?
>>>
>>>
>>> That would be consistent with manual bkops.
>>>
>>
>>> From my first impression I agree, as that is the policy we have been
>>
>> sticking to when writing to persistent EXT_CSD persistent .
>> Although, in this case, I am actually wondering on what is the best
>> approach.
>
>
> I don't know what is the real meaning of "persistent". :)
> I don't know should we count auto bkops as the persistent
> registers....HS_TIMING and BUS_WIDTH should also be persistent
> registers as them are always used after initialization if not changing
> them?
>
> IHMO the more reasonable way is that:
> IIRC many settings for  EXT_CSD should be OTP, like hw-reset(162),
> reliable write(167) fw-configure(169)..etc, which are marked as R/W.
> These should be controlled by userpace or even by firmware when
> flashing emmc, like reliable write...

Yes, that's makes sense to me. OTP registers must only be written to
via mmc utils/userspace.

>
>
> I'm not sure whether should I updete this $SUBJUCT or migirating it to
> userspace... We need to come to an agreement :)
>

I don't have any issue to allow all non-OTP registers bits to be written.

Kind regards
Uffe
