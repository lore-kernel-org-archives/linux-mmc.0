From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Thu, 31 Mar 2011 15:37:04 -0400
Message-ID: <m3fwq3ulnj.fsf@pullcord.laptop.org>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
	<m3zkoc2ne4.fsf@pullcord.laptop.org>
	<AANLkTinmVNGpmjLNB31nuBke+LD+jJ8AbwNGp14tH+d2@mail.gmail.com>
	<201103311301.12053.arnd@arndb.de>
	<AANLkTinQts_R5RaWw=ZkREQaVbAD8A4NxDj0o9+EaBGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41777 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759051Ab1CaTbP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 31 Mar 2011 15:31:15 -0400
In-Reply-To: <AANLkTinQts_R5RaWw=ZkREQaVbAD8A4NxDj0o9+EaBGQ@mail.gmail.com>
	(Andrei Warkentin's message of "Thu, 31 Mar 2011 14:17:49 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org

Hi,

On Thu, Mar 31 2011, Andrei Warkentin wrote:
> Plus what if you do intend to have a file system there? Other than
> complexity and non-obvious usage, I don't see
> anything gained by this. I wouldn't worry about ways of misusing this.
> As I've said, in the only case it matters (some embedded device
> booting from the boot partition), the user would have to gain root
> access, build a kernel giving access to the boot partitions and be
> able to boot into it. So a warning in Kconfig is sufficient.
> 
> If you guys feel concerned, then we can add another Kconfig option
> that will allow write access to the boot partitions.

I'm willing to come around to saying that the risk is acceptable, and
that people who overwrite /dev/mmcblk0b0 on their rooted Android phones
won't blame us (at least, not deservedly) for it.

But I'm still concerned after your Kconfig options are added, because
I'm just not reassured by Kconfig options in principle, because of the
case where *the person who built the kernel* is not the same as the
*user who is running commands*.  Imagine that CyanogenMod (or even
Qualcomm!) distributes a kernel with this Kconfig option turned on --
because they don't realize how dangerous it is, perhaps, or because they
had a use for it during development -- to see where I'm coming from.

Now, the presence of block devices that brick machines when overwritten
isn't a new phenomenon, so we've got a fair amount of precedence behind
us if we simply expose what we see and expect that users won't do
something unrecoverable.  But I'm trying to think about if there's
anything we can do to *minimize* that risk, and have people know what's
going on before they do something they shouldn't.  (I think I like Arnd's
suggestion of explicitly having "boot" in the device name rather than
just "b", because that does lend a feeling of "this partition is really
important".)

Does that help clarify my position?  Would be happy to hear any other
suggestions on what the right affordance to shoot for is.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
