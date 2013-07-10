From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/4 V2] powerpc/85xx: Add support for 85xx cpu type
 detection
Date: Wed, 10 Jul 2013 16:48:13 -0500
Message-ID: <1373492893.8183.236@snotra>
References: <1373441941-32650-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:57980
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752571Ab3GJVsW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Jul 2013 17:48:22 -0400
In-Reply-To: <1373441941-32650-1-git-send-email-Haijun.Zhang@freescale.com>
	(from Haijun.Zhang@freescale.com on Wed Jul 10 02:39:01 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cbouatmailru@gmail.com, cjb@laptop.org, AFLEMING@freescale.com, r39252@freescale.com, X.Xie@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhao Chenhui <chenhui.zhao@freescale.com>

On 07/10/2013 02:39:01 AM, Haijun Zhang wrote:
> +/* Get current SOC Version */
> +#define GET_SVR()	(mfspr(SPRN_SVR))

Unnecessary parens.  Why do we need GET_SVR(), versus opencoding it?   
Note that U-Boot (which this is patterned after) doesn't have  
GET_SVR(), so code that wants to work on both can't use it anyway.

> +#define IS_SVR_REV(svr, maj, min) \
> +	((SVR_MAJ(svr) == (maj)) && (SVR_MIN(svr) == (min)))

I don't think IS_SVR_REV is needed.  Callers can just do "if  
(SVR_REV(svr) == 0x30)" or whatever, especially since we're relying on  
them to do this for greater/less than comparisons.

-Scott
