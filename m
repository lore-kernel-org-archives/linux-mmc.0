From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 3/4] mmc: dw_mmc: Convert to mmc_send_tuning()
Date: Tue, 23 Dec 2014 11:21:54 +0100
Message-ID: <CAPDyKFrue1WWDTRMNmxYU=FLC9Cg6ppMX+o0hriK9RKmoRe4mg@mail.gmail.com>
References: <1417780783-12939-1-git-send-email-ulf.hansson@linaro.org>
	<1417780783-12939-4-git-send-email-ulf.hansson@linaro.org>
	<CAGOxZ525JR9vTuKAZJJjDF6iq3R2-DuEcJFEOT9KkEMZGimUFw@mail.gmail.com>
	<CAPDyKFpOvs_ML+1edoTzeTPctiMV0B8EeD8aE8daGwjeG7gwMQ@mail.gmail.com>
	<CAGOxZ51O9_8YDU30st6uha6PkVhk0GJC6hdjgVu+Gi0XPiaz-A@mail.gmail.com>
	<CAPDyKFr56_8chuuva0dgA5uD3z-366R4wVoy9uvoim1CFiiRwA@mail.gmail.com>
	<54993A96.3070505@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:50170 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723AbaLWKVz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Dec 2014 05:21:55 -0500
Received: by mail-qa0-f41.google.com with SMTP id s7so4280118qap.28
        for <linux-mmc@vger.kernel.org>; Tue, 23 Dec 2014 02:21:54 -0800 (PST)
In-Reply-To: <54993A96.3070505@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Alim Akhtar <alim.akhtar@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Aisheng Dong <b29396@freescale.com>, Stephen Boyd <sboyd@codeaurora.org>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

On 23 December 2014 at 10:49, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi. Ulf.
>
> Your patch has bug..
> If last sample value is failed, then it's returned with error.
>
> I will recommend this. how about?
>
>  drivers/mmc/host/dw_mmc-exynos.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index d0d7aec..d6b8846 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -381,7 +381,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot)
>         struct mmc_host *mmc = slot->mmc;
>         u8 start_smpl, smpl, candiates = 0;
>         s8 found = -1;
> -       int ret = 0;
> +       int ret = 0, success;
>
>         start_smpl = dw_mci_exynos_get_clksmpl(host);
>
> @@ -389,8 +389,8 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot)
>                 mci_writel(host, TMOUT, ~0);
>                 smpl = dw_mci_exynos_move_next_clksmpl(host);
>
> -               ret = mmc_send_tuning(mmc);
> -               if (!ret)
> +               success = mmc_send_tuning(mmc);
> +               if (!success)
>                         candiates |= (1 << smpl);
>
>         } while (start_smpl != smpl);
> --
> 1.9.1
>

Urgh! Thanks a lot for spotting this Jaehoon! I will update my patch
according to your proposal. Sorry for all the noise I caused around
this.

Kind regards
Uffe
