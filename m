From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/4] powerpc/85xx: Add support for 85xx cpu type
 detection
Date: Mon, 8 Jul 2013 18:43:06 -0500
Message-ID: <1373326986.8183.185@snotra>
References: <1373249545-23928-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:49630
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753400Ab3GHXnf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 8 Jul 2013 19:43:35 -0400
In-Reply-To: <1373249545-23928-1-git-send-email-Haijun.Zhang@freescale.com>
	(from Haijun.Zhang@freescale.com on Sun Jul  7 21:12:22 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cbouatmailru@gmail.com, cjb@laptop.org, AFLEMING@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhao Chenhui <chenhui.zhao@freescale.com>

On 07/07/2013 09:12:22 PM, Haijun Zhang wrote:
> Add this file to help detect cpu type in runtime.
> These macros and inline routines will be more favorable for driver
> to apply errata and workaround to specified cpu type.
> 
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
>  arch/powerpc/include/asm/mpc85xx.h | 96  
> ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/mpc85xx.h

What changed since the last time this was posted?  I don't see any of  
the feedback addressed that I gave here:

http://patchwork.ozlabs.org/patch/144880/

-Scott
