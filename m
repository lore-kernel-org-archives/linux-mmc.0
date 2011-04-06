From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: Dynamic MMC device naming vs. bootloaders
Date: Wed, 6 Apr 2011 12:18:40 -0500
Message-ID: <BANLkTik8fti=o1+NRCUALFGYMiFzbRy+Jg@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0493EB33AE@HQMAIL01.nvidia.com>
	<BANLkTik7fbz+QLZY8RH9wCkGQdU3hUNfNA@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0493EB3599@HQMAIL01.nvidia.com>
	<BANLkTimDbPkgHDuERqJ-qRe9Ji2RyzAvXA@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0493EB36C7@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og103.obsmtp.com ([64.18.0.145]:55822 "EHLO
	exprod5og103.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954Ab1DFRSm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2011 13:18:42 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p36HGvPP003478
	for <linux-mmc@vger.kernel.org>; Wed, 6 Apr 2011 13:16:57 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p36GSlnc005996
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 6 Apr 2011 13:16:57 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so2206847wyb.15
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2011 10:18:40 -0700 (PDT)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0493EB36C7@HQMAIL01.nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Kishore Kadiyala <kishorek.kadiyala@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Apr 6, 2011 at 11:59 AM, Stephen Warren <swarren@nvidia.com> wrote:
>
> Ah. I do see now that Tegra's equivalent platform_device registration order was
> changed between the two kernels that exhibit different behavior, so re-ordering
> might work. I'll try it out.
>
> However, isn't it just a fluke that this will work; registering the internal
> host controller first will I assume start probing of any attached devices on
> that controller first, but does it actually guarantee that such probing will
> also complete first, which I believe is the necessary condition for the mmcblk
> device to be assigned ID 0?
>

The device index is only assigned if the mmc block driver is started
on a detected card. This means that
if you remove a card from host 0, then card on host 1 will be detected
first. I would guess most platform code assigns an emmc/esd-containing
host as first to add.
Being first to add implies being first to resume so the ordering
should stick across PM states (and safe MMC resume)

> Equally, if there were two controllers with fixed/internal MMC and/or two
> controllers which supported pluggable SD cards, the race issue would still
> exist?

I think if you had two controllers and you plugged two cards in at the
"same time", then you would have  a race condition, as both would
mmc_detect_change (effectively schedule_work to an ordered wq), and it
would depend on which card change IRQ occured first. It seems like
different hosts use different delays for when the work will be done,
so if you have different hosts, you can make this even more obvious.
You'd have to really try, though, I think. I guess if you are never
going to support multiple cards on one host, you might as well tie the
block index to host index.

A
