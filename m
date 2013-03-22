From: Chris Ball <cjb@laptop.org>
Subject: Re: FW: Regulator API ignored return values
Date: Fri, 22 Mar 2013 12:41:00 -0400
Message-ID: <87d2uro09v.fsf@octavius.laptop.org>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDEB0547F@SC-VEXCH1.marvell.com>
	<CADz5_g+KfxL43BKKsgZZ3Xg4sZWE4-ZaFpFhphKrfj9yK59-XA@mail.gmail.com>
	<201303121403.09315.arnd@arndb.de>
	<87y5dsheqo.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34060 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161013Ab3CVQlW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:41:22 -0400
In-Reply-To: <87y5dsheqo.fsf@octavius.laptop.org> (Chris Ball's message of
	"Tue, 12 Mar 2013 10:30:55 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Liu <keyuan.liu@gmail.com>, "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linus Walleij <linus.walleij@linaro.org>, Axel Lin <axel.lin@ingics.com>, Jingoo Han <jg1.han@samsung.com>, Felipe Balbi <balbi@ti.com>, Dmitry Torokhov <dtor@mail.ru>, linux-mmc@vger.kernel.org

Hi,

On Tue, Mar 12 2013, Chris Ball wrote:
> On Tue, Mar 12 2013, Arnd Bergmann wrote:
>>> Need add regulator_put here since regulator_get has succeed?
>>
>> Hmm, we still don't actually bail out if the error is encountered, so
>> the reference count is balanced with the current patch, but I maybe
>> a failed regulator_enable() should actually be a fatal error?
>
> The reason I didn't make it a fatal error is that this is just vqmmc
> (responsible for moving from 3.3V to 1.8V for UHS modes), not the
> main vmmc regulator.  We can just disable those UHS modes from the
> capabilities on the host if vqmmc is missing, or failed to enable,
> or doesn't support those voltages, and that's what the code does now.

I've pushed this patch to mmc-next for 3.10 now, let me know if you
disagree.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
