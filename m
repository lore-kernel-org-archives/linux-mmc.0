From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: block: Avoid uninitialized warning in mmc_blk_issue_discard_rq()
Date: Thu, 29 Dec 2016 20:02:51 +0100
Message-ID: <CAPDyKFpFfsovCcmAqvuYXxy9VDQhsHzXABXg0JXKtzPGgWMrCw@mail.gmail.com>
References: <1482156225-32517-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482156225-32517-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 19 December 2016 at 15:03, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
> With gcc-4.1.2:
>
>     mmc/core/block.c: In function =E2=80=98mmc_blk_issue_discard_rq=E2=80=
=99:
>     mmc/core/block.c:1150: warning: =E2=80=98arg=E2=80=99 may be used uni=
nitialized in this function
>     mmc/core/block.c:1150: warning: =E2=80=98nr=E2=80=99 may be used unin=
itialized in this function
>     mmc/core/block.c:1150: warning: =E2=80=98from=E2=80=99 may be used un=
initialized in this function
>
> While this is a false positive, it can be avoided easily by jumping over
> the checks for "err" that are always false.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index bab3f07b1117ea81..8c0e0833d481cf94 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1152,7 +1152,7 @@ static int mmc_blk_issue_discard_rq(struct mmc_queu=
e *mq, struct request *req)
>
>         if (!mmc_can_erase(card)) {
>                 err =3D -EOPNOTSUPP;
> -               goto out;
> +               goto fail;
>         }
>
>         from =3D blk_rq_pos(req);
> @@ -1181,6 +1181,7 @@ static int mmc_blk_issue_discard_rq(struct mmc_queu=
e *mq, struct request *req)
>                 goto retry;
>         if (!err)
>                 mmc_blk_reset_success(md, type);
> +fail:
>         blk_end_request(req, err, blk_rq_bytes(req));
>
>         return err ? 0 : 1;
> --
> 1.9.1
>
