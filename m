From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: RE: [PATCH V3 3/3] mmc: tegra: SDMMC pads auto-calibration
Date: Thu, 10 Jan 2019 19:19:47 +0000
Message-ID: <BN7PR12MB283603C485B9B4B04E742FFFC2840@BN7PR12MB2836.namprd12.prod.outlook.com>
References: <1546462674-22856-1-git-send-email-skomatineni@nvidia.com>
 <1546462674-22856-3-git-send-email-skomatineni@nvidia.com>
 <20190110150602.GC25353@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110150602.GC25353@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

>> @@ -805,6 +854,12 @@ static int tegra_sdhci_init_pinctrl_info(struct dev=
ice *dev,
>>  		return -1;
>>  	}
>> =20
>> +	tegra_host->pinctrl_state_1v8_drv =3D pinctrl_lookup_state(
>> +				tegra_host->pinctrl_sdmmc, "sdmmc-1v8-drv");
>> +
>> +	tegra_host->pinctrl_state_3v3_drv =3D pinctrl_lookup_state(
>> +				tegra_host->pinctrl_sdmmc, "sdmmc-3v3-drv");
>
>If this truly is optional, then I suggest we do something like this
>instead:

On tegra210, these settings are part of pinmux so using pinctrl to pinmux d=
evice node with existing properties pull-up and pull-down strength to confi=
gure timeout values.
On tegra186 and later, these settings are part of sdmmc controller itself s=
o using existing pullup and pulldown timeout properties within sdmmc device=
 node itself.

>From sdhci driver perspective, if pinctrl state exists (which is the case o=
f tegra210), it uses it to configure drive settings otherwise (tegra186 & t=
egra194) it configures drive settings in pad register with in sdmmc domain =
itself.
So in away presence of sdmmc-1v8-drv and sdmmc-3v3-drv state is optional as=
 they apply only for tegra210.
>From sdhci-tegra drive perspective,  it shouldn't return error on absence o=
f these states as these states are not used for tegra186 and tegra194 and i=
nstead use drive strengths time out properties.
Will add check in drive to return error on absence of both sdmmc-3v3-drv, s=
dmmc-1v8-drv pinctrl states along with drive settings properties with in sd=
mmc device node...

>
>	tegra_host->pinctrl_state_1v8_drv =3D pinctrl_lookup_state(...);
>	if (IS_ERR(tegra_host->pinctrl_state_1v8_drv)) {
>		err =3D PTR_ERR(tegra_host->pinctrl_state_1v8_drv);
>
>		if (err =3D=3D -ENODEV)
>			tegra_host->pinctrl_state_1v8_drv =3D NULL;
>		else
>			return err;
>	}
>
>With that we can use the much simpler condition everywhere:
>
>	if (tegra_host->pinctrl_state_1v8_drv)
>		...
>
>Thierry
