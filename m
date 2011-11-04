From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/4] mmc: omap: adapt the hsmmc driver to device tree
Date: Fri, 4 Nov 2011 22:25:24 +0100
Message-ID: <4EB45844.5000603@ti.com>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com> <1320407441-29697-3-git-send-email-rnayak@ti.com> <20111104200415.GC3045@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37599 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043Ab1KDVZl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Nov 2011 17:25:41 -0400
In-Reply-To: <20111104200415.GC3045@quad.lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Rajendra Nayak <rnayak@ti.com>, cjb@laptop.org, balajitk@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Olof,

On 11/4/2011 9:04 PM, Olof Johansson wrote:
> On Fri, Nov 04, 2011 at 05:20:39PM +0530, Rajendra Nayak wrote:
>> Define dt bindings for the ti-omap-hsmmc, and adapt
>> the driver to extract data (which was earlier passed as
>> platform_data) from device tree node.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> ---
>>   .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   50 +++++++++
>>   drivers/mmc/host/omap_hsmmc.c                      |  117 ++++++++++++++++++++
>>   2 files changed, 167 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> new file mode 100644
>> index 0000000..370af1b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> @@ -0,0 +1,50 @@
>> +* TI Highspeed MMC host controller for OMAP
>> +
>> +The Highspeed MMC Host Controller on TI OMAP family
>> +provides an interface for MMC, SD, and SDIO types of memory cards.
>> +
>> +Required properties:
>> +- compatible: Should be "ti,omap-hsmmc<n>", "ti,omap2-hsmmc";
>> +n is controller instance starting 0, for OMAP2/3 controllers
>
> No, no, no. You should not have to specify the unit-address in the compatible
> field. They are all programmed the same way, right?

AFAIR, 2 instances contain a DMA engine, but that should anyway be 
detected using a "ti,had-dma-engine" extra property and not like that.

Checking the code in #2, it is used to get the instance of the MMC.

+static unsigned int of_get_hsmmc_instance(struct device_node *np)
+{
+	int i;
+	char comp[32];
+
+	for (; i < OMAP_MMC_DEV_MAX; i++) {
+		snprintf(comp, 32, "ti,omap-hsmmc%d", i);
+		if (of_device_is_compatible(np, comp))
+			break;
+	}
+	return i;
+}

Which does not seems to be a good usage of the compatible property anyway.
For a similar issue someone on the list suggested using the "cell-index" 
property. But the definition I found in some binding documentation seems 
to reserve that to: "enumerate logical devices within an IP core."
Ideally the driver should probably get rid of the need for an index.
I didn't check the original driver, but that should be needed for some 
legacy reason.

> Also, they should go from the specific to the generic, but the first property
> is the same for 2/3 and 4. That's wrong.
>
>> +- compatible: Should be "ti,omap-hsmmc<n>", "ti,omap4-hsmmc";
>> +n is controller instance starting 0, for OMAP4 controllers
>> +- ti,hwmods: Must be "mmc<n>", n is controller instance starting 1
>
> I didn't think hwmod bindings were settled on yet?

Why did you think that?

That binding was pretty straightforward and mandatory for starting any 
OMAP device tree migration until we have the proper reg-names, irq-names 
and dma-names generic binding.

Did you had any concern with that binding?

Regards,
Benoit

