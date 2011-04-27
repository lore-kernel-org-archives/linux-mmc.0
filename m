From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [[v4] 5/5] MMC: SDHCI AutoCMD23 support.
Date: Wed, 27 Apr 2011 00:59:55 -0500
Message-ID: <BANLkTim3v7DJZfZpZrZDnomiXTDx7WfWtA@mail.gmail.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-2-git-send-email-andreiw@motorola.com>
	<1303870235-29041-3-git-send-email-andreiw@motorola.com>
	<1303870235-29041-4-git-send-email-andreiw@motorola.com>
	<1303870235-29041-5-git-send-email-andreiw@motorola.com>
	<1303870235-29041-6-git-send-email-andreiw@motorola.com>
	<6C03668EAF45B747AF947A1603D1B300EB81997F@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:32807 "EHLO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab1D0F77 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2011 01:59:59 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3R5vv3m001679
	for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2011 01:57:57 -0400 (EDT)
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3R5vueF001666
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2011 01:57:57 -0400 (EDT)
Received: by wwk4 with SMTP id 4so3172648wwk.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 22:59:56 -0700 (PDT)
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300EB81997F@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "arnd@arndb.de" <arnd@arndb.de>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>

Hi Arindam,

On Wed, Apr 27, 2011 at 12:49 AM, Nath, Arindam <Arindam.Nath@amd.com> wrote:
> Hi Andrei,
>
> Is there any more change to your V4 than the ones we discussed yesterday? I did the mod we discussed, but seems like the driver only sends CMD23 now, not Auto CMD23.
>

Two things V4 does, both of which we discussed yesterday -
1) Make sure the code that set SDHCI_ACMD23 is always run (got rid of
the Kconfig conditional)
2) Make sure value written into ARGUMENT2 comes from sbc struct.

Only (1) should have affected you. (2) would have broken rel. writes.
I put in an info print telling you if you have auto-cmd23 available or
not. If you see CMD23 getting sent, then AutoCMD23 was not detected as
a feature. Weird. SDHCI_ACMD23 is set if
a) Host controller is version 3
b) You're using ADMA or no DMA.

A
