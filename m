From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] dw-mmc controller fixes
Date: Mon, 21 Nov 2016 11:10:41 +0100
Message-ID: <CAPDyKFqP34Z+fWKikdFwFSCYsLx2mMC=BYCddJ_Jd2wJ4mPkjw@mail.gmail.com>
References: <d43a35c0-0961-ccc6-70ad-0b9b0f0ce2eb@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37960 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbcKUKKn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2016 05:10:43 -0500
Received: by mail-wm0-f47.google.com with SMTP id f82so135420004wmf.1
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2016 02:10:43 -0800 (PST)
In-Reply-To: <d43a35c0-0961-ccc6-70ad-0b9b0f0ce2eb@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 21 November 2016 at 05:28, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Ulf,
>
> Could you pull this patch into your "fixes" branch?
> Before applied this patch, there is the potential lock issue.

Thanks, applied for fixes!

Kind regards
Uffe

>
> Best Regards,
> Jaehoon Chung
>
>
> The following changes since commit b0921d5c9ed6ffa8a4d6afc5ee5f136b87445f14:
>
>   mmc: sdhci-of-esdhc: fixup PRESENT_STATE read (2016-11-18 14:41:47 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git fixes
>
> for you to fetch changes up to 93fad54b87ace925631d8a09de6e0ac7d26af96d:
>
>   mmc: dw_mmc: fix the error handling for dma operation (2016-11-21 13:21:38 +0900)
>
> ----------------------------------------------------------------
> Jaehoon Chung (1):
>       mmc: dw_mmc: fix the error handling for dma operation
>
>  drivers/mmc/host/dw_mmc.c | 1 +
>  1 file changed, 1 insertion(+)
