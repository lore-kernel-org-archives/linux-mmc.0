From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] arm, da8xx, mmc: set second MMC controllers default queue
Date: Sun, 04 Dec 2011 16:15:02 +0400
Message-ID: <4EDB6446.2010208@mvista.com>
References: <1322991210-20486-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61620 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab1LDMQB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Dec 2011 07:16:01 -0500
Received: by bkbzv3 with SMTP id zv3so689127bkb.19
        for <linux-mmc@vger.kernel.org>; Sun, 04 Dec 2011 04:16:00 -0800 (PST)
In-Reply-To: <1322991210-20486-1-git-send-email-hs@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Schocher <hs@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, Wolfgang Denk <wd@denx.de>, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>

Hello.

On 04-12-2011 13:33, Heiko Schocher wrote:

> The MMC driver allocates channels with EVENTQ_DEFAULT they

    Missed comma before "they"?

> get put into EVENTQ_1 which the second EDMA controller does
> not have and hence transfers stall. This is tried to fix
> in commit f23fe857bbea393b4b94fe2218c98d934bd3d4cf

    Please also specify that commit's summary in parens.

> from Ido Yariv, but missed a fix for the second MMC
> controller on da850.

> Signed-off-by: Heiko Schocher<hs@denx.de>
> Signed-off-by: juha.kuikka@gmail.com
> Reported-by: juha.kuikka@gmail.com
> Cc: linux-mmc@vger.kernel.org
> Cc: davinci-linux-open-source@linux.davincidsp.com
> Cc: Rajashekhara, Sudhakar<sudhakar.raj@ti.com>
> Cc: Ido Yariv<ido@wizery.com>
> Cc: Sekhar Nori<nsekhar@ti.com>
> Cc: Wolfgang Denk<wd@denx.de>

WBR, Sergei
