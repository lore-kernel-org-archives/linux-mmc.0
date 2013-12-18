From: John Tobias <john.tobias.ph@gmail.com>
Subject: Re: [PATCH 1/4] iMX6SL frequency table
Date: Wed, 18 Dec 2013 08:24:00 -0800
Message-ID: <CACUGKYNJdHoScfXC2DRaeTHxf0pBbnkc3CXLfivKmzsGAy=iOw@mail.gmail.com>
References: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
	<20131218073755.GG6691@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:49090 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab3LRQYC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2013 11:24:02 -0500
Received: by mail-ob0-f177.google.com with SMTP id vb8so7967712obc.8
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2013 08:24:01 -0800 (PST)
In-Reply-To: <20131218073755.GG6691@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Chris Ball <cjb@laptop.org>

Will update it base on your previous email.

Thanks,

john

On Tue, Dec 17, 2013 at 11:37 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Dec 17, 2013 at 05:17:28PM -0800, John Tobias wrote:
>>     Device tree for iMX6SL doesn't have an existing cpu frequency table.
>
> Drop these leading spaces.
>
>>
>> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
>> ---
>>  arch/arm/boot/dts/imx6sl.dtsi | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>
> For such imx6sl dts changes, please put a prefix 'ARM: dts: imx6sl: ...'
> on the patch subject.
>
>>
>> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
>> index 28558f1..0a2c73c 100644
>> --- a/arch/arm/boot/dts/imx6sl.dtsi
>> +++ b/arch/arm/boot/dts/imx6sl.dtsi
>> @@ -38,6 +38,20 @@
>>                       device_type = "cpu";
>>                       reg = <0x0>;
>>                       next-level-cache = <&L2>;
>> +                     operating-points = <
>> +                             /* kHz    uV */
>> +                             996000  1250000 /* for consumer grade only */
>> +                             792000  1150000
>> +                             396000  1050000
>
> Please see my reply to your previous patch.
>
>> +                     >;
>> +                     clock-latency = <61036>; /* two CLK32 periods */
>> +                     clocks = <&clks IMX6SL_CLK_ARM>, <&clks IMX6SL_CLK_PLL2_PFD2>, <&clks IMX6SL_CLK_STEP>,
>> +                              <&clks IMX6SL_CLK_PLL1_SW>, <&clks IMX6SL_CLK_PLL1_SYS>;
>
> The lines are somehow too long.  The following one might be easier to
> read.
>
>                         clocks = <&clks IMX6SL_CLK_ARM>,
>                                  <&clks IMX6SL_CLK_PLL2_PFD2>,
>                                  <&clks IMX6SL_CLK_STEP>,
>                                  <&clks IMX6SL_CLK_PLL1_SW>,
>                                  <&clks IMX6SL_CLK_PLL1_SYS>;
>
> Shawn
>
>> +                     clock-names = "arm", "pll2_pfd2_396m", "step",
>> +                                   "pll1_sw", "pll1_sys";
>> +                     arm-supply = <&reg_arm>;
>> +                     pu-supply = <&reg_pu>;
>> +                     soc-supply = <&reg_soc>;
>>               };
>>       };
>>
>> --
>> 1.8.3.2
>>
>
