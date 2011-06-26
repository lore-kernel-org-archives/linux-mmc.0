From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Sun, 26 Jun 2011 11:23:39 -0400
Message-ID: <m2pqm0ehvo.fsf@bob.laptop.org>
References: <20110625182011.7CB8E9D401C@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37328 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739Ab1FZPXn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 Jun 2011 11:23:43 -0400
In-Reply-To: <20110625182011.7CB8E9D401C@zog.reactivated.net> (Daniel Drake's
	message of "Sat, 25 Jun 2011 19:20:11 +0100 (BST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi,

On Sat, Jun 25 2011, Daniel Drake wrote:
> mmc_sdio_power_restore() skips some steps that are performed in other
> power-related codepaths which are necessary to fully reset the card.
> Without this, runtime PM fails for SD8686 SDIO wifi on OLPC XO-1.5.
>
> Signed-off-by: Daniel Drake <dsd@laptop.org>

Thanks, merged for 3.0-rc.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
