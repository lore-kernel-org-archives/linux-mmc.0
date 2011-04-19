From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [patchv3 5/5] MMC: SDHCI AutoCMD23 support.
Date: Mon, 18 Apr 2011 22:32:52 -0500
Message-ID: <BANLkTimzRM1hD+FUsNjzdu5gWf59ckkbjA@mail.gmail.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
	<1302950458-1969-6-git-send-email-andreiw@motorola.com>
	<201104171925.10929.arnd@arndb.de>
	<BANLkTi=C=d=OLdKek9T4zpj4Z2dxH9MjqA@mail.gmail.com>
	<BANLkTimDhyQPOubC72xPc9FPHO2fooC9ag@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB504989@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og112.obsmtp.com ([64.18.0.24]:46784 "EHLO
	exprod5og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402Ab1DSDcz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2011 23:32:55 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3J3XIDK019735
	for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2011 23:33:18 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3J3WLLn019469
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2011 23:33:18 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so6049999wwb.3
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2011 20:32:53 -0700 (PDT)
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300EB504989@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>

On Mon, Apr 18, 2011 at 10:19 PM, Nath, Arindam <Arindam.Nath@amd.com> =
wrote:
> Hi Andrei,
>
>
>> -----Original Message-----
>> From: Andrei Warkentin [mailto:andreiw@motorola.com]
>> Sent: Tuesday, April 19, 2011 8:36 AM
>> To: Nath, Arindam
>> Cc: linux-mmc@vger.kernel.org; cjb@laptop.org; subhashj@codeaurora.o=
rg;
>> Arnd Bergmann
>> Subject: Re: [patchv3 5/5] MMC: SDHCI AutoCMD23 support.
>>
>> Arindam,
>>
>> On Sun, Apr 17, 2011 at 2:31 PM, Andrei Warkentin
>> <andreiw@motorola.com> wrote:
>> > Hi Arnd,
>> >
>> > On Sun, Apr 17, 2011 at 12:25 PM, Arnd Bergmann <arnd@arndb.de>
>> wrote:
>> >> On Saturday 16 April 2011, Andrei Warkentin wrote:
>> >>> @@ -68,6 +68,15 @@ config MMC_SDHCI_PCI
>> >>>
>> >>> =A0 =A0 =A0 =A0 =A0 If unsure, say N.
>> >>>
>> >>> +config MMC_SDHCI_AUTO_CMD23
>> >>> + =A0 =A0 =A0 tristate "SDHCI 3.0 Auto-CMD23 support (EXPERIMENT=
AL)"
>> >>> + =A0 =A0 =A0 depends on MMC_SDHCI && EXPERIMENTAL
>> >>> + =A0 =A0 =A0 help
>> >>> + =A0 =A0 =A0 =A0 This enables the Auto-CMD23 optimization for m=
ultiblock
>> >>> + =A0 =A0 =A0 =A0 transfers where a CMD23 would be sent
>> >>> +
>> >>> + =A0 =A0 =A0 =A0 If unsure, say N.
>> >>> +
>> >>> =A0config MMC_RICOH_MMC
>> >>> =A0 =A0 =A0 =A0 bool "Ricoh MMC Controller Disabler =A0(EXPERIME=
NTAL)"
>> >>> =A0 =A0 =A0 =A0 depends on MMC_SDHCI_PCI
>> >>
>> >> Does this need to be a Konfig option? We are already asking too m=
any
>> >> questions here IMHO.
>> >
>> > Sorry, I should have clarified - I made this an experimental optio=
n
>> > because I couldn't vouch for the correct functionality (no SDHCI 3=
=2E0
>> > hardware around me) and I posted it only because Arindam wanted to
>> try
>> > it out and see if it worked alright. As soon as we're clear it wor=
ks
>> > fine I'll take the Kconfig out.
>> >
>> > A
>> >
>>
>> Any update? Have you tried this out?
>
> I am planning to re-submit V3 patches sometime today or tomorrow. Onl=
y after that I will apply your patches on top of mine, and test it out.=
 Please give me some time, I will try to get back to you ASAP.

Alright, thanks, looking forward to your results.

Thanks,
A
