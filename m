From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mmc: host: Fix mmc_alloc_host() error path
Date: Mon, 15 Jun 2015 10:03:00 -0300
Message-ID: <CAOMZO5Au0CoP2Jzvb9y6Q7EXSmRvKLo-VBRUxsuuqwx415fx7A@mail.gmail.com>
References: <1434083961-32540-1-git-send-email-festevam@gmail.com>
	<557A88C7.3020306@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36021 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbbFONDC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jun 2015 09:03:02 -0400
Received: by lbbqq2 with SMTP id qq2so52949503lbb.3
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2015 06:03:01 -0700 (PDT)
In-Reply-To: <557A88C7.3020306@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On Fri, Jun 12, 2015 at 4:22 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 12/06/15 07:39, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> If mmc_gpio_alloc() fails we miss to call 'kfree(host)', so rearrange
>> the error path to fix it.
>
> Are you sure it doesn't get freed through put_device()?

Yes, you are right. Sorry for the noise.

Thanks
