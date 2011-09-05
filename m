From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] dw_mmc: ensure the ciu-reset
Date: Mon, 5 Sep 2011 10:27:01 +0100
Message-ID: <CAFbHwiTSkcnXyy2igZd=WfozER1RmTwFdg=t=B87GzXU+nSwwQ@mail.gmail.com>
References: <4E641A31.8070604@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46431 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1IEJ1D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Sep 2011 05:27:03 -0400
Received: by gxk21 with SMTP id 21so3216418gxk.19
        for <linux-mmc@vger.kernel.org>; Mon, 05 Sep 2011 02:27:02 -0700 (PDT)
In-Reply-To: <4E641A31.8070604@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Wonil Choi <wonil22.choi@samsung.com>

On Mon, Sep 5, 2011 at 1:39 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:

Hi Jaehoon,

> This patch ensured the CIU-reset.
>
> If data0 line is low, bit[9] in status register is set to 1.
> Then we can know the card is busy.
>
> Using this bit in status register, we can ensure to reset the CIU correctly.
> When card is busy and doing ciu-reset, seem like reset completed.
> But actually didn't complete ciu-reset. because card is busy.
>
> So i think good whether check card busy or not before reset the ciu.

It looks like this isn't exactly what the patch does - the reset
happens whether the card is busy or not, but if card data is busy then
the reset may be re-issued.

Is there some way to reproduce the issue in this patch? I can't find
anything in the TRM that suggests that we need to issue the reset more
than once.

Thanks,
