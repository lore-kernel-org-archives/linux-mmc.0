From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] mmc: clean up clockgating code
Date: Thu, 18 Nov 2010 03:30:53 +0000
Message-ID: <20101118033052.GA23555@void.printf.net>
References: <1289926602-14011-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36871 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371Ab0KRDaz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Nov 2010 22:30:55 -0500
Content-Disposition: inline
In-Reply-To: <1289926602-14011-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org

Hi Linus,

On Tue, Nov 16, 2010 at 05:56:42PM +0100, Linus Walleij wrote:
> This rids the unused boolean clk_pending_gate from the code
> and renames the clk_disable_work to clk_gate_work in
> analogy with the other names used for gating code.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

Thanks, merged into mmc-next for .38.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
