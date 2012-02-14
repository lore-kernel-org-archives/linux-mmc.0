From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: shift with slot-id for CLKENA register
Date: Tue, 14 Feb 2012 06:28:10 -0500
Message-ID: <m2r4xxirhx.fsf@bob.laptop.org>
References: <4F3A1C3F.4060109@samsung.com>
	<CAFbHwiRACA64DqUoT7QhnWj=DdnQKqBxpE2bNSVLEBj-u5qf=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45970 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715Ab2BNL2V (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Feb 2012 06:28:21 -0500
In-Reply-To: <CAFbHwiRACA64DqUoT7QhnWj=DdnQKqBxpE2bNSVLEBj-u5qf=A@mail.gmail.com>
	(Will Newton's message of "Tue, 14 Feb 2012 10:30:42 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, James Hogan <james.hogan@imgtec.com>

Hi,

On Tue, Feb 14 2012, Will Newton wrote:
> On Tue, Feb 14, 2012 at 8:33 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> In CLKENA register, can support 16-SD card clocks.
>> If support correctly, must shift with slot-id.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> Looks good.
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Thanks, pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
