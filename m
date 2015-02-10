From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: dw_mmc: fix bug that cause 'Timeout sending command'
Date: Tue, 10 Feb 2015 20:52:47 +0530
Message-ID: <CAGOxZ51wgw9iXF3xX39vnB0M5ZPb+zHWoCtTvvKdyo9bSOCVgw@mail.gmail.com>
References: <1423134801-23219-1-git-send-email-addy.ke@rock-chips.com>
 <1423466726-20833-1-git-send-email-addy.ke@rock-chips.com> <1423466726-20833-2-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423466726-20833-2-git-send-email-addy.ke@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>
Cc: robh+dt <robh+dt@kernel.org>, pawel.moll@arm.com, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, dinguyen@altera.com, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, Douglas Anderson <dianders@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, amstan@chromium.org, djkurtz@chromium.org, huangtao@rock-chips.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, hl@rock-chips.com, linux-doc@vger.kernel.org, yzq@rock-chips.com, zyw@rock-chips.com, zhangqing@rock-chips.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kever.yang@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

Hi Addy,

On Mon, Feb 9, 2015 at 12:55 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> Because of some uncertain factors, such as worse card or worse hardware,
> DAT[3:0](the data lines) may be pulled down by card, and mmc controller
> will be in busy state. This should not happend when mmc controller
> send command to update card clocks. If this happends, mci_send_cmd will
> be failed and we will get 'Timeout sending command', and then system will
> be blocked. To avoid this, we need reset mmc controller.
>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 4d2e3c2..b0b57e3 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -100,6 +100,7 @@ struct idmac_desc {
>  };
>  #endif /* CONFIG_MMC_DW_IDMAC */
>
> +static int dw_mci_card_busy(struct mmc_host *mmc);
>  static bool dw_mci_reset(struct dw_mci *host);
>  static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
>
> @@ -888,6 +889,31 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>                 cmd, arg, cmd_status);
>  }
>
> +static void dw_mci_wait_busy(struct dw_mci_slot *slot)
> +{
> +       struct dw_mci *host = slot->host;
> +       unsigned long timeout = jiffies + msecs_to_jiffies(500);
> +
Why 500 msec?

> +       do {
> +               if (!dw_mci_card_busy(slot->mmc))
> +                       return;
> +               cpu_relax();
> +       } while (time_before(jiffies, timeout));
> +
> +       dev_err(host->dev, "Data busy (status %#x)\n",
> +               mci_readl(slot->host, STATUS));
> +
> +       /*
> +        * Data busy, this should not happend when mmc controller send command
> +        * to update card clocks in non-volt-switch state. If it happends, we
> +        * should reset controller to avoid getting "Timeout sending command".
> +        */
> +       dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS);
> +
Why you need to reset all blocks? may be CTRL_RESET is good enough here.

> +       /* Fail to reset controller or still data busy, WARN_ON! */
> +       WARN_ON(dw_mci_card_busy(slot->mmc));
> +}
> +
>  static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>  {
>         struct dw_mci *host = slot->host;
> @@ -899,6 +925,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>         /* We must continue to set bit 28 in CMD until the change is complete */
>         if (host->state == STATE_WAITING_CMD11_DONE)
>                 sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
> +       else
> +               dw_mci_wait_busy(slot);
>
hmm...I would suggest you to call dw_mci_wait_busy() from inside
mci_send_cmd(), seems like dw_mmc hangs while sending update clock cmd
in multiple cases.see [1]

[1]: http://permalink.gmane.org/gmane.linux.kernel.mmc/31140

>         if (!clock) {
>                 mci_writel(host, CLKENA, 0);
> --
> 1.8.3.2
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Regards,
Alim
