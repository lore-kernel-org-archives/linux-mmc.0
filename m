From: Richard Zhao <linuxzsc@gmail.com>
Subject: Re: [PATCH 5/5] mmc: sdhci: add quirk
 SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
Date: Mon, 21 Feb 2011 20:26:27 +0800
Message-ID: <20110221122627.GA2043@richard-laptop>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
 <1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
 <20110221110624.GK14495@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61805 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab1BUM0y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 07:26:54 -0500
Received: by iyb26 with SMTP id 26so661436iyb.19
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 04:26:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221110624.GK14495@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Richard Zhao <richard.zhao@freescale.com>, r65037@freescale.com, avorontsov@ru.mvista.com, eric@eukrea.com, Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-mmc@vger.kernel.org, w.sang@pengutronix.de, kernel@pengutronix.de, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

On Mon, Feb 21, 2011 at 11:06:24AM +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 21, 2011 at 05:54:55PM +0800, Richard Zhao wrote:
> > +	if (host->quirks & SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO) {
> > +		if (readl(host->ioaddr + SDHCI_VENDOR_SPEC) & 0x2)
> > +			writel(readl(host->ioaddr + SDHCI_VENDOR_SPEC) & ~0x2,
> > +					host->ioaddr + SDHCI_VENDOR_SPEC);
> 
> Is it necessary to read the register twice, or would:
> 
> 		u32 val = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
> 		if (val & 0x02)
> 			writel(val & ~0x02, host->ioaddr + SDHCI_VENDOR_SPEC);
> 
> be clearer and more obvious?
correct. Thanks.

Richard
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
