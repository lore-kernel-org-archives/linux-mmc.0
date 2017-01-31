From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Updates dw-mmc controller for next
Date: Tue, 31 Jan 2017 11:35:39 +0100
Message-ID: <CAPDyKFrTVYM_9aV_A2wipXiaZVt4ft_HpB6VPwDrVAAy2Q+DFw@mail.gmail.com>
References: <CGME20170131035834epcas1p1de000eab0012b2f755a934f5eb277f77@epcas1p1.samsung.com>
 <640ec482-ddc0-fc21-b2eb-414ded64ad90@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35601 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbdAaKfl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2017 05:35:41 -0500
Received: by mail-wm0-f43.google.com with SMTP id b65so72662066wmf.0
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 02:35:40 -0800 (PST)
In-Reply-To: <640ec482-ddc0-fc21-b2eb-414ded64ad90@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 31 January 2017 at 04:58, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Ulf,
>
> Could you pull this patch on your next branch?
>
> The following changes since commit 2fb4d2ecbaa8596ea74408c251121099167ff2e8:
>
>   mmc: core/mmci: restore pre/post_req behaviour (2017-01-30 11:11:30 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git for-ulf
>
> for you to fetch changes up to 77e565420cb4f0d305aceb5378039dfb9b98e2b0:
>
>   mmc: dw_mmc: silent verbose log when calling from PM context (2017-01-31 11:12:20 +0900)
>
> ----------------------------------------------------------------
> Shawn Lin (1):
>       mmc: dw_mmc: silent verbose log when calling from PM context
>
>  drivers/mmc/host/dw_mmc.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> Best Regards,
> Jaehoon Chung

Thanks Jaehoon, pulled into next!

BTW, I also added your sob-tag, as it seems like your forgotten that this time!?

Kind regards
Uffe
