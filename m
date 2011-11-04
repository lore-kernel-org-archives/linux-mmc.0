From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/4] mmc: omap: adapt the hsmmc driver to device tree
Date: Fri, 4 Nov 2011 14:28:16 -0700
Message-ID: <CAOesGMiuJruzyNZWP0=QtWFbh4fvhrJ69z0018bTaZaVQy1OHw@mail.gmail.com>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com>
	<1320407441-29697-3-git-send-email-rnayak@ti.com>
	<20111104200415.GC3045@quad.lixom.net>
	<4EB45844.5000603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38659 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab1KDV2R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2011 17:28:17 -0400
In-Reply-To: <4EB45844.5000603@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, cjb@laptop.org, balajitk@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Nov 4, 2011 at 2:25 PM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
> Hi Olof,
>
> On 11/4/2011 9:04 PM, Olof Johansson wrote:
>>
>> On Fri, Nov 04, 2011 at 05:20:39PM +0530, Rajendra Nayak wrote:
>>>
>>> Define dt bindings for the ti-omap-hsmmc, and adapt
>>> the driver to extract data (which was earlier passed as
>>> platform_data) from device tree node.
>>>
>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>> ---
>>> =A0.../devicetree/bindings/mmc/ti-omap-hsmmc.txt =A0 =A0 =A0| =A0 5=
0 +++++++++
>>> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0117
>>> ++++++++++++++++++++
>>> =A02 files changed, 167 insertions(+), 0 deletions(-)
>>> =A0create mode 100644
>>> Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.tx=
t
>>> b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>> new file mode 100644
>>> index 0000000..370af1b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>> @@ -0,0 +1,50 @@
>>> +* TI Highspeed MMC host controller for OMAP
>>> +
>>> +The Highspeed MMC Host Controller on TI OMAP family
>>> +provides an interface for MMC, SD, and SDIO types of memory cards.
>>> +
>>> +Required properties:
>>> +- compatible: Should be "ti,omap-hsmmc<n>", "ti,omap2-hsmmc";
>>> +n is controller instance starting 0, for OMAP2/3 controllers
>>
>> No, no, no. You should not have to specify the unit-address in the
>> compatible
>> field. They are all programmed the same way, right?
>
> AFAIR, 2 instances contain a DMA engine, but that should anyway be de=
tected
> using a "ti,had-dma-engine" extra property and not like that.

Yep, it should be described by properties instead, such that future
products won't need new bindings unless they add new hardware features
(i.e. just new combinations of existing features should just work,
more or less).

>> I didn't think hwmod bindings were settled on yet?
>
> Why did you think that?
>
> That binding was pretty straightforward and mandatory for starting an=
y OMAP
> device tree migration until we have the proper reg-names, irq-names a=
nd
> dma-names generic binding.
>
> Did you had any concern with that binding?

Nope, just wasn't sure if it had settled down since I hadn't followed
it closely. No concerns.


-Olof
