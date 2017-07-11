From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: block: Initialize ret in mmc_blk_issue_drv_op()
 for MMC_DRV_OP_IOCTL
Date: Tue, 11 Jul 2017 16:44:16 +0200
Message-ID: <CAPDyKFqd0BfYoVMreFMmbERRcJws7sHswbgqm2A_DswFWbcUwQ@mail.gmail.com>
References: <1499267382-28438-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36016 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933161AbdGKOoR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 10:44:17 -0400
Received: by mail-qk0-f182.google.com with SMTP id p21so2634970qke.3
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jul 2017 07:44:17 -0700 (PDT)
In-Reply-To: <1499267382-28438-1-git-send-email-geert@linux-m68k.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 5 July 2017 at 17:09, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> With gcc 4.1.2:
>
>     drivers/mmc/core/block.c: In function =E2=80=98mmc_blk_issue_drv_op=
=E2=80=99:
>     drivers/mmc/core/block.c:1178: warning: =E2=80=98ret=E2=80=99 may be =
used uninitialized in this function
>
> Indeed, for MMC_DRV_OP_IOCTL, if mq_rq->ioc_count is zero, an
> uninitialized value will be stored in mq_rq->drv_op_result and passed to
> blk_end_request_all().
>
> Can mq_rq->ioc_count be zero?
>   - mmc_blk_ioctl_cmd() sets ioc_count to 1, so this is safe,
>   - mmc_blk_ioctl_multi_cmd() obtains ioc_count from user space in
>     response to the MMC_IOC_MULTI_CMD ioctl, and does allow zero.
>
> Initialize ret to zero to fix this for current and future callers.
>
> Fixes: 0493f6fe5bdee8ac ("mmc: block: Move boot partition locking into a =
driver op")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
> v2, as suggested by Arnd:
>   - Move the assignment after "case MMC_DRV_OP_IOCTL", to keep getting
>     compile-time checks on the state of the 'ret' variable,
>   - Initialize ret to zero instead of -EINVAL.
> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 0cfac2d391073922..4920ea1ece38a9b6 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1182,7 +1182,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *=
mq, struct request *req)
>
>         switch (mq_rq->drv_op) {
>         case MMC_DRV_OP_IOCTL:
> -               for (i =3D 0; i < mq_rq->ioc_count; i++) {
> +               for (i =3D 0, ret =3D 0; i < mq_rq->ioc_count; i++) {
>                         ret =3D __mmc_blk_ioctl_cmd(card, md, mq_rq->idat=
a[i]);
>                         if (ret)
>                                 break;
> --
> 2.7.4
>
