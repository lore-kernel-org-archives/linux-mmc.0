From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH RFC 10/12] mmc: mmci: Add clock support for Qualcomm.
Date: Mon, 21 Apr 2014 15:20:45 -0700
Message-ID: <535599BD.1020605@codeaurora.org>
References: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org> <1398116945-31640-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398116945-31640-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: linux-mmc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, agross@quicinc.com, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 04/21/14 14:49, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> MCICLK going to card bus is directly driven by the clock controller, so the
> driver has to set the required rates depending on the state of the card. This
> bit of support is very much similar to bypass mode but there is no such thing
> called bypass mode in MCICLK register of Qcom SD card controller. By default
> the clock is directly driven by the clk controller.
>
> This patch adds clock support for Qualcomm SDCC in the driver. This bit of
> code is conditioned on hw designer.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/mmc/host/mmci.c |   16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index f465eb5..2cd3a8f 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -291,7 +291,18 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
>  	host->cclk = 0;
>  
>  	if (desired) {
> -		if (desired >= host->mclk) {
> +		if (desired != host->mclk &&
> +		    host->hw_designer == AMBA_VENDOR_QCOM) {
> +			/* Qcom MCLKCLK register does not define bypass bits */
> +			int rc = clk_set_rate(host->clk, desired);

Please turn on lockdep (PROVE_LOCKING) and sleeping while atomic checks
(DEBUG_ATOMIC_SLEEP). You cannot call clk_set_rate() in atomic context.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
