From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Date: Tue, 11 Sep 2012 16:59:07 -0400
Message-ID: <87liggwa1w.fsf@octavius.laptop.org>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
	<1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
	<20120911075429.GA27028@lizard> <20120911080457.GA28235@lizard>
	<110EED8CC96DFC488B7E717A2027A27C176170@039-SN1MPN1-002.039d.mgd.msft.net>
	<6D8C87BA-CA06-4215-94F5-63EBF5162B0A@kernel.crashing.org>
	<2A6FCAE3-288F-4972-90C0-15105932F13E@kernel.crashing.org>
	<87k3w0y5yn.fsf@octavius.laptop.org>
	<FC22FA36-B2CF-49C2-A0B1-8A0EA614B9CB@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60886 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755857Ab2IKU7P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 Sep 2012 16:59:15 -0400
In-Reply-To: <FC22FA36-B2CF-49C2-A0B1-8A0EA614B9CB@kernel.crashing.org> (Kumar
	Gala's message of "Tue, 11 Sep 2012 15:26:32 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Huang Changming-R66093 <R66093@freescale.com>, "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>

Hi,

On Tue, Sep 11 2012, Kumar Gala wrote:
> thanks for the info.  Do you know what's required on controller side
> to handle cards that support CMD23?
>
> I'm trying to figure out if older controller's on FSL SoCs are missing
> some feature to allow CMD23 to work (vs Auto-CMD23).

It seems plausible that it's just not implemented on these controllers.
It's a little strange, since the command's been specified for so long
and we haven't seen any other controllers with problems.  The patch
would be correct if this is true.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
