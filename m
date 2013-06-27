From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc-utils: small fixes of output
Date: Thu, 27 Jun 2013 10:35:39 -0400
Message-ID: <87k3lfsjt0.fsf@octavius.laptop.org>
References: <1368599284-28499-1-git-send-email-mario.schuknecht@dresearch-fe.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42029 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412Ab3F0Ofn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 10:35:43 -0400
In-Reply-To: <1368599284-28499-1-git-send-email-mario.schuknecht@dresearch-fe.de> (Mario
	Schuknecht's message of "Wed, 15 May 2013 08:28:04 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mario Schuknecht <mario.schuknecht@dresearch-fe.de>
Cc: linux-mmc@vger.kernel.org

Hi,

On Wed, May 15 2013, Mario Schuknecht wrote:
> Improve "extcsd read" output of the registers.
> Right-shift by 3 of EXT_CSD_BOOT_CFG_EN bits.
> Expand the EXT_CSD_BOOT_CFG_ACC bit mask to 0x7.
> Add case 3 RPMB partition.
>
> Signed-off-by: Mario Schuknecht <mario.schuknecht@dresearch-fe.de>

Thanks, pushed to mmc-utils.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
