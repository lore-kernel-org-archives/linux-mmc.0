From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1 linux-next] mmc: mmc-test: use swap() in mmc_test_nonblock_transfer()
Date: Fri, 22 May 2015 15:47:39 +0200
Message-ID: <CAPDyKFpWbQUC785MvYb215GYj=TQ=RPaWz=oYge2RHMCpY_5FQ@mail.gmail.com>
References: <1431971578-20700-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:35503 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035AbbEVNrk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2015 09:47:40 -0400
Received: by qchk10 with SMTP id k10so8081472qch.2
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2015 06:47:39 -0700 (PDT)
In-Reply-To: <1431971578-20700-1-git-send-email-fabf@skynet.be>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 18 May 2015 at 19:52, Fabian Frederick <fabf@skynet.be> wrote:
> Use kernel.h macro definition.
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Thanks, applied.

Kind regards
Uffe

> ---
>  drivers/mmc/card/mmc_test.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> index 5e90b3f..b78cf5d 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -820,9 +820,7 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
>                                 mmc_test_nonblock_reset(&mrq1, &cmd1,
>                                                         &stop1, &data1);
>                 }
> -               done_areq = cur_areq;
> -               cur_areq = other_areq;
> -               other_areq = done_areq;
> +               swap(cur_areq, other_areq);
>                 dev_addr += blocks;
>         }
>
> --
> 2.4.0
>
