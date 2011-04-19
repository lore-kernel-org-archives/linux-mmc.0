From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [patchv3 5/5] MMC: SDHCI AutoCMD23 support.
Date: Mon, 18 Apr 2011 22:05:58 -0500
Message-ID: <BANLkTimDhyQPOubC72xPc9FPHO2fooC9ag@mail.gmail.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
	<1302950458-1969-6-git-send-email-andreiw@motorola.com>
	<201104171925.10929.arnd@arndb.de>
	<BANLkTi=C=d=OLdKek9T4zpj4Z2dxH9MjqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og115.obsmtp.com ([64.18.0.246]:39990 "EHLO
	exprod5og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273Ab1DSDGC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2011 23:06:02 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3J347Qr008335
	for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2011 23:04:07 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3J346PO008324
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2011 23:04:06 -0400 (EDT)
Received: by wyb34 with SMTP id 34so7606003wyb.15
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2011 20:05:58 -0700 (PDT)
In-Reply-To: <BANLkTi=C=d=OLdKek9T4zpj4Z2dxH9MjqA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: arindam.nath@amd.com
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, subhashj@codeaurora.org, Arnd Bergmann <arnd@arndb.de>

Arindam,

On Sun, Apr 17, 2011 at 2:31 PM, Andrei Warkentin <andreiw@motorola.com=
> wrote:
> Hi Arnd,
>
> On Sun, Apr 17, 2011 at 12:25 PM, Arnd Bergmann <arnd@arndb.de> wrote=
:
>> On Saturday 16 April 2011, Andrei Warkentin wrote:
>>> @@ -68,6 +68,15 @@ config MMC_SDHCI_PCI
>>>
>>> =A0 =A0 =A0 =A0 =A0 If unsure, say N.
>>>
>>> +config MMC_SDHCI_AUTO_CMD23
>>> + =A0 =A0 =A0 tristate "SDHCI 3.0 Auto-CMD23 support (EXPERIMENTAL)=
"
>>> + =A0 =A0 =A0 depends on MMC_SDHCI && EXPERIMENTAL
>>> + =A0 =A0 =A0 help
>>> + =A0 =A0 =A0 =A0 This enables the Auto-CMD23 optimization for mult=
iblock
>>> + =A0 =A0 =A0 =A0 transfers where a CMD23 would be sent
>>> +
>>> + =A0 =A0 =A0 =A0 If unsure, say N.
>>> +
>>> =A0config MMC_RICOH_MMC
>>> =A0 =A0 =A0 =A0 bool "Ricoh MMC Controller Disabler =A0(EXPERIMENTA=
L)"
>>> =A0 =A0 =A0 =A0 depends on MMC_SDHCI_PCI
>>
>> Does this need to be a Konfig option? We are already asking too many
>> questions here IMHO.
>
> Sorry, I should have clarified - I made this an experimental option
> because I couldn't vouch for the correct functionality (no SDHCI 3.0
> hardware around me) and I posted it only because Arindam wanted to tr=
y
> it out and see if it worked alright. As soon as we're clear it works
> fine I'll take the Kconfig out.
>
> A
>

Any update? Have you tried this out?

Thanks,
A
