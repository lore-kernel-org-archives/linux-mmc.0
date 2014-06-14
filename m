From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/3] mmc: Add APM X-Gene SoC SDHC controller support to Arasan SDHCI driver
Date: Sat, 14 Jun 2014 23:36:29 +0200
Message-ID: <5219148.cLBgakF4fc@wuerfel>
References: <1401829985-5212-1-git-send-email-lho@apm.com> <1401829985-5212-3-git-send-email-lho@apm.com> <9432f705-fd6a-44a6-8e04-c0455f0a551c@BN1AFFO11FD054.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:57050 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbaFNVgi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Jun 2014 17:36:38 -0400
In-Reply-To: <9432f705-fd6a-44a6-8e04-c0455f0a551c@BN1AFFO11FD054.protection.gbl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Loc Ho <lho@apm.com>, chris@printf.net, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, patches@apm.com

On Wednesday 04 June 2014 08:09:12 Michal Simek wrote:
> > +
> > +static void sdhci_arasn_xgene_xlat_addr(struct sdhci_arasan_data *data,
> > +                                    u64 dma_addr)
> > +{
> > +     #define AIM_AXI_HI_OFFSET       0x0000000c
> > +     #define  AIM_AXI_ADDRESS_HI_N_WR(src) \
> > +                                     (((u32) (src) << 20) & 0xfff00000)
> 
> ditto with indentation.
> 20 should be shift
> 0xfff00000 is mask.
> 
> Also you should take this opportunity and add function description
> in kernel doc to be exactly clear what this function is doing.

Actually this should just be configured in the dma-ranges property
I think. It's not the driver's business to do the dma translation.

	Arnd
