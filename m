From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH v7] ESDHC: Workaround for data crc error on p1010rdb
Date: Tue, 14 Feb 2012 06:11:25 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C022DF3@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1328688356-17510-1-git-send-email-r66093@freescale.com>
	<m21uq52wk8.fsf@bob.laptop.org>
	<110EED8CC96DFC488B7E717A2027A27C01F304@039-SN1MPN1-002.039d.mgd.msft.net>
	<m2mx8pkqxy.fsf@bob.laptop.org>
	<110EED8CC96DFC488B7E717A2027A27C021A89@039-SN1MPN1-002.039d.mgd.msft.net>
	<m2ty2vjr11.fsf@bob.laptop.org> <m2pqdjjqo2.fsf@bob.laptop.org>
	<110EED8CC96DFC488B7E717A2027A27C021CB2@039-SN1MPN1-002.039d.mgd.msft.net>
 <m2d39ijwez.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:22231
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751317Ab2BNGLc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Feb 2012 01:11:32 -0500
In-Reply-To: <m2d39ijwez.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jain Priyanka-B32167 <B32167@freescale.com>



Thanks
Jerry Huang


> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Tuesday, February 14, 2012 4:44 AM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Jain Priyanka-B32167
> Subject: Re: [PATCH v7] ESDHC: Workaround for data crc error on p1010rdb
> 
> Hi,
> 
> On Mon, Feb 13 2012, Huang Changming-R66093 wrote:
> >> Actually, I think I'm still missing something.  Why doesn't this work?
> >>
> >> +static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int
> >> +clock) {
> >> +       /* Workaround to reduce the clock frequency for p1010 esdhc */
> >> +       if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
> >> +               if (clock > 20000000)
> >> +                       clock -= 5000000;
> >> +               if (clock > 40000000)
> >> +                       clock -= 5000000;
> >> +       }
> >> +
> >> +       /* Set the clock */
> >> +       esdhc_set_clock(host, clock); }
> >>
> > These codes can work, too.
> > I forget the clock will be reduced 5M/10M only when the clock is
> > greater than 20MHz/45MHz.
> > So I should not test the clock in this function.
> 
> Great, thanks -- please test and submit a patch with the code above, and
> I'll merge it.


Thanks, Chris.
I have sent it again.


Jerry Huang

