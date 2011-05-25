From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: SDHCI Auto-CMD23 fixes.
Date: Wed, 25 May 2011 16:13:36 -0400
Message-ID: <m3d3j6r11r.fsf@pullcord.laptop.org>
References: <m3aaeby3xr.fsf@pullcord.laptop.org>
	<1306307623-8610-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39796 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643Ab1EYUMU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 May 2011 16:12:20 -0400
In-Reply-To: <1306307623-8610-1-git-send-email-andreiw@motorola.com> (Andrei
	Warkentin's message of "Wed, 25 May 2011 02:13:43 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Wed, May 25 2011, Andrei Warkentin wrote:
> Fixes bugs in Auto-CMD23 feature enable decision. Auto-CMD23
> shoud be enabled if host is >= v3, and SDMA is not in use.
>
> USE_ADMA | USE_SDMA | Auto-CMD23
> ---------+----------+-----------
>     0    |    0     |     1
> ---------+----------+-----------
>     0    |    1     |     0
> ---------+----------+-----------
>     1    |    0     |     1
> ---------+----------+-----------
>     1    |    1     |     1
>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>

Great, this does the right thing on my XO now.  I'll send it to Linus
along with the rest of the merge shortly.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
