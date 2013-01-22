From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into
 the driver
Date: Tue, 22 Jan 2013 10:20:10 +0000
Message-ID: <20130122102010.GL6857@gmail.com>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
 <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
 <20130122090000.GH6857@gmail.com>
 <CACRpkdatTagYaMqvpe-a8zj_kO3Twjn1r4SqPty8DosNmcxJcQ@mail.gmail.com>
 <20130122100607.GH23505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:37006 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577Ab3AVKUQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jan 2013 05:20:16 -0500
Received: by mail-bk0-f48.google.com with SMTP id jk14so1011084bkc.7
        for <linux-mmc@vger.kernel.org>; Tue, 22 Jan 2013 02:20:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130122100607.GH23505@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, 22 Jan 2013, Russell King - ARM Linux wrote:

> On Tue, Jan 22, 2013 at 10:53:42AM +0100, Linus Walleij wrote:
> > On Tue, Jan 22, 2013 at 10:00 AM, Lee Jones <lee.jones@linaro.org> =
wrote:
> >=20
> > >> From: Lee Jones <lee.jones@linaro.org>
> > >>
> > >> There are currently two instances of the ios_handler being used.
> > >> Both of which mearly toy with some regulator settings. Now there
> > >> is a GPIO regulator API, we can use that instead, and lessen the
> > >> per platform burden. By doing this, we also become more Device
> > >> Tree compatible.
> > >
> > > Russell,
> > >
> > > Why is this patch in your tree with Ulf as the Author?
> >=20
> > This is because of the way Russell's patch tracker works, it sets
> > Author: to the name of the person using the patch tracker and
> > discards the From: field in the beginning of the patch which
> > git am will conversely respect.
>=20
> Actually, the reverse.  It does now respect the From: line, but the
> From: line will be ignored for all notifications about the patch
> because the patch system was never built to parse the actual comments
> when sending out the email notifications.

So what do I have to do to reaffirm myself as the author?

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
