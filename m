From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
Date: Wed, 31 Oct 2012 05:52:18 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C204553@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
 <1351584769-16662-2-git-send-email-r66093@freescale.com>
 <CAGxe1ZEs=3Y9+mdvt1kp2oQ4DXAdUqC0crH2oZAi-j3DKCbAPA@mail.gmail.com>
 <110EED8CC96DFC488B7E717A2027A27C2042CA@039-SN1MPN1-003.039d.mgd.msft.net>
 <5090A927.2050708@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:19451
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752867Ab2JaFwX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 31 Oct 2012 01:52:23 -0400
In-Reply-To: <5090A927.2050708@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Girish K S <girish.shivananjappa@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>



Best Regards
Jerry Huang


> -----Original Message-----
> From: Jaehoon Chung [mailto:jh80.chung@samsung.com]
> Sent: Wednesday, October 31, 2012 12:29 PM
> To: Huang Changming-R66093
> Cc: Girish K S; linux-mmc@vger.kernel.org; Anton Vorontsov; Chris Ball
> Subject: Re: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
> 
> Hi,
> 
> >> *host)
> >>>         if (!host->card || mmc_card_removed(host->card))
> >>>                 return 1;
> >>>
> >>> -       ret = host->bus_ops->alive(host);
> >>> +       if (host->ops->get_cd) {
> >>> +               ret = host->ops->get_cd(host);
> >>> +               if (ret >= 0)
> >>> +                       ret = !ret;
> >>> +       }
> >>> +       if (ret < 0)
> >>> +               ret = host->bus_ops->alive(host);
> >> why should we check for negative here? can move this code into else
> >> path of   if (host->ops->get_cd).
> >>>         if (ret) {
> >
> > I did this comment:
> > If the card is present, 1 will return, if the card is absent, 0 will
> return.
> > If the controller will not support this feature, -ENOSYS will return.
> If checked whether card is absent or not with get_cd(), need to check the
> host->bus_ops->alive?

When get_cd is not supported, need to check it.

