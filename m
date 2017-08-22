From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-msm: Utilize bulk clock API
Date: Tue, 22 Aug 2017 12:38:18 +0200
Message-ID: <CAPDyKFquBaa1U3HzsMGwNJRiw4wRsB=cUGeqoP5bngbanH46ug@mail.gmail.com>
References: <20170818175506.5035-1-bjorn.andersson@linaro.org> <20170818175506.5035-2-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170818175506.5035-2-bjorn.andersson@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On 18 August 2017 at 19:55, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> By stuffing the runtime controlled clocks into a clk_bulk_data array we
> can utilize the newly introduced bulk clock operations and clean up the
> error paths. This allow us to handle additional clocks in subsequent
> patch, without the added complexity.
>
> Cc: Ritesh Harjani <riteshh@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 44 ++++++++++++++++----------------------------
>  1 file changed, 16 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index fc73e56eb1e2..71e01cbc38b6 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -131,6 +131,7 @@ struct sdhci_msm_host {
>         struct clk *pclk;       /* SDHC peripheral bus clock */
>         struct clk *bus_clk;    /* SDHC bus voter clock */
>         struct clk *xo_clk;     /* TCXO clk needed for FLL feature of cm_dll*/
> +       struct clk_bulk_data bulk_clks[2];

Adding bulk clocks, should also enable you to remove the core/pclk
from the struct sdhci_mcm_host, no?

[...]

Kind regards
Uffe
