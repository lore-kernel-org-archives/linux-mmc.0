From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 12/40] mmc: tegra: Reconfigure pad voltages during
 voltage switching
Date: Thu, 9 Aug 2018 14:43:46 +0200
Message-ID: <20180809124346.GU21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-13-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+k4Drb7WGefOwc9B"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533141150-10511-13-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--+k4Drb7WGefOwc9B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:32:02PM +0300, Aapo Vienamo wrote:
> Parse the pinctrl state and nvidia,only-1-8-v properties from the device
> tree. Validate the pinctrl and regulator configuration before unmasking
> UHS modes. Implement pad voltage state reconfiguration in the mmc
> start_signal_voltage_switch() callback. Add NVQUIRK_NEEDS_PAD_CONTROL
> and add set it for Tegra210 and Tegra186.
>=20
> The pad configuration is done in the mmc callback because the order of
> pad reconfiguration and sdhci voltage switch depend on the voltage to
> which the transition occurs.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 138 +++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 131 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index ddf00166..7d98455 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -21,6 +21,8 @@
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
> @@ -55,6 +57,7 @@
>  #define NVQUIRK_ENABLE_SDR104		BIT(4)
>  #define NVQUIRK_ENABLE_DDR50		BIT(5)
>  #define NVQUIRK_HAS_PADCALIB		BIT(6)
> +#define NVQUIRK_NEEDS_PAD_CONTROL	BIT(7)
> =20
>  struct sdhci_tegra_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
> @@ -66,8 +69,12 @@ struct sdhci_tegra {
>  	struct gpio_desc *power_gpio;
>  	bool ddr_signaling;
>  	bool pad_calib_required;
> +	bool pad_control_available;
> =20
>  	struct reset_control *rst;
> +	struct pinctrl *pinctrl_sdmmc;
> +	struct pinctrl_state *pinctrl_state_3v3;
> +	struct pinctrl_state *pinctrl_state_1v8;
>  };
> =20
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -138,12 +145,46 @@ static unsigned int tegra_sdhci_get_ro(struct sdhci=
_host *host)
>  	return mmc_gpio_get_ro(host->mmc);
>  }
> =20
> +static bool tegra_sdhci_is_pad_and_regulator_valid(struct sdhci_host *ho=
st)
> +{
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host =3D sdhci_pltfm_priv(pltfm_host);
> +	int has_1v8, has_3v3;

Can these be boolean?

> +
> +	/*
> +	 * The SoCs which have NVQUIRK_NEEDS_PAD_CONTROL require software pad
> +	 * voltage configuration in order to perform voltage switching. This
> +	 * means that valid pinctrl info is required on SDHCI instances capable
> +	 * of performing voltage switching. Whether or not an SDHCI instance is
> +	 * capable of voltage switching is determined based on the regulator.
> +	 */
> +
> +	if (!(tegra_host->soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL))
> +		return true;
> +
> +	if (IS_ERR(host->mmc->supply.vqmmc))
> +		return false;
> +
> +	has_1v8 =3D regulator_is_supported_voltage(host->mmc->supply.vqmmc,
> +						 1700000, 1950000);
> +
> +	has_3v3 =3D regulator_is_supported_voltage(host->mmc->supply.vqmmc,
> +						 2700000, 3600000);
> +
> +	if (has_1v8 =3D=3D 1 && has_3v3 =3D=3D 1)
> +		return tegra_host->pad_control_available;
> +
> +	/* Fixed voltage, no pad control required. */
> +	return true;
> +}
> +
>  static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>  {
>  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>  	struct sdhci_tegra *tegra_host =3D sdhci_pltfm_priv(pltfm_host);
>  	const struct sdhci_tegra_soc_data *soc_data =3D tegra_host->soc_data;
>  	u32 misc_ctrl, clk_ctrl;
> +	bool pad_and_regulators_valid;

This seems to be used only once. Why not simply use the function call in
the if condition directly?

> =20
>  	sdhci_reset(host, mask);
> =20
> @@ -160,13 +201,8 @@ static void tegra_sdhci_reset(struct sdhci_host *hos=
t, u8 mask)
> =20
>  	clk_ctrl &=3D ~SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE;
> =20
> -	/*
> -	 * If the board does not define a regulator for the SDHCI
> -	 * IO voltage, then don't advertise support for UHS modes
> -	 * even if the device supports it because the IO voltage
> -	 * cannot be configured.
> -	 */
> -	if (!IS_ERR(host->mmc->supply.vqmmc)) {
> +	pad_and_regulators_valid =3D tegra_sdhci_is_pad_and_regulator_valid(hos=
t);
> +	if (pad_and_regulators_valid) {
>  		/* Erratum: Enable SDHCI spec v3.00 support */
>  		if (soc_data->nvquirks & NVQUIRK_ENABLE_SDHCI_SPEC_300)
>  			misc_ctrl |=3D SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300;
> @@ -286,6 +322,84 @@ static int tegra_sdhci_execute_tuning(struct sdhci_h=
ost *host, u32 opcode)
>  	return mmc_send_tuning(host->mmc, opcode, NULL);
>  }
> =20
> +static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage)
> +{
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host =3D sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	if (!tegra_host->pad_control_available)
> +		return 0;

This seems unnecessary. ->pad_control_available is set at the end of
tegra_sdhci_init_pinctrl_info() after we have successfully obtained
the various pinctrl states. At the same time, we only set up the
->start_signal_voltage_switch() callback when we have pinctrl states
available, so this is in fact a duplicate check, right? If we don't
pad control, then the callback will be NULL and we never and up
calling tegra_sdhci_set_padctrl().

> +
> +	if (voltage =3D=3D MMC_SIGNAL_VOLTAGE_180) {
> +		ret =3D pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> +					   tegra_host->pinctrl_state_1v8);
> +		if (ret < 0)
> +			dev_err(mmc_dev(host->mmc),
> +				"setting 1.8V failed, ret: %d\n", ret);
> +	} else {
> +		ret =3D pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> +					   tegra_host->pinctrl_state_3v3);
> +		if (ret < 0)
> +			dev_err(mmc_dev(host->mmc),
> +				"setting 3.3V failed, ret: %d\n", ret);
> +	}

Can we remove the ", ret" from these error messages. The user doesn't
understand what ret means in the context of this message. Just a:

	"... failed: %d\n"

is good enough.

> +
> +	return ret;
> +}
> +
> +static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
> +						   struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host =3D mmc_priv(mmc);
> +	int ret =3D 0;
> +
> +	if (ios->signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_330) {
> +		ret =3D tegra_sdhci_set_padctrl(host, ios->signal_voltage);
> +		if (ret < 0)
> +			return ret;
> +		ret =3D sdhci_start_signal_voltage_switch(mmc, ios);
> +	} else if (ios->signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_180) {
> +		ret =3D sdhci_start_signal_voltage_switch(mmc, ios);
> +		if (ret < 0)
> +			return ret;
> +		ret =3D tegra_sdhci_set_padctrl(host, ios->signal_voltage);
> +	}
> +
> +	return ret;
> +}
> +
> +static int tegra_sdhci_init_pinctrl_info(struct device *dev,
> +					 struct sdhci_tegra *tegra_host)
> +{
> +	tegra_host->pinctrl_sdmmc =3D devm_pinctrl_get(dev);
> +	if (IS_ERR(tegra_host->pinctrl_sdmmc)) {
> +		dev_dbg(dev, "No pinctrl info, err: %ld\n",
> +			PTR_ERR(tegra_host->pinctrl_sdmmc));
> +		return -1;
> +	}
> +
> +	tegra_host->pinctrl_state_3v3 =3D
> +		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-3v3");
> +	if (IS_ERR(tegra_host->pinctrl_state_3v3)) {
> +		dev_warn(dev, "Missing 3.3V pad state, err: %ld\n",
> +			 PTR_ERR(tegra_host->pinctrl_state_3v3));
> +		return -1;
> +	}
> +
> +	tegra_host->pinctrl_state_1v8 =3D
> +		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-1v8");
> +	if (IS_ERR(tegra_host->pinctrl_state_1v8)) {
> +		dev_warn(dev, "Missing 1.8V pad state, err: %ld\n",
> +			 PTR_ERR(tegra_host->pinctrl_state_3v3));
> +		return -1;
> +	}

Why not propagate the error message? I know we really only care about
success vs. failure in the caller, but it will be confusing to anyone
that may eventually end up looking at the error code to see -EPERM.

If we really don't care about the return error, why not just make the
function return a boolean (false for failure, true for success)?

Also, same as earlier, can we remove ", err" from the messages? That's
code specific context and doesn't belong in an error message.

> +
> +	tegra_host->pad_control_available =3D true;
> +
> +	return 0;
> +}
> +
>  static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> @@ -419,6 +533,7 @@ static const struct sdhci_pltfm_data sdhci_tegra210_p=
data =3D {
> =20
>  static const struct sdhci_tegra_soc_data soc_data_tegra210 =3D {
>  	.pdata =3D &sdhci_tegra210_pdata,
> +	.nvquirks =3D NVQUIRK_NEEDS_PAD_CONTROL,
>  };
> =20
>  static const struct sdhci_pltfm_data sdhci_tegra186_pdata =3D {
> @@ -442,6 +557,7 @@ static const struct sdhci_pltfm_data sdhci_tegra186_p=
data =3D {
> =20
>  static const struct sdhci_tegra_soc_data soc_data_tegra186 =3D {
>  	.pdata =3D &sdhci_tegra186_pdata,
> +	.nvquirks =3D NVQUIRK_NEEDS_PAD_CONTROL,
>  };
> =20
>  static const struct of_device_id sdhci_tegra_dt_match[] =3D {
> @@ -478,8 +594,16 @@ static int sdhci_tegra_probe(struct platform_device =
*pdev)
>  	tegra_host =3D sdhci_pltfm_priv(pltfm_host);
>  	tegra_host->ddr_signaling =3D false;
>  	tegra_host->pad_calib_required =3D false;
> +	tegra_host->pad_control_available =3D false;
>  	tegra_host->soc_data =3D soc_data;
> =20
> +	if (soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL) {

Nit: I think all of these quirks could eventually just move into boolean
flags to make tests like this easier to read. Nothing to worry about for
now, though.

Thierry

> +		rc =3D tegra_sdhci_init_pinctrl_info(&pdev->dev, tegra_host);
> +		if (rc =3D=3D 0)
> +			host->mmc_host_ops.start_signal_voltage_switch =3D
> +				sdhci_tegra_start_signal_voltage_switch;
> +	}
> +
>  	rc =3D mmc_of_parse(host->mmc);
>  	if (rc)
>  		goto err_parse_dt;
> --=20
> 2.7.4
>=20

--+k4Drb7WGefOwc9B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsNwAACgkQ3SOs138+
s6EfaQ/+Li6PshIp/xUg+7UqvksW4B5tK5JS5P1VtiH9ez4K/rxPOozQNHyl8XvI
1ZRBbJpfVvd0TxkhxHoXhTDYsE90kuCC0275J/cO5VeTq1sxTYx3bHVDFfHQ2IAd
Fx4FJ70IEAAJ3nr/wbWv43Xw0vFNv2nQcc0a+ujNhy7SibqjRca6GB5KeTovA/N8
da1YdDaFoCb911gMQ1hW67XAWVSITDJflCOk88U2IFHgL57pP6sH+08uMAVAbAqS
2Pzfz4kBfIBqR7EM6gvosZx/fXtjkZNSnDNK6BefOjepHhudmqw/53/UdUO4jRQI
xZq7zulIRibVN8kUDMUYq+IOu2D8Q8N3d3dmrh9BzLjd8lOCN22sgYyIACXI171E
uXwchhCfdZLKrP3Kw77wX4rKZMt8uH50L/GA4kbGrQaCFL6//4kiPJACqimR32D1
/VPbU4gwC0dDFxsdbfvIq6BefG2mwLFJsYV/nJ69Qj2/Cj3OGbY441gh1sk0B/Bc
KXd8yK400qwHPF91O4ToIQfH6KMMjBMg1iKJSVZKcTTfLZuVff1/aJ/vNqYARtlb
oH3DmBzyJGVFugFQ9zJeWBtBXfqUk760gzpA3Xzu0gudMu3QD9dpV7sjaB50VyKC
9O21vscexyr8IWOI7By18lgNTdycI20G06+ufUDdpXnggy7ROFM=
=v/1n
-----END PGP SIGNATURE-----

--+k4Drb7WGefOwc9B--
