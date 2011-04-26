From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc:sdhci:add support to request/free pins for controllers sharing hardware bus
Date: Mon, 25 Apr 2011 23:48:37 -0400
Message-ID: <m3d3k9u0yy.fsf@pullcord.laptop.org>
References: <5EB3BFCD089AD643B9BB63439F5FD5E9A127@SHAASIEXM01.ASIA.ROOT.PRI>
	<BANLkTinj4pnDG=cCJY3JGYGXOYoVPHtA9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60160 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932988Ab1DZDpC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 25 Apr 2011 23:45:02 -0400
In-Reply-To: <BANLkTinj4pnDG=cCJY3JGYGXOYoVPHtA9A@mail.gmail.com> (Barry
	Song's message of "Tue, 26 Apr 2011 11:34:20 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Binghua.Duan@csr.com, andreiw@motorola.com, prakity@marvell.com

Hi Barry,

On Mon, Apr 25 2011, Barry Song wrote:
> From: Bin Shi <bin.shi@csr.com>
>
> some controllers share data bus or other pins between
> multi-controllers and need to switch the functions of shared pins
> runtime.
> this patch requested those shared pins before actual hardware access
> and release them after access
>
> Signed-off-by: Bin Shi <bin.shi@csr.com>
> Cc: Binghua Duan <binghua.duan@csr.com>
> Cc: Andrei Warkentin <andreiw@motorola.com>
> Cc: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Barry Song <21cnbao@gmail.com>

* The patch is corrupt:
    fatal: corrupt patch at line 11
  You can check whether the patch is okay by first e-mailing it to
  yourself and checking that git can apply it.

* Where is the patch that implements the get_shared_pins() hook in
  your driver?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
