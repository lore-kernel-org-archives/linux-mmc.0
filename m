From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [patchv3 4/4] MMC: MMC boot partitions support.
Date: Mon, 11 Apr 2011 18:24:16 -0500
Message-ID: <BANLkTinEXMxEC2if9CkmvVR1SV_g+ug-GA@mail.gmail.com>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
	<1302556424-21951-4-git-send-email-andreiw@motorola.com>
	<m3oc4c8n3b.fsf@pullcord.laptop.org>
	<BANLkTimAFUnodvc2yBs-Bj=DnSpmZN7BwA@mail.gmail.com>
	<m3ei588m3t.fsf@pullcord.laptop.org>
	<BANLkTinHodYLMMA0=JJ1z_kX8jQm1P=akA@mail.gmail.com>
	<m34o648jeo.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:33839 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424Ab1DKXYT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 19:24:19 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3BNMVpP024633
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 19:22:31 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3BNMTfc024623
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 19:22:30 -0400 (EDT)
Received: by wyb34 with SMTP id 34so8606547wyb.15
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 16:24:16 -0700 (PDT)
In-Reply-To: <m34o648jeo.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, arnd@arndb.de

On Mon, Apr 11, 2011 at 6:20 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Andrei,
>
> On Mon, Apr 11 2011, Andrei Warkentin wrote:
>> Ok, great! Will do.
>
> Great, thanks. =A0I've just merged:
>
> mmc: quirks: Extends card quirks with MMC/SD quirks matching the CID.
> [patchv3 1/4] MMC: Rename erase_timeout to cmd_timeout_ms.
> [patchv3 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERASE.
> [patchv3 3/4] MMC: Allow setting CMD timeout for CMD6 (SWITCH).
> [patchv4 1/2] MMC: block.c cleanup for host claim/release.
> [patchv4 2/2] MMC: MMC boot partitions support.
> [PATCH 1/2] MMC: Support for block quirks.
> =A0^ this had a merge conflict with the partitions patch, easily reso=
lved.
> [PATCH 2/2] MMC: Fix erase/trim for certain SanDisk cards.
>
> in that order, and will push out to mmc-next for .40 after a little
> testing. =A0Let me know if anything's been missed or applied in the w=
rong
> order there.

Should be alright.

Thanks,
A
