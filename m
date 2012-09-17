From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Date: Mon, 17 Sep 2012 09:45:30 -0400
Message-ID: <m3fw6gn4p1.fsf@pullcord.laptop.org>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
	<1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
	<20120911075429.GA27028@lizard> <20120911080457.GA28235@lizard>
	<110EED8CC96DFC488B7E717A2027A27C176170@039-SN1MPN1-002.039d.mgd.msft.net>
	<6D8C87BA-CA06-4215-94F5-63EBF5162B0A@kernel.crashing.org>
	<2A6FCAE3-288F-4972-90C0-15105932F13E@kernel.crashing.org>
	<87k3w0y5yn.fsf@octavius.laptop.org>
	<FC22FA36-B2CF-49C2-A0B1-8A0EA614B9CB@kernel.crashing.org>
	<8B1F0805-759E-417A-B787-40DF197896F3@kernel.crashing.org>
	<110EED8CC96DFC488B7E717A2027A27C1785D0@039-SN1MPN1-002.039d.mgd.msft.net>
	<4E15F856-D385-40C4-A5FD-5F298C70F402@kernel.crashing.org>
	<m3k3vsn7wf.fsf@pullcord.laptop.org>
	<1166FFD6-342F-4BDA-BF23-794DAEA95CC9@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52130 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452Ab2IQNpS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Sep 2012 09:45:18 -0400
In-Reply-To: <1166FFD6-342F-4BDA-BF23-794DAEA95CC9@kernel.crashing.org> (Kumar
	Gala's message of "Mon, 17 Sep 2012 08:12:56 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Huang Changming-R66093 <R66093@freescale.com>, "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Anton Vorontsov <cbouatmailru@gmail.com>

Hi,

On Mon, Sep 17 2012, Kumar Gala wrote:
>>>> P1020, p1021, p1022, p1024, p1015 and p4080 can't support it.
>>>> Mpc8536, p2020, and the other current DPAA silicon (e.g. p5020, p3041) support it.
>>> 
>>> Based on this, why don't we use the HOSTVER register to detect instead of device tree:
>> 
>> I've got a mild preference for handling quirk assignment in the DT
>> rather than in driver code, so I'd prefer to just push the original
>> patch to mmc-next as-is.  Does that sound okay?
>
> Why?  I only ask because I agree with Scott that this means you have to update your device tree to get proper functionality.

Thanks, I'd missed that.  I withdraw my preference; I'll pick up
whichever method you all prefer.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
