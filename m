From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 039/102] mmc: sdhci-st: explicitly request exclusive reset control
Date: Thu, 27 Jul 2017 16:49:00 +0200
Message-ID: <CAPDyKFo5mKZefG0jdd=qo0n+qup5HyjpH_DgehyNHnXuZDdCtQ@mail.gmail.com>
References: <20170719152646.25903-1-p.zabel@pengutronix.de> <20170719152646.25903-40-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-40-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Patrice Chotard <patrice.chotard@st.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 19 July 2017 at 17:25, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
>
> No functional changes.
>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>


Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-st.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index 68c36c9fa2318..ad1ab0777d5f6 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -371,7 +371,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
>         if (IS_ERR(icnclk))
>                 icnclk = NULL;
>
> -       rstc = devm_reset_control_get(&pdev->dev, NULL);
> +       rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
>         if (IS_ERR(rstc))
>                 rstc = NULL;
>         else
> --
> 2.11.0
>
