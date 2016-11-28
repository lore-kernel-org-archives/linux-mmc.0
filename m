From: Mason <slash.tmp@free.fr>
Subject: Re: arasan,sdhci.txt "compatibility" DT binding
Date: Mon, 28 Nov 2016 17:52:28 +0100
Message-ID: <583C60CC.2020408@free.fr>
References: <56B07BA5.4060407@free.fr>
 <a20b2b4f-15d4-3c29-324c-1ced5dbcc67f@xilinx.com> <583C50E7.6030400@free.fr>
 <14771688.Q8f97gHC2H@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:33795 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932495AbcK1Qxi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 28 Nov 2016 11:53:38 -0500
In-Reply-To: <14771688.Q8f97gHC2H@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, Rameshwar Sahu <rsahu@apm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <monstr@monstr.eu>, Anton Vorontsov <anton@enomsg.org>, Xiaobo Xie <x.xie@freescale.com>, Suman Tripathi <stripathi@apm.com>, Linus Walleij <linus.walleij@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Rob Herring <robh@kernel.org>, Zach Brown <zach.brown@ni.com>, Ulf Hansson <ulf.hansson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, Suneel Garapati <sune>

On 28/11/2016 17:15, Arnd Bergmann wrote:

> On Monday, November 28, 2016 4:44:39 PM CET Mason wrote:
>
>> Hello,
>>
>> @Shawn Lin, could you take a look below and tell me exactly
>> which IP core(s) Rockchip is using in its SoCs?
>>
>> Based on the feedback I received, here is an updated list of
>> compatible strings and controller versions dealt with by the
>> drivers/mmc/host/sdhci-of-arasan.c code.
>>
>>
>> Xilinx Zynq:
>> "SD2.0 / SDIO2.0 / MMC3.31 AHB Host Controller"
>> "arasan,sdhci-8.9a"
>> NB: 8.9a is the documentation revision (dated 2011-10-19)
>> subsequent tweaks labeled 9.0a, 9.1a, 9.2a
>>
>> Xilinx ZynqMP:
>> "SD3.0 / SDIO3.0 / eMMC4.51 AHB Host Controller"
>> "arasan,sdhci-8.9a"
>> NB: using the same compatible string as Zynq
>>
>> Sigma SMP87xx
>> "SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller"
>> no compatible string yet, platform-specific init required
>>
>> APM:
>> "SD3.0 / SDIO3.0 / eMMC4.41 AHB Host Controller"
>> "arasan,sdhci-4.9a"
>> NB: 4.9a appears to be the documentation revision
>> no functional diff with "arasan,sdhci-8.9a"
>>
>> Rockchip
>> Exact IP unknown, waiting for Shawn's answer
>> "arasan,sdhci-5.1"
>> NB: 5.1 appears to refer to the eMMC standard supported
>>
>>
>> On a final note, there are many variations of the Arasan IP.
>> I've tracked down at least the following:
>>
>> SD_2.0_SDIO_2.0__MMC_3.31_AHB_Host_Controller.pdf
>> SD_3.0_SDIO_3.0_eMMC_4.41_OCP_Host_Controller.pdf
>> SD_3.0_SDIO_3.0_eMMC_4.4__AHB_Host_Controller.pdf
>> SD_3.0_SDIO_3.0_eMMC_4.51_Host_Controller.pdf
>> SD_3.0_SDIO_3.0_eMMC_4.5__Host_Controller.pdf
>> SD_4.1_SDIO_4.1_eMMC_4.51_Host_Controller.pdf
>> SD_4.1_SDIO_4.1_eMMC_5.1__Host_Controller.pdf
>>
>> It seems to me the compatible string should specify
>> the SD/SDIO version AND the eMMC version, since it
>> seems many combinations are allowed, e.g. eMMC 4.51
>> has two possible SD versions.
>>
>> What do you think?
> 
> It seems wrong to have the eMMC or SD version in the compatible
> string.  Is that the only difference between the documents you
> found? Normally there should be a version of IP block itself,
> besides the supported protocol.

But that is exactly the problem :-)

Nowhere in the documentation do they specify an "IP version".
Some documents do provide a revision number, but that's just
a *documentation* revision number, e.g.

changes in version 3.6 : fix typos
changes in version 9.1a : update company logo

That's why Xilinx used "arasan,sdhci-8.9a" and APM used
"arasan,sdhci-4.9a". These are documentation revisions.
In my opinion, that information is mostly worthless.


Looking more closely at SD_3.0_SDIO_3.0_eMMC_4.4__AHB_Host_Controller.pdf
(User Guide, which has more info than Datasheet) I see this:

Changed Host Controller Version Register value from 16'h0002 to 16'h7501
Changed Host Controller Version Register value from 16'h8301 to 16'h8401
Changed Host Controller Version Register value from 16'h8401 to 16'h8501
Changed Host Controller Version Register to 16'h9502
Changed Host Controller Version Register to 16'h9602
Changed Host Controller Version Register to 16'h9902

Host controller version register (offset 0FEh)

Vendor Version Number 15:8
HwInit=0x99
This status is reserved for the vendor version number.
The HD should not use this status.

Specification Version Number 7:0
HwInit=0x02
This status indicates the Host Controller Spec. Version.
The upper and lower 4-bits indicate the version.
Description
00 - SD Host Specification version 1.0
01 - SD Host Specification version 2.00
including only the feature of the Test Register
02 - SD Host Specification Version 3.00
others - Reserved

I'm not sure what this "Vendor Version Number" specifies, nor if is
guaranteed to be unique across controllers.

In SD_3.0_SDIO_3.0_eMMC_4.5__Host_Controller_UserGuide.pdf,
they write "The Vendor Version Number is set to 0x10 (1.0)"

I don't have a UserGuide for "arasan,sdhci-5.1".

Regards.

