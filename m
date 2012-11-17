From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdio: To use multiple scatter gather list
Date: Sat, 17 Nov 2012 15:26:47 -0500
Message-ID: <87a9ug9drs.fsf@octavius.laptop.org>
References: <001101cdb044$8565abf0$903103d0$%kim@samsung.com>
	<87d301q8kb.fsf@octavius.laptop.org>
	<001801cdbca7$0b12bc70$21383550$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39719 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133Ab2KQU0z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 17 Nov 2012 15:26:55 -0500
In-Reply-To: <001801cdbca7$0b12bc70$21383550$%kim@samsung.com> (Kyoungil Kim's
	message of "Wed, 07 Nov 2012 14:16:29 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyoungil Kim <ki0351.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Wed, Nov 07 2012, Kyoungil Kim wrote:
> On Tue, Oct 30 2012, Chris Ball wrote:
>> Hi,
>> 
>> On Mon, Oct 22 2012, Kyoungil Kim wrote:
>> > We used only single sg entry for SDIO transfer.
>> > This chagne is to use multiple sg entry.
>> > In case of dwmci, it support only up to 4KB size per single sg entry.
>> > So if we want to transfer more than 4KB, we should send more than
>> > 1 command.
>> > This makes performance degradation for large data transfer.
>> >
>> > Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
>> 
>> Can you share the before/after benchmark on your controller, please?
>
> When we test before apply this patch, it takes around 335 us for
> 5K(5120) bytes transfer with dwmci controller.
> But when we test after apply this patch, it takes 242 us for 5K bytes.
> So this patch makes around 38% performance improvement for 5K bytes transfer.
> If the transfer size is bigger, then the performance improvement ratio
> will be increased.

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
