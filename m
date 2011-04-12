From: Chris Ball <cjb@laptop.org>
Subject: Re: zaurus: mmcblk0: error -110
Date: Tue, 12 Apr 2011 17:39:26 -0400
Message-ID: <m37hazxi7l.fsf@pullcord.laptop.org>
References: <20110412151547.GC20815@atrey.karlin.mff.cuni.cz>
	<m3aafvz30t.fsf@pullcord.laptop.org>
	<20110412193944.GC2665@atrey.karlin.mff.cuni.cz>
	<m3oc4bxne1.fsf@pullcord.laptop.org>
	<20110412205421.GD2665@atrey.karlin.mff.cuni.cz>
	<m3fwpnxj1w.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60992 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932568Ab1DLVek (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Apr 2011 17:34:40 -0400
In-Reply-To: <m3fwpnxj1w.fsf@pullcord.laptop.org> (Chris Ball's message of
	"Tue, 12 Apr 2011 17:21:15 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Cyril Hrubis <metan@ucw.cz>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric.y.miao@gmail.com, utx@penguin.cz, zaurus-devel@lists.linuxtogo.org, marek.vasut@gmail.com, linux-mmc@vger.kernel.org

Hi,

On Tue, Apr 12 2011, Chris Ball wrote:
> There aren't many -EOPNOTSUPP returns in the stack.  I see:
>
> card/block.c: mmc_blk_issue_secdiscard_rq and mmc_blk_issue_discard_rq
> card/core.c: mmc_erase
> core/sd_ops.c: mmc_app_cmd
>
> Mind doing some instrumentation to figure out which it is?

Actually, this probably isn't necessary -- mmc_app_cmd() is the only call
involved in the setup path, via mmc_sd_init_card() -> mmc_app_send_scr().

So, a better question: was mmc_app_send_scr() succeeding on your previous
kernels?  There hasn't been much change in this area lately.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
