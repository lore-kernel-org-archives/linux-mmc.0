From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 08/12] dt-bindings: mmc: Add Xenon description
Date: Tue, 14 Jun 2016 10:02:47 +0200
Message-ID: <87d1nkci54.fsf@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
	<1465456218-28354-9-git-send-email-gregory.clement@free-electrons.com>
	<20160610141603.GA7827@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160610141603.GA7827@rob-hp-laptop> (Rob Herring's message of
	"Fri, 10 Jun 2016 09:16:03 -0500")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Omri Itach <omrii-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Rob,
 
 On ven., juin 10 2016, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Thu, Jun 09, 2016 at 09:10:14AM +0200, Gregory CLEMENT wrote:
>> This patch documents the Xenon SDHCI controller that we can find in the
>> Armada 37xx and the Armada 7K and 8K SoCs.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> ---
>>  .../devicetree/bindings/mmc/sdhci-xenon.txt        | 27 ++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-xenon.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-xenon.txt b/Documentation/devicetree/bindings/mmc/sdhci-xenon.txt
>> new file mode 100644
>> index 000000000000..e8d49fda5f12
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-xenon.txt
>> @@ -0,0 +1,27 @@
>> +* Marvell sdhci-xenon controller
>> +
>> +This file documents differences between the core properties in mmc.txt
>> +and the properties used by the sdhci-xenon drivers.
>
> Bindings don't document drivers...

Sure I missed this one.


>
>> +
>> +Required properties:
>> +- compatible: Should be "marvell,xenon-sdhci".
>
> SoC specific compatible strings please. This one can be fallback.

OK

>
>> +- reg:
>> +  one register area for the SDHCI registers.
>> +- interrupts-extended: interrupt number and attributes
>
> Just use interrupts unless you really have a need for 
> interrupts-extended. Really, either is valid for any binding, but I 
> prefer to just have bindings documented one way.

OK

>
>> +- clocks: array of clocks required for SDHCI.
>
> Missing from the exmaple, and how many clocks and in what order?


I need to figure out it.

>
>> +- bus-width: max bus width in unit of bit, normally should be 1 bit, 4 bits or 8 bits
>
> Isn't this one standard? Just refer back to the common binding.

OK it will simplify the binding dcumentation.

>
>> +
>> +Optional properties:
>> +- non-removable: whether card is non-removable.
>> +- auto-cmd12: whether cmd12 is sent automatically.
>
> Seems strange this would be optional for a specific controller. I'd 
> expect either the xenon controller needs this or not.

I have to check it.

Thanks for the review,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
