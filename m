From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 03/14] mmc: core: Add mmc-card dt sub-node parse in
 core layer
Date: Wed, 15 Mar 2017 13:43:44 +0100
Message-ID: <CAPDyKFoqxMCSe-2bt2dz1AM_2X7dtVe4w6e7+oAQ==HO_=XKQw@mail.gmail.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <34e51d32c82b57571e061e80df3bbaed731db554.1487091464.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <34e51d32c82b57571e061e80df3bbaed731db554.1487091464.git-series.gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Turquette <mturquette@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, linux-clk <linux-clk@vger.kernel.org>, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lis>
List-Id: linux-mmc@vger.kernel.org

On 14 February 2017 at 18:01, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> From: Hu Ziji <huziji@marvell.com>
>
> Some vendor host, like Xenon, can support multiple types.
> In dts, use mmc-card dt sub-node to indicate eMMC is in use.
>
> Add a generic mmc-card parse function in mmc core layer.
> If mmc-card sub-node is detected, set eMMC common caps, such as
> MMC_CAP_NONREMOVABLE, MMC_CAP2_NO_SD and MMC_CAP2_NO_SDIO.
>
> Since it is likely that struct mmc_card is not allocated yet when
> this mmc-card parse function is called, it will return true if
> mmc-card sub-node is detected. Otherwise, return false.
> It can help vendor host determine if the card type is eMMC.
>
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/mmc/core/mmc.c   | 24 ++++++++++++++++++++++++
>  include/linux/mmc/core.h |  2 ++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index b61b52f9da3d..dc480006a303 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2111,6 +2111,30 @@ static const struct mmc_bus_ops mmc_ops = {
>  };
>
>  /*
> + * Parse mmc-card dt sub-node and set eMMC common caps
> + * if mmc-card exists.
> + * If mmc-card is detected, return true.
> + * Otherwise, return false.
> + */
> +bool mmc_of_parse_mmc_card(struct mmc_host *host)
> +{
> +       struct device_node *np;
> +       bool ret = false;
> +
> +       np = mmc_of_find_child_device(host, 0);

There are already some places in the mmc core where child nodes are
being parsed. You may have a look for mmc_of_find_child_device() and
find the callers of it.

Additionally, we need a generic method of how to describe in DT, when
an mmc host controller has more than one mmc slot. This will also be
done using child nodes.

So, before starting hacking on this, it seems like we need some
consolidation of the code. In principle, I would like to move the APIs
for parsing of the child nodes into host.c, along with existing
mmc_of_parse() function.

> +       if (np && of_device_is_compatible(np, "mmc-card")) {
> +               /* mmc-card sub-node indicates eMMC card is in use. */
> +               host->caps |= MMC_CAP_NONREMOVABLE;
> +               host->caps2 |= MMC_CAP2_NO_SDIO | MMC_CAP2_NO_SD;
> +               ret = true;
> +       }
> +

So instead of providing a new mmc OF parse API, let's make
mmc_of_parse() call another internal function which deals with child
node parsing.

> +       of_node_put(np);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(mmc_of_parse_mmc_card);
> +
> +/*
>   * Starting point for MMC card init.
>   */
>  int mmc_attach_mmc(struct mmc_host *host)
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index e33cc748dcfe..1b27323f3b6e 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -234,4 +234,6 @@ struct device_node;
>  extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
>  extern int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
>
> +extern bool mmc_of_parse_mmc_card(struct mmc_host *host);
> +
>  #endif /* LINUX_MMC_CORE_H */
> --
> git-series 0.9.1

If you didn't quite understand my comments, then please tell me. Then
I can help out cooking some patches for you.

Kind regards
Uffe
