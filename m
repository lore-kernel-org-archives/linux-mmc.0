Received: from mail-m822136163.xmail.ntesmail.com (mail-m822136163.xmail.ntesmail.com [8.221.36.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9F93D76;
	Thu, 15 Jan 2026 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=8.221.36.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768436732; cv=none; b=UyQ9yYFH4eAG7kP+U3DVzxCw2M/yxNkfroWYX5wgsnx6SqrqhUmWLuk2lv9V/wIPOlKys9iNoYa8FR9rF3DRFg3xtLRs+FzOqYHzmY04aOpJfP87F1pmsGwFpmzo+eJYR6e/VrPp5YPqaBx4R9ws5X7vy8CIAxp4JghIqDbJF0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768436732; c=relaxed/simple;
	bh=EXQrhJIMe3v6R1gl4+ziZzeA394iCGahgPPQYPrVyfc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vu7oxARedXZdudgkhF+A26iWBVRNUYbaolNvrhmWASg5iJJl/z57Z59J3StXtniBLKCno6kiz/pTf/ipj6fTQlQJeEl4B/Hfa7rEggRrwm281DfVIKZZJrpiDXtKDSisJRuv4nisWkCaeKUvOoxwLS4pIQvCKPDGk34AoAgPigA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BxhOpBRT; arc=none smtp.client-ip=8.221.36.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BxhOpBRT"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30af7ff73;
	Thu, 15 Jan 2026 08:25:20 +0800 (GMT+08:00)
Message-ID: <b49b223e-e728-4ce9-b972-242ed9b5fa4a@rock-chips.com>
Date: Thu, 15 Jan 2026 08:25:17 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-rockchip@lists.infradead.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, heiko@sntech.de, ulf.hansson@linaro.org
Subject: Re: [PATCH v1 0/3] mmc: dw_mmc-rockchip: Add stability quirk for
 NanoPi R76S
To: Marco Schirrmeister <mschirrmeister@gmail.com>
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
 <67ccb8f6-f9bd-4266-b79a-b688bd6d030b@rock-chips.com>
 <8536413c-8687-4d75-befb-8f25e54838bf@rock-chips.com>
 <6934ae0d-16c5-436f-97f6-c11d304ca51d@rock-chips.com>
 <CAGJh8eDXT43_PfmUbShL4Hysfkd21R=sCerRNe_AGQANbwvSPA@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAGJh8eDXT43_PfmUbShL4Hysfkd21R=sCerRNe_AGQANbwvSPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bbf0ae48909cckunmf5ba25fc501b74
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkwZSVYaSExMTk1CGh5KSRhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BxhOpBRTnQz+GPMIuPHkTUo8xgEUj3FoCSXW6s6PPy6OzyKosh4qIlUkrCft0RHY5hB8sma8mOnoGsD2/ynKIdEgaFgTzt1Tuv7raFbq7O0p21F9Z96Bl2QUbKDo39AB9n0HHNOjAjl8Q0LDzBio2SGKNaXeTGNwtLwIx5qgycs=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=B4QfrPMND0dKajSMmYvgDtwoZx9Otg3YeOPfV5ej2AA=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/15 星期四 3:51, Marco Schirrmeister 写道:
> Hello Shawn,
> 
> On Wed, Jan 14, 2026 at 9:08 AM Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> Except for the patch mentioned above for fixing the hot-plug problem
>> which you confirmed to work fine. I looked the code a bit and see
>> a potential problem related to the runtime suspend + power-domain.
>> Please check the patch to see if it fixes your problem:
> 
> I tested your patch and the issue is still present. For verification I did
> add some debug statements and just to see what it saves and restores.
> 
> The symbols are there.
> root@nanopi-r76s ~# grep dw_mci_rockchip_runtime /proc/kallsyms
> ffff800080bf27a0 t dw_mci_rockchip_runtime_suspend
> ffff800080bf29c0 t dw_mci_rockchip_runtime_resume
> 
> # dmesg output
> [Wed Jan 14 20:13:46 2026] E220d: Restoring phases: sample=231, drv=180
> [Wed Jan 14 20:13:46 2026] mmc_host mmc1: Bus speed (slot 0) = 400000Hz
> [Wed Jan 14 20:13:47 2026] mmc_host mmc1: Bus speed (slot 0) = 198000000Hz
> [Wed Jan 14 20:13:47 2026] dwmmc_rockchip 2a310000.mmc: Successfully
> tuned phase to 232
> [Wed Jan 14 20:13:48 2026] E220d: Saving phases: sample=231, drv=180
> [Wed Jan 14 20:13:48 2026] E220d: Restoring phases: sample=231, drv=180
> [Wed Jan 14 20:13:48 2026] mmc_host mmc1: Bus speed (slot 0) = 400000Hz
> [Wed Jan 14 20:13:48 2026] mmc_host mmc1: Bus speed (slot 0) = 198000000Hz
> [Wed Jan 14 20:13:48 2026] dwmmc_rockchip 2a310000.mmc: Successfully
> tuned phase to 231
> [Wed Jan 14 20:13:48 2026] E220d: Saving phases: sample=231, drv=180
> 
> Based on this, it makes me believe that power to the sd card is completely cut
> and when it wakes up and knows how to continue, it still must go through the
> retraining phase.
> 

This is another mistake for your NanoPi R76S board. Before sent this
patch, I already checked the dts and saw sdmmc uses vmmc-supply =
<&vcc_3v3_s3> which is marked as regulator-always-on, but it's *NOT*
actually per the shcematic[1][2]. So need another fix for your board
to make it actually gpio-based power controller instaed of function
IO based, as when powering off the power domain, the power control bit
will not be able to maintain.


[1] 
https://wiki.friendlyelec.com/wiki/images/6/60/NanoPi_R76S_LP4X_2411_SCH.pdf
[2] 
https://wiki.friendlyelec.com/wiki/images/9/90/NanoPi_R76S_LP5_2411_SCH.pdf

Except for the patches you have tested, please append the blow patch as 
well to test.

--- a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
@@ -192,6 +192,18 @@
                 regulator-name = "vcc_3v3_s0";
                 vin-supply = <&vcc_3v3_s3>;
         };
+
+       vcc3v3_sd: regulator-vcc-3v3-sd {
+               compatible = "regulator-fixed";
+               enable-active-high;
+               gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
+               pinctrl-names = "default";
+               pinctrl-0 = <&sdmmc_pwren>;
+               regulator-name = "vcc3v3_sd";
+               regulator-min-microvolt = <3300000>;
+               regulator-max-microvolt = <3300000>;
+               vin-supply = <&vcc_3v3_s0>;
+       };
  };

  &combphy0_ps {
@@ -726,6 +738,12 @@
                 };
         };

+       sdmmc {
+               sdmmc_pwren: sdmmc-pwren {
+                       rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO 
&pcfg_pull_none>;
+               };
+       };
+
         usb {
                 usb_otg0_pwren_h: usb-otg0-pwren-h {
                         rockchip,pins = <0 RK_PD1 RK_FUNC_GPIO 
&pcfg_pull_none>;
@@ -751,11 +769,14 @@
         bus-width = <4>;
         cap-mmc-highspeed;
         cap-sd-highspeed;
+       cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
         disable-wp;
         no-mmc;
         no-sdio;
+       pinctrl-names = "default";
+       pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_det &sdmmc0_bus4>;
         sd-uhs-sdr104;
-       vmmc-supply = <&vcc_3v3_s3>;
+       vmmc-supply = <&vcc3v3_sd>;
         vqmmc-supply = <&vccio_sd_s0>;
         status = "okay";




>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>> @@ -36,6 +36,8 @@ struct dw_mci_rockchip_priv_data {
>>           int                     default_sample_phase;
>>           int                     num_phases;
>>           bool                    internal_phase;
>> +       int                     sample_phase;
>> +       int                     drv_phase;
>>    };
>>
>>    /*
>> @@ -573,9 +575,43 @@ static void dw_mci_rockchip_remove(struct
>> platform_device *pdev)
>>           dw_mci_pltfm_remove(pdev);
>>    }
>>
>> +static int dw_mci_rockchip_runtime_suspend(struct device *dev)
>> +{
>> +       struct platform_device *pdev = to_platform_device(dev);
>> +       struct dw_mci *host = platform_get_drvdata(pdev);
>> +       struct dw_mci_rockchip_priv_data *priv = host->priv;
>> +
>> +       if (priv->internal_phase) {
>> +               priv->sample_phase = rockchip_mmc_get_phase(host, true);
>> +               priv->drv_phase = rockchip_mmc_get_phase(host, false);
>> +       }
>> +
>> +       return dw_mci_runtime_suspend(dev);
>> +}
>> +
>> +static int dw_mci_rockchip_runtime_resume(struct device *dev)
>> +{
>> +       struct platform_device *pdev = to_platform_device(dev);
>> +       struct dw_mci *host = platform_get_drvdata(pdev);
>> +       struct dw_mci_rockchip_priv_data *priv = host->priv;
>> +       int ret;
>> +
>> +       ret = dw_mci_runtime_resume(dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (priv->internal_phase) {
>> +               rockchip_mmc_set_phase(host, true, priv->sample_phase);
>> +               rockchip_mmc_set_phase(host, false, priv->drv_phase);
>> +               mci_writel(host, MISC_CON, MEM_CLK_AUTOGATE_ENABLE);
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>>    static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
>>           SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> pm_runtime_force_resume)
>> -       RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
>> +       RUNTIME_PM_OPS(dw_mci_rockchip_runtime_suspend,
>> dw_mci_rockchip_runtime_resume, NULL)
>>    };
>>
>>    static struct platform_driver dw_mci_rockchip_pltfm_driver = {
> 

