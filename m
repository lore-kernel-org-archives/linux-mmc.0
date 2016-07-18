From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: core: expose MMC_CAP2_NO_* to dt
Date: Mon, 18 Jul 2016 13:20:30 +0200
Message-ID: <CAPDyKFpxk_ZpJNTndqoWgcq2+tx6D4cDDadur0DoQ7VEx+SSiQ@mail.gmail.com>
References: <1468484764-32353-1-git-send-email-shawn.lin@rock-chips.com> <1468484764-32353-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468484764-32353-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 14 July 2016 at 10:26, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> The reason for why we expose these to dt is that some of
> the controller is unable to send special cmd type due to
> the hw limitation.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

>
> ---
>
> Changes in v2:
> - amend the commit msg
>
>  drivers/mmc/core/host.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index d7e86f9..98f25ff 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -315,6 +315,12 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
>         if (of_property_read_bool(np, "mmc-hs400-enhanced-strobe"))
>                 host->caps2 |= MMC_CAP2_HS400_ES;
> +       if (of_property_read_bool(np, "no-sdio"))
> +               host->caps2 |= MMC_CAP2_NO_SDIO;
> +       if (of_property_read_bool(np, "no-sd"))
> +               host->caps2 |= MMC_CAP2_NO_SD;
> +       if (of_property_read_bool(np, "no-mmc"))
> +               host->caps2 |= MMC_CAP2_NO_MMC;
>
>         host->dsr_req = !of_property_read_u32(np, "dsr", &host->dsr);
>         if (host->dsr_req && (host->dsr & ~0xffff)) {
> --
> 2.3.7
>
>
