From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/3] mmc: protect some gating variables
Date: Thu, 18 Nov 2010 03:32:00 +0000
Message-ID: <20101118033159.GC23555@void.printf.net>
References: <1289926620-14085-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36883 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab0KRDcC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Nov 2010 22:32:02 -0500
Content-Disposition: inline
In-Reply-To: <1289926620-14085-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org

Hi Linus,

On Tue, Nov 16, 2010 at 05:57:00PM +0100, Linus Walleij wrote:
> This adds some more picky variable protection to the state holders
> for the clock gating code. This is particularly important when
> ordinary .set_ios() calls would race with the .set_ios() call
> resulting from a delayed gate operation.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

Thanks, merged into mmc-next for .38.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
