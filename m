From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 10/11] mmc: mmci: Add Qcom variations to MCICommand register.
Date: Tue, 13 May 2014 10:29:35 +0200
Message-ID: <CACRpkdb--trcCguVGoh-uOvKju+1qbKdG2vE0eAOrwR+jZJ0rA@mail.gmail.com>
References: <1398759492-12970-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1398759662-13381-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1398759662-13381-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, agross@quicinc.com, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 29, 2014 at 10:21 AM,  <srinivas.kandagatla@linaro.org> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> Some bits which control Command Path State Machine (CPSM) are new in Qcom
> integration, so this patch adds support to those bits.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
(...)

> +       if (host->hw_designer == AMBA_VENDOR_QCOM &&
> +           mmc_cmd_type(cmd) == MMC_CMD_ADTC)
> +               c |= MCI_CSPM_QCOM_DATCMD;
> +

You know the drill. Use vendor data.

> +/* Modified on Qualcomm Integrations */
> +#define MCI_CSPM_QCOM_DATCMD           (1 << 12)
> +#define MCI_CSPM_QCOM_MCIABORT         (1 << 13)
> +#define MCI_CSPM_QCOM_CCSENABLE                (1 << 14)
> +#define MCI_CSPM_QCOM_CCSDISABLE       (1 << 15)
> +#define MCI_CSPM_QCOM_AUTO_CMD19       (1 << 16)
> +#define MCI_CSPM_QCOM_AUTO_CMD21       (1 << 21)

You know how to rename these defines too :-)

Yours,
Linus Walleij
