From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: fix wrong return value when suspend
Date: Wed, 06 Jun 2012 09:50:37 -0400
Message-ID: <871uls4kia.fsf@octavius.laptop.org>
References: <4FC756A3.3000803@samsung.com>
	<CAPDyKFrHjVe4Y-d0zSM4hdc=yqN5JGKoi3ujc+nHJHe6vB+WcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40984 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754459Ab2FFNun (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Jun 2012 09:50:43 -0400
In-Reply-To: <CAPDyKFrHjVe4Y-d0zSM4hdc=yqN5JGKoi3ujc+nHJHe6vB+WcA@mail.gmail.com>
	(Ulf Hansson's message of "Fri, 1 Jun 2012 10:11:05 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Thu, May 31 2012, Ulf Hansson wrote:
> On 31 May 2012 19:31, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> When mmc_host is not spi mode, mmc/sd is doing mmc_deselect_cards().
>> mmc_deselect_cards could be returned error.
>> If returned error, we can know something wrong when enter suspend.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> This make sense to me!
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks, pushed to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
