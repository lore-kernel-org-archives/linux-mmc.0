From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v10] mmc : general purpose partition support.
Date: Tue, 04 Oct 2011 14:25:46 -0400
Message-ID: <m2y5x0k40l.fsf@bob.laptop.org>
References: <1317750317-4489-1-git-send-email-linkinjeon@gmail.com>
	<CANfBPZ_aet5iF2zQ6zaqX0cjVB4LUnq6wLcHh2t_WNst3zXKAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57904 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932752Ab1JDS0F (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Oct 2011 14:26:05 -0400
In-Reply-To: <CANfBPZ_aet5iF2zQ6zaqX0cjVB4LUnq6wLcHh2t_WNst3zXKAA@mail.gmail.com>
	(Venkatraman S.'s message of "Tue, 4 Oct 2011 23:49:13 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Namjae Jeon <linkinjeon@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, awarkentin@vmware.com, adrian.hunter@intel.com, linus.walleij@linaro.org, james_p_freyensee@linux.intel.com, sebras@gmail.com, Ulf.Hansson@stericsson.com, stefan.xk.nilsson@stericsson.com, per.forlin@stericsson.com, johan.rudholm@stericsson.com

Hi,

On Tue, Oct 04 2011, S, Venkatraman wrote:
> Stupid question - This will affect all MMC instances, right ? Doesn't
> this constitute a ABI breakage for user space scripts ?

As I understand it, these partitions were simply not accessible before
this patch:  we're not renaming mmcblkNpY to anything else, we're adding
support for mmcblkNgpY partitions, which are part of the "MMC General
Purpose Partition" spec, and are partitioned separately and not
currently available to userspace.

So, I don't see what would constitute breakage.  Does that clear it up?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
