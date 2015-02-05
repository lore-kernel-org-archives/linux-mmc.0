From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] mmc: core: add runtime-resume caps to support resume at runtime_resume
Date: Thu, 05 Feb 2015 12:20:27 +0100
Message-ID: <3859799.8I7OHevdI7@phil>
References: <1423134419-23109-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:51097 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbbBELVI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Feb 2015 06:21:08 -0500
In-Reply-To: <1423134419-23109-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, tgih.jun@samsung.com, jh80.chung@samsung.com, chris@printf.net, ulf.hansson@linaro.org, dinguyen@altera.com, olof@lixom.net, dianders@chromium.org, sonnyrao@chromium.org, amstan@chromium.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, zhenfu.fang@rock-chips.com, cf@rock-chips.com, lintao@rock-chips.com, chenfen@rock-chips.com, zyf@rock-chips.com, xjq@rock-chips.com, huangtao@rock-chips.com, zyw@rock-chips.com, yzq@rock-chips.com, hj@rock-chips.com, kever.yang@rock-chips.com, zhangqing@rock-chips.com, hl@rock-chips.com

Hi Addy,

Am Donnerstag, 5. Februar 2015, 19:06:59 schrieb Addy Ke:
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
>  drivers/mmc/core/host.c                       |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt
> b/Documentation/devicetree/bindings/mmc/mmc.txt index 438899e..303b448
> 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -40,9 +40,20 @@ Optional properties:
>  - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
>  - mmc-hs400-1_8v: eMMC HS400 mode(1.8V I/O) is supported
>  - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
> +- runtime-resume: resume at runtime_resume is supported
>  - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
>    programmed with. Valid range: [0 .. 0xffff].
> 
> +Card power and reset control:
> +The following properties can be specified for cases where the MMC
> +peripheral needs additional reset, regulator and clock lines. It is for
> +example common for WiFi/BT adapters to have these separate from the main
> +MMC bus:
> +  - card-reset-gpios: Specify GPIOs for card reset (reset active low)
> +  - card-external-vcc-supply: Regulator to drive (independent) card VCC
> +  - clock with name "card_ext_clock": External clock provided to the card
> +>>>>>>> 0064e63... FROMLIST: mmc: core: add runtime-resume caps to support

you seem to have missed some merge artifacts here because your patch should 
probably only insert the one runtime-resume line above.


Heiko

