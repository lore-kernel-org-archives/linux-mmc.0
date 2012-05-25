From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 0/3] mmc:sd hotplug fixes for omap
Date: Fri, 25 May 2012 12:50:50 +0530
Message-ID: <CANfBPZ9mUwQw6z0zPpgb=zve4Fd7tTsTeZzDiZxDSDsL5Y5vJg@mail.gmail.com>
References: <1337890467-32573-1-git-send-email-vishp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:58416 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753410Ab2EYHVN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 May 2012 03:21:13 -0400
Received: by bkcjm19 with SMTP id jm19so565472bkc.0
        for <linux-mmc@vger.kernel.org>; Fri, 25 May 2012 00:21:10 -0700 (PDT)
In-Reply-To: <1337890467-32573-1-git-send-email-vishp@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viswanath Puttagunta <vishp@ti.com>
Cc: Linux-mmc <linux-mmc@vger.kernel.org>, T Krishnamoorthy Balaji <balajitk@ti.com>, Semen Protsenko <semen.protsenko@ti.com>, Volodymyr Riazantsev <v.riazantsev@ti.com>

On Fri, May 25, 2012 at 1:44 AM, Viswanath Puttagunta <vishp@ti.com> wr=
ote:
> This patch set has fixes for SD card hotplug for OMAP SOCs.
>
> Viswanath Puttagunta (3):
> =A0mmc: omap_hsmmc: Errata i705: SD hot unplug
> =A0mmc: omap_hsmmc: Errata: Fix SD card removal detection
> =A0mfd: Enable Debounce logic for SD hotplug detection

Please copy linux-omap@vger.kernel.org as well, for these patches.
>
> =A0drivers/mfd/twl6030-irq.c =A0 =A0 | =A0 =A08 ++++++++
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 41 +++++++++++++++++++++++++++=
+++++++++++---
> =A0include/linux/i2c/twl.h =A0 =A0 =A0 | =A0 =A05 +++++
> =A03 files changed, 51 insertions(+), 3 deletions(-)
>
> --
> 1.7.4.1
>
