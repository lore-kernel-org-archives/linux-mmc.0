From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCHv2 2/2] mmc: fix integer assignments to pointer
Date: Sun, 28 Aug 2011 13:54:29 -0400
Message-ID: <m2wrdxxvze.fsf@bob.laptop.org>
References: <1314212450-18500-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43769 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980Ab1H1Ryd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 28 Aug 2011 13:54:33 -0400
In-Reply-To: <1314212450-18500-1-git-send-email-svenkatr@ti.com> (Venkatraman
	S.'s message of "Thu, 25 Aug 2011 00:30:50 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org

Hi Venkatraman,

On Wed, Aug 24 2011, Venkatraman S wrote:
> Fix the sparse warning output
> "warning: Using plain integer as NULL pointer"
>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>

Thanks, applied these two patches to mmc-next.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
