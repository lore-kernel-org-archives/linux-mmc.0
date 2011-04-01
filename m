From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Fri, 1 Apr 2011 11:21:50 +0200
Message-ID: <201104011121.50509.arnd@arndb.de>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com> <201103311301.12053.arnd@arndb.de> <AANLkTinQts_R5RaWw=ZkREQaVbAD8A4NxDj0o9+EaBGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61226 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221Ab1DAJVx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2011 05:21:53 -0400
In-Reply-To: <AANLkTinQts_R5RaWw=ZkREQaVbAD8A4NxDj0o9+EaBGQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Thursday 31 March 2011, Andrei Warkentin wrote:
> Plus what if you do intend to have a file system there? Other than
> complexity and non-obvious usage, I don't see
> anything gained by this. I wouldn't worry about ways of misusing this.
> As I've said, in the only case it matters (some embedded device
> booting from the boot partition), the user would have to gain root
> access, build a kernel giving access to the boot partitions and be
> able to boot into it.

The character device (or sysfs_bin_file actually) would only make
sense if we know that there is no reason to put a file system on it.
The idea of that is that we intentionally treat it like a firmware
flash, not like a block device because that is how it's used.

If there is a reasonable chance that people actually want to have
a file system in the boot partition, it should by all means be 
a block device.

	Arnd
