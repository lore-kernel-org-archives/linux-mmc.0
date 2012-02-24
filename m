From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 1/4] mmc: omap_hsmmc: Convert hsmmc driver to use device
 tree
Date: Fri, 24 Feb 2012 18:28:11 +0530
Message-ID: <4F478963.20009@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>	<1329998490-27555-2-git-send-email-rnayak@ti.com> <CANrkHUarg5ntUW=S7k20LXuYe+ZNCN-cYJhfvvLKM=X8+Db4fg@mail.gmail.com> <4F4775FF.2090500@ti.com> <4F4787C3.1010507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:45237 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755195Ab2BXM6T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Feb 2012 07:58:19 -0500
Received: by mail-gy0-f173.google.com with SMTP id r14so667576ghr.18
        for <linux-mmc@vger.kernel.org>; Fri, 24 Feb 2012 04:58:18 -0800 (PST)
In-Reply-To: <4F4787C3.1010507@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "T Krishnamoorthy, Balaji" <balajitk@ti.com>, cjb@laptop.org, linaro-dev@lists.linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday 24 February 2012 06:21 PM, Cousson, Benoit wrote:
> On 2/24/2012 12:35 PM, Rajendra Nayak wrote:
>> On Friday 24 February 2012 05:02 PM, T Krishnamoorthy, Balaji wrote:
>>> On Thu, Feb 23, 2012 at 5:31 PM, Rajendra Nayak<rnayak@ti.com> wrote:
>>>> Define dt bindings for the ti-omap-hsmmc, and adapt
>>>> the driver to extract data (which was earlier passed as
>>>> platform_data) from device tree.
>>>>
>>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>>> ---
>>>> .../devicetree/bindings/mmc/ti-omap-hsmmc.txt | 31 +++++++++
>>>> drivers/mmc/host/omap_hsmmc.c | 68 ++++++++++++++++++++
>>>> 2 files changed, 99 insertions(+), 0 deletions(-)
>>>> create mode 100644
>>>> Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>>> b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>>> new file mode 100644
>>>> index 0000000..e4fa8f0
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>>> @@ -0,0 +1,31 @@
>>>> +* TI Highspeed MMC host controller for OMAP
>>>> +
>>>> +The Highspeed MMC Host Controller on TI OMAP family
>>>> +provides an interface for MMC, SD, and SDIO types of memory cards.
>>>> +
>>>> +Required properties:
>>>> +- compatible:
>>>> + Should be "ti,omap2-hsmmc", for OMAP2/3 controllers
>>>
>>> omap_hsmmc is applicable for omap2430 and omap3.
>>> omap2420 has non high speed controller mmci-omap -
>>> drivers/mmc/host/omap.c
>>> May be omap3-hsmmc compatible with omap2430 ?
>>
>> Agree. I think its best in that case for me to define a
>> compatible "ti,omap2430-hsmmc" for omap2430 and "ti,omap3-hsmmc"
>> for omap3. Though the IP blocks are same, I cant think of some
>> common compatible string without causing confusion.
>
> It depends, can we detect that using HW revision?

We don't need to. The driver does not do anything different for
2430 or omap3.

> In that case, there is no need to differentiate again with compatible.

Thats perfectly fine. But what *common* compatible string would you
use?

>
> Regards,
> Benoit
>
>>
>>>
>>>> + Should be "ti,omap4-hsmmc", for OMAP4 controllers
>>>> +- ti,hwmods: Must be "mmc<n>", n is controller instance starting 1
>>>> +- reg : should contain hsmmc registers location and length
>>>> +
>>>> +Optional properties:
>>>> +ti,dual-volt: boolean, supports dual voltage cards
>>>> +<supply-name>-supply: phandle to the regulator device tree node
>>>> +"supply-name" examples are "vmmc", "vmmc_aux" etc
>>>> +ti,bus-width: Number of data lines, default assumed is 1 if the
>>>> property is missing.
>>>> +cd-gpios: GPIOs for card detection
>>>> +wp-gpios: GPIOs for write protection
>>>> +ti,non-removable: non-removable slot (like eMMC)
>>>> +
>>>> +Example:
>>>> + mmc1: mmc@0x4809c000 {
>>>> + compatible = "ti,omap4-hsmmc";
>>>> + reg =<0x4809c000 0x400>;
>>>> + ti,hwmods = "mmc1";
>>>> + ti,dual-volt;
>>>> + ti,bus-width =<4>;
>>>> + vmmc-supply =<&vmmc>; /* phandle to regulator node */
>>>> + ti,non-removable;
>>>> + };
>>
>> _______________________________________________
>> devicetree-discuss mailing list
>> devicetree-discuss@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/devicetree-discuss
>

