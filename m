From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Thu, 31 Mar 2011 14:17:49 -0500
Message-ID: <AANLkTinQts_R5RaWw=ZkREQaVbAD8A4NxDj0o9+EaBGQ@mail.gmail.com>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
	<m3zkoc2ne4.fsf@pullcord.laptop.org>
	<AANLkTinmVNGpmjLNB31nuBke+LD+jJ8AbwNGp14tH+d2@mail.gmail.com>
	<201103311301.12053.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og112.obsmtp.com ([64.18.0.24]:51236 "EHLO
	exprod5og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620Ab1CaTRy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2011 15:17:54 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2VJGDw8001983
	for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 15:16:14 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2VIlTk3016363
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 15:16:13 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so2970848wyb.15
        for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 12:17:50 -0700 (PDT)
In-Reply-To: <201103311301.12053.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Thu, Mar 31, 2011 at 6:01 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 31 March 2011, Andrei Warkentin wrote:
>> Well, there are less esoteric ways of turning something into a
>> paperweight =). No, the whole point of adding the device partition
>> support is so you don't have to go through hoops to read and write
>> them.
>
> Agreed.
>
>> The scenario where it matters (embedded Linux devices booting through
>> boot partitions) are such, that if you went through sufficient hoops
>> to get root access, and can build and boot a kernel to enable these
>> options for that device, then you must know what you're doing, and a
>> warning message in the Kconfig help is sufficient. The generic case of
>> people sticking cards into a PCI SDHCI controller under Ubuntu is such
>> that you can do no real damage.
>
> One possible way of dealing with this would be to make the boot partition
> a character device instead of a block device. That would still allow
> you to overwrite it, but make it very obvious that you cannot mount or
> partition it.
>
> On the other hand, it would be a rather esoteric interface, since the
> hardware is still fundamentally block based, we just use it in a different
> way.
>

Plus what if you do intend to have a file system there? Other than
complexity and non-obvious usage, I don't see
anything gained by this. I wouldn't worry about ways of misusing this.
As I've said, in the only case it matters (some embedded device
booting from the boot partition), the user would have to gain root
access, build a kernel giving access to the boot partitions and be
able to boot into it. So a warning in Kconfig is sufficient.

If you guys feel concerned, then we can add another Kconfig option
that will allow write access to the boot partitions.

A
