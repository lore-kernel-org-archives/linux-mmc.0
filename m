From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/7] mmc: usdhi6rol0: use to_delayed_work
Date: Wed, 27 Jan 2016 15:15:18 +0100
Message-ID: <CAPDyKFoS2q4-4KXQTZ9Ki54QNqJM6=itLFiH2koW3QFpmuuJfQ@mail.gmail.com>
References: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
	<a595f073abf2bc9fca98c411e20a1af593b9719d.1451659910.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a595f073abf2bc9fca98c411e20a1af593b9719d.1451659910.git.geliangtang@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>
Cc: Rabin Vincent <rabin.vincent@axis.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 1 January 2016 at 15:59, Geliang Tang <geliangtang@163.com> wrote:
> Use to_delayed_work() instead of open-coding it.
>
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Thanks, applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/usdhi6rol0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index b47122d..b2752fe 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1630,7 +1630,7 @@ static irqreturn_t usdhi6_cd(int irq, void *dev_id)
>   */
>  static void usdhi6_timeout_work(struct work_struct *work)
>  {
> -       struct delayed_work *d = container_of(work, struct delayed_work, work);
> +       struct delayed_work *d = to_delayed_work(work);
>         struct usdhi6_host *host = container_of(d, struct usdhi6_host, timeout_work);
>         struct mmc_request *mrq = host->mrq;
>         struct mmc_data *data = mrq ? mrq->data : NULL;
> --
> 2.5.0
>
>
