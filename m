From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: sdhci: add regulator disable/put when control error
Date: Sat, 9 Apr 2011 20:48:28 +0900
Message-ID: <BANLkTimSWHM2m_LpLYgJ09svsgqndEFikQ@mail.gmail.com>
References: <4D9ACC8C.2000202@samsung.com>
	<20110408183825.GB23883@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64826 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab1DILsa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Apr 2011 07:48:30 -0400
Received: by bwz15 with SMTP id 15so3436981bwz.19
        for <linux-mmc@vger.kernel.org>; Sat, 09 Apr 2011 04:48:29 -0700 (PDT)
In-Reply-To: <20110408183825.GB23883@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi..

2011/4/9 Wolfram Sang <w.sang@pengutronix.de>:
> On Tue, Apr 05, 2011 at 05:02:20PM +0900, Jaehoon Chung wrote:
>> Missing regulator disable/put. Fixed them.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> Looks OK but could be merged into the previous patch.

Thanks. :)
yes, i can be merged into the previous patch.
But i think good that  separeted. anyway..don't mind merged or not?

Regards,
Jaehoon Chung

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
> iEYEARECAAYFAk2fViEACgkQD27XaX1/VRt1+wCaAxSjsZ+GqVdhnca16rMsO7LK
> jfcAnjvIvSBSFknx7nMomkT6I4Y1YTgV
> =3DKfuE
> -----END PGP SIGNATURE-----
>
>
