From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc-utils: Fix reported offset for enhanced user area
 start address
Date: Thu, 25 Aug 2016 09:05:13 +0200
Message-ID: <CAPDyKFq+c5TYfx_mzpB4awJyVZsWj339vU-JeyBaL4KZUmK-6A@mail.gmail.com>
References: <fbed5a25-65a0-47f1-e4b4-839149973441@vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37521 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbcHYHFz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2016 03:05:55 -0400
Received: by mail-wm0-f44.google.com with SMTP id i5so56499267wmg.0
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2016 00:05:15 -0700 (PDT)
In-Reply-To: <fbed5a25-65a0-47f1-e4b4-839149973441@vaisala.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tomas.melin@vaisala.com
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

+ Chris

On 25 August 2016 at 06:23,  <tomas.melin@vaisala.com> wrote:
> Block-addressed devices should have address multiplied with sector size.
>
> Clarify with comment how is_blockaddressed() is calculated.
>
> Signed-off-by: Tomas Melin<tomas.melin@vaisala.com>

Chris Ball maintains mmc-utils, you need to send these changes to him.
I have added him on cc this time.

Kind regards
Uffe

> ---
>   mmc_cmds.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 295d505..21ddd55 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -794,7 +794,7 @@ unsigned int get_sector_count(__u8 *ext_csd)
>   int is_blockaddresed(__u8 *ext_csd)
>   {
>       unsigned int sectors = get_sector_count(ext_csd);
> -
> +        /* over 2GiB devices are block-addressed */
>       return (sectors > (2u * 1024 * 1024 * 1024) / 512);
>   }
>
> @@ -1659,7 +1659,7 @@ int do_read_extcsd(int nargs, char **argv)
>           printf("Enhanced User Data Start Address"
>               " [ENH_START_ADDR]: 0x%06x\n", regl);
>           printf(" i.e. %lu bytes offset\n", (is_blockaddresed(ext_csd) ?
> -                1l : 512l) * regl);
> +                512l : 1l) * regl);
>
>           /* A441]: reserved [135] */
>           printf("Bad Block Management mode"
> --
> 2.1.4
