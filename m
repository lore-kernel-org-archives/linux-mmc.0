From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: sd: Fix sd current limit setting
Date: Wed, 18 Jul 2012 22:41:28 -0400
Message-ID: <87hat4bhgn.fsf@octavius.laptop.org>
References: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
	<1341296172-10645-3-git-send-email-aaron.lu@amd.com>
	<CAGxe1ZF=T7GL6ZcyV-=MEd5WVWexNrUbrEZDsYGdFD+KPH4XfA@mail.gmail.com>
	<20120717134325.GA2567@localhost.localdomain>
	<87fw8qieap.fsf@octavius.laptop.org>
	<20120718050939.GA30490@srdclcs1.amd.com>
	<87liihocxj.fsf@octavius.laptop.org>
	<20120718062223.GA2711@aarontestpc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45449 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947Ab2GSCle (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Jul 2012 22:41:34 -0400
In-Reply-To: <20120718062223.GA2711@aarontestpc.amd.com> (Aaron Lu's message
	of "Wed, 18 Jul 2012 14:22:23 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Girish K S <girish.shivananjappa@linaro.org>, Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi,

On Wed, Jul 18 2012, Aaron Lu wrote:
> I've prepared the following code, please check if this is better than
> the current one:

I think the diffstat speaks for itself.  :-)

 drivers/mmc/core/sd.c    |   77 ++++++++++++++++++++++++++--------------------
 drivers/mmc/host/sdhci.c |   51 ++----------------------------
 include/linux/mmc/host.h |   22 +++----------
 3 files changed, 51 insertions(+), 99 deletions(-)

Girish/Philip, does this look good to you too?  If so, I'll squash it
into the original patch.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
