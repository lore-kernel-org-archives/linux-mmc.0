From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: Reliable write support.
Date: Thu, 31 Mar 2011 20:47:54 -0400
Message-ID: <m3ipuyu79h.fsf@pullcord.laptop.org>
References: <m3mxkc44jm.fsf@pullcord.laptop.org>
	<1301614800-3203-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39696 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180Ab1DAAmI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 31 Mar 2011 20:42:08 -0400
In-Reply-To: <1301614800-3203-1-git-send-email-andreiw@motorola.com> (Andrei
	Warkentin's message of "Thu, 31 Mar 2011 18:40:00 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Thu, Mar 31 2011, Andrei Warkentin wrote:
> Allows reliable writes to be used for MMC writes. Reliable writes are used
> to service write REQ_FUA/REQ_META requests. Handles both the legacy and
> the enhanced reliable write support in MMC cards.
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>

Thanks, Andrei, pushed to mmc-next for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
