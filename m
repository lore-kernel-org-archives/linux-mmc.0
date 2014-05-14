From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: card: restrict access to RPMB partition
Date: Wed, 14 May 2014 13:37:45 +0200
Message-ID: <CAPDyKFpBzz5xDfnNGsiH6tb8G5+nRFg5fgPssJt3DU3dSFuuug@mail.gmail.com>
References: <1399642762-11149-1-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1399642762-11149-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Cc: Grant Grundler <grundler@chromium.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, Kukjin Kim <kgene.kim@samsung.com>, joshi@samsung.com, Tomasz Figa <t.figa@samsung.com>, Andrew Bresticker <abrestic@chromium.org>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 9 May 2014 15:39, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
>
> The RPMB partition should only be accessed through the RPMB ioctls
> and not through read()/write().  This patch makes mmc_blk_open()
> reject open attempts to the RPMB partition in read or write mode.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>  drivers/mmc/card/block.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 452782b..fd59090 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -297,7 +297,15 @@ static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
>                         check_disk_change(bdev);
>                 ret = 0;
>
> -               if ((mode & FMODE_WRITE) && md->read_only) {
> +               /*
> +                * Reject read/write access to the RPMB partition.  It should
> +                * only be accessed through ioctls.
> +                */
> +               if ((mode & (FMODE_READ | FMODE_WRITE)) &&
> +                   md->area_type & MMC_BLK_DATA_AREA_RPMB) {
> +                       mmc_blk_put(md);
> +                       ret = -EACCES;

How shall user space be able to receive a file descriptor, unless it's
allowed to open the device?

Kind regards
Ulf Hansson
