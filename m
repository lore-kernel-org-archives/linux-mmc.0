From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V4] Powerpc eSDHC Recover from the ADMA error
Date: Sat, 17 Nov 2012 15:56:03 -0500
Message-ID: <871ufs9cf0.fsf@octavius.laptop.org>
References: <1348107563-16545-1-git-send-email-Haijun.Zhang@freescale.com>
	<20120920025702.GA13639@lizard>
	<110EED8CC96DFC488B7E717A2027A27C21CCE3@039-SN1MPN1-004.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43209 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183Ab2KQU4I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 17 Nov 2012 15:56:08 -0500
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C21CCE3@039-SN1MPN1-004.039d.mgd.msft.net>
	(Huang Changming-R's message of "Tue, 13 Nov 2012 07:51:38 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Zhang Haijun-B42677 <B42677@freescale.com>

Hi,

On Tue, Nov 13 2012, Huang Changming-R66093 wrote:
> Hi, Chris,
> This patch has been ACKed by Anton  on Sep 20.
> Have you any comment about it?

Something weird has happened with this patch -- the latest version has
no commit message even though an earlier version did, and there seem
to be two separate runs of v2-v3-v4 with the same subject but with
different changes in each.

Could you merge the changelog into a single list of changes, rebase
against mmc-next, add the full commit message and Anton's ACK, and
resend?  Then I'll merge it.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
