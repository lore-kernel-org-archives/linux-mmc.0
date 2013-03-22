From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: FW: Regulator API ignored return values
Date: Fri, 22 Mar 2013 17:06:27 +0000
Message-ID: <201303221706.27733.arnd@arndb.de>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDEB0547F@SC-VEXCH1.marvell.com> <87y5dsheqo.fsf@octavius.laptop.org> <87d2uro09v.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:54919 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161016Ab3CVRGj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Mar 2013 13:06:39 -0400
In-Reply-To: <87d2uro09v.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Kevin Liu <keyuan.liu@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linus Walleij <linus.walleij@linaro.org>, Axel Lin <axel.lin@ingics.com>, Jingoo Han <jg1.han@samsung.com>, Felipe Balbi <balbi@ti.com>, Dmitry Torokhov <dtor@mail.ru>, linux-mmc@vger.kernel.org

On Friday 22 March 2013, Chris Ball wrote:
> >
> > The reason I didn't make it a fatal error is that this is just vqmmc
> > (responsible for moving from 3.3V to 1.8V for UHS modes), not the
> > main vmmc regulator.  We can just disable those UHS modes from the
> > capabilities on the host if vqmmc is missing, or failed to enable,
> > or doesn't support those voltages, and that's what the code does now.
> 
> I've pushed this patch to mmc-next for 3.10 now, let me know if you
> disagree.

No, it's fine. Sorry for not replying earlier.

	Arnd
