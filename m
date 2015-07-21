From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] mmc: sunxi: Don't start commands while
 the card is busy
Date: Tue, 21 Jul 2015 14:15:51 +0200
Message-ID: <CAPDyKFoNe0bghfSXs48stHzZToTc7Hjd5gVPy-VbDF8bzdVVMQ@mail.gmail.com>
References: <1436541284-11800-1-git-send-email-hdegoede@redhat.com>
Reply-To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDF57NG2XIHRB57PXCWQKGQEO5DZESA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1436541284-11800-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Eugene K <sigintmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 10 July 2015 at 17:14, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Some sdio wifi modules have not been working reliable with the sunxi-mmc
> host code. This turns out to be caused by it starting new commands while
> the card signals that it is still busy processing a previous command.

Which are those commands? Or more interesting, which response types do
these commands expect?
I don't think this is a sunxi specific issue, I have seen similar
issues for other host controllers.

I am thinking that perhaps this should be managed by the mmc core
instead of local hacks to sunxi. Potentially we could make the core to
invoke the already existing host_ops->card_busy() callback when
needed...

Within this context, could I ask whether you controller supports IRQ
based HW-busy detection? Or you need polling of the status register?

>
> This commit fixes this, thereby fixing the wifi reliability issues on
> the Cubietruck and other sunxi boards using sdio wifi.
>
> Reported-by: Eugene K <sigintmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Suggested-by: Eugene K <sigintmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Eugene K <sigintmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> Changes in v2:
> -Properly accredit Eugene K for coming up with the fix for this
> ---
>  drivers/mmc/host/sunxi-mmc.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 4d3e1ff..daa90b7 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -289,6 +289,24 @@ static int sunxi_mmc_init_host(struct mmc_host *mmc)
>         return 0;
>  }
>
> +/* Wait for card to report ready before starting a new cmd */
> +static int sunxi_mmc_wait_card_ready(struct sunxi_mmc_host *host)
> +{
> +       unsigned long expire = jiffies + msecs_to_jiffies(500);
> +       u32 rval;
> +
> +       do {
> +               rval = mmc_readl(host, REG_STAS);
> +       } while (time_before(jiffies, expire) && (rval & SDXC_CARD_DATA_BUSY));
> +
> +       if (rval & SDXC_CARD_DATA_BUSY) {
> +               dev_err(mmc_dev(host->mmc), "Error R1 ready timeout\n");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
>  static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
>                                     struct mmc_data *data)
>  {
> @@ -383,6 +401,8 @@ static void sunxi_mmc_send_manual_stop(struct sunxi_mmc_host *host,
>         u32 arg, cmd_val, ri;
>         unsigned long expire = jiffies + msecs_to_jiffies(1000);
>
> +       sunxi_mmc_wait_card_ready(host);
> +
>         cmd_val = SDXC_START | SDXC_RESP_EXPIRE |
>                   SDXC_STOP_ABORT_CMD | SDXC_CHECK_RESPONSE_CRC;
>
> @@ -597,6 +617,11 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>  {
>         unsigned long expire = jiffies + msecs_to_jiffies(250);
>         u32 rval;
> +       int ret;
> +
> +       ret = sunxi_mmc_wait_card_ready(host);
> +       if (ret)
> +               return ret;
>
>         rval = mmc_readl(host, REG_CLKCR);
>         rval &= ~(SDXC_CARD_CLOCK_ON | SDXC_LOW_POWER_ON);
> @@ -785,6 +810,13 @@ static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 return;
>         }
>
> +       ret = sunxi_mmc_wait_card_ready(host);
> +       if (ret) {
> +               mrq->cmd->error = ret;
> +               mmc_request_done(mmc, mrq);
> +               return;
> +       }
> +
>         if (data) {
>                 ret = sunxi_mmc_map_dma(host, data);
>                 if (ret < 0) {
> --
> 2.4.3
>

Kind regards
Uffe
