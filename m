From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: fix missing clock for gpio card-detect
Date: Sun, 18 Nov 2012 14:05:14 -0500
Message-ID: <877gpiivf9.fsf@octavius.laptop.org>
References: <201211072357.15572.heiko@sntech.de>
	<87pq3c7wza.fsf@octavius.laptop.org>
	<201211181950.06005.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57727 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267Ab2KRTFV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 14:05:21 -0500
In-Reply-To: <201211181950.06005.heiko@sntech.de> ("Heiko \=\?utf-8\?Q\?St\?\=
 \=\?utf-8\?Q\?\=C3\=BCbner\=22's\?\= message
	of "Sun, 18 Nov 2012 19:50:05 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-mmc@vger.kernel.org, Chander Kashyap <chander.kashyap@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

Hi,

On Sun, Nov 18 2012, Heiko St=C3=BCbner wrote:
> Commit 2abeb5c5ded2 (Add clk_(enable/disable) in runtime suspend/resu=
me)
> added the capability to stop the clocks when the device is runtime
> suspended, but forgot to handle the case of the card-detect using
> an external gpio.
>
> Therefore in the case that runtime-pm is enabled, start the io-clock
> when a card is inserted and stop it again once it is removed.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Thanks, pushed to mmc-next for 3.7.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
