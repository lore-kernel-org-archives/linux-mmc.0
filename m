From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH v7] ESDHC: Workaround for data crc error on p1010rdb
Date: Mon, 13 Feb 2012 02:40:07 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C021A89@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1328688356-17510-1-git-send-email-r66093@freescale.com>
	<m21uq52wk8.fsf@bob.laptop.org>
	<110EED8CC96DFC488B7E717A2027A27C01F304@039-SN1MPN1-002.039d.mgd.msft.net>
 <m2mx8pkqxy.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:4242 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754274Ab2BMCkt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 12 Feb 2012 21:40:49 -0500
In-Reply-To: <m2mx8pkqxy.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jain Priyanka-B32167 <B32167@freescale.com>

Hi, Chris


> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Sunday, February 12, 2012 5:20 AM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Jain Priyanka-B32167
> Subject: Re: [PATCH v7] ESDHC: Workaround for data crc error on p1010rdb
> 
> Hi,
> 
> On Wed, Feb 08 2012, Huang Changming-R66093 wrote:
> >> > +static void esdhc_of_set_clock(struct sdhci_host *host, unsigned
> >> > +int
> >> clock)
> >> > +{
> >> > +	/* Workaround to reduce the clock frequency for p1010 esdhc
> */
> >> > +	if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
> >> > +		if (clock == 0) {
> >> > +			host->clock = clock;
> >> > +			return;
> >> > +		}
> >>
> >> Is this if (clock == 0) necessary?  You'll be calling
> >> esdhc_set_clock() immediately afterwards, and it performs the same
> test.
> >
> > Yes, I perform this test two times.
> > The first time, I test the original value (as the parameter from
> > set_clock) The second time, I test it again, that is because the clock
> > value has been changed or reduced, I think it is necessary to test it
> > again.
> 
> I don't see how it's necessary to test *if it is zero* again, because
> you're not going to change or reduce it to zero.  You're going to
> subtract 5M/10M from it if it was over 20M/40M, so there is no chance of
> it reaching zero.
You are right.
I want to use the below code in header file "drivers/mmc/host/sdhci-esdhc.h":
if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc"))
then I can avoid the twice test of the clock.
do you think if it is reasonable?

Thanks
Jerry Huang

