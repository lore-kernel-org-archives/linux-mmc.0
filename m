From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: queue: exclude asynchronous transfer for special request
Date: Mon, 14 Jan 2013 14:26:15 -0500
Message-ID: <87d2x7tvl4.fsf@laptop.org>
References: <000701cde309$f5ed8fd0$e1c8af70$%jun@samsung.com>
	<50DC4B4C.8090805@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38386 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756960Ab3ANT0a (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Jan 2013 14:26:30 -0500
In-Reply-To: <50DC4B4C.8090805@codeaurora.org> (Konstantin Dorfman's message
	of "Thu, 27 Dec 2012 15:21:16 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Per Forlin' <per.forlin@linaro.org>

Hi,

On Thu, Dec 27 2012, Konstantin Dorfman wrote:
> Reviewed-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>
> On 12/26/2012 03:40 AM, Seungwon Jeon wrote:
>> Unlike normal r/w request, special requests(discard, flush)
>> is finished with a one-time issue_fn. Request change to
>> mqrq_prev makes unnecessary call.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
