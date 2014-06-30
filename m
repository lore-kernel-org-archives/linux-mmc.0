From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: Re: [RFC PATCH v2 4/6] mmc: sdhci: host: add new f_sdh30
Date: Mon, 30 Jun 2014 10:10:21 +0800
Message-ID: <CAOEd-H2M7h1=Yd6m2wLJsSV55TtCaKBtXjHmzBiJ51kW-jzTTA@mail.gmail.com>
References: <1403763812-5495-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<1403763812-5495-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<20140626110351.GN15240@leverpostej>
	<CAOEd-H3+MwT3DMqMO0XHaZQqYAN0zaQqRMjC_UjyJn5ZwCaMoQ@mail.gmail.com>
	<20140627101248.GD7262@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:49493 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbaF3CKW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Jun 2014 22:10:22 -0400
In-Reply-To: <20140627101248.GD7262@leverpostej>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "chris@printf.net" <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "anton@enomsg.org" <anton@enomsg.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "patches@linaro.org" <patches@linaro.org>, "andy.green@linaro.org" <andy.green@linaro.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>

2014-06-27 18:12 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> On Fri, Jun 27, 2014 at 04:32:21AM +0100, Vincent Yang wrote:
>> 2014-06-26 19:03 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
>> > On Thu, Jun 26, 2014 at 07:23:30AM +0100, Vincent Yang wrote:
>> >> This patch adds new host controller driver for
>> >> Fujitsu SDHCI controller f_sdh30.
>> >>
>> >> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>> >> ---
>> >>  .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  35 +++
>> >>  drivers/mmc/host/Kconfig                           |   7 +
>> >>  drivers/mmc/host/Makefile                          |   1 +
>> >>  drivers/mmc/host/sdhci_f_sdh30.c                   | 346 +++++++++++++++++++++
>> >>  drivers/mmc/host/sdhci_f_sdh30.h                   |  40 +++
>> >>  5 files changed, 429 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>> >>  create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c
>> >>  create mode 100644 drivers/mmc/host/sdhci_f_sdh30.h
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>> >> new file mode 100644
>> >> index 0000000..40add438
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>> >> @@ -0,0 +1,35 @@
>> >> +* Fujitsu SDHCI controller
>> >> +
>> >> +This file documents differences between the core properties in mmc.txt
>> >> +and the properties used by the sdhci_f_sdh30 driver.
>> >> +
>> >> +Required properties:
>> >> +- compatible: "fujitsu,f_sdh30"
>> >
>> > Please use '-' rather than '_' in compatible strings.
>>
>> Hi Mark,
>> Yes, I'll update it to '-' in next version.
>>
>> >
>> > This seems to be the name of the driver. What is the precise name of the
>> > IP block?
>>
>> The name of the IP block is "F_SDH30".
>> That's why it uses "fujitsu,f_sdh30"
>
> Hmm. I'd still be tempted to use "fujitsu,f-sdh30".

Hi Mark,
Sure, I'll update it to "fujitsu,f-sdh30" in next version.

>
>> >
>> > [...]
>> >
>> >> +       if (!of_property_read_u32(pdev->dev.of_node, "vendor-hs200",
>> >> +                                 &priv->vendor_hs200))
>> >> +               dev_info(dev, "Applying vendor-hs200 setting\n");
>> >> +       else
>> >> +               priv->vendor_hs200 = 0;
>> >
>> > This wasn't in the binding document, and a grep for "vendor-hs200" in a
>> > v3.16-rc2 tree found me nothing.
>> >
>> > Please document this.
>>
>> Yes, it is a setting for a vendor specific register.
>> I'll update it in next version.
>
> It would be nice to know exactly what this is. We usually shy clear of
> placing register values in dt. I can wait until the next posting if
> you're goin to document that.

I'm thinking about removing this register value in dt.
I'll update it in next version.

>
>> >> +       if (!of_property_read_u32(pdev->dev.of_node, "bus-width", &bus_width)) {
>> >> +               if (bus_width == 8) {
>> >> +                       dev_info(dev, "Applying 8 bit bus width\n");
>> >> +                       host->mmc->caps |= MMC_CAP_8_BIT_DATA;
>> >> +               }
>> >> +       }
>> >
>> > What if bus-width is not 8, or is not present?
>>
>> In both cases, it will not touch host->mmc->caps at all. Then sdhci_add_host()
>> will handle it and set MMC_CAP_4_BIT_DATA as default:
>>
>> [...]
>> /*
>> * A controller may support 8-bit width, but the board itself
>> * might not have the pins brought out.  Boards that support
>> * 8-bit width must set "mmc->caps |= MMC_CAP_8_BIT_DATA;" in
>> * their platform code before calling sdhci_add_host(), and we
>> * won't assume 8-bit width for hosts without that CAP.
>> */
>> if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
>> mmc->caps |= MMC_CAP_4_BIT_DATA;
>
> Ok, but does it make sense for a dts to have:
>
>         bus-width = <1>;
>
> If so, we should presumably do something.
>
> If not, we should at least print a warning that the dtb doesn't make
> sense.

I'll print a warning for invalid values in next version.
Thanks a lot for your review!


Best regards,
Vincent Yang

>
> Cheers,
> Mark.
