From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Fri, 1 Apr 2011 14:42:25 -0500
Message-ID: <AANLkTik8pdawawB-7X2DkAemkGec4qVKsrZ4W8M1_Syt@mail.gmail.com>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
	<201104011238.02551.arnd@arndb.de>
	<AANLkTimHGAWvXgPaTEzi4taYcHwrwNhyGa1heZ8QN82R@mail.gmail.com>
	<201104012125.49155.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:53637 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547Ab1DATm1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2011 15:42:27 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p31JelE8016060
	for <linux-mmc@vger.kernel.org>; Fri, 1 Apr 2011 15:40:47 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p31JVPgk009887
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 1 Apr 2011 15:40:47 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so4290892wwb.3
        for <linux-mmc@vger.kernel.org>; Fri, 01 Apr 2011 12:42:25 -0700 (PDT)
In-Reply-To: <201104012125.49155.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

On Fri, Apr 1, 2011 at 2:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 01 April 2011 20:42:36 Andrei Warkentin wrote:
>> Right now they are exposed as separate devices. This lets the user
>> pick whatever usage they
>> see fit (can format it directly, or can partition it), while the
>> naming (mmcblk0boot0, mmcblk0boot1, mmcblkgp0p1 for first partition on
>> gp0, for example) conveys that the entries are for device partitions.
>
> Ok, sounds good. How do they show up in sysfs then? I think ideally
> a gp device should be a child of the regular device, just like a partition,
> and then it can have further children. That way, a user application can
> easily find out which ones belong together.

Right now, it shows up on the same level as mmcblk0, but I'll fix that
(this is why I wanted the first portion to contain actual device name,
e.g. mmcblk0boot0, but you're right, I should fix the inheritance)

A
