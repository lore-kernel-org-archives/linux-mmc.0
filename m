From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFT] arm64: dts: renesas: salvator-common: enable SDR104 for SD
 cards
Date: Thu, 3 Aug 2017 09:43:51 +0200
Message-ID: <20170803074351.GC19671@verge.net.au>
References: <20170802201311.1394-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:44512 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdHCHnz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Aug 2017 03:43:55 -0400
Content-Disposition: inline
In-Reply-To: <20170802201311.1394-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org

On Wed, Aug 02, 2017 at 10:13:11PM +0200, Wolfram Sang wrote:
> Tests showed that SDHI driver problems have been solved and SDR104 works
> now reliably on both Salvator-X SD card slots, both with an R-Car H3
> (r8a7795 ES1.0) and R-Car M3 (r8a7796 ES 1.0). So, finally, enable it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Awesome, awesome! For the last two days, I did various tests with my boards and
> SD cards and SDR104 worked absolutely reliably :D Even the problematic card I
> had works flawlessly. I couldn't trigger the known failures anymore. Although I
> tried, I can't point to a single patch which "fixed" the issue. It is the
> constant work on dealing with smaller issues which makes SDR104 work at the end
> of the day. However, two patches are likely a bigger part of the cake:
> 
> 43b0b361b01700 ("mmc: tmio: always get number of taps")
> -> Already upstream. This fixed retuning on card changes.
> 
> 85b81aa16ec4ed ("mmc: tmio: fix CMD12 (STOP) handling")
> -> In mmc/next. This allows to handle tuning errors gracefully and to retune.
> 
> With the freshly submitted Gen3 DMA patches, we also get nice transfer speeds :)
> 
> This patch is based on renesas-drivers/master as of today. A branch for testing
> can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/v8-sdr104
> 
> All patches needed for reliable SDR104 are already upstream or in mmc/next. The
> above branch only adds another patch to enable DMA on Gen3. It is not strictly
> needed, but very nice to have. I think it would be cool to get both patches
> into v4.14.
> 
> Looking forward to other testers. Simon, do you have some time for this?

Yes, I should be able to run this through my - until now thought to be
broken - test case this week.

It would be very nice to be able to get closure on this :)

> 
> Thanks and kind regards,
> 
>   a very happy Wolfram
> 
> 
>  arch/arm64/boot/dts/renesas/salvator-common.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> index a451996f590a51..18e2da9f866684 100644
> --- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> +++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> @@ -569,6 +569,7 @@
>  	wp-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
>  	bus-width = <4>;
>  	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
>  	status = "okay";
>  };
>  
> @@ -597,6 +598,7 @@
>  	wp-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
>  	bus-width = <4>;
>  	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
>  	status = "okay";
>  };
>  
> -- 
> 2.11.0
> 
