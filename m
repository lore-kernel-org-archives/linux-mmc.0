From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: Question about ACMD42
Date: Sat, 4 Sep 2010 14:15:50 +0200
Message-ID: <AANLkTimh=DWQNh=01sR8c1enhnCrahMqJXnt-HkPq8uD@mail.gmail.com>
References: <AANLkTi=RUmOzwM3vzzjK=h9aQv5FV2XDmAJDWT246F0H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:39278 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab0IDMPv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Sep 2010 08:15:51 -0400
Received: by qyk33 with SMTP id 33so2863282qyk.19
        for <linux-mmc@vger.kernel.org>; Sat, 04 Sep 2010 05:15:50 -0700 (PDT)
In-Reply-To: <AANLkTi=RUmOzwM3vzzjK=h9aQv5FV2XDmAJDWT246F0H@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?5qKB5Lqm6aOe?= <dinuxlyf@gmail.com>
Cc: linux-mmc@vger.kernel.org

2010/9/3 =E6=A2=81=E4=BA=A6=E9=A3=9E <dinuxlyf@gmail.com>:
> Hi ,
> =C2=A0 =C2=A0 This might be a stupid question, in =C2=A0<<Physical La=
yer Simplified
> Specification Version 2.00>>,there is a command SET_CLR_CARD_
> DETECT, as spec discribed Connect[1]/Disconnect[0] the 50 KOhm pull-u=
p
> resistor on CD/DAT3 (pin 1) of
> the card.
> =C2=A0 =C2=A0 If this command is use to switch the card beteewn the D=
AT[3] and
> CD mode, why i don't see it's being
> use in kernel. Under what circumstance we should use this command?

The pullup is disabled for SDIO part, but not for memory part. I would
call it a bug. This should go to mmc_sd_setup_card() in sd.c. I'll
send a fix after I get my dev machine up, unless someone beats me to
it.

Best Regards,
Micha=C5=82 Miros=C5=82aw
