Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3191366;
	Mon,  3 Jun 2024 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413988; cv=none; b=K0KTRa2v6IdxXxMjS6swomhbComDf+PHODWScimIvHE9bZN25vhCtdGHT1o49EqUcC2DDtPmab/b61wxbzSmX/sXvUNg+WFYZ07vZU4iSp9+MfBEAN9+l7QUDuv+UB4NdlXvaxZ8zU0Z+4ecRHqCY9ovqCgck5dANlgNCKoESNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413988; c=relaxed/simple;
	bh=U5nhK6N3AY+7D8Nic9cgW9P7u0jQsPlGNJPN6Yco6fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9AxcZJRp3XK6H9U+n+wRalhgyfbvfYfx+n4jR+NPLMYx8IqKDFkODfcZlXBpKJllAyj6HY4+4mDxsSwElto8MsgjpsH8uBmJ6ekJNj/2XpGcMkt8c+KkO1rx1vhINtsY9Y+fP2BumQK3encOek48427PJng+vm2Pj7gUEZZYyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b65.versanet.de ([83.135.91.101] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sE5pU-0006rj-BG; Mon, 03 Jun 2024 13:26:20 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>
Cc: serghox@gmail.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, quentin.schulz@cherry.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH] mmc: sdhci-of-dwcmshc: don't enable CQE without a suitable irq
 handler
Date: Mon, 03 Jun 2024 13:26:19 +0200
Message-ID: <4015176.ZaRXLXkqSa@diego>
In-Reply-To: <55cea03b-e685-4f7b-a93b-cb464417d364@intel.com>
References:
 <20240530215532.2192423-1-heiko@sntech.de>
 <55cea03b-e685-4f7b-a93b-cb464417d364@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 3. Juni 2024, 10:01:23 CEST schrieb Adrian Hunter:
> On 31/05/24 00:55, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > 
> > supports-cqe is an established dt property so can appear in devicetrees
> > at any time. CQE support in the sdhci-of-dwcmshc driver does require a
> > special irq handler in the platform-specific ops, to handle the CQE
> > interrupt.
> > 
> > Without this special handler we end up with a spew of unhandled interrupt
> > messages on devices with supports-cqe property but without irq handler:
> > 
> > [   11.624143] mmc0: Unexpected interrupt 0x00004000.
> > [   11.629504] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> > [   11.636711] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00000005
> > [   11.643919] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
> > [   11.651128] mmc0: sdhci: Argument:  0x00018000 | Trn mode: 0x00000033
> > [   11.658336] mmc0: sdhci: Present:   0x13f700f0 | Host ctl: 0x00000034
> > [   11.665545] mmc0: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
> > [   11.672753] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000407
> > [   11.679961] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00004000
> > [   11.687169] mmc0: sdhci: Int enab:  0x02ff4000 | Sig enab: 0x02ff4000
> > [   11.694378] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> > [   11.701586] mmc0: sdhci: Caps:      0x226dc881 | Caps_1:   0x08000007
> > [   11.708794] mmc0: sdhci: Cmd:       0x00000d1e | Max curr: 0x00000000
> > [   11.716003] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
> > [   11.723211] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x000007cd
> > [   11.730419] mmc0: sdhci: Host ctl2: 0x0000000f
> > [   11.735392] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xee28f008
> > [   11.742600] mmc0: sdhci: ============================================
> > 
> > So don't enable CQE if a usable interrupt handler is not defined and warn
> > instead about this fact.
> > 
> > Fixes: 53ab7f7fe412 ("mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support")
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > ---
> > My rk3588-tiger and rk3588-jaguar devicetrees had an accidential
> > supports-cqe in their devicetree, which made me run into this problem
> > with 6.10-rc1 .
> > 
> >  drivers/mmc/host/sdhci-of-dwcmshc.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index 39edf04fedcf7..4410d4523728d 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -1254,10 +1254,14 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >  
> >  	/* Setup Command Queue Engine if enabled */
> >  	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
> > -		priv->vendor_specific_area2 =
> > -			sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
> > +		if (pltfm_data && pltfm_data->ops && pltfm_data->ops->irq) {
> 
> ->irq() could be used for other things, so checking it for CQE
> support is not appropriate.

though here we are in the very limited scope of only the dwcmshc sdhci
controller.

And at this point, any controller using the generic sdhci_dwcmshc_ops
will always get the CQE irq handler, while _all other_ controllers
will need to define one to handle the CQE irqs.

So any variant trying to enable CQE needs to define an irq handler, hence
the check simply was meant to not allow CQE enablement without any irq
handler, because that will always cause those unhandled irq issues.

> If necessary, it would be better to flag which variants support
> CQE in their platform data.

I guess we can assume that all of the dwcmshc IP variants support
CQE, it's just that the implementation is slightly strange in that
a DT can enable CQE support and this will cause the driver to enable the
CQE interrupt, even if nothing is there to handle it.


For my own case I can also just live with the Rockchip irq handler
patch going in (ideally as a fix) and I just wanted to try to fix this
will definitly fail if irq-handler not present case.


Heiko


> However that would probably mean introducing something
> like struct dwcmshc_pltfm_data as described here:
> 
> https://lore.kernel.org/linux-mmc/ed900af1-f090-49a9-bc7e-363a28a4ac2b@intel.com/
> 
> 
> > +			priv->vendor_specific_area2 =
> > +				sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
> >  
> > -		dwcmshc_cqhci_init(host, pdev);
> > +			dwcmshc_cqhci_init(host, pdev);
> > +		} else {
> > +			dev_warn(&pdev->dev, "can't enable cqe support without irq handler\n");
> > +		}
> >  	}
> >  
> >  	if (rk_priv)
> 
> 




