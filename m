From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/3] mmc: sdhci: enable tuning for DDR50
Date: Mon, 5 Oct 2015 12:57:15 +0200
Message-ID: <CAPDyKFpBPKhE37xN9wkbon5YCTQJq-WvLwHxv2F_UoU9pphKNA@mail.gmail.com>
References: <1443960253-4082-1-git-send-email-21cnbao@gmail.com>
	<1443960253-4082-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36672 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbbJEK5Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2015 06:57:16 -0400
Received: by wicgb1 with SMTP id gb1so113600044wic.1
        for <linux-mmc@vger.kernel.org>; Mon, 05 Oct 2015 03:57:15 -0700 (PDT)
In-Reply-To: <1443960253-4082-2-git-send-email-21cnbao@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Weijun Yang <york.yang@csr.com>, Barry Song <Baohua.Song@csr.com>

On 4 October 2015 at 14:04, Barry Song <21cnbao@gmail.com> wrote:
> From: Weijun Yang <york.yang@csr.com>
>
> CMD19 tuning is also available for DDR50 mode.
>
> Signed-off-by: Weijun Yang <york.yang@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Thanks, applied for next - with a minor change.

> ---
>  drivers/mmc/host/sdhci.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 64b7fdb..2ea30fa 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1893,9 +1893,9 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 tuning_count = host->tuning_count;
>
>         /*
> -        * The Host Controller needs tuning only in case of SDR104 mode
> -        * and for SDR50 mode when Use Tuning for SDR50 is set in the
> -        * Capabilities register.
> +        * The Host Controller needs tuning in case of SDR104 and DDR5

/s / DDR5 / DDR50

> +        * mode, and for SDR50 mode when Use Tuning for SDR50 is set in
> +        * the Capabilities register.
>          * If the Host Controller supports the HS200 mode then the
>          * tuning function has to be executed.
>          */
> @@ -1915,6 +1915,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 break;
>
>         case MMC_TIMING_UHS_SDR104:
> +       case MMC_TIMING_UHS_DDR50:
>                 break;
>
>         case MMC_TIMING_UHS_SDR50:
> --
> 1.9.1
>

Kind regards
Uffe
