From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: sdhci-s3c: fix the card detection in runtime-pm
Date: Mon, 29 Oct 2012 17:16:47 -0400
Message-ID: <87liepq8qo.fsf@octavius.laptop.org>
References: <004801cdad17$498d9140$dca8b3c0$%jun@samsung.com>
	<201210181302.30843.heiko@sntech.de>
	<006501cdadd0$548d1f70$fda75e50$%jun@samsung.com>
	<201210191010.48776.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54859 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760998Ab2J2VQx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Oct 2012 17:16:53 -0400
In-Reply-To: <201210191010.48776.heiko@sntech.de> ("Heiko \=\?utf-8\?Q\?St\?\=
 \=\?utf-8\?Q\?\=C3\=BCbner\=22's\?\= message
	of "Fri, 19 Oct 2012 10:10:48 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Chander Kashyap' <chander.kashyap@linaro.org>

Hi,

On Fri, Oct 19 2012, Heiko St=C3=BCbner wrote:
> Am Freitag, 19. Oktober 2012, 10:04:14 schrieb Seungwon Jeon:
>> On Thursday, October 18, 2012, Heiko Stuebner <heiko@sntech.de>
>>=20
>> > If host clock is disabled, host cannot detect a card
>> > in case of using the internal or gpio card-detect for detection.
>> >=20
>> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> > Tested-by: Heiko Stuebner <heiko@sntech.de>
>> > ---
>> > I've added the SDHCI_CD_GPIO to the conditional. With this change =
it
>> > works on my machine. But I'm not sure if this would also be necess=
ary
>> > for the external card detect.
>>=20
>> Card detection will be asserted out of host in case of using SDHCI_C=
D_GPIO.
>> Adding SDHCI_CD_GPIO to the conditional seems unnecessary.
>
> But it _was_ necessary :-) . Because only then did the problem go awa=
y. You=20
> might be right, that there exists a better solution for this, but som=
ething in=20
> the original patch is at least still missing to fix the problem.

Seungwon, what would you like to do here?  (I'm unhappy taking a patch
with your name on it that's been modified in a way you disagree with.)

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
