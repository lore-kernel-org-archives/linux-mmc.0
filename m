From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 05/10] mmc: cb710: use to_platform_device()
Date: Mon, 28 Dec 2015 14:29:48 +0100
Message-ID: <CAPDyKFpE5+xHy9dBomRyFL=PAOnXoi2VSVQp7H+mAeTyWUjuWw@mail.gmail.com>
References: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
	<fc686afe2f3846425396bebe8cac7d3b76da42a2.1451221174.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fc686afe2f3846425396bebe8cac7d3b76da42a2.1451221174.git.geliangtang@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 27 December 2015 at 14:15, Geliang Tang <geliangtang@163.com> wrote:
> Use to_platform_device() instead of open-coding it.
>
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/cb710-mmc.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/cb710-mmc.h b/drivers/mmc/host/cb710-mmc.h
> index 8984ec8..8ecd9e5 100644
> --- a/drivers/mmc/host/cb710-mmc.h
> +++ b/drivers/mmc/host/cb710-mmc.h
> @@ -29,8 +29,7 @@ static inline struct mmc_host *cb710_slot_to_mmc(struct cb710_slot *slot)
>
>  static inline struct cb710_slot *cb710_mmc_to_slot(struct mmc_host *mmc)
>  {
> -       struct platform_device *pdev = container_of(mmc_dev(mmc),
> -               struct platform_device, dev);
> +       struct platform_device *pdev = to_platform_device(mmc_dev(mmc));
>         return cb710_pdev_to_slot(pdev);
>  }
>
> --
> 2.5.0
>
>
