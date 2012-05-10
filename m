From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: Avoid null pointer dereference
Date: Wed, 09 May 2012 20:54:51 -0400
Message-ID: <873978n9d0.fsf@laptop.org>
References: <1334176305-6183-1-git-send-email-philippedeswert@gmail.com>
	<CAKYAXd8Ofmg+kzUgr26CngaNgcw-MXJ91cS4R+BcMLY7yPxjNw@mail.gmail.com>
	<CAKYAXd9roe8he2bGKiurCsxS3+U5otqQqRXzpB8fVPWak2ow_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60874 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756907Ab2EJAyn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 May 2012 20:54:43 -0400
In-Reply-To: <CAKYAXd9roe8he2bGKiurCsxS3+U5otqQqRXzpB8fVPWak2ow_Q@mail.gmail.com>
	(Namjae Jeon's message of "Thu, 10 May 2012 09:43:06 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Philippe De Swert <philippedeswert@gmail.com>

Hi,

On Wed, May 09 2012, Namjae Jeon wrote:
> Hi. Chris.
>
> Would you check this patch ?
>
> Thanks.
>
> 2012/4/12, Namjae Jeon <linkinjeon@gmail.com>:
>> 2012/4/12 Philippe De Swert <philippedeswert@gmail.com>:
>>> After the null check on md the code jumped to cmd_done, which then
>>> will dereference md in mmc_blk_put. This patch avoids the possible
>>> null pointer dereference in that case.
>>>
>>> Signed-off-by: Philippe De Swert <philippedeswert@gmail.com>
>> This patch is good also.
>> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>

Thanks for the reminder -- pushed to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
