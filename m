From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Fixup broken suspend and eMMC4.5 power off notify
Date: Fri, 14 Sep 2012 11:19:05 +0200
Message-ID: <CAPDyKFoWMO1Jz2XuawEffzmemvmhecHdiA8BeRxVU49jtYjAag@mail.gmail.com>
References: <1347528053-8521-1-git-send-email-ulf.hansson@stericsson.com>
	<CAGxe1ZF5hBoV5seKYDnwCNgk0ff1+wcie1RgEX19MFGAnNYebg@mail.gmail.com>
	<CAGxe1ZF6FDTxrbmBkzzSqhP8TPjA_7MbZPukaAeSzs8KOu1m2g@mail.gmail.com>
	<CAPDyKFotCTKX9O3KYtr3ZtAqaoCaNuHWDYfP23=+z11=_7XQOA@mail.gmail.com>
	<CAGxe1ZFJhc-c8rS0KGdfTvejs27jjpz7T4Z2AVwoB-=7QOMemg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:44588 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758166Ab2INJTH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Sep 2012 05:19:07 -0400
Received: by weyx8 with SMTP id x8so2263231wey.19
        for <linux-mmc@vger.kernel.org>; Fri, 14 Sep 2012 02:19:06 -0700 (PDT)
In-Reply-To: <CAGxe1ZFJhc-c8rS0KGdfTvejs27jjpz7T4Z2AVwoB-=7QOMemg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Saugata Das <saugata.das@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>

On 14 September 2012 10:25, Girish K S <girish.shivananjappa@linaro.org> wrote:
> On 14 September 2012 12:37, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Hi Girish,
>>
>> I should also have stated that this patch has not been tested with an
>> eMMC 4.5 device, thus the power off notification is not fully tested.
>> Unfortunate I don't have such a device available right now. What I did
>> test was that patch must not break anything and tested that the
>> suspend/resume sequence is fixed for eMMC with sleep support. I also
>> tested this with MMC_CAP2_POWEROFF_NOTIFY enabled.
>>
>> Are you able to help out in testing with a eMMC 4.5 device with
>> POWER_OFF_NOTIFY support?
> I am also facing the same  problem. The board that i used earlier to
> upstream 4.5 patches is not functioning. Thats the reason for the
> delay in upstreaming or sending the patch. Once i get it repaired i ll
> definitely do it.
> It would be helpful if somebody in the list can do this in the mean time.

Ah, I see.

If not possible to test soon, I anyway think we should go ahead with
this patch, since it fixes the supend/resume sequence for eMMC with
sleep, which to me is far more important right know, it has been
broken for several month now. If there are any issues with power off
notify feature, we can fix that later on. What do you think of that
approach?

Kind regards
Ulf Hansson
