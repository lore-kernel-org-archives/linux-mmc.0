From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 4/5] arm: mach-mx3: pcm043: add write-protect and
 card-detect for SD1
Date: Tue, 22 Feb 2011 16:26:51 -0300
Message-ID: <AANLkTi=cDkuo9Q1Eqzno=_FKLN+0pNBCdvD=SqFsysVf@mail.gmail.com>
References: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
	<1298379500-27590-5-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44518 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102Ab1BVT0x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 14:26:53 -0500
Received: by wyg36 with SMTP id 36so87553wyg.19
        for <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2011 11:26:51 -0800 (PST)
In-Reply-To: <1298379500-27590-5-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>, linux-arm-kernel@lists.infradead.org

Hi Wolfram,

On Tue, Feb 22, 2011 at 9:58 AM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
=2E..
> =C2=A0#define AC97_GPIO_TXFS (1 * 32 + 31)
> =C2=A0#define AC97_GPIO_TXD =C2=A0(1 * 32 + 28)
> =C2=A0#define AC97_GPIO_RESET =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 * 32 + 0)
>
> +#define SD1_GPIO_WP =C2=A0 =C2=A0(1 * 32 + 23)
> +#define SD1_GPIO_CD =C2=A0 =C2=A0(1 * 32 + 24)

You could also do:

+#define SD1_GPIO_WP    IMX_GPIO_NR(2, 23)
+#define SD1_GPIO_CD     IMX_GPIO_NR(2, 24)

Regards,

=46abio Estevam
