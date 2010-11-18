From: Chris Ball <cjb@laptop.org>
Subject: Re: omap4: hsmmc: Fix improper card detection while booting
Date: Thu, 18 Nov 2010 03:39:09 +0000
Message-ID: <20101118033909.GD23555@void.printf.net>
References: <6576.10.24.255.17.1289812139.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57923 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371Ab0KRDjK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Nov 2010 22:39:10 -0500
Content-Disposition: inline
In-Reply-To: <6576.10.24.255.17.1289812139.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

Hi Kishore,

On Mon, Nov 15, 2010 at 02:38:59PM +0530, kishore kadiyala wrote:
> While booting OMAP4 ES2.0 boards, cards on MMC1 and MMC2 controllers
> are not getting detected some times.
> 
> During reset of command/data line, wrong pointer to base address
> was passed while read operation to SYSCTL register, thus impacting
> the updated reset logic.
> Passing correct base address fixes the issue.
> 
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>

Thanks, I've taken this into the MMC for-linus branch for .37 now.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
