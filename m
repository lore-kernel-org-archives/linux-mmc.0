From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dt: tegra: Add sdhci regulators
Date: Tue, 23 Oct 2012 12:42:11 -0600
Message-ID: <5086E503.8090604@wwwdotorg.org>
References: <1350976740-19284-1-git-send-email-pkunapuli@nvidia.com> <1350976740-19284-2-git-send-email-pkunapuli@nvidia.com> <4346406.Jy2o1pWcOR@ax5200p>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4346406.Jy2o1pWcOR@ax5200p>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org>
Cc: Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 10/23/2012 12:07 PM, Marc Dietrich wrote:
> Pavan,
> 
> On Tuesday 23 October 2012 12:48:59 Pavan Kunapuli wrote:
>> Adding vmmc and vmmcq supplies for sdhci nodes
>> in tegra dt files.
> 
> <...>
> 
>> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts
>> b/arch/arm/boot/dts/tegra20-paz00.dts index 6a93d14..e161b65 100644
>> --- a/arch/arm/boot/dts/tegra20-paz00.dts
>> +++ b/arch/arm/boot/dts/tegra20-paz00.dts
>> @@ -422,13 +422,17 @@
>>  		status = "okay";
>>  		cd-gpios = <&gpio 173 0>; /* gpio PV5 */
>>  		wp-gpios = <&gpio 57 0>;  /* gpio PH1 */
>> -		power-gpios = <&gpio 169 0>; /* gpio PV1 */
>>  		bus-width = <4>;
>> +		vmmc-supply = <&vddio_sd_reg>;
>> +		vqmmc-supply = <&vddio_sd_reg>;
>>  	};
>>
>>  	sdhci@c8000600 {
>>  		status = "okay";
>>  		bus-width = <8>;
>> +		vmmc-supply = <&vddio_sdmmc_reg>;
>> +		vqmmc-supply = <&vddio_sdmmc_reg>;
> 
> to make it better, this should be:
> 
> vmmc-supply = <&vcore_mmc_reg>; and
> vqmmc-supply = <&vddio_nand_reg>;
> 
> with vcore_mmc_reg is ldo5 and vddio_nand_reg is the fixed regulator below.

I think for the eMMC (not SD card), the core supply is actually +3vs_s3,
and hence fixed; it looks like LDO5 used to be used, but they changed
it. See the note for the VCC connections on the eMMC chip.

> By doing so, I get "sdhci-tegra sdhci-tegra.3: could not set regulator OCR 
> (-1)". MMC subsys wants to set ldo5 to 3.3V but it is fixed. I guess that's 
> harmless for now. 

What I mention above might end up fixing that?
