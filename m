From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: duplicated trial with same freq when mmc_rescan_try_freq()
Date: Thu, 12 May 2011 10:04:20 -0400
Message-ID: <m3fwokypzv.fsf@pullcord.laptop.org>
References: <4DCB97F3.9060704@samsung.com>
	<8A2FC72B45BB5A4C9F801431E06AE48F1154C484@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33846 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851Ab1ELOCG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 May 2011 10:02:06 -0400
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F1154C484@039-SN1MPN1-005.039d.mgd.msft.net>
	(Huang Changming-R's message of "Thu, 12 May 2011 08:57:45 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <R66093@freescale.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, "andy.ross@windriver.com" <andy.ross@windriver.com>

Hi,

On Thu, May 12 2011, Huang Changming-R66093 wrote:
> The required min frequency (f_min) is 400KHz during identify stage, is
> it necessary to use the frequency table (freqs[], including 300KHz,
> 200KHz and 100KHz)?

Yes.  Some hardware is buggy/out of compliance with the spec.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
