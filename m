From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [patchv3 2/5] MMC: Use CMD23 for multiblock transfers when we can.
Date: Tue, 19 Apr 2011 10:18:33 -0500
Message-ID: <BANLkTi=7tt1Xb_1w9OY647YnOK-ufqhcRg@mail.gmail.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
	<201104171923.31039.arnd@arndb.de>
	<BANLkTimErvCyAOVW=DgHvRqDZg9EF9QKeg@mail.gmail.com>
	<201104190939.19905.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og112.obsmtp.com ([64.18.0.24]:52214 "EHLO
	exprod5og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab1DSPSf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 11:18:35 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3JFGe3C021522
	for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2011 11:16:40 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3JFDsrP019963
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2011 11:16:39 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so8277233wyb.15
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2011 08:18:33 -0700 (PDT)
In-Reply-To: <201104190939.19905.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org

On Tue, Apr 19, 2011 at 2:39 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 19 April 2011, Andrei Warkentin wrote:
>
>> So maybe this should be a blacklist for known bad cards. And the
>> entire support should be a "default-N" compile option for MMCs (not
>> SDs). That way someone who just does an "make oldconfig" will see
>> "CONFIG_MMC_BLK_CMD23 - I/O performance improvement for newer eMMC
>> cards, may cause degradation on older cards". What do you think?
>
> I'm not sure if I understand the distinction between MMC and SD
> here. Do you suggest we always enable it for SD but make it compile-time
> selected for MMC?

I did, because CMD23 support on SDs is a new feature mandatory on
UHS104 cards. However, I guess no matter
what you do, it's going to break something.  Right now I'm only aware
of Toshiba perf regressions.

>
> I generally argue against compile time options. A distribution
> integrator needs to choose a reasonable default, and giving them
> an option makes it possible to get it wrong.
>
> I believe the best way would be trying to warn people against
> regressions while going forward with this enabled unconditionally,
> unless we hear back from people that actually got regressions.

Alright. Then I'll just blacklist the known-affected Toshiba cards for
now, and we'll keep it enabled by default.

>
> We could perhaps key enabling the feature by the production date
> on the card, so it only gets turned on for new cards.
>

Unfortunately, date by itself is meaningless too (current Toshiba eMMCs)

A
