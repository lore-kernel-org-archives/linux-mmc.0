From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
Date: Fri, 2 Nov 2012 01:37:21 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C210A6D@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
	<1351584769-16662-2-git-send-email-r66093@freescale.com>
 <CA+20K0AfmJSrPO9-_-yNk4HhEVYPj8cMaa+jCZAZhp23Vb817g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:50670
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932147Ab2KBBh0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Nov 2012 21:37:26 -0400
In-Reply-To: <CA+20K0AfmJSrPO9-_-yNk4HhEVYPj8cMaa+jCZAZhp23Vb817g@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>

Hi, Johan,
When quicks SDHCI_QUIRK_BROKEN_CARD_DETECTION is set, the driver will poll the card status with the command CMD13 periodically, then many interrupts will be generated, which affect the performance.

Yes, some cases to detect GPIO can't be trusted, so I only just implement this callback in eSDHC-of driver. that is to say, just when the platform support it, this callback can be implement, if not, continue to send the command CMD13.  

> Hi Jerry,
> 
> 2012/10/30  <r66093@freescale.com>:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > In order to check whether the card has been removed, the function
> > mmc_send_status() will send command CMD13 to card and ask the card to
> > send its status register to sdhc driver, which will generate many
> > interrupts repeatedly and make the system performance bad.
> >
> > Therefore, add callback function get_cd() to check whether the card
> > has been removed when the driver has this callback function.
> >
> > If the card is present, 1 will return, if the card is absent, 0 will
> return.
> > If the controller will not support this feature, -ENOSYS will return.
> 
> In what cases is the performance affected by this? I believe this
> function is called only on some errors and on detect?
> 
> Also, we've seen cases where the card detect GPIO cannot be trusted to
> tell wether the card is present or not, for instance in the corner case
> when an SD-card is removed very slowly...
> 
> Kind regards, Johan


