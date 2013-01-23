From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into
 the driver
Date: Wed, 23 Jan 2013 11:18:05 +0000
Message-ID: <20130123111805.GI15873@gmail.com>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
 <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
 <20130122090000.GH6857@gmail.com>
 <CACRpkdatTagYaMqvpe-a8zj_kO3Twjn1r4SqPty8DosNmcxJcQ@mail.gmail.com>
 <20130122100607.GH23505@n2100.arm.linux.org.uk>
 <20130122102010.GL6857@gmail.com>
 <20130122103723.GI23505@n2100.arm.linux.org.uk>
 <20130122105608.GP6857@gmail.com>
 <20130123101349.GH15873@gmail.com>
 <20130123101748.GO23505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:35576 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737Ab3AWLSJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Jan 2013 06:18:09 -0500
Received: by mail-bk0-f45.google.com with SMTP id i18so644573bkv.4
        for <linux-mmc@vger.kernel.org>; Wed, 23 Jan 2013 03:18:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130123101748.GO23505@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, 23 Jan 2013, Russell King - ARM Linux wrote:

> On Wed, Jan 23, 2013 at 10:13:49AM +0000, Lee Jones wrote:
> > On Tue, 22 Jan 2013, Lee Jones wrote:
> > > Are you saying that you won't do it? :)
> > >=20
> > > Is there anything I can do to make the process easier?
> >=20
> > Thinking about this a little more. Is it easier to remove it from y=
our
> > tree altogether? Only I have a small "ARM: ux500: " patch-set which
> > directly relies on this patch. I could take it in via ARM-SoC witho=
ut
> > any fear of ordering issues.
>=20
> Thankfully, the patch doesn't conflict with any of the others I have,=
 so
> we can do that (and it's actually easier to do that.)
>=20
> Done.

Brilliant, that's 2 birds with one stone. I'll queue it up for ARM-SoC.

Thanks Russell.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
