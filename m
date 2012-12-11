From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: slot-gpio: use devm_* managed functions to ease users
Date: Mon, 10 Dec 2012 20:58:09 -0500
Message-ID: <87d2yh4afi.fsf@octavius.laptop.org>
References: <1354887168-3073-1-git-send-email-shawn.guo@linaro.org>
	<Pine.LNX.4.64.1212071438010.24520@axis700.grange>
	<20121207144006.GB30468@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40921 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472Ab2LKB6T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Dec 2012 20:58:19 -0500
In-Reply-To: <20121207144006.GB30468@S2100-06.ap.freescale.net> (Shawn Guo's
	message of "Fri, 7 Dec 2012 22:40:10 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Shawn, Guennadi,

On Fri, Dec 07 2012, Shawn Guo wrote:
>> > Use devm_* managed functions, so that slot-gpio users do not have to
>> > call mmc_gpio_free_ro/cd to free up resources requested in
>> > mmc_gpio_request_ro/cd.
>> > 
>> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> 
>> Thanks for the patch, but I'm not sure this is a good idea. Firstly, using 
>> devm_* allocation functions means, that normally you don't have to free 
>> these resources explicitly any more. So, actually you would have to remove 
>> free_irq() and gpio_free() calls completely from the API instead of 
>> replacing them with devm_* analogs.
>
> With the changes, most of the slot-gpio users will only need to call
> mmc_gpio_request_* functions at probe time, nothing else.  That said,
> they will not call mmc_gpio_free_* functions at all.  I patched
> mmc_gpio_free_* functions replacing free_irq() and gpio_free() with
> devm_* versions to 1) ease the migration of exiting users calling
> mmc_gpio_free_*; 2) provide a mean for users to manually free resources
> for whatever reasons.

I'd like to find a way to merge this -- maybe we can compromise by
adding a comment or some documentation that explains that you need to be
careful (and use _request_* and _free_*) to avoid allocating more than
once if you're doing something odd like runtime switching between CD
methods?

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
