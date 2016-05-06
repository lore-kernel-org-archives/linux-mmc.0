From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc-rockchip: add default drv phase support
Date: Fri, 6 May 2016 10:28:18 -0700
Message-ID: <CAD=FV=XZOJuD=kgSHQM3v63xtVGvxp4m-Y7KAzCRNkqy3tVSyA@mail.gmail.com>
References: <1462527648-24443-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35319 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758751AbcEFR2U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2016 13:28:20 -0400
Received: by mail-qk0-f175.google.com with SMTP id j68so50347821qke.2
        for <linux-mmc@vger.kernel.org>; Fri, 06 May 2016 10:28:19 -0700 (PDT)
In-Reply-To: <1462527648-24443-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi,

On Fri, May 6, 2016 at 2:40 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> This patch introduces default drv phase exposed to dts for
> users to set drv phase. If default-drv-phase is not assigned,
> let's set it to 180 degrees.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/mmc/host/dw_mmc-rockchip.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Replying to this patch in case someone isn't reading the bindings
patch.  See my reply there that it's probably wrong to specify it this
way in the device tree.  Let's continue the discussion there.

-Doug
