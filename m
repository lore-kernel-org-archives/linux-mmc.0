From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: cd-gpio: allow NULL context in mmc_cd_gpio_free()
Date: Tue, 24 Apr 2012 12:22:21 -0400
Message-ID: <8762cpcd6q.fsf@laptop.org>
References: <Pine.LNX.4.64.1204241746530.21239@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38861 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755773Ab2DXQWC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 Apr 2012 12:22:02 -0400
In-Reply-To: <Pine.LNX.4.64.1204241746530.21239@axis700.grange> (Guennadi
	Liakhovetski's message of "Tue, 24 Apr 2012 17:56:29 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org

Hi Guennadi,

On Tue, Apr 24 2012, Guennadi Liakhovetski wrote:
> Do not Oops, even if mmc_cd_gpio_free() is mistakenly called on a
> driver-cleanup path, even though a previous call to mmc_cd_gpio_request()
> failed.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> Hi Chris
>
> Unfortunately, as I submitted the final version of the original cd-gpio 
> patch http://article.gmane.org/gmane.linux.kernel.mmc/12013 I forgot, that 
> I'd already sent a v2 and hadn't incremented the version to v3. And that 
> version contained the below fix, that went lost because of the wrong 
> version number. So, please, push this incremental fix for 3.4, because 
> otherwise some error-paths of the tmio-mmc driver can Oops.

Sorry about that, I should have noticed this as well.

Pushed to mmc-next for 3.4 with a stable@ tag for 3.3.  (It's helpful if
you can add the stable@ tag yourself when submitting.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
