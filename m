From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCH] mmc: core: Try other signal levels during power up
Date: Thu, 24 Apr 2014 14:42:54 -0700
Message-ID: <CAAYSxhoK=6wPqCm3RbRRkftCX6RoN_eGdisSPrxE9mPjBF6M-g@mail.gmail.com>
References: <1397847510-17199-1-git-send-email-tim.kryger@linaro.org>
	<CAPDyKFp12-g0EXvnp0z2pQfiFxTRZMK4nK8y0XMUhUeDSOwNEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:45449 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbaDXVmy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Apr 2014 17:42:54 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so3365234obc.34
        for <linux-mmc@vger.kernel.org>; Thu, 24 Apr 2014 14:42:54 -0700 (PDT)
In-Reply-To: <CAPDyKFp12-g0EXvnp0z2pQfiFxTRZMK4nK8y0XMUhUeDSOwNEA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Linux MMC <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Apr 24, 2014 at 1:38 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 18 April 2014 20:58, Tim Kryger <tim.kryger@linaro.org> wrote:

>>  void mmc_power_up(struct mmc_host *host, u32 ocr)
>>  {
>> +       int err;
>> +
>
> The variable err is not needed, since we don't plan on printing it nor
> returning it. Please remove and handle the return code directly in the
> if statements.

Sure.  I'll send out an updated version shortly.

Thanks,
Tim
