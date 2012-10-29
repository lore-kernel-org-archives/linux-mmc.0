From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: debugfs: Add signal_voltage to ios dump
Date: Mon, 29 Oct 2012 17:28:38 -0400
Message-ID: <87zk35otmh.fsf@octavius.laptop.org>
References: <1351243915-30190-1-git-send-email-johan.rudholm@stericsson.com>
	<C5E82048-310E-414C-A772-F05862041AD5@nvidia.com>
	<CA+20K0D2H__UR8kN7RvMt612c2g-JmR8MB7_45YXoNqHcv8owA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44885 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758079Ab2J2V2r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Oct 2012 17:28:47 -0400
In-Reply-To: <CA+20K0D2H__UR8kN7RvMt612c2g-JmR8MB7_45YXoNqHcv8owA@mail.gmail.com>
	(Johan Rudholm's message of "Fri, 26 Oct 2012 13:27:11 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: Philip Rakity <prakity@nvidia.com>, Johan Rudholm <johan.rudholm@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>

Hi,

On Fri, Oct 26 2012, Johan Rudholm wrote:
> 2012/10/26 Philip Rakity <prakity@nvidia.com>:
>>
>> On Oct 26, 2012, at 11:31 AM, Johan Rudholm
>> <johan.rudholm@stericsson.com> wrote:
>>
>>> +     default:
>>> +             str = "invalid";
>>
>> would "is unknown"  be a better str ?
>
> Maybe... Actually, I just followed the standard in the function, all
> other strings default to "invalid" when the definition is missing. So
> if I change this, then I should also change the rest of the strings in
> the function. I will do this if we think it's worth the effort, but is
> it?

Thanks, pushed to mmc-next for 3.8 -- let's handle string renaming
separately to this patch.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
