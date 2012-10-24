From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] mmc: Standardise capability type
Date: Wed, 24 Oct 2012 15:53:08 +0100
Message-ID: <20121024145308.GE3537@gmail.com>
References: <1351084664-30526-1-git-send-email-lee.jones@linaro.org>
 <201210241321.26878.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50533 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934915Ab2JXOxO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Oct 2012 10:53:14 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so299509bkc.19
        for <linux-mmc@vger.kernel.org>; Wed, 24 Oct 2012 07:53:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201210241321.26878.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@stericsson.com, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Wed, 24 Oct 2012, Arnd Bergmann wrote:

> On Wednesday 24 October 2012, Lee Jones wrote:
> >=20
> > There are discrepancies with regards to how MMC capabilities
> > are carried throughout the subsystem. Let's standardise them
> > to elevate any confusion.
> >=20
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: linux-mmc@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>=20
> Why make it "unsigned long" then? I think that adds to the
> confusion because it's sometimes 32 bits and sometimes 64 bits,
> depending on the CPU. Since it's a bitmask, I would suggest
> using u32 to make the size explicit.

I'm not sure that it leaves any confusion. It perhaps wastes a little
space on 64bit architectures, but that also applies to a great deal
of other bitmasks floating around.

I can do it if you feel that passionate about it, but it's a bigger
job to hunt down all occurrences and change them over. I only felt
strongly enough about it to craft this patch because I noticed the
inconsistency as I created new populate caps for OF functionality.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
