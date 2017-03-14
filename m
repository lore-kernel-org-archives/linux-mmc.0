From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [BUG] dmaengine: pxa_dma: + mmc: pxamci: race condition with DMA error on tx channel
Date: Tue, 14 Mar 2017 22:11:46 +0100
Message-ID: <871stzh8bx.fsf@belgarion.home>
References: <e749aff1-0ffc-c9ed-42b2-82397b4e8ba2@tul.cz>
        <877f3zwwgo.fsf@belgarion.home>
        <feb39d00-d40d-f935-751c-8119f40b4df4@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:29537 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbdCNVLx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2017 17:11:53 -0400
In-Reply-To: <feb39d00-d40d-f935-751c-8119f40b4df4@tul.cz> (Petr Cvek's
        message of "Fri, 10 Mar 2017 01:49:12 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: vinod.koul@intel.com, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org

Petr Cvek <petr.cvek@tul.cz> writes:

Ok Petr, I've been trying for days to reproduce without any luck.

I had a look at your traces, and I'd like something else when it happens :
 1) The patch I provided earlier applied
 2) This done (the 'cat' after the bug) :
	mount -t debugfs none /sys/kernel/debug/
	cat /sys/kernel/debug/pxa-dma.0/channels/4/[sd]*

Cheers.

--
Robert
