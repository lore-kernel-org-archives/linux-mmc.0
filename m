From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH v3] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Mon, 24 Sep 2012 02:30:05 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C191DD3@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1348223135-6435-1-git-send-email-r66093@freescale.com>
 <m3y5k3e4tq.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:2098
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751588Ab2IXCaN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 23 Sep 2012 22:30:13 -0400
In-Reply-To: <m3y5k3e4tq.fsf@pullcord.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Xie Shaohui-B21989 <B21989@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Kumar Gala <galak@kernel.crashing.org>



> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Saturday, September 22, 2012 12:09 AM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Xie Shaohui-B21989;
> Anton Vorontsov; Kumar Gala
> Subject: Re: [PATCH v3] powerpc/esdhc: disable CMD23 for some Freescale
> SoCs
> 
> Hi,
> 
> On Fri, Sep 21 2012, r66093@freescale.com wrote:
> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > @@ -143,6 +143,35 @@ static void esdhc_of_resume(struct sdhci_host
> > *host)  }  #endif
> >
> > +static const u32 non_cmd23_processor_table[] = {
> > +	/* P1020 Dual/Single core */
> > +	0x80EC00, 0x80E400, 0x80ED00, 0x80E500,
> > +	/* P1021 Dual/Single core */
> > +	0x80EC01, 0x80E401, 0x80ED01, 0x80E501,
> > +	/* P1022 Dual/Single core */
> > +	0x80EE00, 0x80E600, 0x80EF00, 0x80E700,
> > +	/* P1024 Dual/Single core */
> > +	0x80EC02, 0x80E402, 0x80ED02, 0x80E502,
> > +	/* P1025 Dual/Single core */
> > +	0x80EC03, 0x80E403, 0x80ED03, 0x80E503,
> > +	/* P4080 and P4040 */
> > +	0x820000, 0x820800, 0x820100, 0x820900
> 
> I don't see how this method improves on either of the previous two we've
> discussed.  If anything, Kumar's suggested method seems better than this
> one:  it detected the MMC IP revision, which I'd expect to be more
> reliable than building a list of which SoCs contain that IP.
> 
> Why is this better than using DT or detecting the MMC revision?
> 
The first version, I use the DT, but someone don't like it.
MPC8536 and P4080 have the same version: VVN1.0, but MPC8536 supports CMD23, P4080 can't support.
no anyone can make sure all future silicones can support CMD23.
So, I think if DT can't be used, it is the better way to detect the processor.

