From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] mmc: block: delete packed command support
Date: Thu, 24 Nov 2016 10:50:55 +0100
Message-ID: <CACRpkdZqL0b9i0r+TwRVYD-uw5PuoNbOsxKoghtHam+Wawp1Rg@mail.gmail.com>
References: <CGME20161123154834epcas3p479d3731e59db07c42688b323cd37104e@epcas3p4.samsung.com>
 <1479916086-26641-1-git-send-email-linus.walleij@linaro.org> <0e12314b-e1ce-d2ce-1136-02465fdbead4@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35667 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935913AbcKXJu5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 04:50:57 -0500
Received: by mail-qk0-f171.google.com with SMTP id n204so43944049qke.2
        for <linux-mmc@vger.kernel.org>; Thu, 24 Nov 2016 01:50:56 -0800 (PST)
In-Reply-To: <0e12314b-e1ce-d2ce-1136-02465fdbead4@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>

On Thu, Nov 24, 2016 at 6:24 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:

>> Cc: Namjae Jeon <namjae.jeon@samsung.com>
>> Cc: Maya Erez <qca_merez@qca.qualcomm.com>
>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Did i send the acked-by tag? :)
> I just agreed some this patch's points.
> When i become assured, i will send the acked-by tag. is this way right?

As per Documentation/SubmittingPatches, section 12:

--------------------------
Acked-by: is not as formal as Signed-off-by:.  It is a record that the acker
has at least reviewed the patch and has indicated acceptance.  Hence patch
mergers will sometimes manually convert an acker's "yep, looks good to me"
into an Acked-by: (but note that it is usually better to ask for an
explicit ack).
---------------------------

Yours,
Linus Walleij
