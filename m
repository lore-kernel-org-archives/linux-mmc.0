From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Don't send clock off command if power is off
Date: Fri, 27 Mar 2015 16:21:09 +0900
Message-ID: <551504E5.7060304@samsung.com>
References: <1426874420-25103-1-git-send-email-dianders@chromium.org>
 <CAGOxZ52OWucMh_HjWnZnhN=c7C3TXeQ4aV-GAe5XXtRbu0r2Kg@mail.gmail.com>
 <CAD=FV=VUG54vk9xD9zEnaP_rQcL4cWLOHuy76aMRta0OOsLn1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:56539 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbbC0HVM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Mar 2015 03:21:12 -0400
In-reply-to: <CAD=FV=VUG54vk9xD9zEnaP_rQcL4cWLOHuy76aMRta0OOsLn1g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Alim Akhtar <alim.akhtar@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On 03/23/2015 06:59 AM, Doug Anderson wrote:
> Alim,
> 
> On Sun, Mar 22, 2015 at 5:16 AM, Alim Akhtar <alim.akhtar@gmail.com> wrote:
>>>         case MMC_POWER_OFF:
>>> -               /* Turn clock off before power goes down */
>>> -               dw_mci_setup_bus(slot, false);
>>> +               /* Turn clock off before power goes down; only if powered */
>>> +               if (slot->host->vqmmc_enabled)
>>> +                       dw_mci_setup_bus(slot, false);
>>>
>> vqmmc_enabled is always _true_ when entering MMC_POWER_OFF case..right?
>> Is this done for extra protection? Or do you have a case where vqmmc
>> is OFF and driver still calls dw_mci_setup_bus from here?
> 
> Hmm.  I know I got it into the debugger in at least one reboot case
> where it was failing to turn the clock off.  I thought I confirmed it
> was the core trying to call MMC_POWER_OFF when the power was already
> off, but now I'm less certain.  I looked back at my debug session and
> I don't see where I got that evidence.  :-/  Certainly if I put a
> printout here right now I can't see my code making a difference.

I'm not sure this is really needs...and i can't find any error case..

Best Regards,
Jaehoon Chung
> 
> Unfortunately the crash was a very rare one, so I may have to go back
> to the drawing board here...
> 
> -Doug
> 

