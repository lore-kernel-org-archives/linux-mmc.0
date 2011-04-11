From: Chris Ball <cjb@laptop.org>
Subject: Re: [patchv3 4/4] MMC: MMC boot partitions support.
Date: Mon, 11 Apr 2011 18:22:14 -0400
Message-ID: <m3ei588m3t.fsf@pullcord.laptop.org>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
	<1302556424-21951-4-git-send-email-andreiw@motorola.com>
	<m3oc4c8n3b.fsf@pullcord.laptop.org>
	<BANLkTimAFUnodvc2yBs-Bj=DnSpmZN7BwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41426 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756199Ab1DKWRU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Apr 2011 18:17:20 -0400
In-Reply-To: <BANLkTimAFUnodvc2yBs-Bj=DnSpmZN7BwA@mail.gmail.com> (Andrei
	Warkentin's message of "Mon, 11 Apr 2011 17:10:37 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, arnd@arndb.de

Hi Andrei,

On Mon, Apr 11 2011, Andrei Warkentin wrote:
> So it was one of the two -
> a) stick mmc_bkl_part_switch into mmc_blk_issue_secdiscard_rq,
> mmc_blk_issue_discard_rq,  and mmc_blk_issue_rw_rq.
> b) Move claim/release into mmc_blk_issue_rq and put partition switch
> code into one place.
>
> (b) is cleaner.  What do you think?

Thanks, I see.

(b) is definitely fine -- I'm suggesting one patch to push claim/release
up into mmc_blk_issue_rq() (which should have no other side-effects),
and then a second patch to add partitioning support and also insert the
single mmc_blk_part_switch() into the right place.  Does that make sense?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
