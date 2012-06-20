From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: Where to power on the wifi device before loading the driver.
Date: Wed, 20 Jun 2012 19:28:50 +0800
Message-ID: <6B4D417B830BC44B8026029FD256F7F1C6EE2DD629@HKMAIL01.nvidia.com>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
 <4FD90352.9090606@wwwdotorg.org>
 <20120614063120.GA20167@avionic-0098.mockup.avionic-design.de>
 <20120614121234.GC3913@opensource.wolfsonmicro.com>
 <4FDA092E.10301@wwwdotorg.org>
 <6B4D417B830BC44B8026029FD256F7F1C377BFFE8D@HKMAIL01.nvidia.com>
 <4FDB5976.20809@wwwdotorg.org>
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD61F@HKMAIL01.nvidia.com>
 <43E4817426ED174AA81263BCECB4351D138E8ACD6B@sc-vexch3.marvell.com>
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD622@HKMAIL01.nvidia.com>
 <20120619091719.GZ3974@opensource.wolfsonmicro.com>
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD626@HKMAIL01.nvidia.com>
 <4FE112F2.7000506@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FE112F2.7000506-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Stephen Warren' <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: 'Mark Brown' <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, 'Philip Rakity' <prakity-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Rakesh Kumar <krakesh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "'frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org'" <frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mursalin Akon <makon-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "'linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "'linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 20, 2012 at 08:01:54, Stephen Warren wrote:
>On 06/19/2012 03:44 AM, Wei Ni wrote:
>> On Tue, Jun 19, 2012 at 17:17:19, Mark Brown wrote:
>>> * PGP Signed by an unknown key
>>>
>>> On Tue, Jun 19, 2012 at 12:25:58PM +0800, Wei Ni wrote:
>>>
>>> As Stephen previously said please fix your mail formatting - word 
>>> wrapping within paragraphs is important!
>>>
>>>> On Tue, Jun 19, 2012 at 09:23:35, Philip Rakity wrote:
>>>>> Why can't you use the regulator notify to get called back on power 
>>>>> or voltage change options to plumb in the manipulation of the gpio.
>>>>> I can imagine you might need to add a notify call in core.c if you 
>>>>> need to assert the gpio before power is applied
>>>>
>>>> Yes, we can use the regulator notify, but the Tegra30 support is 
>>>> via device tree, I think there have no special board file to run 
>>>> the call back.
>>>
>>> You can mix board files with device tree for cases where device tree 
>>> is not yet up to the job, though the goal should be to come up with 
>>> a way of expressing things in
>device tree.
>>
>> I think we wish to use the device tree to handle these gpios, pass 
>> them to the related driver to
>assert them.
>> If we mix the board files, we even can set these gpio directly, not 
>> use the notify. But I think this
>is not a goog way.
>
>Yes, I would definitely not want to add this to a board file; there is 
>no board file for Cardhu, and we're getting close to deleting all the board files that are left for other boards.
>
>I think what we need is some way of matching a DT node to a device even 
>when that device was instantiated through some probing mechanism such 
>as SDIO or USB (and I've heard hints that one can already do this for PCI; I should investigate).
>
>So, we start off with the plain SDHCI controller node:
>
>sdhci@78000000 {
>	compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
>	reg = <0x78000000 0x200>;
>	interrupts = <0 14 0x04>;
>};
>
>Then, we add a child node to represent the device that's attached:
>
>sdhci@78000000 {
>	compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
>	reg = <0x78000000 0x200>;
>	interrupts = <0 14 0x04>;
>
>	sdio-device {
>		reset-gpios = <...>;
>		enable-gpios = <...>;
>	};
>};
>
>When the SDHCI controller/core instantiates the child device it finds 
>on the HW bus, it initializes that struct device's of_node with a 
>pointer to the sdio-device node above. From there, the child device can get DT properties such as GPIOs in the usual way.
>
>However, there are still some issues that need thought here; what if 
>(as is I believe the case on
>Cardhu) we can in fact plug in multiple different types of device into 
>the socket? Might we end up with something like:
>
>sdhci@78000000 {
>	compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
>	reg = <0x78000000 0x200>;
>	interrupts = <0 14 0x04>;
>
>	sdio-device-option@0 {
>		compatible = "broadcom,bcm4239";
>		reset-gpios = <...>;
>		enable-gpios = <...>;
>	};
>
>	sdio-device-option@1 {
>		compatible = "broadcom,bcm4330";
>		reset-gpios = <...>;
>		enable-gpios = <...>;
>	};
>};
>
>and match on compatible value?
>
>But in this case, at least some of the data those two drivers want from 
>that node is the same; the 2 GPIOs that control the reset and enable 
>signals. Do we just make the bindings for those two devices happen to 
>share the same properties so that we can get away with just one node 
>irrespective of what device type has been found? What we're really modeling is the card slot, and the services it provides, so perhaps we should really end up with:
>
>sdhci@78000000 {
>	compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
>	reg = <0x78000000 0x200>;
>	interrupts = <0 14 0x04>;
>
>	socket {
>		reset-gpios = <...>;
>		enable-gpios = <...>;
>
>		sdio-device-option@0 {
>			compatible = "broadcom,bcm4239";
>		};
>
>		sdio-device-option@1 {
>			compatible = "broadcom,bcm4330";
>		};
>	};
>};
>
>Where somehow the WiFi drivers can obtain the reset/enable service from 
>the socket that hosts them, but still have nodes for the attached 
>device itself in case any additional driver-specific configuration is needed.
>
>That sounds somewhat similar to the virtual platform device that was 
>mentioned earlier in this thread by Broadcom, although I'm not sure 
>whether explicitly modeling it as a platform device makes sense, rather than the socket providing services to the WiFi module, not necessarily through a device.
>
>Unfortunately, it should be noted that the WiFi device socket on Cardhu 
>apparently isn't some standardized thing (like PCIe) but something 
>rather more custom, although there are apparently devices available to 
>plug into it from multiple module vendors which contain WiFi chips from multiple chip vendors.
>
>Anyway, these are just some quick thoughts on the topic - obviously more flesh is needed.

Stephen, as Rakesh said that in case of bcm4329, the two GPIO (WF_EN and WF_RST) are shorted. So I think we can simply to use the power-gpios properity in the SD driver, just use one gpio.
I test it in this way, it runs ok, the bcm4329 can be powered up. We can use this option.

---
nvpublic
