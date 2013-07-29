From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] mmc:core: parse voltage from device-tree
Date: Mon, 29 Jul 2013 17:07:18 -0500
Message-ID: <1375135638.30721.58@snotra>
References: <1375066595-14968-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:9727
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750983Ab3G2WHX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Jul 2013 18:07:23 -0400
In-Reply-To: <1375066595-14968-1-git-send-email-Haijun.Zhang@freescale.com>
	(from Haijun.Zhang@freescale.com on Sun Jul 28 21:56:33 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cbouatmailru@gmail.com, cjb@laptop.org, AFLEMING@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>

On 07/28/2013 09:56:33 PM, Haijun Zhang wrote:
> Add function to support get voltage from device-tree.
> If there are voltage-range specified in device-tree node, this  
> function
> will parse it and return the avail voltage mask.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---
>  drivers/mmc/core/core.c  | 48  
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/core.h |  1 +
>  2 files changed, 49 insertions(+)

Move the code rather than copying it.

-Scott
