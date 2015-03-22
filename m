From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Don't send clock off command if power is off
Date: Sun, 22 Mar 2015 14:59:27 -0700
Message-ID: <CAD=FV=VUG54vk9xD9zEnaP_rQcL4cWLOHuy76aMRta0OOsLn1g@mail.gmail.com>
References: <1426874420-25103-1-git-send-email-dianders@chromium.org>
	<CAGOxZ52OWucMh_HjWnZnhN=c7C3TXeQ4aV-GAe5XXtRbu0r2Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35406 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbbCVV72 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Mar 2015 17:59:28 -0400
Received: by ieclw3 with SMTP id lw3so23551516iec.2
        for <linux-mmc@vger.kernel.org>; Sun, 22 Mar 2015 14:59:27 -0700 (PDT)
In-Reply-To: <CAGOxZ52OWucMh_HjWnZnhN=c7C3TXeQ4aV-GAe5XXtRbu0r2Kg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Alim,

On Sun, Mar 22, 2015 at 5:16 AM, Alim Akhtar <alim.akhtar@gmail.com> wrote:
>>         case MMC_POWER_OFF:
>> -               /* Turn clock off before power goes down */
>> -               dw_mci_setup_bus(slot, false);
>> +               /* Turn clock off before power goes down; only if powered */
>> +               if (slot->host->vqmmc_enabled)
>> +                       dw_mci_setup_bus(slot, false);
>>
> vqmmc_enabled is always _true_ when entering MMC_POWER_OFF case..right?
> Is this done for extra protection? Or do you have a case where vqmmc
> is OFF and driver still calls dw_mci_setup_bus from here?

Hmm.  I know I got it into the debugger in at least one reboot case
where it was failing to turn the clock off.  I thought I confirmed it
was the core trying to call MMC_POWER_OFF when the power was already
off, but now I'm less certain.  I looked back at my debug session and
I don't see where I got that evidence.  :-/  Certainly if I put a
printout here right now I can't see my code making a difference.

Unfortunately the crash was a very rare one, so I may have to go back
to the drawing board here...

-Doug
