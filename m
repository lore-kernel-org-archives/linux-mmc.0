From: Chris Ball <cjb@laptop.org>
Subject: Re: [2.6.37/38] SDHCI spurious interrupt...
Date: Thu, 20 Jan 2011 04:26:13 +0000
Message-ID: <20110120042613.GA5480@void.printf.net>
References: <AANLkTi=koHRNJaVQGwdPiEkSOwveOKHK97oO99n6PiwF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57178 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754885Ab1ATE0O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Jan 2011 23:26:14 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=koHRNJaVQGwdPiEkSOwveOKHK97oO99n6PiwF@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: linux-mmc@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Hi Daniel,

On Thu, Jan 20, 2011 at 11:21:14AM +0700, Daniel J Blueman wrote:
> With 2.6.37 (and by extension 2.6.38-rc1, as the code hasn't changed),
> I occasionally see an 'IRQ 16: nobody cared' message a second before
> shutting down (previously reported [1]); the culprit is the SDHCI
> driver for my Ricoh controller.
> 
> I modified the interrupt handler to be unregistered later with a
> delay, and to dump out the interrupt mask read, but didn't catch it
> yet.

Are you able to bisect?

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
