From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: add support for pre_req and post_req
Date: Tue, 26 Apr 2011 12:21:08 +0200
Message-ID: <BANLkTinmDS1MayqUwNvWKvhjV3LPbu1u=A@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1302972516-8673-1-git-send-email-shawn.guo@linaro.org>
	<BANLkTi=pqGyijbfuHD=uQzPnaYvNOQyzdg@mail.gmail.com>
	<4DB61F29.4090600@samsung.com>
	<20110426024758.GB6145@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:32949 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab1DZKVI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 06:21:08 -0400
Received: by iwn34 with SMTP id 34so376031iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 03:21:08 -0700 (PDT)
In-Reply-To: <20110426024758.GB6145@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Andrei Warkentin <andreiw@motorola.com>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, cjb@laptop.org, Kyungmin Park <kyungmin.park@samsung.com>

On 26 April 2011 04:47, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Tue, Apr 26, 2011 at 10:26:01AM +0900, Jaehoon Chung wrote:
>> Hi Shawn
>>
>> I tested using ADMA with your patch...(benchmark : IOzone)
>> But I didn't get improvement of performance with ADMA..
>> (i can see improvement of performance with SDMA)
>>
>> I want to know how you think about this..
>>
> It's still an open question if pre_req and post_req were correctly
> added, even you have seen improvement of SDMA case with IOzone. =A0I
> would leave the question to Per Forlin.
>
Performance numbers from user space may vary.
Currently I am looking into how the block layer adds request to the
mmc blockdev. I can see that if is common that one read request is
pushed to the mmc blockdev queue after the previous request has
already finished. For this scenario there will no improvement. If
running IOzone with large record sizes multiple requests are queued up
in the mmc blockdev queue and this results in increase of bandwidth.
The mmc_test are intended to help verifying if the pre_req and
post_req are implemented correctly and give a number of the maximum
gain in performance.

> --
> Regards,
> Shawn
Regards,
Per
