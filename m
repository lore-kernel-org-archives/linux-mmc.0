From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 2/4] MMC/SD: Add callback function to detect card
Date: Tue, 13 Dec 2011 08:26:04 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11644C9D@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1323077026-12071-1-git-send-email-r66093@freescale.com>
 <1323077026-12071-2-git-send-email-r66093@freescale.com>
 <4EE1DCEB.5030102@intel.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F11644BF7@039-SN1MPN1-006.039d.mgd.msft.net>
 <4EE7063F.9090900@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:54703 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099Ab1LMI0H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 03:26:07 -0500
In-Reply-To: <4EE7063F.9090900@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
> Sent: Tuesday, December 13, 2011 4:01 PM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org
> Subject: Re: [PATCH 2/4] MMC/SD: Add callback function to detect card
> 
> On 13/12/11 09:25, Huang Changming-R66093 wrote:
> >
> >
> >> -----Original Message-----
> >> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> >> owner@vger.kernel.org] On Behalf Of Adrian Hunter
> >> Sent: Friday, December 09, 2011 6:03 PM
> >> To: Huang Changming-R66093
> >> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093
> >> Subject: Re: [PATCH 2/4] MMC/SD: Add callback function to detect card
> >>
> >> On 05/12/11 11:23, r66093@freescale.com wrote:
> >>> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >>>
> >>> In order to check whether the card has been removed, the function
> >>> mmc_send_status() will send command CMD13 to card and ask the card
> >>> to send its status register to sdhc driver, which will generate many
> >>> interrupts repeatedly and make the system performance bad.
> >>
> >> That should not be true.  sdhci.c will not send a command to the card
> >> if the card is not present i.e. see this excerpt from
> >> sdhci_request():
> >>
> >>
> >> 	/* If polling, assume that the card is always present. */
> >> 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> >> 		present = true;
> >> 	else
> >> 		present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
> >> 				SDHCI_CARD_PRESENT;
> >>
> >> 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
> >> 		host->mrq->cmd->error = -ENOMEDIUM;
> >> 		tasklet_schedule(&host->finish_tasklet);
> >> --
> > But, for some controller, this field of SDHCI_PRESENT_STATE register is
> reserved and always is 1. When the card is absent, many command will try
> to send to the card, and generate many interrupt.
> > If even controller can detect the card state, if the card is absent as
> you said, this command can't send to card. But, when card is present,
> there will be many command to the card and many interrupts will be
> generated, that will affect the performance.
> > So, I don't think this comment is not correct.
> >
> >
> >
> 
> You patch uses (SDHCI_CARD_PRESENT | SDHCI_CARD_CDPL) Does that mean
> SDHCI_CARD_CDPL does work in that case?
No.
The SDHCI_CARD_CDPL[bit13] reflect the pin level:
CDPL: Card detect pin level. This bit reflects the inverse value of the SDHC_CD pin for the card socket.
0 No card present (SDHC_CD = 1)
1 Card present (SDHC_CD = 0)

So, this bit has the same effect as SDHCI_CARD_PRESENT[bit15], the difference is that debouncing is not performed on this bit.

Freescale's controller supports the card detection, if card is present, none-zero will be returned, otherwise, zero will be returned.

You can see my other patch [3/4], I add one callback to detect the card state in special platform: if the controller supports card detection, this callback will be performed in special platform (e.g. sdhci-of-esdhc.c) and return the card state (present or absent), if controller doesn't support card detection, this callback will be not performed and return -ENOSYS.



