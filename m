From: Chris Ball <chris@printf.net>
Subject: Re: RFC: raw extcsd dump
Date: Fri, 07 Mar 2014 17:23:46 +0000
Message-ID: <86siqtgbx9.fsf@void.printf.net>
References: <CANEJEGtyGM0jbyy9b0SSY-9D90J8EZFNWYVOUMLQ27rz1Jkztg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42362 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbaCGRXt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Mar 2014 12:23:49 -0500
In-Reply-To: <CANEJEGtyGM0jbyy9b0SSY-9D90J8EZFNWYVOUMLQ27rz1Jkztg@mail.gmail.com>
	(Grant Grundler's message of "Fri, 7 Mar 2014 08:31:21 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Grant,

On Fri, Mar 07 2014, Grant Grundler wrote:
> Are you interested in "raw dump" of extcsd data?
>
> We need it to dump vendor specific data that happens to be in a reserved field.

I don't see any reason to exclude it from mmc-utils, but have you seen
the debugfs node?

mount -t debugfs /dev/mmcblk0 /mnt/
cat /mnt/mmc0/mmc0\:0001/ext_csd

Want to explain whether that's insufficient?  If so, maybe we should
just fix that instead.

Thanks,

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
