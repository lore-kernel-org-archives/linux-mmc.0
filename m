From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] mmc: mvsdio: Convert to devm_ioremap_resource
Date: Wed, 25 Sep 2013 21:57:58 -0400
Message-ID: <87wqm42vkp.fsf@octavius.laptop.org>
References: <1378968396-18604-1-git-send-email-sachin.kamat@linaro.org>
	<CAK9yfHwvD9wfTWzZ5DFUz7Y5DTRof5kUiiCWfnsN_rd1e+SQ_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49002 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107Ab3IZB6F (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 Sep 2013 21:58:05 -0400
In-Reply-To: <CAK9yfHwvD9wfTWzZ5DFUz7Y5DTRof5kUiiCWfnsN_rd1e+SQ_w@mail.gmail.com> (Sachin
	Kamat's message of "Tue, 24 Sep 2013 17:37:51 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hi Sachin,

On Tue, Sep 24 2013, Sachin Kamat wrote:
> On 12 September 2013 12:16, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> devm_request_and_ioremap() is deprecated. Use devm_ioremap_resource()
>> instead.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>
> Gentle ping on this series Chris.

Thanks, all pushed to mmc-next for 3.13.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
