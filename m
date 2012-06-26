From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: Where to power on the wifi device before loading the driver.
Date: Tue, 26 Jun 2012 16:38:32 -0600
Message-ID: <4FEA39E8.6090502@wwwdotorg.org>
References: <20120614121234.GC3913@opensource.wolfsonmicro.com>
 <4FDA092E.10301@wwwdotorg.org>
 <6B4D417B830BC44B8026029FD256F7F1C377BFFE8D@HKMAIL01.nvidia.com>
 <4FDB5976.20809@wwwdotorg.org>
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD61F@HKMAIL01.nvidia.com>
 <43E4817426ED174AA81263BCECB4351D138E8ACD6B@sc-vexch3.marvell.com>
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD622@HKMAIL01.nvidia.com>
 <20120619091719.GZ3974@opensource.wolfsonmicro.com>
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD626@HKMAIL01.nvidia.com>
 <4FE112F2.7000506@wwwdotorg.org>
 <20120626085605.GA6047@shlinux2.ap.freescale.net>
 <4FE9E907.6050803@wwwdotorg.org> <4FEA28EC.2080906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4FEA28EC.2080906-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "'linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, b29397-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Mursalin Akon <makon-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, r64343-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, 'Philip Rakity' <prakity-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Li Frank-B20596 <B20596-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "'frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org'" <frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rakesh Kumar <krakesh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, r65037-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Estevam Fabio-R49496 <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, 'Mark Brown' <broonie@opensour>
List-Id: linux-mmc@vger.kernel.org

On 06/26/2012 03:26 PM, Rob Herring wrote:
> On 06/26/2012 11:53 AM, Stephen Warren wrote:
>> (I'm adding everyone on thread "ARM: imx6q: add config-on-boot gpios" to
>> the CC of this similar thread. Sorry if you think that's spam.)
>>
>> On 06/26/2012 02:56 AM, Dong Aisheng wrote:
>>> On Tue, Jun 19, 2012 at 06:01:54PM -0600, Stephen Warren wrote:
>> ...
>>>> I think what we need is some way of matching a DT node to a device even
>>>> when that device was instantiated through some probing mechanism such as
>>>> SDIO or USB (and I've heard hints that one can already do this for PCI;
>>>> I should investigate).
>>>>
>>>> So, we start off with the plain SDHCI controller node:
>>>>
>>>> sdhci@78000000 {
>>>> 	compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
>>>> 	reg = <0x78000000 0x200>;
>>>> 	interrupts = <0 14 0x04>;
>>>> };
>>>>
>>>> Then, we add a child node to represent the device that's attached:
>>>>
>>>> sdhci@78000000 {
>>>> 	compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
>>>> 	reg = <0x78000000 0x200>;
>>>> 	interrupts = <0 14 0x04>;
>>>>
>>>> 	sdio-device {
>>>> 		reset-gpios = <...>;
>>>> 		enable-gpios = <...>;
>>>> 	};
>>>> };
>>>>
>>>> When the SDHCI controller/core instantiates the child device it finds on
>>>> the HW bus, it initializes that struct device's of_node with a pointer
>>>> to the sdio-device node above. From there, the child device can get DT
>>>> properties such as GPIOs in the usual way.
>>>>
>>>> However, there are still some issues that need thought here; what if (as
>>>> is I believe the case on Cardhu) we can in fact plug in multiple
>>>> different types of device into the socket? Might we end up with
>>>> something like:
>>>>
>>>> sdhci@78000000 {
>>>> 	compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
>>>> 	reg = <0x78000000 0x200>;
>>>> 	interrupts = <0 14 0x04>;
>>>>
>>>> 	sdio-device-option@0 {
>>>> 		compatible = "broadcom,bcm4239";
>>>> 		reset-gpios = <...>;
>>>> 		enable-gpios = <...>;
>>>> 	};
>>>>
>>>> 	sdio-device-option@1 {
>>>> 		compatible = "broadcom,bcm4330";
>>>> 		reset-gpios = <...>;
>>>> 		enable-gpios = <...>;
>>>> 	};
>>>> };
>>>>
>>>> and match on compatible value?
>>>>
>>> I like this idea.
>>> We may extend the sdio_device_id to contain a compatible string,
>>> then sdio core is responsible to pass the corresponding device node to the
>>> sdio function driver once a match device found, this is sdio function independent.
>>> The sdio function driver then are responsible to parse the device node to
>>> fetch the needed information like reset-gpios and enable-gpios to do correct
>>> initialization sequence.
>>>
>>> However, one known question for this model is that some WiFi may need reset the chip
>>> via gpio first before being able to be enumerated.
>>
>> Yes, that's exactly the issue that makes the above binding incorrect.
>>
>> In another thread on a very similar topic, I proposed a binding that
>> would address this issue:
>>
>> http://www.spinics.net/lists/linux-usb/msg66013.html
>>
>>> sdhci@78000000 {
>>> 	compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
>>> 	reg = <0x78000000 0x200>;
>>> 	interrupts = <0 14 0x04>;
>>>
>>> 	sdio-device {
>>> 		reset-gpios = <...>;
>>> 		enable-gpios = <...>;
>>> 	};
> 
> These are really no different than CD and WP on gpio lines. So I don't
> think a child node is even necessary. They are really properties of the
> host controller as you have to know how to handle them before enumeration.
> 
> One question is do the gpios have strict timing or ordering
> requirements. If so then that would be difficult to describe generically.

There certainly are some timing requirements specified in our downstream
kernels, although as I mentioned earlier in the thread, I think the code
is a bit confused since it controls two GPIOs but only one is hooked up,
at least on the one plugin WiFi card I looked at. Even with just one
GPIO, there's still potentially a delay needed between GPIO assertion
and device enumeration.

>>> };
>>
>>> ehci {
>>>     /* The following node is dynamically detected, although the hub
>>>      * IC is physically soldered onto the board
>>>      */
>>>     hub {
>>>         hub { /* also dynamic */
>>>             port@2 {
>>>                 child-supply = <&regulator>;
>>>                 reset-gpios = <&gpio 0 0>;
>>>             };
>>>         };
>>>     };
>>> }
>>
> 
> Considering the same enumeration ordering requirement as above and that
> this is probably limited to a single hub/device on the root hub, I think
> the simple solution of just adding the gpio's to the ehci node and
> handling in the ehci driver is sufficient.
> 
>> Presumably something similar could be set up with platform data.
>>
>> Basically, the SD controller or USB host/hub node contains a child that
>> represents the socket/port/... that needs some services provided to it
>> (power, reset de-asserted, even clocks). The services provided by that
>> node are set up before enumeration, so that the device will respond to
>> enumeration. Hopefully, the DT representation of this socket/port/..
>> could be shared across arbitrary types of controller (so both SD and
>> USB) and the driver the "implements" that node would be common code that
>> SD and USB call into, rather than having them both re-implement it from
>> scratch.
> 
> While I think this can be handled generically with SD and USB drivers,
> I'm not so sure there would be benefit across them. It is just getting a
> gpio and toggling it. But really that's a detail that doesn't matter
> until we're closer to an implementation...

Well, power-gpios should really be a regulator not a GPIO if it really
represents power (although on the one WiFi board I looked at, it was
really an enable/reset signal not a power signal), and we also need to
enable a clock out to the card too, so it gets a bit more complex than
just a couple GPIOs...
