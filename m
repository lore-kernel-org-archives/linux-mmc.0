From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/2] mmc: omap_hsmmc: omap_hsmmc_set_power cleanup
Date: Mon, 20 Jul 2015 16:22:04 +0200
Message-ID: <CAPDyKFpkTRmgGRN5LGLn2UAvLOqmR9d29bi+unsrVZu4w1Xjqg@mail.gmail.com>
References: <1436294324-18666-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34062 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932665AbbGTOWF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2015 10:22:05 -0400
Received: by qkfc129 with SMTP id c129so69986174qkf.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jul 2015 07:22:04 -0700 (PDT)
In-Reply-To: <1436294324-18666-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 7 July 2015 at 20:38, Andreas Fenkart <afenkart@gmail.com> wrote:
> v2:
> - add empty omap_hsmmc_set_power in case CONFIG_REGULATOR is undefined
>
> Andreas Fenkart (2):
>   mmc: omap_hsmmc: call omap_hsmmc_set_power directly
>   mmc: omap_hsmmc: regulator automatically released by devm
>
>  drivers/mmc/host/omap_hsmmc.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)

Thanks, applied.

Kind regards
Uffe

>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
