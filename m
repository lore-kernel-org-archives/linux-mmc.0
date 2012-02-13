From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v7] ESDHC: Workaround for data crc error on p1010rdb
Date: Sun, 12 Feb 2012 23:36:13 -0500
Message-ID: <m2pqdjjqo2.fsf@bob.laptop.org>
References: <1328688356-17510-1-git-send-email-r66093@freescale.com>
	<m21uq52wk8.fsf@bob.laptop.org>
	<110EED8CC96DFC488B7E717A2027A27C01F304@039-SN1MPN1-002.039d.mgd.msft.net>
	<m2mx8pkqxy.fsf@bob.laptop.org>
	<110EED8CC96DFC488B7E717A2027A27C021A89@039-SN1MPN1-002.039d.mgd.msft.net>
	<m2ty2vjr11.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53709 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775Ab2BMEgR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 12 Feb 2012 23:36:17 -0500
In-Reply-To: <m2ty2vjr11.fsf@bob.laptop.org> (Chris Ball's message of "Sun, 12
	Feb 2012 23:28:26 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jain Priyanka-B32167 <B32167@freescale.com>

Hi,

On Sun, Feb 12 2012, Chris Ball wrote:
> Hi,
>
> On Sun, Feb 12 2012, Huang Changming-R66093 wrote:
>> You are right.
>> I want to use the below code in header file "drivers/mmc/host/sdhci-esdhc.h":
>> if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc"))
>> then I can avoid the twice test of the clock.
>> do you think if it is reasonable?
>
> Yes, I think that's okay; let's try it.  Thanks,

Actually, I think I'm still missing something.  Why doesn't this work?

+static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+       /* Workaround to reduce the clock frequency for p1010 esdhc */
+       if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
+               if (clock > 20000000)
+                       clock -= 5000000;
+               if (clock > 40000000)
+                       clock -= 5000000;
+       }
+
+       /* Set the clock */
+       esdhc_set_clock(host, clock);
+}

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
