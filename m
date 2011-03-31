From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Thu, 31 Mar 2011 01:57:09 -0500
Message-ID: <AANLkTinmVNGpmjLNB31nuBke+LD+jJ8AbwNGp14tH+d2@mail.gmail.com>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
	<1300828300-8677-2-git-send-email-andreiw@motorola.com>
	<AANLkTinMu57VyaVK3zBpePdJ-Yi=g9zt2833UtbcRpM5@mail.gmail.com>
	<201103301403.20779.arnd@arndb.de>
	<AANLkTimD=vwG-Jh0a4E2tYYYwA9sG5sVWS8BFrDBeThb@mail.gmail.com>
	<m3ipv044c6.fsf@pullcord.laptop.org>
	<m3ei5o446f.fsf@pullcord.laptop.org>
	<AANLkTimDp0yRgf-PLVcmd8Y6wdHJ3GNn-U37CytY3Eov@mail.gmail.com>
	<m3zkoc2ne4.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:60161 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756245Ab1CaG5N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2011 02:57:13 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2V6tY86001773
	for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 02:55:34 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2V6obpx000109
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 02:55:34 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so2326006wwb.3
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2011 23:57:10 -0700 (PDT)
In-Reply-To: <m3zkoc2ne4.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org

On Wed, Mar 30, 2011 at 6:34 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Wed, Mar 30 2011, Andrei Warkentin wrote:
>> The argument against turning it on by default is that someone might
>> figure that mke2fs-ing the boot partitions is a good way to reclaim
>> 4MB on their rooted device,
>> and if they didn't realize the data was necessary for boot-up, they
>> will brick the device.
>
> Ah. =A0Ugh, that sucks; I can totally see that happening. =A0Now I'm
> wondering if we should just be hardcoding boot devices as always
> read-only and just refusing to write to them.
>
> What do others think? =A0Is there an acceptable tradeoff somewhere?
> It's not clear to me that Kconfig entries are sufficient to obtain
> consent to present r/w mounts of the boot partitions; the user
> writing the "dd" line usually isn't the person who made the Kconfig
> selection, and the person who made the Kconfig selection is often a
> distro maintainer who just turns on new Kconfig symbols without
> reading closely.
>

Well, there are less esoteric ways of turning something into a
paperweight =3D). No, the whole point of adding the device partition
support is so you don't have to go through hoops to read and write
them.

The scenario where it matters (embedded Linux devices booting through
boot partitions) are such, that if you went through sufficient hoops
to get root access, and can build and boot a kernel to enable these
options for that device, then you must know what you're doing, and a
warning message in the Kconfig help is sufficient. The generic case of
people sticking cards into a PCI SDHCI controller under Ubuntu is such
that you can do no real damage.

A
