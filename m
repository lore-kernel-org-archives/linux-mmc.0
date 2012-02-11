From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v7] ESDHC: Workaround for data crc error on p1010rdb
Date: Sat, 11 Feb 2012 16:20:25 -0500
Message-ID: <m2mx8pkqxy.fsf@bob.laptop.org>
References: <1328688356-17510-1-git-send-email-r66093@freescale.com>
	<m21uq52wk8.fsf@bob.laptop.org>
	<110EED8CC96DFC488B7E717A2027A27C01F304@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53882 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618Ab2BKVUe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 11 Feb 2012 16:20:34 -0500
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C01F304@039-SN1MPN1-002.039d.mgd.msft.net>
	(Huang Changming-R's message of "Thu, 9 Feb 2012 02:12:14 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jain Priyanka-B32167 <B32167@freescale.com>

Hi,

On Wed, Feb 08 2012, Huang Changming-R66093 wrote:
>> > +static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int
>> clock)
>> > +{
>> > +	/* Workaround to reduce the clock frequency for p1010 esdhc */
>> > +	if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
>> > +		if (clock == 0) {
>> > +			host->clock = clock;
>> > +			return;
>> > +		}
>> 
>> Is this if (clock == 0) necessary?  You'll be calling esdhc_set_clock()
>> immediately afterwards, and it performs the same test.
>
> Yes, I perform this test two times.
> The first time, I test the original value (as the parameter from set_clock)
> The second time, I test it again, that is because the clock value has
> been changed or reduced,
> I think it is necessary to test it again. 

I don't see how it's necessary to test *if it is zero* again, because
you're not going to change or reduce it to zero.  You're going to
subtract 5M/10M from it if it was over 20M/40M, so there is no chance
of it reaching zero.

This isn't a huge deal, but:  could you walk me through an example of
where it's necessary to have the first test for 0, because something
bad would happen if you didn't?  I'm talking about this piece of code:

+       if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
+               if (clock == 0) {
+                       host->clock = clock;
+                       return;
+               }

.. which I think will get caught by the same test in esdhc_set_clock()
when you call that immediately after this test.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
