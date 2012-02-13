From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v7] ESDHC: Workaround for data crc error on p1010rdb
Date: Sun, 12 Feb 2012 23:28:26 -0500
Message-ID: <m2ty2vjr11.fsf@bob.laptop.org>
References: <1328688356-17510-1-git-send-email-r66093@freescale.com>
	<m21uq52wk8.fsf@bob.laptop.org>
	<110EED8CC96DFC488B7E717A2027A27C01F304@039-SN1MPN1-002.039d.mgd.msft.net>
	<m2mx8pkqxy.fsf@bob.laptop.org>
	<110EED8CC96DFC488B7E717A2027A27C021A89@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35958 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755199Ab2BME2k (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 12 Feb 2012 23:28:40 -0500
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C021A89@039-SN1MPN1-002.039d.mgd.msft.net>
	(Huang Changming-R's message of "Mon, 13 Feb 2012 02:40:07 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jain Priyanka-B32167 <B32167@freescale.com>

Hi,

On Sun, Feb 12 2012, Huang Changming-R66093 wrote:
> You are right.
> I want to use the below code in header file "drivers/mmc/host/sdhci-esdhc.h":
> if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc"))
> then I can avoid the twice test of the clock.
> do you think if it is reasonable?

Yes, I think that's okay; let's try it.  Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
