From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: amend using error interrupt status
Date: Tue, 07 Aug 2012 23:17:32 -0400
Message-ID: <87d332xeb7.fsf@octavius.laptop.org>
References: <006301cd6f7c$db537500$91fa5f00$%jun@samsung.com>
	<CAGxe1ZH=NZ5ZC3SVjaxwoXa_5dZEQzCAzYxK40Sy2rYr4dCpBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56699 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728Ab2HHDRi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Aug 2012 23:17:38 -0400
In-Reply-To: <CAGxe1ZH=NZ5ZC3SVjaxwoXa_5dZEQzCAzYxK40Sy2rYr4dCpBA@mail.gmail.com>
	(Girish K. S.'s message of "Wed, 1 Aug 2012 09:57:28 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hi,

On Wed, Aug 01 2012, Girish K S wrote:
> On 1 August 2012 06:00, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> RINTSTS status includes masked interrupts as well as unmasked.
>> data_status and cmd_status are set by value of RINTSTS in interrupt handler
>> and tasklet finally uses it to decide whether error is happened or not.
>> In addition, MINTSTS status is used for setting data_status in PIO.
>> Masked error interrupt will not be handled and that status can be considered
>> non-error case.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
