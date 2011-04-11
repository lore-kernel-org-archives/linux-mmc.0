From: Chris Ball <cjb@laptop.org>
Subject: Re: [patchv3 4/4] MMC: MMC boot partitions support.
Date: Mon, 11 Apr 2011 18:00:56 -0400
Message-ID: <m3oc4c8n3b.fsf@pullcord.laptop.org>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
	<1302556424-21951-4-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59209 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986Ab1DKV4B (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Apr 2011 17:56:01 -0400
In-Reply-To: <1302556424-21951-4-git-send-email-andreiw@motorola.com> (Andrei
	Warkentin's message of "Mon, 11 Apr 2011 16:13:44 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, arnd@arndb.de

Hi Andrei,

On Mon, Apr 11 2011, Andrei Warkentin wrote:
> Allows device MMC boot partitions to be accessed. MMC partitions
> are treated effectively as separate block devices on the same
> MMC card.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>

Looks fine, but would you mind breaking out the {claim,release}_host
changes around mmc_blk_issue_rq() into a separate patch?  It doesn't
look like they're obviously related to the partitioning support, but
maybe I'm missing something.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
