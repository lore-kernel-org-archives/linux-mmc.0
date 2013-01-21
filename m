From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: read all data in FIFO after Data transfer
 over interrupt in pio mode
Date: Mon, 21 Jan 2013 21:21:23 +0900
Message-ID: <001b01cdf7d1$d4016860$7c043920$%kim@samsung.com>
References: <001701cdf7c0$bb3c5fd0$31b51f70$%kim@samsung.com>
 <CAFbHwiTKBUiEyRzwv=mtvfqXQToD62j8RQedAk13SH+WwvPWHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:61085 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab3AUMVZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jan 2013 07:21:25 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MGZ00IY66AZBCK0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 21 Jan 2013 21:21:24 +0900 (KST)
Received: from DOKI0351KIM04 ([12.23.119.96])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MGZ00E3E6BNHK10@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 21 Jan 2013 21:21:24 +0900 (KST)
In-reply-to: <CAFbHwiTKBUiEyRzwv=mtvfqXQToD62j8RQedAk13SH+WwvPWHg@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Will Newton' <will.newton@gmail.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Kyoungil Kim' <ki0351.kim@samsung.com>, 'Seungwon Jeon' <tgih.jun@samsung.com>

On Mon, Jan 21, 2013 at 7:45 PM, Will Newton wrote:
> 
> On Mon, Jan 21, 2013 at 10:19 AM, Kyoungil Kim <ki0351.kim@samsung.com> wrote:
> > In dwc manual, the below contents are described.
> > "During end of packet, interrupt is not generated if threshold
> > programming is larger than any remaining data. It is responsibility
> > of host to read remaining bytes on seeing Data Transfer Done
> > interrupt"
> > We also have seen the data cannot be read fully
> > when "sg_miter->length" is less than FIFO size.
> >
> > Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> >  drivers/mmc/host/dw_mmc.c |   11 +++++++----
> >  1 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 323c502..afcc0f4 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -1430,7 +1430,7 @@ static void dw_mci_pull_data(struct dw_mci *host, void *buf, int cnt)
> >         host->pull_data(host, buf, cnt);
> >  }
> >
> > -static void dw_mci_read_data_pio(struct dw_mci *host)
> > +static void dw_mci_read_data_pio(struct dw_mci *host, u8 int_data_over)
> 
> The data_over argument should probably be a bool.

Thank you.
I'll apply and submit again.

