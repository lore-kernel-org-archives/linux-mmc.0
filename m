Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FE8C2D0DB
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 10:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33DA20684
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 10:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nvVtLLxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgATKVJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:21:09 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:32796 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgATKVJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2020 05:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o28cx7O0X4XAioZnVt8nJLAZSRK49uH6kL/Zzv/f0rI=; b=nvVtLLxK0I/b7ZojG7jfz6o1S
        3rzHZpnEODR9FtCnSYA2AKXBA4d2NiurxwHPZ2kTD1EAtxpKWXcijbddDOzw8ZHYn0IMexLx9IVqX
        ewhAAn10pa3ZMDGd2CU9quA4g8kQlZa0MODffnmcl3iMuSGJc2LcfvwafP+2W548miQ5uSVedjU+L
        Yl9n+338X2E/WIuiF0CGxOsUu7fjuNrVoNk2O9nCsGXRtW3f/NzqjH5ZoGEtGHwM2+QDGtQ0nx+rH
        dB/nrhgu1UPSSi0veuzRuQpSTzyumAEiLMk3HLhCPpLNYVb0dI2j+8zDAeiWfq9pMERCdNu4Rl4GO
        Pio5dQ60w==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:57394)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1itUAy-0005SJ-O0; Mon, 20 Jan 2020 10:20:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1itUAt-0002l9-OH; Mon, 20 Jan 2020 10:20:51 +0000
Date:   Mon, 20 Jan 2020 10:20:51 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        dann frazier <dann.frazier@canonical.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA
 coherence
Message-ID: <20200120102051.GA25745@shell.armlinux.org.uk>
References: <20190922102341.GO25745@shell.armlinux.org.uk>
 <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
 <AM7PR04MB688507B5B4D84EB266738891F8320@AM7PR04MB6885.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM7PR04MB688507B5B4D84EB266738891F8320@AM7PR04MB6885.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Jan 20, 2020 at 10:09:00AM +0000, Y.b. Lu wrote:
> Hi Russell,
> 
> Recently I got eSDHC ADMA issue on PowerPC T2080 platform. After checking, the issue is related to this patch.
> This patch was to make eSDHC DMA SNOOP bit set per dma-coherent. That resolved issue on LX2160A ARM64 platform.
> However on T2080, we are facing similar issue again. It didn't have dma-coherent in dts.
> Adding dma-coherent in dts, or reverting the patch could resolve the problem.
> 
> Would you please help to have a look at it too? Thanks:)

All aspects of this was discussed extensively by many parties, and as
far as I remember, no conclusion was reached - the discussion became
rather unproductive, so I walked away from it.

I've more or less washed my hands of this in disgust that no way
forward can be found, not even reverting the patch (and then I'll
just carry the patch locally, so at least my machines work - shame
for other ARM64 folk trying to use the LX2160A.)

> 
> mmc0: ADMA error: 0x02000000
> mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00002002
> mmc0: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000001
> mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> NET: Registered protocol family 10
> mmc0: sdhci: Present:   0x01fd020a | Host ctl: 0x00000038
> mmc0: sdhci: Power:     0x00000003 | Blk gap:  0x00000000
> mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x000020b8
> mmc0: sdhci: Timeout:   0x00000003 | Int stat: 0x00000001
> mmc0: sdhci: Int enab:  0x037f100f | Sig enab: 0x037f100b
> mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00002002
> mmc0: sdhci: Caps:      0x34fa0000 | Caps_1:   0x0000af00
> mmc0: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
> mmc0: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x003b3733
> mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x3f400e00
> mmc0: sdhci: Host ctl2: 0x00000000
> mmc0: sdhci: ADMA Err:  0x0000000d | ADMA Ptr: 0x00000000f35ad20c
> mmc0: sdhci: ============================================
> mmc0: sdhci: f35ad200: DMA 0x00000000f3587710, LEN 0x0008, Attr=0x23
> mmc0: error -5 whilst initialising SD card
> 
> Best regards,
> Yangbo Lu
> 
> 
> > -----Original Message-----
> > From: Russell King <rmk@armlinux.org.uk> On Behalf Of Russell King
> > Sent: Sunday, September 22, 2019 6:27 PM
> > To: Robin Murphy <robin.murphy@arm.com>; dann frazier
> > <dann.frazier@canonical.com>; Will Deacon <will.deacon@arm.com>; Nicolin
> > Chen <nicoleotsuka@gmail.com>; Y.b. Lu <yangbo.lu@nxp.com>; Christoph
> > Hellwig <hch@lst.de>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>; Ulf Hansson
> > <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org
> > Subject: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA
> > coherence
> > 
> > We must not unconditionally set the DMA snoop bit; if the DMA API is
> > assuming that the device is not DMA coherent, and the device snoops the
> > CPU caches, the device can see stale cache lines brought in by
> > speculative prefetch.
> > 
> > This leads to the device seeing stale data, potentially resulting in
> > corrupted data transfers.  Commonly, this results in a descriptor fetch
> > error such as:
> > 
> > mmc0: ADMA error
> > mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> > mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00002202
> > mmc0: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000001
> > mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> > mmc0: sdhci: Present:   0x01f50008 | Host ctl: 0x00000038
> > mmc0: sdhci: Power:     0x00000003 | Blk gap:  0x00000000
> > mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x000040d8
> > mmc0: sdhci: Timeout:   0x00000003 | Int stat: 0x00000001
> > mmc0: sdhci: Int enab:  0x037f108f | Sig enab: 0x037f108b
> > mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00002202
> > mmc0: sdhci: Caps:      0x35fa0000 | Caps_1:   0x0000af00
> > mmc0: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
> > mmc0: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x001d8a33
> > mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x3f400e00
> > mmc0: sdhci: Host ctl2: 0x00000000
> > mmc0: sdhci: ADMA Err:  0x00000009 | ADMA Ptr: 0x000000236d43820c
> > mmc0: sdhci: ============================================
> > mmc0: error -5 whilst initialising SD card
> > 
> > but can lead to other errors, and potentially direct the SDHCI
> > controller to read/write data to other memory locations (e.g. if a valid
> > descriptor is visible to the device in a stale cache line.)
> > 
> > Fix this by ensuring that the DMA snoop bit corresponds with the
> > behaviour of the DMA API.  Since the driver currently only supports DT,
> > use of_dma_is_coherent().  Note that device_get_dma_attr() can not be
> > used as that risks re-introducing this bug if/when the driver is
> > converted to ACPI.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/mmc/host/sdhci-of-esdhc.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
> > b/drivers/mmc/host/sdhci-of-esdhc.c
> > index 4dd43b1adf2c..74de5e8c45c8 100644
> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > @@ -495,7 +495,12 @@ static int esdhc_of_enable_dma(struct sdhci_host
> > *host)
> >  		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
> > 
> >  	value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
> > -	value |= ESDHC_DMA_SNOOP;
> > +
> > +	if (of_dma_is_coherent(dev->of_node))
> > +		value |= ESDHC_DMA_SNOOP;
> > +	else
> > +		value &= ~ESDHC_DMA_SNOOP;
> > +
> >  	sdhci_writel(host, value, ESDHC_DMA_SYSCTL);
> >  	return 0;
> >  }
> > --
> > 2.7.4
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
