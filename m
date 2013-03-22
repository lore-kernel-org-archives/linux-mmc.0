From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH for 3.9 v3] mmc: mvsdio: fix non-DT probing of GPIOs
Date: Fri, 22 Mar 2013 13:17:50 -0400
Message-ID: <874ng3l5fl.fsf@octavius.laptop.org>
References: <1363959023-25661-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47826 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422635Ab3CVRSB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 13:18:01 -0400
In-Reply-To: <1363959023-25661-1-git-send-email-thomas.petazzoni@free-electrons.com>
	(Thomas Petazzoni's message of "Fri, 22 Mar 2013 14:30:23 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-mmc@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Maen Suleiman <maen@marvell.com>, Ralph Droms <rdroms@gmail.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>

Hi,

On Fri, Mar 22 2013, Thomas Petazzoni wrote:
> Ralph Droms <rdroms@gmail.com> reported that 3.9-rc was breaking the
> SDIO interface on his Sheevaplug platform, and that the recent changes
> to the mvsdio driver are responsible for this breakage. Precisely, the
> regression has been introduced by 07728b77c03d (mmc: mvsdio: use
> slot-gpio for card detect gpio).

Thanks, pushed to mmc-next for 3.9-rc.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
