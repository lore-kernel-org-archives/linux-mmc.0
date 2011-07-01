From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] OMAP: HSMMC maintainence
Date: Fri, 1 Jul 2011 09:59:02 +0530
Message-ID: <BANLkTimZMBUbtGcWo851FTFeJ+Qs-dfGfQ@mail.gmail.com>
References: <1309468046-17904-1-git-send-email-m-sonasath@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:55708 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750709Ab1GAE3F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Jul 2011 00:29:05 -0400
In-Reply-To: <1309468046-17904-1-git-send-email-m-sonasath@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, cjb <cjb@laptop.org>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Jul 1, 2011 at 2:37 AM,  <Chikkature@lina0132712> wrote:
> From: Madhusudhan Chikkature <madhu.cr@ti.com>
>
> Removing the OMAP HS MMC entry from the MAINTAINERS file as I will
> no longer be able to maintain this driver.
>
> Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> ---
> =A0MAINTAINERS | =A0 =A06 ------
> =A01 files changed, 0 insertions(+), 6 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0094224..96061d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4306,12 +4306,6 @@ L: =A0 =A0 =A0 linux-omap@vger.kernel.org
> =A0S: =A0 =A0 Maintained
> =A0F: =A0 =A0 drivers/mmc/host/omap.c
>
> -OMAP HS MMC SUPPORT
> -M: =A0 =A0 Madhusudhan Chikkature <madhu.cr@ti.com>
> -L: =A0 =A0 linux-omap@vger.kernel.org
> -S: =A0 =A0 Maintained
> -F: =A0 =A0 drivers/mmc/host/omap_hsmmc.c
> -
> =A0OMAP RANDOM NUMBER GENERATOR SUPPORT
> =A0M: =A0 =A0 Deepak Saxena <dsaxena@plexity.net>
> =A0S: =A0 =A0 Maintained
> --
> 1.7.0.4
>

Hi Madhu,
 Thanks to your hard work and maintenance of OMAP MMC & good luck to
whatever you plan to do after this!!
=46or this patch, NAK :-)
It would be better to just change the status to 'Orphaned' than
deleting the entire section.
I hope that someone will step up to maintain it shortly..

Best regards,
Venkat.
