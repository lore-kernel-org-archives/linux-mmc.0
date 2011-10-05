From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 2/3] mmc: Add OF bindings support for mmc host controller capabilities
Date: Wed, 5 Oct 2011 19:57:47 +0530
Message-ID: <CAJuYYwS_NeE6OG9X2p2rkjgo4OqO-ijeVwr1sLGkUuLJOxMw2g@mail.gmail.com>
References: <1317809581-28783-1-git-send-email-thomas.abraham@linaro.org>
	<1317809581-28783-3-git-send-email-thomas.abraham@linaro.org>
	<4E8C5BD6.2070709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64103 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab1JEO1r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2011 10:27:47 -0400
In-Reply-To: <4E8C5BD6.2070709@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com, kgene.kim@samsung.com, ben-linux@fluff.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

Hi Rob,

On 5 October 2011 18:59, Rob Herring <robherring2@gmail.com> wrote:
> Thomas,
>
> On 10/05/2011 05:13 AM, Thomas Abraham wrote:
>> Device nodes representing sd/mmc controllers in a device tree would =
include
>> mmc host controller capabilities. Add support for parsing of mmc hos=
t
>> controller capabilities included in device nodes.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> =A0.../devicetree/bindings/mmc/linux-mmc-host.txt =A0 =A0 | =A0 11 +=
++++++
>> =A0drivers/mmc/core/host.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0 31 ++++++++++++++++++++
>> =A0include/linux/mmc/host.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 =A03 ++
>> =A03 files changed, 45 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/devicetree/bindings/mmc/linux-mm=
c-host.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/linux-mmc-host.tx=
t b/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
>> new file mode 100644
>> index 0000000..cb43905
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
>> @@ -0,0 +1,11 @@
>> +* Linux mmc host capabilities
>> +
>> +MMC Host Controller capabilities used in linux:
>
> These aren't really linux properties... Is the capabilities register
> really this broken that all these are needed? If so, perhaps just a
> straight caps register value to override with would be better.


I was trying to provide bindings for the MMC_CAP_XXX defined in
include/linux/mmc/host.h file. I am no expert in mmc subsystem but I
believe that these capabilities are not directly mapped to any
capabilities register in the host controller hardware. All of the
MMC_CAP_XXX defines are flags used by the mmc core to make runtime
decisions. The host controller driver would read its capability
register and report its capabilities to the mmc core layer using these
MMC_CAP_XXX defines.

But not all of the MMC_CAP_XXX defines can be derived from a
capabilities register of a host controller. Some of the MMC_CAP_XXX
capabilities are used as defaults by the host controller driver while
some others which are board dependent are feed to the host controller
driver using the platform data.

While migrating a host controller driver to device tree, and not
relying on the aux data for platform data, there has to be mechanism
to specify the mmc core subsystem capabilities which are board
specific and I though bindings for MMC_CAP_XXX could be an option.


>
>> +- linux,mmc_cap_4_bit_data - host can do 4 bit transfers
>> +- linux,mmc_cap_mmc_highspeed - host can do MMC high-speed timing
>> +- linux,mmc_cap_sd_highspeed - host can do SD high-speed timing
>> +- linux,mmc_cap_needs_poll - host needs polling for card detection
>> +- linux,mmc_cap_8_bit_data - host can do 8 bit transfer
>
> "sdhci,1-bit-only" already exists as a binding. Perhaps add
> "sdhci,4-bit-only". No property then means can do 8-bit.


Ok. But that would remain just as sdhci host controller capability and
will not be applicable to other types of host controllers.


>
>> +- linux,mmc_cap_disable - host can be disabled
>
> What?

Apologies. I will be more verbose next time.

>
>> +- linux,mmc_cap_nonremovable - host is connected to nonremovable me=
dia
>> +- linux,mmc_cap_erase - host allows erase/trim commands
>
> Isn't TRIM a card property and transparent to the host controller?


I am not sure on this. Maybe it might have some dependency on the host
controller as well.


>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index 793d0a0..4ee2e43 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -19,6 +19,7 @@
>> =A0#include <linux/leds.h>
>> =A0#include <linux/slab.h>
>> =A0#include <linux/suspend.h>
>> +#include <linux/of.h>
>>
>> =A0#include <linux/mmc/host.h>
>> =A0#include <linux/mmc/card.h>
>> @@ -385,3 +386,33 @@ void mmc_free_host(struct mmc_host *host)
>> =A0}
>>
>> =A0EXPORT_SYMBOL(mmc_free_host);
>> +
>> +#ifdef CONFIG_OF
>> +/**
>> + * =A0 mmc_of_parse_host_caps - parse mmc host capabilities from de=
vice node
>> + * =A0 @np: pointer to device node in device tree
>> + * =A0 @caps: pointer to host caps value to be returned
>> + *
>> + * =A0 Search the device node in device tree for mmc host capabilit=
ies.
>> + */
>> +void mmc_of_parse_host_caps(struct device_node *np, unsigned long *=
caps)
>> +{
>> + =A0 =A0 if (of_find_property(np, "linux,mmc_cap_4_bit_data", NULL)=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *caps |=3D MMC_CAP_4_BIT_DATA;
>> + =A0 =A0 if (of_find_property(np, "linux,mmc_cap_mmc_highspeed", NU=
LL))
>> + =A0 =A0 =A0 =A0 =A0 =A0 *caps |=3D MMC_CAP_MMC_HIGHSPEED;
>> + =A0 =A0 if (of_find_property(np, "linux,mmc_cap_sd_highspeed", NUL=
L))
>> + =A0 =A0 =A0 =A0 =A0 =A0 *caps |=3D MMC_CAP_SD_HIGHSPEED;
>> + =A0 =A0 if (of_find_property(np, "linux,mmc_cap_needs_poll", NULL)=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *caps |=3D MMC_CAP_NEEDS_POLL;
>> + =A0 =A0 if (of_find_property(np, "linux,mmc_cap_8_bit_data", NULL)=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *caps |=3D MMC_CAP_8_BIT_DATA;
>> + =A0 =A0 if (of_find_property(np, "linux,mmc_cap_disable", NULL))
>> + =A0 =A0 =A0 =A0 =A0 =A0 *caps |=3D MMC_CAP_DISABLE;
>> + =A0 =A0 if (of_find_property(np, "linux,mmc_cap_nonremovable", NUL=
L))
>> + =A0 =A0 =A0 =A0 =A0 =A0 *caps |=3D MMC_CAP_NONREMOVABLE;
>> + =A0 =A0 if (of_find_property(np, "linux,mmc_cap_erase", NULL))
>> + =A0 =A0 =A0 =A0 =A0 =A0 *caps |=3D MMC_CAP_ERASE;
>> +}
>> +EXPORT_SYMBOL(mmc_of_parse_host_caps);
>> +#endif /* CONFIG_OF */
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 1d09562..72b5df2 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -309,6 +309,9 @@ extern struct mmc_host *mmc_alloc_host(int extra=
, struct device *);
>> =A0extern int mmc_add_host(struct mmc_host *);
>> =A0extern void mmc_remove_host(struct mmc_host *);
>> =A0extern void mmc_free_host(struct mmc_host *);
>> +#ifdef CONFIG_OF
>> +extern void mmc_of_parse_host_caps(struct device_node *np, unsigned=
 long *caps);
>> +#endif
>
> You don't need a ifdef around this.

Ok.

>
> Rob
>

Thanks for your review.

Regards,
Thomas.
