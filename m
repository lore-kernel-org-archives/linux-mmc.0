From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] wait while adding MMC host to ensure root mounts
Date: Sat, 13 Apr 2013 08:52:21 -0400
Message-ID: <8738uubnju.fsf@octavius.laptop.org>
References: <1363223183-3772-1-git-send-email-ynvich@gmail.com>
	<1363224194-7366-1-git-send-email-ynvich@gmail.com>
	<87620jmkoe.fsf@octavius.laptop.org>
	<CAPDyKFp27MUOjhydLXf92vN3cua=XcX4oTJnMGfOJPpBhtwM8Q@mail.gmail.com>
	<87ppylf429.fsf@octavius.laptop.org>
	<1365850153.9806.59.camel@host5.omatika.ru>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40412 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142Ab3DMMw2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 13 Apr 2013 08:52:28 -0400
In-Reply-To: <1365850153.9806.59.camel@host5.omatika.ru> (Sergey Yanovich's
	message of "Sat, 13 Apr 2013 14:49:13 +0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergey Yanovich <ynvich@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Namjae Jeon <linkinjeon@gmail.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Hi,

On Sat, Apr 13 2013, Sergey Yanovich wrote:
> On Wed, 2013-03-27 at 07:57 -0400, Chris Ball wrote:
>> If the delay's significant, I agree with you and will revert this patch.
>
> The patch was reverted. The problem is back. Filed bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=56561
>
> A possible solution is to make card a separate device (now only the host
> is a device). In this case, the probing could be done asynchronously
> without breaking the assumption in prepare_namespace().
>
> Chris, could you comment?

The same problem (of requiring rootwait) exists when trying to boot
from a SCSI/USB device, so I don't think there's any MMC-specific
problem here.  Most people who aren't using an initrd have to supply
rootwait.

I liked the idea behind your patch, but the performance regression
isn't acceptable.  If we can't find a way to conditionalize the call
to mmc_flush_scheduled_work() on being in a situation where we're
definitely about to panic, I think the only option would be to try
to come up with a solution at the layers above MMC.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
