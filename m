From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 02/14] mmc: mmci: Don't pretend all variants to have
 MCI_STARBITERR flag
Date: Mon, 15 Jan 2018 13:32:14 +0100
Message-ID: <CAPDyKFpqENchQs7c1BSJnorTgidbwHFAHByHJU3t9TV6uHurxA@mail.gmail.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com> <1515759368-16946-3-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1515759368-16946-3-git-send-email-patrice.chotard@st.com>
Sender: linux-clk-owner@vger.kernel.org
To: Patrice CHOTARD <patrice.chotard@st.com>
Cc: Russell King <linux@armlinux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Andrea Merello <andrea.merello@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 12 January 2018 at 13:15,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> This patch prepares for supporting the STM32 variant that
> has no such bit in the status register.
>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>  drivers/mmc/host/mmci.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 3125dc0..7e56f85 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -83,6 +83,8 @@
>   * @qcom_dml: enables qcom specific dma glue for dma transfers.
>   * @reversed_irq_handling: handle data irq before cmd irq.
>   * @mmcimask1: true if variant have a MMCIMASK1 register.
> + * @start_err: true is the variant has STARTBITERR bit inside MMCISTATUS
> + *            register.
>   */
>  struct variant_data {
>         unsigned int            clkreg;
> @@ -113,6 +115,7 @@ struct variant_data {
>         bool                    qcom_dml;
>         bool                    reversed_irq_handling;
>         bool                    mmcimask1;
> +       bool                    start_err;

To be consistent with how we implement support for similar variant
variations, I would prefer to have this being a u32. Something along
the lines of how the "busy_detect_flag" is being used.

Otherwise this looks good to me.

[...]

Kind regards
Uffe
