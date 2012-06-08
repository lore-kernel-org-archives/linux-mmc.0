From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: power class selection fails on 3.5-rc1
Date: Fri, 8 Jun 2012 18:11:20 +0530
Message-ID: <CANfBPZ8D=LQMNP3b2pqXk6boW7KRHEhCFrmvXQYtntWHyTw47Q@mail.gmail.com>
References: <6008680.IROCjD91iZ@ax5200p>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:34692 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752770Ab2FHMlm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Jun 2012 08:41:42 -0400
Received: by pbbrq13 with SMTP id rq13so2685029pbb.36
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jun 2012 05:41:41 -0700 (PDT)
In-Reply-To: <6008680.IROCjD91iZ@ax5200p>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marc Dietrich <marvin24@gmx.de>
Cc: linux-mmc@vger.kernel.org

On Mon, Jun 4, 2012 at 10:05 PM, Marc Dietrich <marvin24@gmx.de> wrote:
> Hi,
>
> somehow I hope this would go away by itself, but it didn't :-( I repo=
rted this
> problem some time ago (see: http://www.mail-archive.com/linux-
> mmc@vger.kernel.org/msg13688.html ) but got no clear answer or fix.
>
> In addition to the information I posted on the thread above, I also d=
umped the
> contents of the ext_csd register file (where reg values are not zero)=
:
>
> reg =A0 =A0 =A0 Sandisk =A0 =A0 =A0 =A0 Toshiba
> 241 =A0 =A0 10 =A0 =A0 =A00x0a =A0 =A050 =A0 =A0 =A00x32
> 239 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A051 =A0 =A0 =A00x33
> 238 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A0119 =A0 =A0 0x77
> 234 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A030 =A0 =A0 =A00x1e
> 232 =A0 =A0 1 =A0 =A0 =A0 0x01 =A0 =A04 =A0 =A0 =A0 0x04
> 231 =A0 =A0 21 =A0 =A0 =A00x15 =A0 =A021 =A0 =A0 =A00x15
> 230 =A0 =A0 150 =A0 =A0 0x96 =A0 =A016 =A0 =A0 =A00x10
> 229 =A0 =A0 150 =A0 =A0 0x96 =A0 =A066 =A0 =A0 =A00x42
> 228 =A0 =A0 1 =A0 =A0 =A0 0x01 =A0 =A07 =A0 =A0 =A0 0x07
> 226 =A0 =A0 8 =A0 =A0 =A0 0x08 =A0 =A016 =A0 =A0 =A00x10
> 225 =A0 =A0 6 =A0 =A0 =A0 0x06 =A0 =A07 =A0 =A0 =A0 0x07
> 224 =A0 =A0 4 =A0 =A0 =A0 0x04 =A0 =A08 =A0 =A0 =A0 0x08
> 223 =A0 =A0 1 =A0 =A0 =A0 0x01 =A0 =A02 =A0 =A0 =A0 0x02
> 222 =A0 =A0 8 =A0 =A0 =A0 0x08 =A0 =A016 =A0 =A0 =A00x10
> 221 =A0 =A0 16 =A0 =A0 =A00x10 =A0 =A01 =A0 =A0 =A0 0x01
> 220 =A0 =A0 8 =A0 =A0 =A0 0x08 =A0 =A07 =A0 =A0 =A0 0x07
> 219 =A0 =A0 7 =A0 =A0 =A0 0x07 =A0 =A07 =A0 =A0 =A0 0x07
> 217 =A0 =A0 16 =A0 =A0 =A00x10 =A0 =A017 =A0 =A0 =A00x11
> 215 =A0 =A0 1 =A0 =A0 =A0 0x01 =A0 =A00 =A0 =A0 =A0 0x00
> 214 =A0 =A0 218 =A0 =A0 0xda =A0 =A0238 =A0 =A0 0xee
> 213 =A0 =A0 160 =A0 =A0 0xa0 =A0 =A0128 =A0 =A0 0x80
> 210 =A0 =A0 10 =A0 =A0 =A00x0a =A0 =A00 =A0 =A0 =A0 0x00
> 209 =A0 =A0 10 =A0 =A0 =A00x0a =A0 =A060 =A0 =A0 =A00x3c
> 208 =A0 =A0 10 =A0 =A0 =A00x0a =A0 =A00 =A0 =A0 =A0 0x00
> 207 =A0 =A0 10 =A0 =A0 =A00x0a =A0 =A060 =A0 =A0 =A00x3c
> 206 =A0 =A0 10 =A0 =A0 =A00x0a =A0 =A00 =A0 =A0 =A0 0x00
> 205 =A0 =A0 10 =A0 =A0 =A00x0a =A0 =A030 =A0 =A0 =A00x1e
> 203 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A051 =A0 =A0 =A00x33
> 202 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A051 =A0 =A0 =A00x33
> 201 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A0119 =A0 =A0 0x77
> 200 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A0119 =A0 =A0 0x77
> 196 =A0 =A0 3 =A0 =A0 =A0 0x03 =A0 =A07 =A0 =A0 =A0 0x07
> 194 =A0 =A0 2 =A0 =A0 =A0 0x02 =A0 =A02 =A0 =A0 =A0 0x02
> 192 =A0 =A0 5 =A0 =A0 =A0 0x05 =A0 =A05 =A0 =A0 =A0 0x05
> 185 =A0 =A0 1 =A0 =A0 =A0 0x01 =A0 =A01 =A0 =A0 =A0 0x01
> 181 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A01 =A0 =A0 =A0 0x01
> 179 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A01 =A0 =A0 =A0 0x01
> 175 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A01 =A0 =A0 =A0 0x01
> 169 =A0 =A0 1 =A0 =A0 =A0 0x01 =A0 =A00 =A0 =A0 =A0 0x00
> 168 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A02 =A0 =A0 =A0 0x02
> 160 =A0 =A0 3 =A0 =A0 =A0 0x03 =A0 =A03 =A0 =A0 =A0 0x03
> 158 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A03 =A0 =A0 =A0 0x03
> 157 =A0 =A0 237 =A0 =A0 0xed =A0 =A0186 =A0 =A0 0xba
>
> The second and the third column is from a device with a Sandisk eMCC =
which
> works fine, while the last two columns are from a Toshiba eMMC which =
shows the
> error. Looking into it, I found that only the Toshiba eMMC specifies =
a
> powerclass in registers 203-200 while Sandisk does not, so the powerc=
lass is
> not changed in the latter case and the problem cannot be triggered th=
ere.
>
> I also attached a boot log with mmc debug enabled. I think there is n=
ot much I
> can do else. Either this eMMC is just bogus and needs blacklisting or=
 there is
> some problem in the driver code.
>
I am a bit rusty here, so bear with me.
According to the ext_csd, the power class value that should be sent to
the card was 0x7. (Upper nibble of ext_csd[201]).

What I saw in the attached debug Log:
[    3.842390] mmc1: starting CMD6 arg 03bb0301 flags 0000049d
This means write 0x03 into 0xBB register, and not 0x7 which is what is =
needed.

While Marc has tried all values from 0 to 10, this wouldn't be the
definite issue, but I am wondering is there is some other problem.

Or have I got it all wrong ?
~Venkat.
