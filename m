From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH V2] Powerpc eSDHC Recover from the ADMA error
Date: Tue, 18 Sep 2012 23:08:48 -0700
Message-ID: <20120919060848.GA25261@lizard>
References: <1348031113-19583-1-git-send-email-B42677@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64270 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558Ab2ISGL1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Sep 2012 02:11:27 -0400
Received: by pbbrr13 with SMTP id rr13so1678071pbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 18 Sep 2012 23:11:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1348031113-19583-1-git-send-email-B42677@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: B42677@freescale.com
Cc: linux-mmc@vger.kernel.org, Haijun Zhang <Haijun.Zhang@freescale.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>

On Wed, Sep 19, 2012 at 01:05:13PM +0800, B42677@freescale.com wrote:
> From: Haijun Zhang <Haijun.Zhang@freescale.com>
> 
> A-003500: False ADMA Error might be reported when ADMA is used for
> multiple block read command with Stop at Block Gap. If PROCTL[SABGREQ]
> is set when the particular block's data is received by the System side
> logic before entire block(with CRC) data is received by the SD side logic,
> and also if ADMA descriptor line is fetched at the same time,
> then DMA engine might report false ADMA error. eSDHC might not be able
> to Continue(PROCTL[CREQ]=1)after Stop at Block Gap.
> This issue will impact the eSDHC IP VVN2.3.
> 
> 
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Anton Vorontsov <cbouatmailru@gmail.com>
> ---
> changes for v2:
> 	- Invert the condition of the if statement in function workground

Hm.

[...]
> +static void esdhci_of_adma_workaround(struct sdhci_host *host, u32 intmask)
> +{
> +	u32 tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
> +
> +	tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> +	if ((intmask & SDHCI_INT_DATA_END) &&
> +		(intmask & SDHCI_INT_BLK_GAP) &&
> +		(tmp == VENDOR_V_23)) {

I really don't see it inverted. :-)

What I meant was this:

static void esdhci_of_adma_workaround(struct sdhci_host *host, u32 intmask)
{
	u32 vendor;
	bool applicable;
	dma_addr_t dmastart;
	dma_addr_t dmanow;

	vendor = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
	vendor = (vendor & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;

	applicable = intmask & SDHCI_INT_DATA_END &&
		     intmask & SDHCI_INT_BLK_GAP &&
		     vendor == VENDOR_V_23;
	if (!applicable)
		return;

	host->data->error = 0;
	dmastart = sg_dma_address(host->data->sg);
	dmanow = dmastart + host->data->bytes_xfered;
	...
	...
}

This is human-readable and there's no additional indentation.

Thanks,

Anton.
