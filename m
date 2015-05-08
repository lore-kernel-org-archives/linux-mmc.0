From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Fri, 8 May 2015 09:02:39 +0200
Message-ID: <CAPDyKFqzump-WsbfG2kx+pUZVeduvtvd3PmRy-jEJQZaD5xqbw@mail.gmail.com>
References: <554B2451.7020509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:33962 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbbEHHCj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2015 03:02:39 -0400
Received: by qcyk17 with SMTP id k17so33141389qcy.1
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2015 00:02:39 -0700 (PDT)
In-Reply-To: <554B2451.7020509@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, zhangfei <zhangfei.gao@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 7 May 2015 at 10:37, Jaehoon Chung <jh80.chung@gmail.com> wrote:
> Dear, Ulf.
>
> Could you pull dw-mmc controller patches for v4.2-rc3?
>
> Best Regards,
> Jaehoon Chung
>
> The following changes since commit 75f65952d431aee8b97a20a9df2de1341ca8da01:
>
>   Merge branch 'fixes' into next (2015-05-06 14:56:06 +0200)
>
> are available in the git repository at:
>
>
>   https://github.com/jh80chung/dw-mmc.git tags/dw-mmc-v4.1-rc3-for-ulf
>
> for you to fetch changes up to 6df66485e62467487ea885c9697df3a3ee22c86f:
>
>   mmc: dw_mmc: dw_mci_get_cd check MMC_CAP_NONREMOVABLE (2015-05-07 16:32:58 +0900)
>
> ----------------------------------------------------------------
> dw-mmc-v.4.1-rc3-for-ulf
>
> ----------------------------------------------------------------
> Zhangfei Gao (2):
>       mmc: dw_mmc: init desc in dw_mci_idmac_init
>       mmc: dw_mmc: dw_mci_get_cd check MMC_CAP_NONREMOVABLE
>
>  drivers/mmc/host/dw_mmc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)


While I tried to pull this into my fixes branch, I realized that you
have based this on my next branch. That's not working very well for
patches intended for fixes.

This time I managed to cherry-pick the patches from your tree, so no
worries. Next time you send my fixes, please base those on the latest
available rc instead.

Thanks Jaehoon!

Kind regards
Uffe
