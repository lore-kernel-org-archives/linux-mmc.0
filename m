From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: Re: [PATCH RESEND] ARM: dts: exynos5422-odroidxu3: add mmc detect
 gpio
Date: Mon, 04 May 2015 18:45:53 +0900
Message-ID: <55473FD1.7060605@gmail.com>
References: <1423813734-20664-1-git-send-email-a.hajda@samsung.com> <CABxcv==sgCGGsVY8=RtdTGw501zUybufkpW-N_h-fopg37UFPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34877 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbbEDJp7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 May 2015 05:45:59 -0400
In-Reply-To: <CABxcv==sgCGGsVY8=RtdTGw501zUybufkpW-N_h-fopg37UFPg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Andrzej Hajda <a.hajda@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>

W dniu 13.02.2015 o 19:03, Javier Martinez Canillas pisze:
> Hello Andrzej,
> 
> On Fri, Feb 13, 2015 at 8:48 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>> The patch adds gpio for detecting presence of MMC card.
>> It fixes issue with kernel hang due when MMC card is missing.
> 
> Maybe s/MMC/eMMC here? to make more clear that this patch is solving
> an issue when the eMMC and not the uSD is missing.
> 
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> Hi,
>>
>> This is just resend of the patch with added mmc ML and dw-mmc maintainers.
>>
>> Javier, I have no access to peach-pi(t) schematics, so I do not know if they
>> have mmc-cd line connected to gpc0-2 gpio, but I guess it could be the case.
>> You could check if similar patches will fix the issue for them.
>>
> 
> Yes, both the eMMC and uSD card detection lines in the Peach Pit/Pi
> are connected to the XMMC0CDN and XMMC2CDN built-in CD# pins so is the
> same than the Odroid XU3 if I read the schematics correctly since the
> those pins are also GPC0_2 and GPC2_2.
> 
> Now, in the Peach Pit Chromebook the eMMC is not removable so card
> detection is not an issue there, the problem I'm having is that card
> detection for the uSD seems to be broken after adding Addy's patches:
> 
> mmc: dw_mmc: fix bug that cause 'Timeout sending command'
> mmc: dw_mmc: Don't start command while data busy
> 
> And adding a cd-gpios property with a phandle to gpc2_2 to the mmc2
> device node does not help.
> 
> But without those patches, I've timeouts when mmc commands are sent to
> the SDIO slot which has the wifi chip connected to.
> 
>> Regards
>> Andrzej
>>
>>  arch/arm/boot/dts/exynos5422-odroidxu3.dts | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>> index 47ec9bf..a563811 100644
>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>> @@ -11,6 +11,7 @@
>>  */
>>
>>  /dts-v1/;
>> +#include <dt-bindings/gpio/gpio.h>
>>  #include "exynos5800.dtsi"
>>
>>  / {
>> @@ -355,13 +356,13 @@
>>
>>  &mmc_0 {
>>         status = "okay";
>> -       broken-cd;
>> +       cd-gpios = <&gpc0 2 GPIO_ACTIVE_LOW>;
>>         card-detect-delay = <200>;
>>         samsung,dw-mshc-ciu-div = <3>;
>>         samsung,dw-mshc-sdr-timing = <0 4>;
>>         samsung,dw-mshc-ddr-timing = <0 2>;
>>         pinctrl-names = "default";
>> -       pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>> +       pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_cd>;
>>         bus-width = <8>;
>>         cap-mmc-highspeed;
>>  };
>> --
> 
> Your patch looks good to me though from what I've seen in the Odroid
> XU3 schematic and taking into account that the eMMC can be removed in
> that board.
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Hi Andrzej,

The patch no longer applies cleanly, so could you re-spin it with
Javier's tag above?

Best regards,
Krzysztof

