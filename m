From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH v1 1/1] mmc: core: skip card initialization if power class selection fails
Date: Tue, 10 Apr 2012 23:26:15 +0530
Message-ID: <000001cd1743$3f165bd0$bd431370$@codeaurora.org>
References: <1333976419-2018-1-git-send-email-subhashj@codeaurora.org>	<CAKYAXd_F1ZpR3uYFM9fQUnFKRULKw8o3UO7Zw29MG5BsRuXCew@mail.gmail.com> <87ehrvwu3y.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:3373 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455Ab2DJR4Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Apr 2012 13:56:25 -0400
In-Reply-To: <87ehrvwu3y.fsf@laptop.org>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>, 'Namjae Jeon' <linkinjeon@gmail.com>
Cc: linux-mmc@vger.kernel.org, saugata.das@linaro.org



> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Tuesday, April 10, 2012 7:46 PM
> To: Namjae Jeon
> Cc: Subhash Jadavani; linux-mmc@vger.kernel.org; saugata.das@linaro.org
> Subject: Re: [PATCH v1 1/1] mmc: core: skip card initialization if power
class
> selection fails
> 
> Hi,
> 
> On Mon, Apr 09 2012, Namjae Jeon wrote:
> > Hi Subhash.
> > There are duplicate printks in three places. Is there no way to avoid
> > duplicate printks ?
> 
> The printk can go just before the final "return err" in
mmc_select_powerclass().
Yes. will fix it and post another patch.

Thanks,
Subhash

> 
> Thanks,
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

