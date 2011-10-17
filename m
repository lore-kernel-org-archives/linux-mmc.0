From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: dw_mmc: modify DATA register offset
Date: Mon, 17 Oct 2011 14:12:23 -0400
Message-ID: <m262jn7aig.fsf@bob.laptop.org>
References: <4E9C0527.50706@samsung.com> <4E9C0941.1030507@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58434 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198Ab1JQSMg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Oct 2011 14:12:36 -0400
In-Reply-To: <4E9C0941.1030507@imgtec.com> (James Hogan's message of "Mon, 17
	Oct 2011 11:53:53 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>

Hi,

On Mon, Oct 17 2011, James Hogan wrote:
> On 10/17/2011 11:36 AM, Jaehoon Chung wrote:
>> In dw_mmc 2.40a spec, Data register's offset is changed.
>> Now we used Data register offset is 0x100. but if somebody use 2.40a
>> controller, must use 0x200 for Data register.
>> 
>> This patch is added version-id checking point and using SDMMC_DATA(x)
>> instead of SDMMC_DATA. (assume 2.40a is the latest version)
>> 
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> Acked-by: James Hogan <james.hogan@imgtec.com>

Pushed to mmc-next for 3.2, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
