From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: sdio: avoid spurious calls to interrupt handlers
Date: Wed, 18 Apr 2012 19:49:29 -0400
Message-ID: <87aa28mwhi.fsf@laptop.org>
References: <alpine.LFD.2.02.1204131639510.16314@xanadu.home>
	<alpine.LFD.2.02.1204161913120.16314@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34296 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656Ab2DRXtX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Apr 2012 19:49:23 -0400
In-Reply-To: <alpine.LFD.2.02.1204161913120.16314@xanadu.home> (Nicolas
	Pitre's message of "Mon, 16 Apr 2012 19:16:54 -0400 (EDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-mmc@vger.kernel.org, Sujit Reddy Thumma <sthumma@codeaurora.org>

Hi,

On Mon, Apr 16 2012, Nicolas Pitre wrote:
> Commit 06e8935feb "optimized SDIO IRQ handling for single irq"
> introduced some spurious calls to SDIO function interrupt handlers,
> such as when the SDIO IRQ thread is started, or the safety check
> performed upon a system resume.  Let's add a flag to perform the
> optimization only when a real interrupt is signaled by the host
> driver and we know there is no point confirming it.
>
> Reported-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> Cc: stable@kernel.org

Thanks, pushed v2 to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
