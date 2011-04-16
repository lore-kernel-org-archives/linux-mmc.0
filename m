From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH v3 01/12] mmc: sdhci: add support for auto CMD23
Date: Sat, 16 Apr 2011 04:40:09 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300EB44436E@SAUSEXMBP01.amd.com>
References: <1302863942-1774-1-git-send-email-arindam.nath@amd.com>
	<1302863942-1774-2-git-send-email-arindam.nath@amd.com>
	<BANLkTimZGonC+D0czjiY4i7pFFW=upj_qw@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB443FB6@SAUSEXMBP01.amd.com>
	<BANLkTimEKQceSiuL=dX2yhMw+MLu7BzLvQ@mail.gmail.com>
	<BANLkTimfQo7wJ3_ecs64VSp7xKJrjYdJ3w@mail.gmail.com>
	<BANLkTikoAWEMGOAHrxJT4jNknVFtyuhdqw@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB44434B@SAUSEXMBP01.amd.com>
 <BANLkTimUrvnkg5dxiSh6cmToR_QTpYtnyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:56271
	"EHLO AM1EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755365Ab1DPJzN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 16 Apr 2011 05:55:13 -0400
In-Reply-To: <BANLkTimUrvnkg5dxiSh6cmToR_QTpYtnyw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Andrei,


> -----Original Message-----
> From: Andrei Warkentin [mailto:andreiw@motorola.com]
> Sent: Saturday, April 16, 2011 2:38 PM
> To: Nath, Arindam
> Cc: linux-mmc@vger.kernel.org
> Subject: Re: [PATCH v3 01/12] mmc: sdhci: add support for auto CMD23
> 
> On Sat, Apr 16, 2011 at 12:25 AM, Nath, Arindam <Arindam.Nath@amd.com>
> wrote:
> > Hi Andrei,
> >
> > I saw in one of the community threads that you also have a patch
> ready for supporting Auto CMD23 for SDHCI. Can you share the same with
> us? I would like to take a look at your patch first before deciding
> whether it would make sense for controllers which comply with Host
> Controller Spec v3.00.
> >
> 
> Will send updated patch set in a few. You and Subhash are on the Cc.
> Once again, the Auto-CMD23 is completely untested. I would be
> extremely grateful if you can verify it.

Yes, I can do that. On that note, I have a suggestion. Since the Auto CMD23 feature is separate and none of my other patches depend on this, I would rather re-submit V3 patches except for the Auto CMD23 feature. Then once your patches have been accepted and tested, we can enable Auto CMD23 feature in the kernel. Let me know what you think.

> Is there any kind of error injection mechanism you guys use to verify
> the error paths for Auto 12/23?

None in particular.

> 
> By the way -
> 
> +       /* If the host can perform ADMA operation, we reset SDMA flag
> */
> +       if (host->flags & SDHCI_USE_ADMA)
> +               host->flags &= ~SDHCI_USE_SDMA;
> 
> This seems completely unnecessary, as the code already prefers ADMA to
> SDMA. What do you think?

As per the Host Controller Spec v3.00, Auto CMD23 can either be used with non-DMA transfers or ADMA, but _not_ SDMA. To take care of both these cases in a single shot, I have tested against SDHCI_USE_SDMA not being set. So, I need to make sure we reset this flag when we enable ADMA support.

Thanks,
Arindam

> 
> A


