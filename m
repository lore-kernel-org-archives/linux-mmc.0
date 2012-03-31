From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Possible issue with tifm_7xx1 and interrupt latency
Date: Sat, 31 Mar 2012 06:49:27 -0700 (PDT)
Message-ID: <1333201767.36239.YahooMailNeo@web121005.mail.ne1.yahoo.com>
References: <20120330113915.GE9075@marvin.atrad.com.au>
Reply-To: Alex Dubov <oakad@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120330113915.GE9075@marvin.atrad.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org





----- Original Message -----
> From: Jonathan Woithe <jwoithe@just42.net>
>=20
> Although somewhat circumstancial, during the debugging of a FFADO iss=
ue with
> a user it seemed possible that the tifm_7xx1 module may have been swi=
tching
> interrupts off for long periods of time.=A0 For a full history of the=
 problem
> please refer to
>=20
> =A0 http://subversion.ffado.org/ticket/250
>=20
> Unfortunately the original reporter no longer has access to the hardw=
are
> concerned and the report itself dates from 2 years ago (I kept forget=
ting
> to report it).=A0 However, it may be useful none-the-less.

Unfortunately, I don't have access to that hardware either.

However, there are really only few operations in that driver between "i=
rqsave"
and "irqrestore", unless PIO mode is used (which may, ostensibly, cause=
 this
sort of interrupt delays). On the other hand, PIO mode there is purely =
intended
for troubleshooting purposes and can only be enabled through special mo=
dule
parameter by an adventurous user.

>=20
> Please CC me any replies.
>=20
> Thanks
> =A0 jonathan

Regards,
Alex
