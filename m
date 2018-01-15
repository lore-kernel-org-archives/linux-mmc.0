From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 04/14] mmc: mmci: Add STM32 variant
Date: Mon, 15 Jan 2018 02:13:20 +0100
Message-ID: <CACRpkdYVDpmEmrF=Zk1zX8RCRnPDieTgPuCen6KQ4ttFpAm+Yg@mail.gmail.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com> <1515759368-16946-5-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1515759368-16946-5-git-send-email-patrice.chotard@st.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Patrice CHOTARD <patrice.chotard@st.com>
Cc: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-gpio@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Andrea Merello <andrea.merello@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 12, 2018 at 1:15 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> STM32F4 and STM32F7 MCUs has a SDIO controller that looks like
> an ARM pl810.

PL180 you mean. Ulf can fix while applying.

> This patch adds the STM32 variant so that mmci driver supports it.
>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

(...)
> +static struct variant_data variant_stm32 = {
> +       .fifosize               = 32 * 4,
> +       .fifohalfsize           = 8 * 4,
> +       .clkreg                 = MCI_CLK_ENABLE,
> +       .clkreg_enable          = MCI_ST_UX500_HWFCEN,

If the asic designed derived this from ux500 I guess it is proper.

> +       .clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
> +       .clkreg_neg_edge_enable = MCI_ST_UX500_NEG_EDGE,
> +       .datalength_bits        = 24,
> +       .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
> +       .st_sdio                = true,

Did you test SDIO? I think we lack features for that.

> +       {
> +               .id     = 0x00880180,
> +               .mask   = 0x00ffffff,
> +               .data   = &variant_stm32,
> +       },

Since ux500 was 480180 I wonder what variants 5,6,7 are...

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
