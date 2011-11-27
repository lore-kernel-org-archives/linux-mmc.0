From: =?ISO-8859-1?Q?Thomas_Lang=E5s?= <thomas.langaas@gmail.com>
Subject: Re: SDIO wifi card works with 2.6.36, not with 3.2
Date: Sun, 27 Nov 2011 10:40:41 +0100
Message-ID: <CANN7TQnuJ55RUuhC3UBhmqyMQ0p3mFtbghCmssAw6jWMSOJY+Q@mail.gmail.com>
References: <CANN7TQkp4t2rhfS=LM38TSUdrp2pE7d0VX_t36AjiEEqayqNmQ@mail.gmail.com>
	<4ED03ABF.5070604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62503 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab1K0Jkn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2011 04:40:43 -0500
Received: by iage36 with SMTP id e36so7155497iag.19
        for <linux-mmc@vger.kernel.org>; Sun, 27 Nov 2011 01:40:43 -0800 (PST)
In-Reply-To: <4ED03ABF.5070604@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On Sat, Nov 26, 2011 at 2:02 AM, Xiangfu Liu <xiangfu.z@gmail.com> wrot=
e:
> I am not sure if this is the root cause. by revert this commit.[1]
> our SDIO ks7010 wifi card work again in linux 3.0.
> check out this emails, under mailing list:
> =A0SDIO single IRQ optimization breaks libertas
> =A0http://permalink.gmane.org/gmane.linux.kernel.mmc/8338

Didn't help my problem, I'm afraid.  I guess I should try if the 2.6.36
non-android works and if it does do a bisect session to see if I get
anywhere with that.

--=20
Thomas
