From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 00/20] native support for wl1271 on ZOOM
Date: Mon, 2 Aug 2010 18:59:07 +0300
Message-ID: <AANLkTimaSeLqowRHSCivGXTiSE7NatNTR=jLWQYsSo-6@mail.gmail.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<20100726193028.GG3903@tuxdriver.com> <1280736987.17809.18.camel@chilepepper>
	<20100802114256.GE12293@atomide.com> <AANLkTikvtMbqUdwHtCtdL2xXbQh64pxjApo6ZH6hAXnP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42988 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab0HBP72 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Aug 2010 11:59:28 -0400
In-Reply-To: <AANLkTikvtMbqUdwHtCtdL2xXbQh64pxjApo6ZH6hAXnP@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Luciano Coelho <luciano.coelho@nokia.com>, Kalle Valo <kalle.valo@iki.fi>, Pandita Vikram <vikram.pandita@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ext John W. Linville" <linville@tuxdriver.com>, San Mehat <san@google.com>, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Aug 2, 2010 at 6:12 PM, Vitaly Wool <vitalywool@gmail.com> wrot=
e:
> Also, specifically to 12xx, I'd like to see REF_CLOCK moved on and
> have this set by platform too (I haven't found anything like that in
> the patches but maybe I've overlooked that).

Check out patch no. 9:

http://www.spinics.net/lists/arm-kernel/msg93836.html


>
> Thanks,
> =A0 Vitaly
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wirel=
ess" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
