From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 V2] mmc: esdhc: Correct host version of T4240-R1.0
Date: Wed, 17 Jul 2013 12:11:14 -0500
Message-ID: <1374081074.8183.360@snotra>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
	<1374055891-20703-2-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:44788
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932071Ab3GQRLW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Jul 2013 13:11:22 -0400
In-Reply-To: <1374055891-20703-2-git-send-email-Haijun.Zhang@freescale.com>
	(from Haijun.Zhang@freescale.com on Wed Jul 17 05:11:30 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cbouatmailru@gmail.com, cjb@laptop.org, AFLEMING@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>

On 07/17/2013 05:11:30 AM, Haijun Zhang wrote:
> Vender version and sdhc spec version of T4240-R1.0 is incorrect.
> The right value should be VVN=0x13, SVN = 0x1. The wrong version
> number will break down the ADMA data transfer.
> This defect only exist in T4240-R1.0. Will be fixed in T4240-R2.0.
> Also share vvn and svr for public use.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>

We're not supporting T4240 rev 1.0 in upstream Linux, as it's not  
production silicon.

-Scott
