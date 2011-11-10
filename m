From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/3] mmc: sdhci-pxa: Add SDHCI driver for PXA16x
Date: Thu, 10 Nov 2011 15:09:54 -0500
Message-ID: <87r51fwxgt.fsf@laptop.org>
References: <1319546229-31804-1-git-send-email-tanmay.upadhyay@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41985 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753363Ab1KJUKK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Nov 2011 15:10:10 -0500
In-Reply-To: <1319546229-31804-1-git-send-email-tanmay.upadhyay@einfochips.com>
	(Tanmay Upadhyay's message of "Tue, 25 Oct 2011 18:07:09 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Cc: zhangfei.gao@marvell.com, dwang4@marvell.com, njun@marvell.com, wuqm@marvell.com, prakity@marvell.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tanmay and Philip,

On Tue, Oct 25 2011, Tanmay Upadhyay wrote:
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
> ---
>  drivers/mmc/host/Kconfig                |   13 ++
>  drivers/mmc/host/Makefile               |    1 +
>  drivers/mmc/host/sdhci-pxav1.c          |  256 +++++++++++++++++++++++++++++++

By my script's count, 215 of the 256 lines in this file (84%) are simply
duplicated from sdhci-pxav2.c, which makes me think we've failed at
abstraction here.  Can you have a think about how to do better, please?

My intuition is that since there are only 41 lines of difference (actually,
less, since the only difference on many of these is s/pxav2/pxav1/g), I'd
rather see this become special-cases in the sdhci-pxav2.c code.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
