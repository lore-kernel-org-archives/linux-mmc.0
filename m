From: Koen Beel <koen.beel.barco@gmail.com>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Mon, 4 Jul 2011 13:01:09 +0200
Message-ID: <CAHMSPgNtOzZ=Dm1cEO9rXxc9JaoVXq2+whK_h9RSGM-COK=A2w@mail.gmail.com>
References: <BANLkTi==Y_MJ2H_u15DzunWusUb=GsotWg@mail.gmail.com>
	<BANLkTinKcb-=m3sURawdEjR=vTt=ApBKaQ@mail.gmail.com>
	<20110630145507.GG1997@pengutronix.de>
	<20110701091753.GE1922@pengutronix.de>
	<BANLkTi=cTigrnAHY3sDNC04aNpmZOQpUsA@mail.gmail.com>
	<20110701122709.GJ1922@pengutronix.de>
	<BANLkTim5aHJHbtbw-ZWnqdjdj_nxWZuwog@mail.gmail.com>
	<20110701144409.GA3825@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49538 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab1GDLBL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jul 2011 07:01:11 -0400
Received: by wyg8 with SMTP id 8so3325217wyg.19
        for <linux-mmc@vger.kernel.org>; Mon, 04 Jul 2011 04:01:10 -0700 (PDT)
In-Reply-To: <20110701144409.GA3825@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, shawn.guo@freescale.com

On Fri, Jul 1, 2011 at 4:44 PM, Wolfram Sang <w.sang@pengutronix.de> wr=
ote:
> Hi,
>
> On Fri, Jul 01, 2011 at 03:26:39PM +0200, Koen Beel wrote:
>> I send the patch as attachment for now.
>
> Fine with me in this case...
>
>> But I'll have to look into another way of doing this. Corporate mail
>> system is adding stupid disclaimers, gmail web ui is not working ok
>> and corporate firewalls avoid using a different smtp server...
>
> Good luck with that!
>
> About the patch itself: I didn't verify the formulas, but it does sol=
ve one
> special problem here. Thanks a lot! So:

Does it solve any other special problem except for the wrong clock rate=
 setting?


>
> Tested-by: Wolfram Sang <w.sang@pengutronix.de>
>
> @chris: If Shawn also likes the patch, I think this is a stable candi=
date.
>
> Very minor nits:
>
>> From ab610437fade5b30fdeacd9e959ddf95bc42587a Mon Sep 17 00:00:00 20=
01
>> From: Koen Beel <koen.beel@barco.com>
>> Date: Thu, 30 Jun 2011 12:00:19 +0200
>> Subject: [PATCH] mxs-mmc: fix clock rate setting
>>
>> Fix clock rate setting on mxs-mmc driver.
>> Previously, if div2 was zero the value for TIMING_CLOCK_RATE would h=
ave been 255 instead of 0.
>> Also the limits for div1 (TIMING_CLOCK_DIVIDE) and div2 (TIMING_CLOC=
K_RATE + 1) where not correctly defined.
>>
>> Can easily be reproduced on mx23evk: default clock for high speed sd=
io cards is 50 MHz.
>> With a SSP_CLK of 28.8 MHz (default), this resulted in an actual clo=
ck rate of about 56 kHz.
>
> Commit msg should linebreak at 72.
>
>
>> Signed-off-by: Koen beel <koen.beel@barco.com>
>
> Capital 'B'?

Indeed, it should have been:
"Signed-off-by: Koen Beel <koen.beel@barco.com>"

>
> Regards,
>
> =C2=A0 Wolfram
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Wolfram Sang =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
