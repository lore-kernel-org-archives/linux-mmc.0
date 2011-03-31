From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Thu, 31 Mar 2011 16:03:57 -0400
Message-ID: <m3bp0rukeq.fsf@pullcord.laptop.org>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
	<m3zkoc2ne4.fsf@pullcord.laptop.org>
	<AANLkTinmVNGpmjLNB31nuBke+LD+jJ8AbwNGp14tH+d2@mail.gmail.com>
	<201103311301.12053.arnd@arndb.de>
	<AANLkTinQts_R5RaWw=ZkREQaVbAD8A4NxDj0o9+EaBGQ@mail.gmail.com>
	<m3fwq3ulnj.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43573 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759298Ab1CaT6H (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 31 Mar 2011 15:58:07 -0400
In-Reply-To: <m3fwq3ulnj.fsf@pullcord.laptop.org> (Chris Ball's message of
	"Thu, 31 Mar 2011 15:37:04 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org

Hi,

On Thu, Mar 31 2011, Chris Ball wrote:
> But I'm still concerned after your Kconfig options are added, because
> I'm just not reassured by Kconfig options in principle, because of the
> case where *the person who built the kernel* is not the same as the
> *user who is running commands*.  Imagine that CyanogenMod (or even
> Qualcomm!) distributes a kernel with this Kconfig option turned on --
> because they don't realize how dangerous it is, perhaps, or because they
> had a use for it during development -- to see where I'm coming from.

Another strawman, after brainstorming a bit on IRC -- how about
the block device itself comes up read-only, until you use a module
parameter/sysfs entry to make it read-write.  As a strawman:

echo 1 > /sys/module/mmc_block/boot_partitions_are_writeable

(That way people who write to it regularly can throw the module parameter
in their boot environment, and the rooting enthusiasts who didn't compile
the kernel are safe until they learn enough to be really dangerous..)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
