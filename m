From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: RE: [PATCH v2] mmc: dw_mmc: read all data in FIFO after Data transfer
 over interrupt in pio mode
Date: Tue, 22 Jan 2013 16:34:58 +0900
Message-ID: <000301cdf872$fb5d5350$f217f9f0$%kim@samsung.com>
References: <001c01cdf7d2$e1385290$a3a8f7b0$%kim@samsung.com>
 <50FDFAE0.4050101@samsung.com>
 <000c01cdf866$c97f53d0$5c7dfb70$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:51911 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab3AVHfI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jan 2013 02:35:08 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MH00079DNQ2BBI0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 Jan 2013 16:34:59 +0900 (KST)
Received: from DOKI0351KIM04 ([12.23.119.96])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MH000KQANQAJUC0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 Jan 2013 16:34:59 +0900 (KST)
In-reply-to: <000c01cdf866$c97f53d0$5c7dfb70$%jun@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Seungwon Jeon' <tgih.jun@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>

Thank you for review.
I'll apply.

On Tuesday, January 22, 2013 3:08 PM, Seungwon Jeon wrote:
> Kyoungil,
> 
> Could you resend the following change considering Jaehoon's comment?
> - int_data_over -> dto
> - use boolean constants(true, false) for dw_mci_read_data_pio argument.
> 
> Thanks,
> Seungwon Jeon
> 
> On Tuesday, January 22, 2013, Jaehoon Chung wrote:
> > Hi,
> >
> > i didn't test with this patch. But it makes sense.
> > Just i have minor comment.
> >
> > Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> >
> > On 01/21/2013 09:28 PM, Kyoungil Kim wrote:
> > > In dwc manual, the below contents are described.
> > > "During end of packet, interrupt is not generated if threshold
> > > programming is larger than any remaining data. It is responsibility
> > > of host to read remaining bytes on seeing Data Transfer Done
> > > interrupt"
> > > We also have seen the data cannot be read fully
> > > when "sg_miter->length" is less than FIFO size.
> > >
> > > Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> > > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > > ---
> > >  drivers/mmc/host/dw_mmc.c |   11 +++++++----
> > >  1 files changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > > index 323c502..064c010 100644
> > > --- a/drivers/mmc/host/dw_mmc.c
> > > +++ b/drivers/mmc/host/dw_mmc.c
> > > @@ -1430,7 +1430,7 @@ static void dw_mci_pull_data(struct dw_mci *host, void *buf, int cnt)
> > >  	host->pull_data(host, buf, cnt);
> > >  }
> > >
> > > -static void dw_mci_read_data_pio(struct dw_mci *host)
> > > +static void dw_mci_read_data_pio(struct dw_mci *host, bool int_data_over)
> > >  {
> > >  	struct sg_mapping_iter *sg_miter = &host->sg_miter;
> > >  	void *buf;
> > > @@ -1465,7 +1465,10 @@ static void dw_mci_read_data_pio(struct dw_mci *host)
> > >  		sg_miter->consumed = offset;
> > >  		status = mci_readl(host, MINTSTS);
> > >  		mci_writel(host, RINTSTS, SDMMC_INT_RXDR);
> > > -	} while (status & SDMMC_INT_RXDR); /*if the RXDR is ready read again*/
> > > +	/* if the RXDR is ready read again */
> > > +	} while ((status & SDMMC_INT_RXDR) ||
> > > +			(int_data_over &&
> > > +			 SDMMC_GET_FCNT(mci_readl(host, STATUS))));
> > If you can change int_data_over, we can use the one line.
> >
> > Best Regards,
> > Jaehoon Chung

