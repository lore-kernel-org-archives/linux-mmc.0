From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/4] mmc: bfin_sdh: Port bf5xx SD host driver to support new RSI controller in bf60x.
Date: Wed, 08 Aug 2012 00:15:53 -0400
Message-ID: <87r4rit3wm.fsf@octavius.laptop.org>
References: <1344309015-13248-1-git-send-email-sonic.adi@gmail.com>
	<1344309015-13248-2-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41425 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712Ab2HHEQA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Aug 2012 00:16:00 -0400
In-Reply-To: <1344309015-13248-2-git-send-email-sonic.adi@gmail.com> (Sonic
	Zhang's message of "Tue, 7 Aug 2012 11:10:13 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: linux-mmc@vger.kernel.org, Bob Liu <liubbo@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

Hi,

On Mon, Aug 06 2012, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
>
> In BF60x RSI controller:
> 1) MMR read/write width differs.
> 2) PWR and CTL MMRs are merged to together.
> 3) ROD and PD_DAT3 bit masks are obsolete.
> 4) New RSI block size MMR is defined.
> 5) The definition of DMA descriptor set size is changed.
> 6) set_ios should powers up controller in 2 steps.
>
> In addition, this patch cleans up the spin locks.
>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
