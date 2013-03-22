From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mvsdio: use dev_*() API instead of pr_*() API
Date: Fri, 22 Mar 2013 13:13:15 -0400
Message-ID: <87k3ozl5n8.fsf@octavius.laptop.org>
References: <1363792181-26512-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47769 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422636Ab3CVRNY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 13:13:24 -0400
In-Reply-To: <1363792181-26512-1-git-send-email-thomas.petazzoni@free-electrons.com>
	(Thomas Petazzoni's message of "Wed, 20 Mar 2013 16:09:41 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Ralph Droms <rdroms.ietf@gmail.com>

Hi,

On Wed, Mar 20 2013, Thomas Petazzoni wrote:
> The mvsdio driver was already using some dev_*() functions to print
> some messages, but still using pr_*() functions for some others. This
> patch converts all messages to use dev_*() functions.
>
> Many of the pr_*() function calls were printing the output of
> mmc_hostname() to preprend the message with an identifier for the
> device. Since the dev_*() functions do that automatically, this patch
> also gets rid of those string prefixes.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> This is for 3.10.

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
