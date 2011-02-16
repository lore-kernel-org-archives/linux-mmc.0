From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH 01/12] mmc: sdhci: add support for auto CMD23
Date: Wed, 16 Feb 2011 02:04:19 -0600
Message-ID: <6C03668EAF45B747AF947A1603D1B300DCDEF7FC@SAUSEXMBP01.amd.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
 <1297762510-2696-2-git-send-email-arindam.nath@amd.com>
 <alpine.LFD.2.00.1102151556450.14920@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:55040
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753628Ab1BPITd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Feb 2011 03:19:33 -0500
In-Reply-To: <alpine.LFD.2.00.1102151556450.14920@xanadu.home>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

Hi Nicolas,

> -----Original Message-----
> From: Nicolas Pitre [mailto:nico@fluxnic.net]
> Sent: Wednesday, February 16, 2011 2:29 AM
> To: Nath, Arindam
> Cc: cjb@laptop.org; linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron;
> anath.amd@gmail.com
> Subject: Re: [PATCH 01/12] mmc: sdhci: add support for auto CMD23
> 
> On Tue, 15 Feb 2011, Arindam Nath wrote:
> 
> > Host Controller v3.00 and later support Auto CMD23 in the Transfer
> > Mode register. Since Auto CMD23 can be used with or without DMA,
> > and if used with DMA, it should _only_ be ADMA, we check against
> > SDHCI_USE_SDMA not being set. This flag is reset when SDHCI_USE_ADMA
> > is set.
> >
> > A new definition for SDHCI_ARGUMENT2 register has been added
> > in v3.00 spec, which is the same as SDHCI_DMA_ADDRESS. We program the
> > block count for CMD23 in SDHCI_ARGUMENT2, so we don't need CMD12 to
> > stop multiple block transfers. But during error recovery procedure,
> > we will need to send Abort command, so we use a global variable
> > abort_cmd to save the stop command to be used later.
> 
> This is wrong.  Don't use global variables for such things.  Imagine
> what might happen if you have more than one sdhci controller in a
> system. This is a per instance issue certainly not a global driver
> issue.

Thanks for the review. I will make the changes in V2 of the patchset.

Regards,
Arindam

