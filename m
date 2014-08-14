From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: rtsx: fix incorrect last byte in R2 response
Date: Thu, 14 Aug 2014 11:32:16 +0200
Message-ID: <CAPDyKFo5W6_388f0kaFeOhi0q6LqBzWYUUDZ9MssTZHvVx+Ebg@mail.gmail.com>
References: <1407745936-18513-1-git-send-email-rogerable@realtek.com>
	<CAPDyKFrTbiHxYgW5YCR48DKX8arxuxK3rz7k_H-waGEMiPFjSg@mail.gmail.com>
	<1407996435.6245.15.camel@debian-rtk5880>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:51049 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbaHNJcR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Aug 2014 05:32:17 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so787531qgd.37
        for <linux-mmc@vger.kernel.org>; Thu, 14 Aug 2014 02:32:16 -0700 (PDT)
In-Reply-To: <1407996435.6245.15.camel@debian-rtk5880>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roger Tseng <rogerable@realtek.com>
Cc: Chris Ball <chris@printf.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, Wei_wang <wei_wang@realsil.com.cn>, micky <micky_ching@realsil.com.cn>

On 14 August 2014 08:06, Roger Tseng <rogerable@realtek.com> wrote:
> On Wed, 2014-08-13 at 17:09 +0200, Ulf Hansson wrote:
>> On 11 August 2014 10:32,  <rogerable@realtek.com> wrote:
>> > From: Roger Tseng <rogerable@realtek.com>
>> >
>> > Current code erroneously fill the last byte of R2 response with an undefined
>> > value. In addition, it is impossible to obtain the real values since the
>> > controller actually 'offloads' the last byte(CRC7, end bit) while receiving R2
>> > response. This could cause mmc stack to obtain inconsistent CID from the same
>> > card after resume and misidentify it as a different card.
>> >
>> > Fix by assigning a dummy value 0x01 to the last byte of R2 response.
>> >
>> > Signed-off-by: Roger Tseng <rogerable@realtek.com>
>>
>> Thanks! Queued for 3.18.
>>
>> I guess this should go for stable as well?
> Yes. However, since rtsx_usb* is present in 3.16 and later, this patch
> will not apply on 3.15.y or older. Should I separately send an adapted
> version to stable?

I haven't pushed this externally yet. I will drop the patch from my 3.18 branch.

Then, let's split the patch into two, one for usb and one for pci -
that should simplify patch management.

Additionally, you should include a Cc tag with proper hashmark telling
which kernel each patch should be included into.

Kind regards
Uffe
