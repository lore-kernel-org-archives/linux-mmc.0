From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/4] mmc: omap: adapt the hsmmc driver to device tree
Date: Mon, 07 Nov 2011 11:44:43 +0530
Message-ID: <4EB77753.8040606@ti.com>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com> <1320407441-29697-3-git-send-email-rnayak@ti.com> <20111104200415.GC3045@quad.lixom.net> <4EB45844.5000603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:35229 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751600Ab1KGGOw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2011 01:14:52 -0500
In-Reply-To: <4EB45844.5000603@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Olof Johansson <olof@lixom.net>, cjb@laptop.org, balajitk@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Saturday 05 November 2011 02:55 AM, Cousson, Benoit wrote:
>>> +Required properties:
>>> +- compatible: Should be "ti,omap-hsmmc<n>", "ti,omap2-hsmmc";
>>> +n is controller instance starting 0, for OMAP2/3 controllers
>>
>> No, no, no. You should not have to specify the unit-address in the
>> compatible
>> field. They are all programmed the same way, right?
>
> AFAIR, 2 instances contain a DMA engine, but that should anyway be
> detected using a "ti,had-dma-engine" extra property and not like that.
>
> Checking the code in #2, it is used to get the instance of the MMC.
>
> +static unsigned int of_get_hsmmc_instance(struct device_node *np)
> +{
> +    int i;
> +    char comp[32];
> +
> +    for (; i < OMAP_MMC_DEV_MAX; i++) {
> +        snprintf(comp, 32, "ti,omap-hsmmc%d", i);
> +        if (of_device_is_compatible(np, comp))
> +            break;
> +    }
> +    return i;
> +}
>
> Which does not seems to be a good usage of the compatible property anyway.
> For a similar issue someone on the list suggested using the "cell-index"
> property. But the definition I found in some binding documentation seems
> to reserve that to: "enumerate logical devices within an IP core."
> Ideally the driver should probably get rid of the need for an index.
> I didn't check the original driver, but that should be needed for some
> legacy reason.

yes, there are a bunch of things done inside the driver based on the
instance id which seem wrong, but I agree, encoding the instance
in the compatible property seems really bad and non-scalable.
Will look at how some of this legacy code in the driver can be
removed/cleaned up.
