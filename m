From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: RE: [PATCH V2 1/3] dt-bindings: mmc: tegra: Add pinctrl for pad drive
 strength config
Date: Sat, 29 Dec 2018 00:08:02 +0000
Message-ID: <BN7PR12MB2836C77E851E7AC4BCD38BF0C2B00@BN7PR12MB2836.namprd12.prod.outlook.com>
References: <1545260153-11338-1-git-send-email-skomatineni@nvidia.com>
 <20181227213353.GA8110@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181227213353.GA8110@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Mikko Perttunen <mperttunen@nvidia.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Preetham Chandru <pchandru@nvidia.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Rob,

>> Add pinctrl for 3V3 and 1V8 pad drive strength configuration for
>> Tegra210 sdmmc which has pad configuration registers in the pinmux=20
>> reigster domain.
>
> typo
>
>>=20
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6=20
>> +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>=20
>> diff --git=20
>> a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt=20
>> b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
>> index 32b4b4e41923..2cecdc71d94c 100644
>> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
>> @@ -39,12 +39,16 @@ sdhci@c8000200 {
>>  	bus-width =3D <8>;
>>  };
>> =20
>> -Optional properties for Tegra210 and Tegra186:
>> +Optional properties for Tegra210, Tegra186 and Tegra194:
>
>Adding Tegra194, but this patch concerns Tegra210...
Yes this is mainly part of Tegra210 Patch but pinctrls sdmmc-1v8 and sdmmc-=
3v3
also applies for Tegra194 and since it was not mentioned, added Tegra194 as=
 well.
Does adding Tegra194 in this should come as separate patch?
>
>>  - pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
>>    configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
>>    for controllers supporting multiple voltage levels. The order of name=
s
>>    should correspond to the pin configuration states in pinctrl-0 and
>>    pinctrl-1.
>> +- pinctrl-names : "sdmmc-3v3-drv" and "sdmmc-1v8-drv" are applicable=20
>> +for
>
>These are in addition to the previous values?
Yes these are additional pinctrl states for pad drive settings which are in=
 pinmux
Domain and are applicable during calibration process.
>
>> +  Tegra210 where pad config registers are in the pinmux register=20
>> + domain  for pull-up-strength and pull-down-strength values=20
>> + configuration when  using pads at 3V3 and 1V8 levels.
>>  - nvidia,only-1-8-v : The presence of this property indicates that the
>>    controller operates at a 1.8 V fixed I/O voltage.
>>  - nvidia,pad-autocal-pull-up-offset-3v3,
>> --
>> 2.7.4
>>=20

Thanks & Regards,
sowjanya
