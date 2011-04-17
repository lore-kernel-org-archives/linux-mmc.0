From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [patchv3 5/5] MMC: SDHCI AutoCMD23 support.
Date: Sun, 17 Apr 2011 14:31:13 -0500
Message-ID: <BANLkTi=C=d=OLdKek9T4zpj4Z2dxH9MjqA@mail.gmail.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
	<1302950458-1969-6-git-send-email-andreiw@motorola.com>
	<201104171925.10929.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:46359 "EHLO
	exprod5og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab1DQTbQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Apr 2011 15:31:16 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3HJTNd6022782
	for <linux-mmc@vger.kernel.org>; Sun, 17 Apr 2011 15:29:23 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3HJTLi2022772
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sun, 17 Apr 2011 15:29:22 -0400 (EDT)
Received: by wwb28 with SMTP id 28so4554699wwb.3
        for <linux-mmc@vger.kernel.org>; Sun, 17 Apr 2011 12:31:13 -0700 (PDT)
In-Reply-To: <201104171925.10929.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org, subhashj@codeaurora.org

Hi Arnd,

On Sun, Apr 17, 2011 at 12:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 16 April 2011, Andrei Warkentin wrote:
>> @@ -68,6 +68,15 @@ config MMC_SDHCI_PCI
>>
>> =A0 =A0 =A0 =A0 =A0 If unsure, say N.
>>
>> +config MMC_SDHCI_AUTO_CMD23
>> + =A0 =A0 =A0 tristate "SDHCI 3.0 Auto-CMD23 support (EXPERIMENTAL)"
>> + =A0 =A0 =A0 depends on MMC_SDHCI && EXPERIMENTAL
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 This enables the Auto-CMD23 optimization for multi=
block
>> + =A0 =A0 =A0 =A0 transfers where a CMD23 would be sent
>> +
>> + =A0 =A0 =A0 =A0 If unsure, say N.
>> +
>> =A0config MMC_RICOH_MMC
>> =A0 =A0 =A0 =A0 bool "Ricoh MMC Controller Disabler =A0(EXPERIMENTAL=
)"
>> =A0 =A0 =A0 =A0 depends on MMC_SDHCI_PCI
>
> Does this need to be a Konfig option? We are already asking too many
> questions here IMHO.

Sorry, I should have clarified - I made this an experimental option
because I couldn't vouch for the correct functionality (no SDHCI 3.0
hardware around me) and I posted it only because Arindam wanted to try
it out and see if it worked alright. As soon as we're clear it works
fine I'll take the Kconfig out.

A
