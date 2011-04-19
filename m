From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH v2 00/12] mmc: use nonblock mmc requests to minimize latency
Date: Tue, 19 Apr 2011 23:30:41 +0900
Message-ID: <BANLkTim7QdTvffsMdCfG-GBs-TkfB4nY4Q@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<BANLkTikZVDejarZ4O5KgNS7S4fxBLSmANA@mail.gmail.com>
	<BANLkTikVeXvfSBS-xLDXVdesKJpKdtUVqg@mail.gmail.com>
	<BANLkTikaerLi9NC153L=kJM2hAC_VerBKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59047 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab1DSOan (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 10:30:43 -0400
In-Reply-To: <BANLkTikaerLi9NC153L=kJM2hAC_VerBKQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>

Hi Per..

2011/4/11 Per Forlin <per.forlin@linaro.org>:
> On 9 April 2011 13:55, Jae hoon Chung <jh80.chung@gmail.com> wrote:
>> Hi Per..
>>
>> I'm applied your patch..and sent the patch about dw_mmc.c.
>> I think good this approach..
>>
> Do you have any test results from the mmc_tests I added?
> I am interested in the results.

I didn't test with mmc_tests..but i tested with IOzone..
I'll test with mmc_test..then i'll share the results..

Regards,
Jaehoon Chung
