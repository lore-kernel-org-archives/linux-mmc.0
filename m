From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v2 06/12] mmc: pwrseq: add support for power-on sequencing
 through DT
Date: Mon, 11 Jan 2016 13:02:46 -0300
Message-ID: <5693D226.2000307@osg.samsung.com>
References: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
 <1452155155-16232-7-git-send-email-wxt@rock-chips.com>
 <568FAA07.1010509@osg.samsung.com> <6960259.dpUH8KWsNS@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55208 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757640AbcAKQCy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Jan 2016 11:02:54 -0500
In-Reply-To: <6960259.dpUH8KWsNS@phil>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Caesar Wang <wxt@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-rockchip@lists.infradead.org, leecam@google.com, leozwang@google.com, keescook@google.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, NeilBrown <neil@brown.name>

Hello Heiko,

On 01/08/2016 11:42 PM, Heiko Stuebner wrote:
> Am Freitag, 8. Januar 2016, 09:22:31 schrieb Javier Martinez Canillas:
>>> For example:
>>> we need enable wifi module power to via the WL_REG_ON
>>> pin, we need enable it as the regulator if this pin is connected to
>>> the gpio of cpu.
>>
>> This part confuses me, so does your chip have an actual regulator that
>> needs to be enabled or is just a fake regulator whose gpio property is
>> used not to enable the regulator but to toggle the WL_REG_ON pin of
>> the WiFi chip?
> 
> another option would be to use the reset-gpio-handles. rk3288-veyron and I 
> think some Exynos as well use it that way.
>

Yes I know, my point was that the reset-gpios property should be used
instead of a fake regulator if what's needed is to toggle a chip pin.

>
>>> Maybe, someone will say that can pull up/down from dts.
>>> Unfortunately some SoCs can't support pinctrl pull up/down in
>>> internal.
>>
>> Can you please elaborate on this? AFAIU this limitation is the reason
>> why you went with the regulator approach so I think it deserve a more
>> deep explanation.
> 
> On the rk3036 each pin has an individual unchangable pull direction. So it's 
> either no bias or pulling in the predefined direction (the pin_default bias 
> option).
>

I think each change has to be justified on its own so I would say that
having a regulator enabled as a part of a SDIO chip's power sequencing
is something needed for many platforms, and that this provider should
be extended to support that (something like commit msg in patch 05/12).

And then in the kylin DTS change (patch 08/12), I would explain why a
chained regulators approach is used/needed instead of the reset-gpios
due any platform limitations.

> 
> Heiko
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
