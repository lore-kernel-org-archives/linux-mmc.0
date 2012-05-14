From: Adam Cooper <acooper@gmail.com>
Subject: Re: [PATCH] mmc: Limit MMC speed to 25MHz if HIGHSPEED CAPS bit is
 not set.
Date: Mon, 14 May 2012 16:15:35 -0400
Message-ID: <CAEAGnKhDRKTM9aDsXXDhK9mk4_A9NKXanZZ09j021wGRoGjNqw@mail.gmail.com>
References: <1337026314-14003-1-git-send-email-acooper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59428 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231Ab2ENUPh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 May 2012 16:15:37 -0400
Received: by bkcji2 with SMTP id ji2so4188323bkc.19
        for <linux-mmc@vger.kernel.org>; Mon, 14 May 2012 13:15:36 -0700 (PDT)
In-Reply-To: <1337026314-14003-1-git-send-email-acooper@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org, cernekee@gmail.com
Cc: Al Cooper <acooper@gmail.com>

This is not Al's email address. Please have him use his own email addre=
ss.

On Mon, May 14, 2012 at 4:11 PM, Al Cooper <acooper@gmail.com> wrote:
> If the HIGHSPEED capabilities bit is not set, limit the MMC clock
> speed to 25MHz.
>
> Signed-off-by: Al Cooper <acooper@gmail.com>
> ---
> =A0drivers/mmc/core/mmc.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 54df5ad..912c893 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1045,7 +1045,7 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_ca=
rd_set_hs200(card);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_se=
t_timing(card->host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 MMC_TIMING_MMC_HS200);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (host->caps &=
 MMC_CAP_MMC_HIGHSPEED) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_ca=
rd_set_highspeed(card);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_se=
t_timing(card->host, MMC_TIMING_MMC_HS);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> --
> 1.7.6
>
>
