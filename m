From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH v2] mmc: sdhci: fix incorrect command used in tuning
Date: Wed, 4 Jul 2012 13:11:30 +0800
Message-ID: <20120704051130.GA2607@aarontestpc.amd.com>
References: <1341307669-20834-1-git-send-email-aaron.lu@amd.com>
 <874npo744y.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:18303
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753015Ab2GDFLn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jul 2012 01:11:43 -0400
Content-Disposition: inline
In-Reply-To: <874npo744y.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi Chris,

On Tue, Jul 03, 2012 at 08:37:33PM -0400, Chris Ball wrote:
> Hi,
> 
> On Tue, Jul 03 2012, Aaron Lu wrote:
> > V2:
> > Fix for SDIO case: both SD and SDIO cards use cmd19 while eMMC use cmd21.
> >
> > V1:
> > For SD hosts using retuning mode 1, when retuning timer expired, it will
> > need to do retuning in sdhci_request before processing the actual
> > request. But the retuning command is fixed: cmd19 for SD card and cmd21
> > for eMMC card, so we can't use the original request's command to do the
> > tuning.
> >
> > And since the tuning command depends on the card type atteched to the
> > host, we will need to know the card type to use the correct tuning
> > command.
> >
> > Cc: stable <stable@vger.kernel.org> [3.3+]
> > Signed-off-by: Aaron Lu <aaron.lu@amd.com>
> > ---
> 
> Thanks, pushed to mmc-next for 3.6 with Philip's Reviewed-by.
> 
> For next time, please put the patch changelog at this point in the patch
> (after ---) so that it doesn't show up in the recorded commit message.
> 
> Also, please don't e-mail the patch to stable@ before it has entered
> mainline.  They'll pick it up from the CC in the commit message when
> Linus merges it, they don't want a copy of the patch before then.

OK, thanks for pointing this out, will follow this in the future.

-Aaron

> 
> Thanks!
> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

