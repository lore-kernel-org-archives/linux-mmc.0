From: Chris Ball <cjb@laptop.org>
Subject: Re: Re:[lnxrevli] [REVIEW 2/2] ENGR0000137838 SDHCI Some eMMC
	cards can't workwell in our BSP
Date: Tue, 11 Jan 2011 02:22:30 +0000
Message-ID: <20110111022229.GB9534@void.printf.net>
References: <1294711368-446-1-git-send-email-r65037@freescale.com> <1.10.2011-mgd.freescale.com-30-6343028328831767454500-3831@freescale.com> <010C9052C42A00499CE76D637FA5EE9004756C@039-SN1MPN1-001.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53377 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754495Ab1AKCWc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Jan 2011 21:22:32 -0500
Content-Disposition: inline
In-Reply-To: <010C9052C42A00499CE76D637FA5EE9004756C@039-SN1MPN1-001.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <R65037@freescale.com>
Cc: Zhang Lily-R58066 <R58066@freescale.com>, "root@udp161639uds.ap.freescale.net" <root@udp161639uds.ap.freescale.net>, ReviewList Linux-LNXREVLI <LNXREVLI@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Richard,

On Tue, Jan 11, 2011 at 02:17:08AM +0000, Zhu Richard-R65037 wrote:
> Hi Chris:
> I keep all the info of the original patch into my local patch.
> The script the pull-tool used by us send out the emails to all the sign-off email address,
> When I used this tool to push the local patch into our mainline.
> Sorry to bring any inconvenience to you.

Please modify the script so that it does not send mail to the people
in the Signed-off chain, or at least so that it never sends mail to
linux-mmc@.  The fact that you're importing a patch locally is off-topic
for the list.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
