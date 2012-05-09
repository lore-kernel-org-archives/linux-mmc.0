From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/4] mmc: core and queue cleanups
Date: Wed, 09 May 2012 10:11:59 -0400
Message-ID: <877gwlo34g.fsf@laptop.org>
References: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50900 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425Ab2EIOLv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 May 2012 10:11:51 -0400
In-Reply-To: <1334319854-5989-1-git-send-email-svenkatr@ti.com> (Venkatraman
	S.'s message of "Fri, 13 Apr 2012 17:54:10 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org

Hi Venkat,

On Fri, Apr 13 2012, Venkatraman S wrote:
> 	The first 3 are straight forward / trivial fixes.
> The last one is a functional change on how HPI should be invoked
> on the card. This is required for my future foreground HPI series
> that'll follow.
>
> Also available at git://github.com/svenkatr/linux.git my/mmc/cleanups-v2
>
> Venkatraman S (4):
>   mmc: queue: rename mmc_request function
>   mmc: include cd-gpio.h in the source file
>   mmc: queue: remove redundant memsets
>   mmc: core: Send HPI only till it is successful

I've pushed patches 1 and 3 to mmc-next for 3.5; 2 is already applied
via H Hartley Sweeten, and I'm waiting on a final resend of 4.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
