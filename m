From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting clock
 from 100ms to 1ms
Date: Fri, 2 Dec 2011 07:13:31 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F1162FCA2@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1321944150-12162-1-git-send-email-tony.lin@freescale.com>
 <87vcq0kvs6.fsf@laptop.org>
 <97D3A72708D04647A5AC84A04996E5B526EC0F@039-SN1MPN1-001.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:43846
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752555Ab1LBHNf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 2 Dec 2011 02:13:35 -0500
In-Reply-To: <97D3A72708D04647A5AC84A04996E5B526EC0F@039-SN1MPN1-001.039d.mgd.msft.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lin Tony-B19295 <B19295@freescale.com>, Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Xie Xiaobo-R63061 <r63061@freescale.com>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>

I don't think it make sense to change the delay time.
Which will affect all PowerPC eSDHC controller, could you confirm which can work on all PowerPC platform?

-----Original Message-----
From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Lin Tony-B19295
Sent: Friday, December 02, 2011 1:37 PM
To: Chris Ball
Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Xie Xiaobo-R63061; avorontsov@ru.mvista.com
Subject: RE: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting clock from 100ms to 1ms

Okay
Thanks

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc- 
> owner@vger.kernel.org] On Behalf Of Chris Ball
> Sent: Friday, December 02, 2011 2:11 AM
> To: Lin Tony-B19295
> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; 
> Xie Xiaobo-R63061; avorontsov@ru.mvista.com
> Subject: Re: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting 
> clock from 100ms to 1ms
> 
> Hi,
> 
> On Tue, Nov 22 2011, Tony Lin wrote:
> > 1ms is enough for hardware to change the clock to stable.
> > 100ms is too long in the tasklet.
> >
> > Signed-off-by: Tony Lin <tony.lin@freescale.com>
> > CC: Xiaobo Xie <X.Xie@freescale.com>
> > CC: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc.h 
> > b/drivers/mmc/host/sdhci-esdhc.h index c3b08f1..b97b2f5 100644
> > --- a/drivers/mmc/host/sdhci-esdhc.h
> > +++ b/drivers/mmc/host/sdhci-esdhc.h
> > @@ -73,7 +73,7 @@ static inline void esdhc_set_clock(struct 
> > sdhci_host *host, unsigned int clock)
> >  		| (div << ESDHC_DIVIDER_SHIFT)
> >  		| (pre_div << ESDHC_PREDIV_SHIFT));
> >  	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> > -	mdelay(100);
> > +	mdelay(1);
> >  out:
> >  	host->clock = clock;
> >  }
> 
> I don't know if 1ms is actually long enough for the clock to stabilize 
> on all boards, but I'll push this change to mmc-next and we can see if 
> we get any regression reports.
> 
> Thanks,
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html


