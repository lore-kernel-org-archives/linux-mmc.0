From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 04/11] mmc: sdhci-of-arasan: Properly set
 corecfg_baseclkfreq on rk3399
Date: Mon, 13 Jun 2016 16:36:59 +0800
Message-ID: <f5dcc018-bd60-87a7-798b-efc261e443dd@rock-chips.com>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-5-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:54152 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964880AbcFMIho (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2016 04:37:44 -0400
In-Reply-To: <1465339484-969-5-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc: shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

=D4=DA 2016/6/8 6:44, Douglas Anderson =D0=B4=B5=C0:
> In the the earlier change in this series ("Documentation: mmc:
> sdhci-of-arasan: Add soc-ctl-syscon for corecfg regs") we can see the
> mechansim for specifying a syscon to properly set corecfg registers i=
n
> sdhci-of-arasan.  Now let's use this mechanism to properly set
> corecfg_baseclkfreq on rk3399.
>
>>From [1] the corecfg_baseclkfreq is supposed to be set to:
>   Base Clock Frequency for SD Clock.
>   This is the frequency of the xin_clk.
>
> This is a relatively easy thing to do.  Note that we assume that xin_=
clk
> is not dynamic and we can check the clock at probe time.  If any real
> devices have a dynamic xin_clk future patches could register for
> notifiers for the clock.
>
> At the moment, setting corecfg_baseclkfreq is only supported for rk33=
99
> since we need a specific map for each implementation.  The code is
> written in a generic way that should make this easy to extend to othe=
r
> SoCs.  Note that a specific compatible string for rk3399 is already i=
n
> use and so we add that to the table to match rk3399.
>
> [1]: https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-=
1-3.pdf
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 189 +++++++++++++++++++++++++++=
+++++++---
>  1 file changed, 178 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sd=
hci-of-arasan.c
> index 3ff1711077c2..859ea1b21215 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -22,6 +22,8 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>

alphabetical order

>  #include "sdhci-pltfm.h"
>
>  #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
> @@ -32,18 +34,115 @@
>  #define CLK_CTRL_TIMEOUT_MASK		(0xf << CLK_CTRL_TIMEOUT_SHIFT)
>  #define CLK_CTRL_TIMEOUT_MIN_EXP	13
>
> +/*
> + * On some SoCs the syscon area has a feature where the upper 16-bit=
s of
> + * each 32-bit register act as a write mask for the lower 16-bits.  =
This allows
> + * atomic updates of the register without locking.  This macro is us=
ed on SoCs
> + * that have that feature.
> + */
> +#define HIWORD_UPDATE(val, mask, shift) \
> +		((val) << (shift) | (mask) << ((shift) + 16))
> +
> +/**
> + * struct sdhci_arasan_soc_ctl_field - Field used in sdhci_arasan_so=
c_ctl_map
> + *
> + * @reg:	Offset within the syscon of the register containing this fi=
eld
> + * @width:	Number of bits for this field
> + * @shift:	Bit offset within @reg of this field (or -1 if not avail)
> + */
> +struct sdhci_arasan_soc_ctl_field {
> +	u32 reg;
> +	u16 width;
> +	s16 shift;
> +};
> +
> +/**
> + * struct sdhci_arasan_soc_ctl_map - Map in syscon to corecfg regist=
ers
> + *
> + * It's up to the licensee of the Arsan IP block to make these avail=
able
> + * somewhere if needed.  Presumably these will be scattered somewher=
e that's
> + * accessible via the syscon API.
> + *
> + * @baseclkfreq:	Where to find corecfg_baseclkfreq
> + * @hiword_update:	If true, use HIWORD_UPDATE to access the syscon
> + */
> +struct sdhci_arasan_soc_ctl_map {
> +	struct sdhci_arasan_soc_ctl_field	baseclkfreq;
> +	bool					hiword_update;
> +};
> +
>  /**
>   * struct sdhci_arasan_data
> - * @clk_ahb:	Pointer to the AHB clock
> - * @phy:	Pointer to the generic phy
> - * @phy_on:	True if the PHY is turned on.
> + * @clk_ahb:		Pointer to the AHB clock
> + * @phy:		Pointer to the generic phy
> + * @phy_on:		True if the PHY is turned on.
> + * @soc_ctl_base:	Pointer to regmap for syscon for soc_ctl registers=
=2E
> + * @soc_ctl_map:	Map to get offsets into soc_ctl registers.
>   */
>  struct sdhci_arasan_data {
>  	struct clk	*clk_ahb;
>  	struct phy	*phy;
>  	bool		phy_on;
> +
> +	struct regmap	*soc_ctl_base;
> +	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
> +};
> +
> +static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map =3D =
{
> +	.baseclkfreq =3D { .reg =3D 0xf000, .width =3D 8, .shift =3D 8 },
> +	.hiword_update =3D true,
>  };
>
> +/**
> + * sdhci_arasan_syscon_write - Write to a field in soc_ctl registers
> + *
> + * This function allows writing to fields in sdhci_arasan_soc_ctl_ma=
p.
> + * Note that if a field is specified as not available (shift < 0) th=
en
> + * this function will silently return an error code.  It will be noi=
sy
> + * and print errors for any other (unexpected) errors.
> + *
> + * @host:	The sdhci_host
> + * @fld:	The field to write to
> + * @val:	The value to write
> + */
> +static int sdhci_arasan_syscon_write(struct sdhci_host *host,
> +				   const struct sdhci_arasan_soc_ctl_field *fld,
> +				   u32 val)
> +{
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan =3D sdhci_pltfm_priv(pltfm_h=
ost);
> +	struct regmap *soc_ctl_base =3D sdhci_arasan->soc_ctl_base;
> +	u32 reg =3D fld->reg;
> +	u16 width =3D fld->width;
> +	s16 shift =3D fld->shift;
> +	int ret;
> +
> +	/*
> +	 * Silently return errors for shift < 0 so caller doesn't have
> +	 * to check for fields which are optional.  For fields that
> +	 * are required then caller needs to do something special
> +	 * anyway.
> +	 */
> +	if (shift < 0)
> +		return -EINVAL;
> +
> +	if (sdhci_arasan->soc_ctl_map->hiword_update)
> +		ret =3D regmap_write(soc_ctl_base, reg,
> +				   HIWORD_UPDATE(val, GENMASK(width, 0),
> +						 shift));
> +	else
> +		ret =3D regmap_update_bits(soc_ctl_base, reg,
> +					 GENMASK(shift + width, shift),
> +					 val << shift);
> +
> +	/* Yell about (unexpected) regmap errors */
> +	if (ret)
> +		pr_warn("%s: Regmap write fail: %d\n",
> +			 mmc_hostname(host->mmc), ret);
> +
> +	return ret;
> +}
> +
>  static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host=
 *host)
>  {
>  	u32 div;
> @@ -191,9 +290,66 @@ static int sdhci_arasan_resume(struct device *de=
v)
>  static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspe=
nd,
>  			 sdhci_arasan_resume);
>
> +static const struct of_device_id sdhci_arasan_of_match[] =3D {
> +	/* SoC-specific compatible strings w/ soc_ctl_map */
> +	{
> +		.compatible =3D "rockchip,rk3399-sdhci-5.1",
> +		.data =3D &rk3399_soc_ctl_map,
> +	},
> +
> +	/* Generic compatible below here */
> +	{ .compatible =3D "arasan,sdhci-8.9a" },
> +	{ .compatible =3D "arasan,sdhci-5.1" },
> +	{ .compatible =3D "arasan,sdhci-4.9a" },
> +
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> +
> +/**
> + * sdhci_arasan_update_baseclkfreq - Set corecfg_baseclkfreq
> + *
> + * The corecfg_baseclkfreq is supposed to contain the MHz of clk_xin=
=2E  This
> + * function can be used to make that happen.
> + *
> + * NOTES:
> + * - Many existing devices don't seem to do this and work fine.  To =
keep
> + *   compatibility for old hardware where the device tree doesn't pr=
ovide a
> + *   register map, this function is a noop if a soc_ctl_map hasn't b=
een provided
> + *   for this platform.
> + * - It's assumed that clk_xin is not dynamic and that we use the SD=
HCI divider
> + *   to achieve lower clock rates.  That means that this function is=
 called once
> + *   at probe time and never called again.
> + *
> + * @host:		The sdhci_host
> + */
> +static void sdhci_arasan_update_baseclkfreq(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan =3D sdhci_pltfm_priv(pltfm_h=
ost);
> +	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map =3D
> +		sdhci_arasan->soc_ctl_map;
> +	u32 mhz =3D DIV_ROUND_CLOSEST(clk_get_rate(pltfm_host->clk), 100000=
0);
> +

It's broken when reading capabilities reg on RK3399 platform
which means you should get it via clk framework. But you should conside=
r
the non-broken case.

> +	/* Having a map is optional */
> +	if (!soc_ctl_map)
> +		return;
> +
> +	/* If we have a map, we expect to have a syscon */
> +	if (!sdhci_arasan->soc_ctl_base) {
> +		pr_warn("%s: Have regmap, but no soc-ctl-syscon\n",
> +			mmc_hostname(host->mmc));
> +		return;
> +	}
> +
> +	sdhci_arasan_syscon_write(host, &soc_ctl_map->baseclkfreq, mhz);

should we check the return value, and if not -EINVAL, we should give
another try?

> +}
> +
>  static int sdhci_arasan_probe(struct platform_device *pdev)
>  {
>  	int ret;
> +	const struct of_device_id *match;
> +	struct device_node *node;
>  	struct clk *clk_xin;
>  	struct sdhci_host *host;
>  	struct sdhci_pltfm_host *pltfm_host;
> @@ -207,6 +363,23 @@ static int sdhci_arasan_probe(struct platform_de=
vice *pdev)
>  	pltfm_host =3D sdhci_priv(host);
>  	sdhci_arasan =3D sdhci_pltfm_priv(pltfm_host);
>
> +	match =3D of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
> +	sdhci_arasan->soc_ctl_map =3D match->data;
> +
> +	node =3D of_parse_phandle(pdev->dev.of_node, "arasan,soc-ctl-syscon=
", 0);

should it be within the scope of arasan,sdhci-5.1 or
rockchip,rk3399-sdhci-5.1?

> +	if (node) {
> +		sdhci_arasan->soc_ctl_base =3D syscon_node_to_regmap(node);
> +		of_node_put(node);
> +
> +		if (IS_ERR(sdhci_arasan->soc_ctl_base)) {
> +			ret =3D PTR_ERR(sdhci_arasan->soc_ctl_base);
> +			if (ret !=3D -EPROBE_DEFER)
> +				dev_err(&pdev->dev, "Can't get syscon: %d\n",
> +					ret);
> +			goto err_pltfm_free;
> +		}
> +	}
> +
>  	sdhci_arasan->clk_ahb =3D devm_clk_get(&pdev->dev, "clk_ahb");
>  	if (IS_ERR(sdhci_arasan->clk_ahb)) {
>  		dev_err(&pdev->dev, "clk_ahb clock not found.\n");
> @@ -236,6 +409,8 @@ static int sdhci_arasan_probe(struct platform_dev=
ice *pdev)
>  	sdhci_get_of_property(pdev);
>  	pltfm_host->clk =3D clk_xin;
>
> +	sdhci_arasan_update_baseclkfreq(host);
> +
>  	ret =3D mmc_of_parse(host->mmc);
>  	if (ret) {
>  		dev_err(&pdev->dev, "parsing dt failed (%u)\n", ret);
> @@ -301,14 +476,6 @@ static int sdhci_arasan_remove(struct platform_d=
evice *pdev)
>  	return ret;
>  }
>
> -static const struct of_device_id sdhci_arasan_of_match[] =3D {
> -	{ .compatible =3D "arasan,sdhci-8.9a" },
> -	{ .compatible =3D "arasan,sdhci-5.1" },
> -	{ .compatible =3D "arasan,sdhci-4.9a" },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> -
>  static struct platform_driver sdhci_arasan_driver =3D {
>  	.driver =3D {
>  		.name =3D "sdhci-arasan",
>


--=20
Best Regards
Shawn Lin

