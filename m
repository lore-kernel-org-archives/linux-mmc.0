From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/5] mmc: Miscellaneous fixes for SDHCI and MMC core
Date: Mon, 27 Oct 2014 13:49:08 +0100
Message-ID: <CAPDyKFov1S-2iGLwpkbAcjm9cUHrrVSRUdt7rYS9gdHpVeehAw@mail.gmail.com>
References: <1412165651-2652-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:50260 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbaJ0MtJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Oct 2014 08:49:09 -0400
Received: by mail-qg0-f54.google.com with SMTP id q108so430551qgd.27
        for <linux-mmc@vger.kernel.org>; Mon, 27 Oct 2014 05:49:08 -0700 (PDT)
In-Reply-To: <1412165651-2652-1-git-send-email-andrew_gabbasov@mentor.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 1 October 2014 14:14, Andrew Gabbasov <andrew_gabbasov@mentor.com> wrote:
> Andrew Gabbasov (5):
>   mmc: sdhci: Balance vmmc regulator_disable()
>   mmc: sdhci: fix error conditions for controller reset
>   mmc: core: Initialize SET_BLOCK_COUNT request fields
>   mmc: core: Add debug message for SET_BLOCK_COUNT result
>   mmc: core: Fix error paths and messages in mmc_init_card
>
>  drivers/mmc/core/core.c  | 12 ++++++++++++
>  drivers/mmc/core/mmc.c   | 16 ++++++++--------
>  drivers/mmc/host/sdhci.c | 10 ++++------
>  3 files changed, 24 insertions(+), 14 deletions(-)

Thanks! Applied for next!

Kind regards
Uffe

>
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
