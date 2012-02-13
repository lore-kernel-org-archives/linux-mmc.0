From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v7] ESDHC: Workaround for data crc error on p1010rdb
Date: Mon, 13 Feb 2012 15:44:20 -0500
Message-ID: <m2d39ijwez.fsf@bob.laptop.org>
References: <1328688356-17510-1-git-send-email-r66093@freescale.com>
	<m21uq52wk8.fsf@bob.laptop.org>
	<110EED8CC96DFC488B7E717A2027A27C01F304@039-SN1MPN1-002.039d.mgd.msft.net>
	<m2mx8pkqxy.fsf@bob.laptop.org>
	<110EED8CC96DFC488B7E717A2027A27C021A89@039-SN1MPN1-002.039d.mgd.msft.net>
	<m2ty2vjr11.fsf@bob.laptop.org> <m2pqdjjqo2.fsf@bob.laptop.org>
	<110EED8CC96DFC488B7E717A2027A27C021CB2@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58128 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754696Ab2BMUoZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Feb 2012 15:44:25 -0500
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C021CB2@039-SN1MPN1-002.039d.mgd.msft.net>
	(Huang Changming-R's message of "Mon, 13 Feb 2012 07:43:52 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jain Priyanka-B32167 <B32167@freescale.com>

Hi,

On Mon, Feb 13 2012, Huang Changming-R66093 wrote:
>> Actually, I think I'm still missing something.  Why doesn't this work?
>> 
>> +static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int
>> +clock) {
>> +       /* Workaround to reduce the clock frequency for p1010 esdhc */
>> +       if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
>> +               if (clock > 20000000)
>> +                       clock -= 5000000;
>> +               if (clock > 40000000)
>> +                       clock -= 5000000;
>> +       }
>> +
>> +       /* Set the clock */
>> +       esdhc_set_clock(host, clock);
>> +}
>> 
> These codes can work, too.
> I forget the clock will be reduced 5M/10M only when the clock is
> greater than 20MHz/45MHz.
> So I should not test the clock in this function.

Great, thanks -- please test and submit a patch with the code above,
and I'll merge it.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
