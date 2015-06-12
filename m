From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Fri, 12 Jun 2015 09:33:43 +0200
Message-ID: <CAPDyKFr7zhPgBgDD_BTQ6wUqhwBRJ6u85G-Md49K6n26MQRWew@mail.gmail.com>
References: <557A3BD6.2080001@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35958 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbbFLHdo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Jun 2015 03:33:44 -0400
Received: by qkx62 with SMTP id 62so13771504qkx.3
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2015 00:33:43 -0700 (PDT)
In-Reply-To: <557A3BD6.2080001@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Prabu Thangamuthu <Prabu.T@synopsys.com>

On 12 June 2015 at 03:54, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear, Ulf.
>
> Could you pull this patch for mmc-next?
>
> Best Regards,
> Jaehoon Chung
>
>
> The following changes since commit 5fd26c7ecb32082745b0bd33c8e35badd1cb5a91:
>
>   mmc: sdhci: Restore behavior while creating OCR mask (2015-06-08 09:49:57 +0200)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git tags/dw_mmc-next-for-ulf
>
> for you to fetch changes up to d15283723e066512f7d4d18c78cf68d15a400b29:
>
>   mmc: dw_mmc: insmod followed by rmmod will hung for eMMC (2015-06-12 01:42:02 +0900)
>
> ----------------------------------------------------------------
> Prabu Thangamuthu (1):
>       mmc: dw_mmc: insmod followed by rmmod will hung for eMMC
>
>  drivers/mmc/host/dw_mmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks Jaehoon, pulled into my next branch!

Kind regards
Uffe
