From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] Revert "mmc: sdhci-s3c: Add clk_(enable/disable) in runtime  suspend/resume"
Date: Sat, 17 Nov 2012 16:14:49 -0500
Message-ID: <87pq3c7wza.fsf@octavius.laptop.org>
References: <201211072357.15572.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37876 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185Ab2KQVPG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 17 Nov 2012 16:15:06 -0500
In-Reply-To: <201211072357.15572.heiko@sntech.de> ("Heiko \=\?utf-8\?Q\?St\?\=
 \=\?utf-8\?Q\?\=C3\=BCbner\=22's\?\= message
	of "Wed, 7 Nov 2012 23:57:15 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-mmc@vger.kernel.org, Chander Kashyap <chander.kashyap@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

Hi Heiko,

On Wed, Nov 07 2012, Heiko St=C3=BCbner wrote:
> This reverts commit 2abeb5c5ded2e7f7d288058426fb0ae852adc77f, as it b=
reaks
> machines using the gpio-based card-detect option with a loop of
>
>         mmc0: Timeout waiting for hardware interrupt.
>         mmc0: Internal clock never stabilised.
>         mmc0: Timeout waiting for hardware interrupt.
>         mmc0: Internal clock never stabilised.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

This doesn't apply to mmc-next, please could you rebase/resend?

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
