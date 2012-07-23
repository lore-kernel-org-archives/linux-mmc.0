From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw-mmc: fixed secstion mismatch in reference
Date: Mon, 23 Jul 2012 12:02:13 +0900
Message-ID: <003401cd687f$8f57be80$ae073b80$%jun@samsung.com>
References: <50082569.8030002@samsung.com>
 <001201cd666b$d7359800$85a0c800$%jun@samsung.com>
 <500CAE49.6040503@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:26876 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab2GWDCR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Jul 2012 23:02:17 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M7L00BS2F37S6I0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 23 Jul 2012 12:02:14 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M7L004XDF3PXO90@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 23 Jul 2012 12:02:14 +0900 (KST)
In-reply-to: <500CAE49.6040503@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Shashidhar Hiremath' <shashidharh@vayavyalabs.com>

July 23, 2012, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Seungwon,
> 
> On 07/20/2012 08:36 PM, Seungwon Jeon wrote:
> > Hi Jaehoon,
> >
> > July 20, 2012, Jaehoon Chung <jh80.chung@samsung.com>
> >> Fixed the below message.
> >>
> >> WARNING: drivers/mmc/host/built-in.o(.text+0x5ee8): Section mismatch in reference from the function
> >> dw_mci_probe() to the function .init.text:dw_mci_init_slot()
> >> The function dw_mci_probe() references
> >> the function __init dw_mci_init_slot().
> >> This is often because dw_mci_probe lacks a __init
> >> annotation or the annotation of dw_mci_init_slot is wrong
> >>
> >> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >> ---
> >>  drivers/mmc/host/dw_mmc.c |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> >> index 72dc3cd..7955eba 100644
> >> --- a/drivers/mmc/host/dw_mmc.c
> >> +++ b/drivers/mmc/host/dw_mmc.c
> >> @@ -1760,7 +1760,7 @@ static void dw_mci_work_routine_card(struct work_struct *work)
> >>  	}
> >>  }
> >>
> >> -static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
> >> +static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
> >>  {
> >>  	struct mmc_host *mmc;
> >>  	struct dw_mci_slot *slot;
> >
> >
> > __init macro isn't required?
> > If so, how about adding __init macros to dw_mci_probe and dw_mci_pltfm_probe?
> As you're mentioned, I think right that add __init macro to dw_mci_pltfm_probe.
> but dw_mci_probe? i didn't think so...
Yes, dw_mci_pltfm_probe is only proper.

Thanks,
Seungwon Jeon

> 
> Best Regards,
> Jaehoon Chung
> >
> > Best regards,
> > Seungwon Jeon
> >> --
> >> 1.7.4.1
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

