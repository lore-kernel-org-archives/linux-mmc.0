From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Fri, 1 Apr 2011 21:25:48 +0200
Message-ID: <201104012125.49155.arnd@arndb.de>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com> <201104011238.02551.arnd@arndb.de> <AANLkTimHGAWvXgPaTEzi4taYcHwrwNhyGa1heZ8QN82R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:65153 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab1DATZ5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2011 15:25:57 -0400
In-Reply-To: <AANLkTimHGAWvXgPaTEzi4taYcHwrwNhyGa1heZ8QN82R@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

On Friday 01 April 2011 20:42:36 Andrei Warkentin wrote:
> Right now they are exposed as separate devices. This lets the user
> pick whatever usage they
> see fit (can format it directly, or can partition it), while the
> naming (mmcblk0boot0, mmcblk0boot1, mmcblkgp0p1 for first partition on
> gp0, for example) conveys that the entries are for device partitions.

Ok, sounds good. How do they show up in sysfs then? I think ideally
a gp device should be a child of the regular device, just like a partition,
and then it can have further children. That way, a user application can
easily find out which ones belong together.

	Arnd
