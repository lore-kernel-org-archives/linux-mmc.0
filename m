From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 01/15] ARM: pxa: Don't rely on public mmc header to include leds.h
Date: Fri, 20 Jan 2017 09:01:33 +0100
Message-ID: <87efzydusi.fsf@belgarion.home>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
        <1484313256-25993-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:31122 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751397AbdATIBi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2017 03:01:38 -0500
In-Reply-To: <1484313256-25993-2-git-send-email-ulf.hansson@linaro.org> (Ulf
        Hansson's message of "Fri, 13 Jan 2017 14:14:02 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Some of the pxa platforms, balloon3, colibri-pxa270-income, corgi,
> trizeps4, vpac270, zeus and zylonite depends on leds.h. Explicitly include
> it instead of relying on the public mmc header host.h.
>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> I am seeking an ack for this change as following changes for mmc in the
> series, has build-dependencies to it.
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Actually I already have a patch for arch/arm/mach-pxa/idp.c which adds this
include also in my -next tree, just in case you're tempted to modify this one,
which would conflict with my pxa tree.

An other point, I checked which files don't have a leds.h :
 - grep -ls _led arch/arm/mach-pxa/*.c > /tmp/a
 - grep -ls 'linux/leds.h' arch/arm/mach-pxa/*.c > /tmp/b
 - sdiff -s /tmp/a /tmp/b
This gives me :
	balloon3.c
	colibri-pxa270-income.c
	corgi.c
	corgi_pm.c
	em-x270.c
	ezx.c
	hx4700.c
	magician.c
	palmld.c
	palmtc.c
	palmtreo.c
	palmz72.c
	spitz_pm.c
	tosa.c
	trizeps4.c
	vpac270.c
	z2.c
	zeus.c
	zylonite.c
	zylonite_pxa300.c
	zylonite_pxa320.c

So I was wondering how you made the choice of which files you add the include to
and which you don't touch ?

Cheers.

--
Robert
