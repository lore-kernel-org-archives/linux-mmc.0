From: Prashanth Bhat <prashanth.bhat@manipal.net>
Subject: Possible bug in sdio.c?
Date: Sun, 29 May 2011 07:26:00 +0530
Message-ID: <4DE1A7B0.7000600@manipal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtpauth19.prod.mesa1.secureserver.net ([64.202.165.30]:60584
	"HELO smtpauth19.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750804Ab1E2CC5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 28 May 2011 22:02:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Micha=C5=82,

In mmc/core/sdio.c, routine mmc_enable_4bit_bus():

I think:

     if (card->type =3D=3D MMC_TYPE_SDIO)
               return sdio_enable_wide(card);

should really be:

     if (card->type =3D=3D MMC_TYPE_SDIO || card->type =3D=3D MMC_TYPE_=
SD_COMBO )
                return sdio_enable_wide(card);

Otherwise, the SDIO component of the SD Combo card will not operate in=20
wide mode. What do you think?

Perhaps a similar change is needed in the sdio_enable_hs() routine too.

Thanks,
Prashanth

ps: I am sorry to be emailing you directly with questions/bug reports.=20
What is the formal process of reporting suggestions for code change?






