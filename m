From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH for 3.10 v2] mmc: mvsdio: use dev_*() API instead of pr_*() API
Date: Fri, 22 Mar 2013 13:18:13 -0400
Message-ID: <87zjxvjqui.fsf@octavius.laptop.org>
References: <1363959441-30744-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50166 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422635Ab3CVRSS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 13:18:18 -0400
In-Reply-To: <1363959441-30744-1-git-send-email-thomas.petazzoni@free-electrons.com>
	(Thomas Petazzoni's message of "Fri, 22 Mar 2013 14:37:21 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-mmc@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Maen Suleiman <maen@marvell.com>, Ralph Droms <rdroms@gmail.com>, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Mar 22 2013, Thomas Petazzoni wrote:
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
>
> Changes between v1 and v2:
>
>  * Fix incorrect format string. A "%s" was left, even though the
>    mmc_hostname() argument was removed due to the conversion to the
>    dev_*() API.

Thanks, I've updated to v2 in mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
