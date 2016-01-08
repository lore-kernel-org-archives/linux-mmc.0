From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v2 06/12] mmc: pwrseq: add support for power-on sequencing
 through DT
Date: Fri, 8 Jan 2016 09:22:31 -0300
Message-ID: <568FAA07.1010509@osg.samsung.com>
References: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
 <1452155155-16232-7-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:49301 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbcAHMWl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Jan 2016 07:22:41 -0500
In-Reply-To: <1452155155-16232-7-git-send-email-wxt@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rockchip@lists.infradead.org, leecam@google.com, leozwang@google.com, keescook@google.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, NeilBrown <neil@brown.name>

Hello Caesar,

On 01/07/2016 05:25 AM, Caesar Wang wrote:
> This patch enables support for power-on sequencing of SDIO
> peripherals through DT.
>

I think the subject line and this first paragraph are misleading since
the simple power sequence provider already supports power-on sequencing.

This patch does not add or enable support but extends the current support
to also enable a regulator as a part of the SDIO chip power on sequencing.
 
> In general, it's quite common that wifi modules and other similar
> peripherals have several signals in addition to the SDIO interface that
> needs wiggling before the module will power on.
> 
> For example:
> we need enable wifi module power to via the WL_REG_ON
> pin, we need enable it as the regulator if this pin is connected to
> the gpio of cpu.
>

This part confuses me, so does your chip have an actual regulator that
needs to be enabled or is just a fake regulator whose gpio property is
used not to enable the regulator but to toggle the WL_REG_ON pin of
the WiFi chip?
 
> Maybe, someone will say that can pull up/down from dts.
> Unfortunately some SoCs can't support pinctrl pull up/down in
> internal.
>

Can you please elaborate on this? AFAIU this limitation is the reason
why you went with the regulator approach so I think it deserve a more
deep explanation.
 
> Anyway, we can add this patch to supprt the power-on sequencing for

s/supprt/support

> sdio.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
