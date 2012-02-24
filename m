From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/4] mmc: omap_hsmmc: Convert hsmmc driver to use device
	tree
Date: Fri, 24 Feb 2012 13:51:15 +0100
Message-ID: <4F4787C3.1010507@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>	<1329998490-27555-2-git-send-email-rnayak@ti.com>
	<CANrkHUarg5ntUW=S7k20LXuYe+ZNCN-cYJhfvvLKM=X8+Db4fg@mail.gmail.com>
	<4F4775FF.2090500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4F4775FF.2090500-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, "T Krishnamoorthy,
	Balaji" <balajitk-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 2/24/2012 12:35 PM, Rajendra Nayak wrote:
> On Friday 24 February 2012 05:02 PM, T Krishnamoorthy, Balaji wrote:
>> On Thu, Feb 23, 2012 at 5:31 PM, Rajendra Nayak<rnayak-l0cyMroinI0@public.gmane.org> wrote:
>>> Define dt bindings for the ti-omap-hsmmc, and adapt
>>> the driver to extract data (which was earlier passed as
>>> platform_data) from device tree.
>>>
>>> Signed-off-by: Rajendra Nayak<rnayak-l0cyMroinI0@public.gmane.org>
>>> ---
>>> .../devicetree/bindings/mmc/ti-omap-hsmmc.txt | 31 +++++++++
>>> drivers/mmc/host/omap_hsmmc.c | 68 ++++++++++++++++++++
>>> 2 files changed, 99 insertions(+), 0 deletions(-)
>>> create mode 100644
>>> Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>> b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>> new file mode 100644
>>> index 0000000..e4fa8f0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>> @@ -0,0 +1,31 @@
>>> +* TI Highspeed MMC host controller for OMAP
>>> +
>>> +The Highspeed MMC Host Controller on TI OMAP family
>>> +provides an interface for MMC, SD, and SDIO types of memory cards.
>>> +
>>> +Required properties:
>>> +- compatible:
>>> + Should be "ti,omap2-hsmmc", for OMAP2/3 controllers
>>
>> omap_hsmmc is applicable for omap2430 and omap3.
>> omap2420 has non high speed controller mmci-omap -
>> drivers/mmc/host/omap.c
>> May be omap3-hsmmc compatible with omap2430 ?
>
> Agree. I think its best in that case for me to define a
> compatible "ti,omap2430-hsmmc" for omap2430 and "ti,omap3-hsmmc"
> for omap3. Though the IP blocks are same, I cant think of some
> common compatible string without causing confusion.

It depends, can we detect that using HW revision?
In that case, there is no need to differentiate again with compatible.

Regards,
Benoit

>
>>
>>> + Should be "ti,omap4-hsmmc", for OMAP4 controllers
>>> +- ti,hwmods: Must be "mmc<n>", n is controller instance starting 1
>>> +- reg : should contain hsmmc registers location and length
>>> +
>>> +Optional properties:
>>> +ti,dual-volt: boolean, supports dual voltage cards
>>> +<supply-name>-supply: phandle to the regulator device tree node
>>> +"supply-name" examples are "vmmc", "vmmc_aux" etc
>>> +ti,bus-width: Number of data lines, default assumed is 1 if the
>>> property is missing.
>>> +cd-gpios: GPIOs for card detection
>>> +wp-gpios: GPIOs for write protection
>>> +ti,non-removable: non-removable slot (like eMMC)
>>> +
>>> +Example:
>>> + mmc1: mmc@0x4809c000 {
>>> + compatible = "ti,omap4-hsmmc";
>>> + reg =<0x4809c000 0x400>;
>>> + ti,hwmods = "mmc1";
>>> + ti,dual-volt;
>>> + ti,bus-width =<4>;
>>> + vmmc-supply =<&vmmc>; /* phandle to regulator node */
>>> + ti,non-removable;
>>> + };
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
