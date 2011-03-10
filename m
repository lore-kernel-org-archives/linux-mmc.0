From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: Block quirks redux + Toshiba performance quirk
Date: Wed, 9 Mar 2011 18:12:30 -0600
Message-ID: <AANLkTi=fqxXYe5aea9d5P2eKNrE-4gcv+bdCveDh1Aom@mail.gmail.com>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og106.obsmtp.com ([64.18.0.182]:41589 "EHLO
	exprod5og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab1CJAMc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 19:12:32 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2A0BBP2017533
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:11:11 -0500 (EST)
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com [209.85.212.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2A0ANku017341
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:11:11 -0500 (EST)
Received: by mail-vw0-f42.google.com with SMTP id 10so1344304vws.15
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 16:12:30 -0800 (PST)
In-Reply-To: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: tardyp@gmail.com, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>

On Wed, Mar 9, 2011 at 6:54 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> I'm sending this as a new mail instead of a reply-to, because it's really a
> different set of patches. I'm holding off on the reliability improvement, because
> the generic-code equiv. depends on reliable write support, so I'll wait until everybody
> is satisfied with these changes until sending those in.
>
> This is based on linux-next tree with Pierre's quirks.c.
>
> I've tested it on K36 with backported Pierre's changes.
>
> Thanks,
> A
>
>

Oops, forgot to add CCs... sorry about that.

A
