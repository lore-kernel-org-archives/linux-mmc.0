From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Adding esdhc4 eMMC support on mx6sabresd
Date: Thu, 8 May 2014 11:05:20 -0300
Message-ID: <CAOMZO5AdS=X93MCeS54_A4hKe=rBHHph+ed_qkw9BFJ3+XJJMw@mail.gmail.com>
References: <CAOMZO5CJEoe_fGLH-Uu9uVwNdWPp940k3WGAkjzkCiGmjAPAXA@mail.gmail.com>
	<20140508091835.78daafbe@ipc1.ka-ro>
	<20140508101730.GA28787@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:64534 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbaEHOFV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 May 2014 10:05:21 -0400
Received: by mail-vc0-f175.google.com with SMTP id hu19so332381vcb.34
        for <linux-mmc@vger.kernel.org>; Thu, 08 May 2014 07:05:20 -0700 (PDT)
In-Reply-To: <20140508101730.GA28787@shlinux1.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>, Sascha Hauer <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawn.guo@freescale.com>

On Thu, May 8, 2014 at 7:17 AM, Dong Aisheng <b29396@freescale.com> wrote:

> I'm not very sure about HYS bit, but it should not be pad setting issue.
> This pad setting was tested ok with FSL internal tree.
>
> I just tested an old Chris/mmc-next tree which is 3.14 rc2 with the top commit is b42b9b.
> The eMMC works well on SabreSD boards.
> But it failed and got the same issue with latest chris/mmc-next tree.
> I noticed there's no changes on sdhci-esdhc-imx.c
> Probably some other changes breaks this function.
>
> Fabio,
> You may bisect it yourself or i will do it later when i'm a bit free.

Ok, I have just tested with Shawn's branch and the mmc error does not
happen, so it must be something in linux-next that causes the issue.

Will submit the dts change.

Regards,

Fabio Estevam
