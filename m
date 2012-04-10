From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v1 1/1] mmc: core: skip card initialization if power class selection fails
Date: Tue, 10 Apr 2012 10:15:45 -0400
Message-ID: <87ehrvwu3y.fsf@laptop.org>
References: <1333976419-2018-1-git-send-email-subhashj@codeaurora.org>
	<CAKYAXd_F1ZpR3uYFM9fQUnFKRULKw8o3UO7Zw29MG5BsRuXCew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46089 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424Ab2DJOPz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Apr 2012 10:15:55 -0400
In-Reply-To: <CAKYAXd_F1ZpR3uYFM9fQUnFKRULKw8o3UO7Zw29MG5BsRuXCew@mail.gmail.com>
	(Namjae Jeon's message of "Mon, 9 Apr 2012 23:35:11 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, linux-mmc@vger.kernel.org, saugata.das@linaro.org

Hi,

On Mon, Apr 09 2012, Namjae Jeon wrote:
> Hi Subhash.
> There are duplicate printks in three places. Is there no way to avoid
> duplicate printks ?

The printk can go just before the final "return err" in
mmc_select_powerclass().

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
