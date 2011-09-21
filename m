From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
Date: Wed, 21 Sep 2011 13:53:27 -0400
Message-ID: <m2pqit4wa0.fsf@bob.laptop.org>
References: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41765 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582Ab1IURxp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Sep 2011 13:53:45 -0400
In-Reply-To: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
	(Roy Zang's message of "Fri, 9 Sep 2011 20:05:46 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, cbouatmailru@gmail.com, Xu lei <B33228@freescale.com>, Kumar Gala <galak@kernel.crashing.org>

Hi Roy,

On Fri, Sep 09 2011, Roy Zang wrote:
> From: Xu lei <B33228@freescale.com>
>
> Freescale eSDHC registers only support 32-bit accesses,
> this patch ensures that all Freescale eSDHC register accesses
> are 32-bit.
>
> Signed-off-by: Xu lei <B33228@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Pushed to mmc-next for 3.2 with Anton's ACK now, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
