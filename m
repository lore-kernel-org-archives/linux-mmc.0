From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: fixed regulator control when suspend/resume
Date: Sat, 9 Apr 2011 20:44:42 +0900
Message-ID: <BANLkTikw_PkcWSWsnX6mOub=M2xB=mUt0Q@mail.gmail.com>
References: <4D9D3C58.5030901@samsung.com>
	<20110408184710.GC23883@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35177 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab1DILoo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Apr 2011 07:44:44 -0400
Received: by bwz15 with SMTP id 15so3435678bwz.19
        for <linux-mmc@vger.kernel.org>; Sat, 09 Apr 2011 04:44:43 -0700 (PDT)
In-Reply-To: <20110408184710.GC23883@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi, Wolfram..

2011/4/9 Wolfram Sang <w.sang@pengutronix.de>:
> On Thu, Apr 07, 2011 at 01:23:52PM +0900, Jaehoon Chung wrote:
>> Suspend/resume is working always enable regulator after resuming.
>> (if there is host->vmmc)
>
> The regulator is enabled during add_host. How could it not be enabled=
 in
> suspend?

you're right..When running add_host, enabled the regulator "vmmc".
I'm missing this patch.sorry ^^
Actually,If controller didn't detect the card, i added disable
function in sdhci-s3c.c.
Then regulator is disabled when enter suspend. :)

But i didn't find methed to disable in sdhci.c.
(i think that should be find to use CDn pin)

I'll resend the modified patch.
If you have other method, let me know your opinion.

Thanks very much for your comment.
>
>> =A0 =A0 =A0 struct regulator *vmmc; /* Power regulator */
>> + =A0 =A0 bool restore_vmmc; =A0 =A0 =A0/* Restore vmmc */
>
> If you can explain the above, this should be turned into a SDHCI_-fla=
g IMHO.
>
> Regards,
>
> =A0 Wolfram
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAk2fWC4ACgkQD27XaX1/VRuTAwCghHV5u2l8tAqnLPAwBf3fz+iV
> MVoAnRB+hXXCZU3xZQghwVVBcm7iu5+H
> =3DcDOF
> -----END PGP SIGNATURE-----
>
>
