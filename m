From: Zhang Haijun-B42677 <B42677@freescale.com>
Subject: RE: [PATCH 2/2] mmc: esdhc: get voltage from dts file
Date: Tue, 23 Jul 2013 03:41:49 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E13E4A96@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1374479636-9254-1-git-send-email-Haijun.Zhang@freescale.com>
	<1374479636-9254-2-git-send-email-Haijun.Zhang@freescale.com>
	<1374514847.15592.7@snotra>
	<99E897753B6F7048BD8CCDB4661D02E13E49EC@039-SN2MPN1-022.039d.mgd.msft.net>
 <1374547294.15592.22@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:11039
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753109Ab3GWDly convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Jul 2013 23:41:54 -0400
In-Reply-To: <1374547294.15592.22@snotra>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wood Scott-B07421 <B07421@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, Fleming Andy-AFLEMING <afleming@freescale.com>



Thanks.

Regards
Haijun.


> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, July 23, 2013 10:42 AM
> To: Zhang Haijun-B42677
> Cc: Wood Scott-B07421; linux-mmc@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; cbouatmailru@gmail.com; cjb@laptop.org; Fleming
> Andy-AFLEMING
> Subject: Re: [PATCH 2/2] mmc: esdhc: get voltage from dts file
> 
> On 07/22/2013 09:38:33 PM, Zhang Haijun-B42677 wrote:
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Tuesday, July 23, 2013 1:41 AM
> > > To: Zhang Haijun-B42677
> > > Cc: linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > > cbouatmailru@gmail.com; cjb@laptop.org; Fleming Andy-AFLEMING; Zhang
> > > Haijun-B42677; Zhang Haijun-B42677
> > > Subject: Re: [PATCH 2/2] mmc: esdhc: get voltage from dts file
> > >
> > > On 07/22/2013 02:53:56 AM, Haijun Zhang wrote:
> > > > Add voltage-range support in esdhc of T4, So we can choose to read
> > > > voltages from dts file as one optional.
> > > > If we can get a valid voltage-range from device node, we use this
> > > > voltage as the final voltage support. Else we still read from
> > capacity
> > > > or from other provider.
> > > >
> > > > Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> > > > Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
> > > > ---
> > > >  drivers/mmc/host/sdhci-of-esdhc.c | 31
> > > > +++++++++++++++++++++++++++++++
> > > >  drivers/mmc/host/sdhci.c          |  3 +++
> > > >  include/linux/mmc/sdhci.h         |  1 +
> > > >  3 files changed, 35 insertions(+)
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
> > > > b/drivers/mmc/host/sdhci-of-esdhc.c
> > > > index 15039e2..8b4b27a 100644
> > > > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > > > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > > > @@ -262,6 +262,35 @@ static int esdhc_pltfm_bus_width(struct
> > > > sdhci_host *host, int width)
> > > >  	return 0;
> > > >  }
> > > >
> > > > +static void esdhc_get_voltage(struct sdhci_host *host,
> > > > +			struct platform_device *pdev)
> > > > +{
> > > > +	const u32 *voltage_ranges;
> > > > +	int num_ranges, i;
> > > > +	struct device_node *np;
> > > > +	np = pdev->dev.of_node;
> > > > +
> > > > +	voltage_ranges = of_get_property(np, "voltage-ranges",
> > > > &num_ranges);
> > > > +	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
> > > > +	if (!voltage_ranges || !num_ranges) {
> > > > +		dev_info(&pdev->dev, "OF: voltage-ranges
> > > > unspecified\n");
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	for (i = 0; i < num_ranges; i++) {
> > > > +		const int j = i * 2;
> > > > +		u32 mask;
> > > > +		mask =
> > > > mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
> > > > +				be32_to_cpu(voltage_ranges[j + 1]));
> > > > +		if (!mask) {
> > > > +			dev_info(&pdev->dev,
> > > > +				"OF: false voltage-ranges specified\n");
> > > > +			return;
> > > > +		}
> > > > +		host->ocr_mask |= mask;
> > > > +	}
> > > > +}
> > >
> > > Don't duplicate this code.  Move it somewhere common and share it.
> > [Haijun Wrote:] So, move it drivers/mmc/host/sdhci-pltfm.c and share
> > it as Sdhc_get_voltage()....?
> 
> I'll let the MMC maintainer say what the appropriate place would be...
> Don't capitalize the function name, though. :-)
[Haijun Wrote:] Thanks scott. I'm always expecting chris's advice.
> 
> -Scott

