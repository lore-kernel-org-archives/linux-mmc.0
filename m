From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] Powerpc eSDHC Recover from the ADMA error
Date: Tue, 18 Sep 2012 13:12:22 -0700
Message-ID: <20120918201220.GA27312@lizard>
References: <1347955699-18780-1-git-send-email-B42677@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50355 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab2IRUPH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Sep 2012 16:15:07 -0400
Received: by pbbrr13 with SMTP id rr13so727331pbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 18 Sep 2012 13:15:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1347955699-18780-1-git-send-email-B42677@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: B42677@freescale.com
Cc: linux-mmc@vger.kernel.org, Haijun Zhang <Haijun.Zhang@freescale.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>

On Tue, Sep 18, 2012 at 04:08:19PM +0800, B42677@freescale.com wrote:
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
[...]
> +static void esdhci_of_adma_workaround(struct sdhci_host *host, u32 intmask)
> +{
> +	u32 tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
> +
> +	tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> +	if (tmp == VENDOR_V_23) {
> +		if ((intmask & SDHCI_INT_DATA_END) &&
> +			(intmask & SDHCI_INT_BLK_GAP)) {

By inverting the condition, you could greatly reduce the
indentation. I.e. return early if the condition is false, and
do the rest outside of the if block. (Plus, one if statement
would be enough, no need to nest them.)

Thanks,

Anton.
