From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/3] mmc: protect against clockgate races
Date: Thu, 18 Nov 2010 03:31:16 +0000
Message-ID: <20101118033116.GB23555@void.printf.net>
References: <1289926612-14049-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36875 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab0KRDbS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Nov 2010 22:31:18 -0500
Content-Disposition: inline
In-Reply-To: <1289926612-14049-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>

Hi Linus,

On Tue, Nov 16, 2010 at 05:56:52PM +0100, Linus Walleij wrote:
> This adds a mutex to protect from races between gate and ungate
> calls colliding.
> 
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

Thanks, merged into mmc-next for .38.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
