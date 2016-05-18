From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Consider HLE errors to be data and command errors
Date: Tue, 17 May 2016 17:47:34 -0700
Message-ID: <CAD=FV=UJGcwa_biSCGhD=kS-T+fppCniBFfOHb5ohnwSwSwMMA@mail.gmail.com>
References: <1426002490-2014-1-git-send-email-dianders@chromium.org>
 <5502CA4E.9060401@samsung.com> <CAD=FV=VX3ix-j4y95W1q8b-aVuVEN+4xsd8WLx2xcE7KPNJwRw@mail.gmail.com>
 <5506707D.40708@samsung.com> <55189F04.8000404@samsung.com> <CAD=FV=WFAZqAsXOqunt0fxw87M-FruwUrxuzW0MJsG6UvfSjzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36163 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbcERArg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 May 2016 20:47:36 -0400
Received: by mail-vk0-f42.google.com with SMTP id s184so41971267vkb.3
        for <linux-mmc@vger.kernel.org>; Tue, 17 May 2016 17:47:35 -0700 (PDT)
In-Reply-To: <CAD=FV=WFAZqAsXOqunt0fxw87M-FruwUrxuzW0MJsG6UvfSjzA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Alexandru Stan <amstan@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>

Jaehoon,

On Mon, Mar 30, 2015 at 8:47 AM, Doug Anderson <dianders@chromium.org> wrote:
> Jaehoon,
>
> On Sun, Mar 29, 2015 at 5:55 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Dear Doug,
>>
>> I'm considering to control HLE error..So holding this patch.
>> If this is absolutely necessary patch, let me know, plz.
>>
>> Best Regards,
>> Jaehoon Chung
>
> Sounds OK.  I have certainly applied this locally and the driver isn't
> robust against insertions / removals without it, but once the card is
> inserted things are OK so it's probably not urgent that it be applied
> upstream.  Hopefully we can figure out a better solution...

I'm now testing a nice new rebased kernel and I'm hitting this again.

Of course I'll just pick my same patch to my new kernel tree, but
since it's been a year and nobody has done anything better, would you
consider landing my patch?  It is certainly better than nothing.

-Doug
