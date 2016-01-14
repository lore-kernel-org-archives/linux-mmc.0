From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: mmci: fix an ages old detection error
Date: Thu, 14 Jan 2016 10:52:02 +0100
Message-ID: <CAPDyKFqADAro2vY+u_ZDidRqS3QpHxqsTJFcLLx4rzr-k2nurg@mail.gmail.com>
References: <1451870515-21049-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36793 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbcANJwD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2016 04:52:03 -0500
Received: by mail-qk0-f171.google.com with SMTP id q19so232337760qke.3
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2016 01:52:02 -0800 (PST)
In-Reply-To: <1451870515-21049-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "# 4.0+" <stable@vger.kernel.org>

On 4 January 2016 at 02:21, Linus Walleij <linus.walleij@linaro.org> wrote:
> commit 4956e10903fd3459306dd9438c1e714ba3068a2a
> "ARM: 6244/1: mmci: add variant data and default MCICLOCK support"
> added variant data for ARM, U300 and Ux500 variants. The
> Nomadik NHK8815/8820 variant was erroneously labeled as a
> U300 variant, and when the proper Nomadik variant was
> later introduced in commit
> 34fd421349ffc6a4280b71276bf7c6d48f92156f
> "ARM: 7378/1: mmci: add support for the Nomadik MMCI variant"
> this was not fixes. Let's say this fixes the latter commit
> as there was no proper Nomadik support until then.
>
> Cc: stable@vger.kernel.org
> Fixes: 34fd421349ff "ARM: 7378/1: mmci: add support for the Nomadik MMCI variant"
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, applied patch 1 and patch2 for fixes.

Patch1 had some checkpatch issues regarding the changelog, I fixed it up myself.

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index fb266745f824..acece3299756 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1886,7 +1886,7 @@ static struct amba_id mmci_ids[] = {
>         {
>                 .id     = 0x00280180,
>                 .mask   = 0x00ffffff,
> -               .data   = &variant_u300,
> +               .data   = &variant_nomadik,
>         },
>         {
>                 .id     = 0x00480180,
> --
> 2.4.3
>
