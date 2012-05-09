From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 1/1] mmc: core: skip card initialization if power class selection fails
Date: Wed, 09 May 2012 10:07:47 -0400
Message-ID: <87bolxo3bg.fsf@laptop.org>
References: <1334239567-22285-1-git-send-email-subhashj@codeaurora.org>
	<CAKYAXd-HfDL1AXJ=X-+iTjqCcVTF=1=J-RBBNU05r9P+om_6bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50884 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758710Ab2EIOHj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 May 2012 10:07:39 -0400
In-Reply-To: <CAKYAXd-HfDL1AXJ=X-+iTjqCcVTF=1=J-RBBNU05r9P+om_6bQ@mail.gmail.com>
	(Namjae Jeon's message of "Fri, 13 Apr 2012 23:41:56 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

Hi,

On Fri, Apr 13 2012, Namjae Jeon wrote:
> 2012/4/12 Subhash Jadavani <subhashj@codeaurora.org>:
>> With current implementation of power class selection,
>> mmc_select_powerclass() should never fail. So treat any error
>> returned by this function as serious enough to skip the card
>> initialization.
>>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Looks good to me.
> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>

Thanks, pushed to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
