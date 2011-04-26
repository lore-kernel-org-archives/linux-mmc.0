From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc:sdhci:add support to request/free pins for controllers sharing hardware bus
Date: Tue, 26 Apr 2011 09:00:40 -0400
Message-ID: <m3pqo9rwuf.fsf@pullcord.laptop.org>
References: <5EB3BFCD089AD643B9BB63439F5FD5E9A127@SHAASIEXM01.ASIA.ROOT.PRI>
	<BANLkTinj4pnDG=cCJY3JGYGXOYoVPHtA9A@mail.gmail.com>
	<m3d3k9u0yy.fsf@pullcord.laptop.org>
	<BANLkTimXXirF6zqx9h9DMRSpx+o8_vb=3w@mail.gmail.com>
	<20110426065851.GA14534@pengutronix.de>
	<BANLkTineayh539zJx6GfxnpgCJwJdxYy0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34594 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755297Ab1DZM5G (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Apr 2011 08:57:06 -0400
In-Reply-To: <BANLkTineayh539zJx6GfxnpgCJwJdxYy0Q@mail.gmail.com> (Barry
	Song's message of "Tue, 26 Apr 2011 15:27:28 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, Binghua.Duan@csr.com, andreiw@motorola.com, prakity@marvell.com

Hi Barry,

On Tue, Apr 26 2011, Barry Song wrote:
> Just because Our SoCs are still on the way to opensource and mainline.
> Even our arch/arm/mach-xxx hasn't been merged yet. Our target is
> syncing our codes with mainline. So as a modification to sdhci common
> level, we just get upstream's opinion for local maintaining earlier.
>
> Anyway, this patch may be applied later after our others are ready. Or
> it can be now so that other SoC companies can use this feature.

Thanks for the explanation.  In that case, I'll give you my Reviewed-by:
on the patch now, but will wait to merge it until you have your driver
support code posted too.  (Or until, as you say, someone else would like
the same hook.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
