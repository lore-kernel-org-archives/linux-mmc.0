From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: block: delete packed command support
Date: Thu, 24 Nov 2016 19:23:15 +0900
Message-ID: <bffa21b9-6c14-345b-bf90-f12ffe56b542@samsung.com>
References: <CGME20161123154834epcas3p479d3731e59db07c42688b323cd37104e@epcas3p4.samsung.com>
 <1479916086-26641-1-git-send-email-linus.walleij@linaro.org>
 <0e12314b-e1ce-d2ce-1136-02465fdbead4@samsung.com>
 <CACRpkdZqL0b9i0r+TwRVYD-uw5PuoNbOsxKoghtHam+Wawp1Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:60368 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757152AbcKXKXR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 05:23:17 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OH500IIO66RTZE0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 24 Nov 2016 19:23:15 +0900 (KST)
In-reply-to: <CACRpkdZqL0b9i0r+TwRVYD-uw5PuoNbOsxKoghtHam+Wawp1Rg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>

On 11/24/2016 06:50 PM, Linus Walleij wrote:
> On Thu, Nov 24, 2016 at 6:24 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> 
>>> Cc: Namjae Jeon <namjae.jeon@samsung.com>
>>> Cc: Maya Erez <qca_merez@qca.qualcomm.com>
>>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Did i send the acked-by tag? :)
>> I just agreed some this patch's points.
>> When i become assured, i will send the acked-by tag. is this way right?
> 
> As per Documentation/SubmittingPatches, section 12:
> 
> --------------------------
> Acked-by: is not as formal as Signed-off-by:.  It is a record that the acker
> has at least reviewed the patch and has indicated acceptance.  Hence patch
> mergers will sometimes manually convert an acker's "yep, looks good to me"
> into an Acked-by: (but note that it is usually better to ask for an
> explicit ack).
> ---------------------------

Thanks for sharing this information..i didn't read this documentation.

Anyway, until today, i have checked the I/O performance with Exynos3/4/5 boards which i have.
It seems that there is no I/O performance benefit about packed command at this time.

I don't know how other guys are thinking.

Explicit..

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> 
> Yours,
> Linus Walleij
> 
> 
> 

