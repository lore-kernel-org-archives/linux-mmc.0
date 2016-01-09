From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 06/12] mmc: pwrseq: add support for power-on sequencing through DT
Date: Sat, 09 Jan 2016 03:42:03 +0100
Message-ID: <6960259.dpUH8KWsNS@phil>
References: <1452155155-16232-1-git-send-email-wxt@rock-chips.com> <1452155155-16232-7-git-send-email-wxt@rock-chips.com> <568FAA07.1010509@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:47881 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754717AbcAICmR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Jan 2016 21:42:17 -0500
In-Reply-To: <568FAA07.1010509@osg.samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Caesar Wang <wxt@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-rockchip@lists.infradead.org, leecam@google.com, leozwang@google.com, keescook@google.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, NeilBrown <neil@brown.name>

Am Freitag, 8. Januar 2016, 09:22:31 schrieb Javier Martinez Canillas:
> > For example:
> > we need enable wifi module power to via the WL_REG_ON
> > pin, we need enable it as the regulator if this pin is connected to
> > the gpio of cpu.
> 
> This part confuses me, so does your chip have an actual regulator that
> needs to be enabled or is just a fake regulator whose gpio property is
> used not to enable the regulator but to toggle the WL_REG_ON pin of
> the WiFi chip?

another option would be to use the reset-gpio-handles. rk3288-veyron and I 
think some Exynos as well use it that way.


> > Maybe, someone will say that can pull up/down from dts.
> > Unfortunately some SoCs can't support pinctrl pull up/down in
> > internal.
> 
> Can you please elaborate on this? AFAIU this limitation is the reason
> why you went with the regulator approach so I think it deserve a more
> deep explanation.

On the rk3036 each pin has an individual unchangable pull direction. So it's 
either no bias or pulling in the predefined direction (the pin_default bias 
option).


Heiko
