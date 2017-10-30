From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: vub300: Use common code in __download_offload_pseudocode()
Date: Mon, 30 Oct 2017 14:03:13 +0100
Message-ID: <CAPDyKFqaaX3i5wLu-aORRB765Kjac705384UM4nCbV8n1Kfc3w@mail.gmail.com>
References: <7b418db1-ec35-4c85-5d06-45edde56822c@users.sourceforge.net>
 <CAPDyKFp6h_DAcDvDEMft_WApEakdPQiMw0v8t2fPVxS+H1KkOA@mail.gmail.com> <20171030121508.zfnsvpsrt25prhr4@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:48352 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbdJ3NDO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Oct 2017 09:03:14 -0400
Received: by mail-io0-f173.google.com with SMTP id j17so26912324iod.5
        for <linux-mmc@vger.kernel.org>; Mon, 30 Oct 2017 06:03:13 -0700 (PDT)
In-Reply-To: <20171030121508.zfnsvpsrt25prhr4@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, Tony Olech <tony.olech@elandigitalsystems.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 30 October 2017 at 13:15, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Mon, Oct 30, 2017 at 12:40:39PM +0100, Ulf Hansson wrote:
>> On 27 October 2017 at 21:31, SF Markus Elfring
>> <elfring@users.sourceforge.net> wrote:
>> > From: Markus Elfring <elfring@users.sourceforge.net>
>> > Date: Fri, 27 Oct 2017 21:21:40 +0200
>> >
>> > Add a jump target so that a specific string copy operation is stored
>> > only once at the end of this function implementation.
>> > Replace two calls of the function "strncpy" by goto statements.
>> >
>> > This issue was detected by using the Coccinelle software.
>> >
>> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>>
>> Thanks, applied for next!
>>
>
> What's the advantage of this patch?  The new code seems more complicated
> to me and GCC automatically reuses duplicate constant strings so there
> is no memory savings.

It looked to me that the error path got a bit cleaner. However, I
guess it's matter of taste.

If you insist, I can drop it.

Kind regards
Uffe
