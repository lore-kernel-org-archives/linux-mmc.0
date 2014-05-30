From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 11/13] mmc: mmci: add f_max to variant structure
Date: Fri, 30 May 2014 11:29:44 +0100
Message-ID: <53885D98.8030207@linaro.org>
References: <1401284608-16428-1-git-send-email-srinivas.kandagatla@linaro.org>	<1401284862-16894-1-git-send-email-srinivas.kandagatla@linaro.org> <CAPDyKFoURODuKS6NB4hN=iW=22S0x+ZiJWYz_UXW0Rc+0pW2Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:32873 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932674AbaE3K3v (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 May 2014 06:29:51 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so826933wib.11
        for <linux-mmc@vger.kernel.org>; Fri, 30 May 2014 03:29:47 -0700 (PDT)
In-Reply-To: <CAPDyKFoURODuKS6NB4hN=iW=22S0x+ZiJWYz_UXW0Rc+0pW2Nw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>

Thanks Ulf,

On 30/05/14 11:28, Ulf Hansson wrote:
>>           */
>> >-       if (host->mclk > 100000000) {
>> >-               ret = clk_set_rate(host->clk, 100000000);
>> >+       if (host->mclk > host->variant->f_max) {
> You can use the local variant pointer directly, instead of host->variant.
>
yes, Will do that in next version.

Thanks,
srini
>> >+               ret = clk_set_rate(host->clk, host->variant->f_max);
>> >                 if (ret < 0)
>> >                         goto clk_disable;
>> >                 host->mclk = clk_get_rate(host->clk);
>> >--
