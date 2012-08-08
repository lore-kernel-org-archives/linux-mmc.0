From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: Add regulator support for vccq (voltage regualor)
Date: Tue, 07 Aug 2012 22:23:37 -0400
Message-ID: <87a9y6yvdi.fsf@octavius.laptop.org>
References: <1343084183-6070-1-git-send-email-prakity@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41229 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753587Ab2HHCXn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Aug 2012 22:23:43 -0400
In-Reply-To: <1343084183-6070-1-git-send-email-prakity@marvell.com>
	(philipspatches@gmail.com's message of "Mon, 23 Jul 2012 15:56:23
	-0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: philipspatches@gmail.com
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

Hi,

On Mon, Jul 23 2012, philipspatches@gmail.com wrote:
> From: Philip Rakity <prakity@marvell.com>
>
> On some systems the host controller does not support vccq
> signaling.  This is supplied by a dedicated regulator (vqmmc).
>
> Add support for this regulator.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
