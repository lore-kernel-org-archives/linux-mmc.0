From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: sdhci-s3c: ensure non-transaction of bus before clk_disable
Date: Mon, 29 Oct 2012 17:18:56 -0400
Message-ID: <87hapdq8n3.fsf@octavius.laptop.org>
References: <004701cdad16$6886e890$3994b9b0$%jun@samsung.com>
	<201210181301.20819.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54875 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760975Ab2J2VTA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Oct 2012 17:19:00 -0400
In-Reply-To: <201210181301.20819.heiko@sntech.de> ("Heiko \=\?utf-8\?Q\?St\?\=
 \=\?utf-8\?Q\?\=C3\=BCbner\=22's\?\= message
	of "Thu, 18 Oct 2012 13:01:20 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Chander Kashyap' <chander.kashyap@linaro.org>

Hi,

On Thu, Oct 18 2012, Heiko St=C3=BCbner wrote:
> Clock should be supplied during bus transaction. This patch defers
> clk_disabe in runtime_suspend if CMD/DATA line is used.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> ---
> It's also necessary to destaticise the forward declarations in the to=
p of
> sdhci.c, which I've done in this v2.

Looks like this doesn't apply to mmc-next anymore -- please could you
rebase/resend?

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
