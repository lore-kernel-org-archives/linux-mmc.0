From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/5] Add power domain support for dw_mmc/sdhci-of-arasan
Date: Fri, 29 Jul 2016 11:21:01 +0200
Message-ID: <CAPDyKFq6itpANwnLqgOqKHT0fJH4SvZi2FWrafa=HSBfiZE52w@mail.gmail.com>
References: <1469765703-30999-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36312 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbcG2JVF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jul 2016 05:21:05 -0400
Received: by mail-wm0-f48.google.com with SMTP id q128so282147981wma.1
        for <linux-mmc@vger.kernel.org>; Fri, 29 Jul 2016 02:21:04 -0700 (PDT)
In-Reply-To: <1469765703-30999-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Feng Xiao <xf@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 29 July 2016 at 06:14, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> We need to enable the power domain manually while probing as the
> power policy will turn off the pd which is not referenced. Otherwise

I assume you are going to use the generic PM domain (genpd)?
If so, this statement isn't entirely correct.

As a matter of fact, the PM domain will be "powered on" once you have
registered your PM domain with genpd and when the device (dw_mmc etc)
gets attached to the domain. The attach occurs when the platform bus'
->probe() function get invoked for the device.

Genpd monitors each device within the domain. To allow it to "power
off", all devices in same domain needs to be runtime PM enabled and
runtime PM suspended.

Due to this, you should be able to deploy genpd support+an updated
DTB, without first having to deploying runtime PM support in the
related drivers. In other words, you should be able to work on these
things almost independently of each other.

> we may take risk of breaking kernel once Feng Xiao land the rockchip pd
> relate stuff. So, let's do it in advance.
>
> This pachset is based on the latest linux-next[1] which should contain
> the next branch of linux-mmc and dt stuff. It's ideal to pack these all
> into Ulf' tree with Heiko's ack for dts, Rob's ack for Doc and Jaehoon's
> ack for dw_mmc. But it's okay to be merged seperately.
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>
> Thanks.
>
>
>
> Shawn Lin (5):
>   Documentation: mmc: synopsys-dw-mshc: add power domain description
>   Documentation: mmc: sdhci-of-arasan: add power domain description

To me this isn't necessary to describe for each device. I think
Documentation/devicetree/bindings/power/power_domain.txt describes all
that is needed.

>   arm64: dts: rockchip: Provide power-domains for sd/sdio/emmc
>     controllers
>   mmc: dw_mmc: add power domain support
>   mmc: sdhci-of-arasan: add power domain support

I would rephrase these commit message headers, to something like
"Deploy runtime PM support", as that is actually what you intend to
do.

>
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt     |  1 +
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt |  2 ++
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi                   |  3 +++
>  drivers/mmc/host/dw_mmc.c                                  | 11 +++++++++++
>  drivers/mmc/host/sdhci-of-arasan.c                         | 10 ++++++++++
>  5 files changed, 27 insertions(+)
>
> --
> 2.3.7
>
>

Kind regards
Uffe
