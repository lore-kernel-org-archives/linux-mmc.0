From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: RE: [PATCH] mmc: add the MMC/SD/SDIO Arasan host controller
Date: Wed, 28 Jul 2010 11:28:48 +0200
Message-ID: <107012446AC13D4C90B85672EAF5FB0E9C2E08DF25@SAFEX1MAIL3.st.com>
References: <1280299127-3075-1-git-send-email-peppe.cavallaro@st.com>
 <4C4FECC8.9060101@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:40170 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754465Ab0G1J30 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Jul 2010 05:29:26 -0400
In-Reply-To: <4C4FECC8.9060101@csr.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi David,

> -----Original Message-----
> From: David Vrabel [mailto:david.vrabel@csr.com]
> Sent: Wednesday, July 28, 2010 10:40 AM
> To: Peppe CAVALLARO
> Cc: linux-mmc@vger.kernel.org
> Subject: Re: [PATCH] mmc: add the MMC/SD/SDIO Arasan host controller
> 
> Giuseppe CAVALLARO wrote:
> > This patch adds the MMC/SD/SDIO Arasan host controller.
> > Advanced DMA, Single DMA and PIO modes are supported.
> > The former is the default.
> 
> The Arasan IP is a Standard Host Controller so you should look at using
> the existing sdhci driver.  The sdhci-s3c driver provides an an example
> of how to do this.

So I've to move part of my work to another file (e.g. sdhci-stm) obviously reworking all in order to use the existent code (sdhci core etc).
I'll post a new patch asap

Regards,
Peppe

> 
> David
