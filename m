From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [[v4] 5/5] MMC: SDHCI AutoCMD23 support.
Date: Wed, 27 Apr 2011 01:05:41 -0500
Message-ID: <BANLkTikxOMeM9nxo0cbB0HAWSME8Ttq=HQ@mail.gmail.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-2-git-send-email-andreiw@motorola.com>
	<1303870235-29041-3-git-send-email-andreiw@motorola.com>
	<1303870235-29041-4-git-send-email-andreiw@motorola.com>
	<1303870235-29041-5-git-send-email-andreiw@motorola.com>
	<1303870235-29041-6-git-send-email-andreiw@motorola.com>
	<6C03668EAF45B747AF947A1603D1B300EB81997F@SAUSEXMBP01.amd.com>
	<BANLkTim3v7DJZfZpZrZDnomiXTDx7WfWtA@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB81998D@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:47631 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab1D0GFo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2011 02:05:44 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3R63g4W003975
	for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2011 02:03:42 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3R61F5j003137
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2011 02:03:42 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so1320461wyb.15
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 23:05:42 -0700 (PDT)
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300EB81998D@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "arnd@arndb.de" <arnd@arndb.de>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>

On Wed, Apr 27, 2011 at 1:02 AM, Nath, Arindam <Arindam.Nath@amd.com> wrote:
> Guess I will have to hand modify my code based on your V4 patches again, I don't think your patches are based on top of mine.
>
> Thanks,
> Arindam
>

Just verify these blobs look similar -

+               else if (host->mrq->sbc &&
+                        host->flags & SDHCI_ACMD23) {
+                       mode |= SDHCI_TRNS_ACMD23;
+                       sdhci_writel(host, host->mrq->sbc->arg,
SDHCI_ARGUMENT2);
+               }

and

               host->flags |= SDHCI_ACMD12;

+       /* Auto-CMD23 stuff only works in ADMA or PIO. */
+       if ((host->version == SDHCI_SPEC_300) &&
+           ((host->flags & SDHCI_USE_ADMA) ||
+            !(host->flags & SDHCI_REQ_USE_DMA))) {
+               host->flags |= SDHCI_ACMD23;
+               printk(KERN_INFO "%s: Auto-CMD23 available\n",
mmc_hostname(mmc));
+       } else
+               printk(KERN_INFO "%s: Auto-CMD23 unavailable\n",
mmc_hostname(mmc));
+
       /*
        * A controller may support 8-bit width, but the board itself
        * might not have the pins brought out.  Boards that support

I apologize for the fuss.

A
