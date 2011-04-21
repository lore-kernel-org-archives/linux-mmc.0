From: Chris Ball <cjb@laptop.org>
Subject: Re: CMD23 plumbing and support patchset.
Date: Wed, 20 Apr 2011 21:44:53 -0400
Message-ID: <m3pqogbcoa.fsf@pullcord.laptop.org>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
	<1302950458-1969-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41765 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398Ab1DUBkp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Apr 2011 21:40:45 -0400
In-Reply-To: <1302950458-1969-1-git-send-email-andreiw@motorola.com> (Andrei
	Warkentin's message of "Sat, 16 Apr 2011 05:40:53 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com

Hi,

On Sat, Apr 16 2011, Andrei Warkentin wrote:
> This is the third version of the CMD23 plumbing and host driver support
> patch set.
>
> Changes:
> 1) CMD23 support (used for features such as reliable writes) is decoupled
>    from general multiblock trans through use of a quirk for affected cards.
> 2) Newer Sandisk MMC products are whitelisted along with some known good ones. All other
>    MMC products do not use CMD23 for general transfers (seems like safest choice for now).
>    SD products unaffected.

Just gave this a try on SEM04G, which is in the whitelist, but didn't
see a performance increase (or decrease).  What are you using for a
testcase?  I'm a little wary of running mmc_test on it.  :)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
