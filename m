From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 3/3] mmc: dw_mmc: Don't start command while data busy
Date: Thu, 19 Feb 2015 16:21:31 -0800
Message-ID: <CAD=FV=WS_KG2XjQEtKPuBy__mtWDD3ja58rccEHxV=1XmBTCuw@mail.gmail.com>
References: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
	<1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
	<1423894668-8886-4-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423894668-8886-4-git-send-email-addy.ke@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Olof Johansson <olof@lixom.net>, Alim Akhtar <alim.akhtar@gmail.com>, Andrzej Hajda <a.hajda@samsung.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Eddie Cai <cf@rock-chips.com>, lintao <lintao@rock-chips.com>, Tao Huang <huangtao@rock-chips.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
List-Id: linux-mmc@vger.kernel.org

Addy,

On Fri, Feb 13, 2015 at 10:17 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> We should wait until unbusy before the next request.
> But this does't need if the command is CMD13, which can access
> SD Status register regardless of data busy.
>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
> Changes in v4:
> - CMD13 doesn't need wait until unbusy.
>
>  drivers/mmc/host/dw_mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ac21863..692d97a 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1076,6 +1076,10 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>
>         WARN_ON(slot->mrq);
>
> +       /* Wait until unbusy if the command isn't CMD13 */
> +       if (mrq->cmd->opcode != MMC_SEND_STATUS)
> +               dw_mci_wait_busy(slot);
> +

I think you need to be more general.  You really should be checking
"cmd_flags & SDMMC_CMD_PRV_DAT_WAIT".  That leverages dw_mmc's
knowledge about whether it needs to wait.  Right now you'll be waiting
for CMD52 (SDIO) which I don't think is a good idea.

It also seems like this would be better in dw_mci_start_command() so
that we have the least chance of hitting the case.  The downside is
that you can't sleep there, though...  Hrm.

I updated a version of my take on this at
<https://chromium-review.googlesource.com/#/c/244850/>.  I'll put a
timeout on it soon-ish.  Any extra testing that folks can do would be
appreciated...

-Doug
