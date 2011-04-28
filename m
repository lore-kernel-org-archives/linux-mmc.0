From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [[v4] 5/5] MMC: SDHCI AutoCMD23 support.
Date: Thu, 28 Apr 2011 03:34:47 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300EB81A3EB@SAUSEXMBP01.amd.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-2-git-send-email-andreiw@motorola.com>
	<1303870235-29041-3-git-send-email-andreiw@motorola.com>
	<1303870235-29041-4-git-send-email-andreiw@motorola.com>
	<1303870235-29041-5-git-send-email-andreiw@motorola.com>
	<1303870235-29041-6-git-send-email-andreiw@motorola.com>
	<6C03668EAF45B747AF947A1603D1B300EB81997F@SAUSEXMBP01.amd.com>
	<BANLkTim3v7DJZfZpZrZDnomiXTDx7WfWtA@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB81998D@SAUSEXMBP01.amd.com>
 <BANLkTikxOMeM9nxo0cbB0HAWSME8Ttq=HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:4874
	"EHLO DB3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754901Ab1D1IfV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Apr 2011 04:35:21 -0400
In-Reply-To: <BANLkTikxOMeM9nxo0cbB0HAWSME8Ttq=HQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "arnd@arndb.de" <arnd@arndb.de>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "Xu, Suki" <Suki.Xu@amd.com>

Hi Andrei,

The controller is able to send Auto CMD23 with your patch.

Thanks,
Arindam

> -----Original Message-----
> From: Andrei Warkentin [mailto:andreiw@motorola.com]
> Sent: Wednesday, April 27, 2011 11:36 AM
> To: Nath, Arindam
> Cc: linux-mmc@vger.kernel.org; cjb@laptop.org; arnd@arndb.de;
> subhashj@codeaurora.org
> Subject: Re: [[v4] 5/5] MMC: SDHCI AutoCMD23 support.
> 
> On Wed, Apr 27, 2011 at 1:02 AM, Nath, Arindam <Arindam.Nath@amd.com>
> wrote:
> > Guess I will have to hand modify my code based on your V4 patches
> again, I don't think your patches are based on top of mine.
> >
> > Thanks,
> > Arindam
> >
> 
> Just verify these blobs look similar -
> 
> +               else if (host->mrq->sbc &&
> +                        host->flags & SDHCI_ACMD23) {
> +                       mode |= SDHCI_TRNS_ACMD23;
> +                       sdhci_writel(host, host->mrq->sbc->arg,
> SDHCI_ARGUMENT2);
> +               }
> 
> and
> 
>                host->flags |= SDHCI_ACMD12;
> 
> +       /* Auto-CMD23 stuff only works in ADMA or PIO. */
> +       if ((host->version == SDHCI_SPEC_300) &&
> +           ((host->flags & SDHCI_USE_ADMA) ||
> +            !(host->flags & SDHCI_REQ_USE_DMA))) {
> +               host->flags |= SDHCI_ACMD23;
> +               printk(KERN_INFO "%s: Auto-CMD23 available\n",
> mmc_hostname(mmc));
> +       } else
> +               printk(KERN_INFO "%s: Auto-CMD23 unavailable\n",
> mmc_hostname(mmc));
> +
>        /*
>         * A controller may support 8-bit width, but the board itself
>         * might not have the pins brought out.  Boards that support
> 
> I apologize for the fuss.
> 
> A


