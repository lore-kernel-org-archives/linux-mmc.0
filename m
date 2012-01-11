From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2] arm, da8xx, mmc: set second MMC controllers default
 queue
Date: Wed, 11 Jan 2012 09:28:56 +0100
Message-ID: <4F0D4848.4070000@denx.de>
References: <1322991210-20486-1-git-send-email-hs@denx.de>
 <1323327357-23886-1-git-send-email-hs@denx.de>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from b.relay.invitel.net ([62.77.203.4]:41145 "EHLO
	b.relay.invitel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755838Ab2AKI3G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2012 03:29:06 -0500
In-reply-to: <1323327357-23886-1-git-send-email-hs@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: juha.kuikka@gmail.com, linux-mmc@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, Ido Yariv <ido@wizery.com>, Sekhar Nori <nsekhar@ti.com>, Wolfgang Denk <wd@denx.de>, Sergei Shtylyov <sshtylyov@mvista.com>

Hello,

Heiko Schocher wrote:
> The MMC driver allocates channels with EVENTQ_DEFAULT, they
> get put into EVENTQ_1, which the second EDMA controller does
> not have and hence transfers stall. This is fixed
> in commit f23fe857bbea393b4b94fe2218c98d934bd3d4cf
> "ARM: davinci: Explicitly set channel controllers' default queues"
> from Ido Yariv. This patch sets immediately in edma_probe()
> the proper default_queue, so this patch does not really fix
> something, it is more a cosmetic change.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Signed-off-by: juha.kuikka@gmail.com
> Reported-by: juha.kuikka@gmail.com
> Acked-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: davinci-linux-open-source@linux.davincidsp.com
> Cc: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
> Cc: Ido Yariv <ido@wizery.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Sergei Shtylyov <sshtylyov@mvista.com>
> 
> ---
> - changes for v2:
>   - add comment from Sergei Shtylyov
>     add in commit message the commit's summary in parens.
>   - add comment from Ido Yariv:
>     changed comment and commit message
>   - added Acked-by from Rajashekhara, Sudhakar
> 
>  arch/arm/mach-davinci/dma.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)

Ping. Can this patch go into mainline, or are there some more objections?

Thanks
bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
