From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [mmc] mmc: core: mmc_blk_rw_cmd_err - remove unused variable
Date: Thu, 16 Mar 2017 15:46:07 +0100
Message-ID: <CAPDyKFrizfVA_tLUCxqnbv767+Xg9jO8+T+UUbWX6sJ5URroKw@mail.gmail.com>
References: <20170309145821.8849-1-tomas.winkler@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33369 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753517AbdCPOqT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Mar 2017 10:46:19 -0400
Received: by mail-vk0-f51.google.com with SMTP id d188so25232538vka.0
        for <linux-mmc@vger.kernel.org>; Thu, 16 Mar 2017 07:46:13 -0700 (PDT)
In-Reply-To: <20170309145821.8849-1-tomas.winkler@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 9 March 2017 at 15:58, Tomas Winkler <tomas.winkler@intel.com> wrote:
> Fix compilation warning:
>
> drivers/mmc/core/block.c:1563:24: warning: variable =E2=80=98mq_rq=E2=80=
=99 set but not
> used [-Wunused-but-set-variable]  struct mmc_queue_req *mq_rq;
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 1621fa08e206..87f8091f936c 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1560,11 +1560,8 @@ static bool mmc_blk_rw_cmd_err(struct mmc_blk_data=
 *md, struct mmc_card *card,
>                                struct mmc_blk_request *brq, struct reques=
t *req,
>                                bool old_req_pending)
>  {
> -       struct mmc_queue_req *mq_rq;
>         bool req_pending;
>
> -       mq_rq =3D container_of(brq, struct mmc_queue_req, brq);
> -
>         /*
>          * If this is an SD card and we're writing, we can first
>          * mark the known good sectors as ok.
> --
> 2.9.3
>
