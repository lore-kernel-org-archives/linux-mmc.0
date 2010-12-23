From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/2] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Thu, 23 Dec 2010 10:27:29 -0800
Message-ID: <AANLkTinpfKrLoZEr4RkiLJvNNHKavKCY4VBaJn+eGCv_@mail.gmail.com>
References: <1293096475-19634-1-git-send-email-olof@lixom.net>
	<1293096828-19985-1-git-send-email-olof@lixom.net>
	<20101223112346.GA5044@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64627 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460Ab0LWS1a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Dec 2010 13:27:30 -0500
In-Reply-To: <20101223112346.GA5044@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, Mike Rapoport <mike@compulab.co.il>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>

On Thu, Dec 23, 2010 at 3:23 AM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
>
>> Changes since v2:
>> =A0 =A0 =A0 * Whitespace fixes
>> =A0 =A0 =A0 * Changed order of test in get_ro
>
> What benefit has the reordering? (And just to make sure: You still
> return -1 meaning "read-only". I assume this is intentional)\

Uh, thanks for the vague feedback last time. I thought that's what
your concern with it was.

But yeah, defaulting to RW makes more sense. v4 coming once I know if
you want me to rip out the new quirk or not.


-Olof
