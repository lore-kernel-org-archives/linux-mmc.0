From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v2 1/5] OMAP4-HSMMC: Adding HSMMC support for OMAP4430
	Board file
Date: Thu, 6 May 2010 21:28:40 +0530
Message-ID: <j2n7f9d1ffb1005060858ndb8063ew41725e789365d784@mail.gmail.com>
References: <35156.10.24.255.17.1272988883.squirrel@dbdmail.itg.ti.com>
	 <4BE14945.5040300@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63143 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab0EFP6l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2010 11:58:41 -0400
In-Reply-To: <4BE14945.5040300@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "madhu.cr@ti.com" <madhu.cr@ti.com>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "paul@pwsan.com" <paul@pwsan.com>

<<snip>>
>
> Can do this instead I think:
>
> static struct regulator_consumer_supply sdp4430_vmmc_supply[] =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.supply =A0 =A0 =A0 =A0 =3D "vmmc",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.dev_name =A0 =A0 =A0 =3D "mmci-omap-h=
s.0",
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.supply =A0 =A0 =A0 =A0 =3D "vmmc",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.dev_name =A0 =A0 =A0 =3D "mmci-omap-h=
s.1",
> =A0 =A0 =A0 =A0},
> };
>

Agree , will make changes in next version
