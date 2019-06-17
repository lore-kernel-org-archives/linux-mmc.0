From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 2/2] mmc: mediatek: fix SDIO IRQ detection issue
Date: Mon, 17 Jun 2019 13:35:13 +0200
Message-ID: <CAPDyKFoTBhCy2bB8uzzDTNMBPnNjD81134BGt2Op3USFCW1R7Q@mail.gmail.com>
References: <1560769448-23070-1-git-send-email-jjian.zhou@mediatek.com> <1560769448-23070-2-git-send-email-jjian.zhou@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560769448-23070-2-git-send-email-jjian.zhou@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jjian Zhou <jjian.zhou@mediatek.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yong Mao <yong.mao@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 17 Jun 2019 at 13:04, Jjian Zhou <jjian.zhou@mediatek.com> wrote:
>
> From: jjian zhou <jjian.zhou@mediatek.com>
>
> If cmd19 timeout or response crcerr occurs during execute_tuning(),
> it need invoke msdc_reset_hw(). Otherwise SDIO IRQ can't be detected.
>
> Signed-off-by: jjian zhou <jjian.zhou@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>

Applied for fixes and by adding a fixes/stable tag, thanks!


> ---
>  drivers/mmc/host/mtk-sd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index fa7d420..ba1ad5e 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1031,6 +1031,8 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
>         msdc_track_cmd_data(host, mrq->cmd, mrq->data);
>         if (mrq->data)
>                 msdc_unprepare_data(host, mrq);
> +       if (host->error)
> +               msdc_reset_hw(host);
>         mmc_request_done(host->mmc, mrq);
>  }
>
> --
> 1.9.1
>
