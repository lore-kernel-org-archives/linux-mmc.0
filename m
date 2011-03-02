From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V4 1/4] ARM: imx53_loco: add esdhc device support
Date: Tue, 1 Mar 2011 22:21:53 -0300
Message-ID: <AANLkTinR9+tFVfNb626LF4TSc8c+8a+rSUNvQB7DwSUZ@mail.gmail.com>
References: <1298973500-2858-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:40045 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757602Ab1CBBVz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 20:21:55 -0500
Received: by wwe15 with SMTP id 15so5166004wwe.1
        for <linux-mmc@vger.kernel.org>; Tue, 01 Mar 2011 17:21:53 -0800 (PST)
In-Reply-To: <1298973500-2858-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, w.sang@pengutronix.de, eric.miao@linaro.org, richard.zhao@freescale.com, eric@eukrea.com, avorontsov@ru.mvista.com, linuxzsc@gmail.com

On Tue, Mar 1, 2011 at 6:58 AM, Richard Zhu <Hong-Xing.Zhu@freescale.co=
m> wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
> =C2=A0arch/arm/mach-mx5/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A01 +
> =C2=A0arch/arm/mach-mx5/board-mx53_loco.c | =C2=A0 =C2=A02 ++
> =C2=A02 files changed, 3 insertions(+), 0 deletions(-)

I thought you were going to put this patch as the last of the series.

It is strange to add support for the board first and add the support
for the MX53 later.

Regards,

=46abio Estevam
