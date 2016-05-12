From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] mmc: dw_mmc: rockchip: Set the drive phase properly
Date: Thu, 12 May 2016 11:15:52 -0700
Message-ID: <CAD=FV=UiPo5EnsX+erm5PDsuCHczr1qbhwz8s4FcLeNGPdVuGQ@mail.gmail.com>
References: <1463002848-580-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36221 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbcELSPy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 May 2016 14:15:54 -0400
Received: by mail-vk0-f41.google.com with SMTP id s184so108034483vkb.3
        for <linux-mmc@vger.kernel.org>; Thu, 12 May 2016 11:15:53 -0700 (PDT)
In-Reply-To: <1463002848-580-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On Wed, May 11, 2016 at 2:40 PM, Douglas Anderson <dianders@chromium.org> wrote:
> Historically for Rockchip devices we've relied on the power-on
> default (or perhaps the firmware setting) to get the correct drive
> phase for dw_mmc devices.  This worked OK for the most part, but:
>
> * Relying on the setting just "being right" is a bit fragile.
>
> * As soon as there is an instance where the power on default is wrong or
>   where the firmware didn't configure this properly then we'll get a
>   mysterious failure.
>
> Let's explicitly set this phase in the kernel.
>
> The comments inside this patch try to explain the situation quite
> throughly, but the high level overview of this is:
>
> Before this patch on rk3288 devices tested:
> * eMMC: 180 degrees
> * SDMMC/SDIO0/SDIO1: 90 degrees
>
> After this patch:
> * Use 90 degree phase offset usually.
> * Use 180 degree phase offset for MMC_DDR52, SDR104, HS200.
>
> That means we are _changing_ behavior for those devices in this way:
>
> * If we have HS200 eMMC or DDR52 eMMC, we'll run ID mode at 90
>   degrees (vs 180) but otherwise have no change.
>
> * For any non-HS200 / non-DDR52 eMMC devices we'll now _always_ run at
>   90 degrees (vs 180).  It seems fairly unlikely that building modern
>   hardware is using an eMMC that isn't using DDR52 or HS200, of course.
>
> * For SDR104 cards we'll now run with 180 degree phase offset (vs 90).
>   It's expected that 90 degree phase offset would have worked OK, but
>   this gives us extra margin.
>
> I have tested this by inserting my collection of uSD cards (mostly UHS,
> though a few not) into a veyron_minnie and confirmed that they still
> seem to enumerate properly.  For a subset of them I tried putting a
> filesystem on them and also tried running mmc_test.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v2:
> - Now use 90 degrees for some modes; updated comments to say why.
>
>  drivers/mmc/host/dw_mmc-rockchip.c | 64 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)

Just a note that I have since found out that recent patches in the
kernel in fact _do_ init the drive phase and apparently do it
improperly.  That means that $SUBJECT patch actually is expected to
fix real problems on real devices.

See <https://patchwork.kernel.org/patch/9085311/> for some details.

-Doug
