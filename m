From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [[v4] 5/5] MMC: SDHCI AutoCMD23 support.
Date: Wed, 27 Apr 2011 01:02:12 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300EB81998D@SAUSEXMBP01.amd.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-2-git-send-email-andreiw@motorola.com>
	<1303870235-29041-3-git-send-email-andreiw@motorola.com>
	<1303870235-29041-4-git-send-email-andreiw@motorola.com>
	<1303870235-29041-5-git-send-email-andreiw@motorola.com>
	<1303870235-29041-6-git-send-email-andreiw@motorola.com>
	<6C03668EAF45B747AF947A1603D1B300EB81997F@SAUSEXMBP01.amd.com>
 <BANLkTim3v7DJZfZpZrZDnomiXTDx7WfWtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:25923
	"EHLO VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751870Ab1D0GCT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Apr 2011 02:02:19 -0400
In-Reply-To: <BANLkTim3v7DJZfZpZrZDnomiXTDx7WfWtA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "arnd@arndb.de" <arnd@arndb.de>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>

Guess I will have to hand modify my code based on your V4 patches again, I don't think your patches are based on top of mine.

Thanks,
Arindam

> -----Original Message-----
> From: Andrei Warkentin [mailto:andreiw@motorola.com]
> Sent: Wednesday, April 27, 2011 11:30 AM
> To: Nath, Arindam
> Cc: linux-mmc@vger.kernel.org; cjb@laptop.org; arnd@arndb.de;
> subhashj@codeaurora.org
> Subject: Re: [[v4] 5/5] MMC: SDHCI AutoCMD23 support.
> 
> Hi Arindam,
> 
> On Wed, Apr 27, 2011 at 12:49 AM, Nath, Arindam <Arindam.Nath@amd.com>
> wrote:
> > Hi Andrei,
> >
> > Is there any more change to your V4 than the ones we discussed
> yesterday? I did the mod we discussed, but seems like the driver only
> sends CMD23 now, not Auto CMD23.
> >
> 
> Two things V4 does, both of which we discussed yesterday -
> 1) Make sure the code that set SDHCI_ACMD23 is always run (got rid of
> the Kconfig conditional)
> 2) Make sure value written into ARGUMENT2 comes from sbc struct.
> 
> Only (1) should have affected you. (2) would have broken rel. writes.
> I put in an info print telling you if you have auto-cmd23 available or
> not. If you see CMD23 getting sent, then AutoCMD23 was not detected as
> a feature. Weird. SDHCI_ACMD23 is set if
> a) Host controller is version 3
> b) You're using ADMA or no DMA.
> 
> A


