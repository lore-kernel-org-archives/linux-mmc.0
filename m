From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 07/11] mmc: sdhci-of-arasan: Add ability to export card clock
Date: Wed, 15 Jun 2016 09:40:41 -0700
Message-ID: <CAD=FV=UH+5bs8TUe+nOKnmEsYL+7iF2JkKri2kzRgHYpyDLK1Q@mail.gmail.com>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org> <1465859076-4868-8-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:32807 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbcFOQkn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2016 12:40:43 -0400
Received: by mail-vk0-f44.google.com with SMTP id d185so37542087vkg.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2016 09:40:43 -0700 (PDT)
In-Reply-To: <1465859076-4868-8-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Ziyuan Xu <xzy.xu@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>

Hi,

On Mon, Jun 13, 2016 at 4:04 PM, Douglas Anderson <dianders@chromium.org> wrote:
> Some SD/eMMC PHYs (like the PHY from Arasan that is designed to work
> with arasan,sdhci-5.1) need to know the card clock in order to function
> properly.  Let's add the ability to expose this clock.  Any PHY that
> needs to know the clock rate can add a reference and query the clock
> rate.
>
> At the moment we register a CLK_GET_RATE_NOCACHE clock that simply
> allows querying the clock.  This allows us to be less intrusive with
> regards to the main SDHCI driver, which has complex logic for adjusting
> the SD clock.  Right now we always fully power cycle the PHY when the
> clock changes and that gives the PHY a good chance to query our clock.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v2: None
>
>  drivers/mmc/host/sdhci-of-arasan.c | 125 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 122 insertions(+), 3 deletions(-)

I've sent out a new version of just this patch as "version 2.1" to
address a problem found by Guenter Roeck.  Please see
<https://patchwork.kernel.org/patch/9178951/>.  If it's handy for me
to send out a whole new v3 series, please let me know.

-Doug
