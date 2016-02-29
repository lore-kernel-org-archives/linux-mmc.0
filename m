From: Shawn Lin <shawn.lin@kernel-upstream.org>
Subject: Re: MMC broken in kernel 4.4
Date: Mon, 29 Feb 2016 21:06:17 +0800
Message-ID: <56D44249.7070200@kernel-upstream.org>
References: <hubert_tonneau/BJJ9BVJR/0G321OJ19@hubert-tonneau.storga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:53548 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbcB2NOb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Feb 2016 08:14:31 -0500
In-Reply-To: <hubert_tonneau/BJJ9BVJR/0G321OJ19@hubert-tonneau.storga.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, shawn.lin@kernel-upstream.org

On 2016/2/29 18:17, Hubert Tonneau wrote:
> Hi everybody,
>
> MMC support seems to be broken on kernel 4.4.X as opposed to kernel 4.3.X on Lenovo Yoga 8 inch tablet.

Do you have this part of code[0] in your repository?

[0]: https://patchwork.kernel.org/patch/7323541/

>
> Kernel 4.3.X report:
> <6>[    2.051236] mmc0: MAN_BKOPS_EN bit is not set
> <6>[    2.077376] mmc0: new HS200 MMC card at address 0001
> <6>[    2.078390] mmcblk0: mmc0:0001 SEM32G 29.1 GiB
> <6>[    2.078940] mmcblk0boot0: mmc0:0001 SEM32G partition 1 4.00 MiB
> <6>[    2.079505] mmcblk0boot1: mmc0:0001 SEM32G partition 2 4.00 MiB
> <6>[    2.079952] mmcblk0rpmb: mmc0:0001 SEM32G partition 3 4.00 MiB
> <6>[    2.085209]  mmcblk0: p1 p2
> <6>[    2.222903] mmc1: new ultra high speed DDR50 SDIO card at address 0001
>
> Kernel 4.4.X report:
> <6>[    2.102615] mmc0: MAN_BKOPS_EN bit is not set
> <6>[    2.114463] mmc0: new HS200 MMC card at address 0001
> <6>[    2.115505] mmcblk0: mmc0:0001 SEM32G 29.1 GiB
> <6>[    2.115779] mmcblk0boot0: mmc0:0001 SEM32G partition 1 4.00 MiB
> <6>[    2.116101] mmcblk0boot1: mmc0:0001 SEM32G partition 2 4.00 MiB
> <6>[    2.116395] mmcblk0rpmb: mmc0:0001 SEM32G partition 3 4.00 MiB
> <6>[    2.119932]  mmcblk0: p1 p2
> <6>[    2.267193] sdhci: Timeout waiting for Buffer Read Ready interrupt during tuning procedure, falling back to fixed sampling clock
> <3>[    2.267200] mmc1: tuning execution failed
> <3>[    2.267273] mmc1: error -5 whilst initialising SDIO card
> <3>[    2.277268] mmc1: Controller never released inhibit bit(s).
> <3>[    2.279733] mmc1: Unexpected interrupt 0x04000000.
> <6>[    2.427192] sdhci: Timeout waiting for Buffer Read Ready interrupt during tuning procedure, falling back to fixed sampling clock
> <3>[    2.427198] mmc1: tuning execution failed
> <3>[    2.427250] mmc1: error -5 whilst initialising SDIO card
> <3>[    2.437254] mmc1: Controller never released inhibit bit(s).
> <3>[    2.439836] mmc1: Unexpected interrupt 0x04000000.
> <6>[    2.591191] sdhci: Timeout waiting for Buffer Read Ready interrupt during tuning procedure, falling back to fixed sampling clock
> <3>[    2.591197] mmc1: tuning execution failed
> <3>[    2.591259] mmc1: error -5 whilst initialising SDIO card
> <3>[    2.601253] mmc1: Controller never released inhibit bit(s).
> <3>[    2.603792] mmc1: Unexpected interrupt 0x04000000.
> <6>[    2.779193] sdhci: Timeout waiting for Buffer Read Ready interrupt during tuning procedure, falling back to fixed sampling clock
> <3>[    2.779199] mmc1: tuning execution failed
> <3>[    2.779262] mmc1: error -5 whilst initialising SDIO card
> <3>[    2.789256] mmc1: Controller never released inhibit bit(s).
> <3>[    2.791753] mmc1: Unexpected interrupt 0x04000000.
>
> The result is that SDIO devices (Broadcom wifi and bluetooth) are not listed when running kernel 4.4.X as opposed to 4.3.X
>
> Here is the report of the harware inside the Lenovo Yoga 8 inch tablet:
> acpi 80860F09:00 acpi:80860F09:80860F09: pwm_lpss_platform pwm_lpss_platform
> acpi 80860F09:01 acpi:80860F09:80860F09: pwm_lpss_platform pwm_lpss_platform
> acpi 80860F0A:00 acpi:80860F0A:80860F0A: 8250_dw 8250_dw
> acpi 80860F0A:01 acpi:80860F0A:80860F0A: 8250_dw 8250_dw
> acpi 80860F0E:00 acpi:80860F0E:80860F0E: spi_pxa2xx_platform spi_pxa2xx_platform
> acpi 80860F14:00 acpi:80860F14:PNP0D40:
> acpi 80860F14:01 acpi:80860F14:PNP0D40:
> acpi 80860F28:00 acpi:80860F28:80860F28: snd_soc_sst_acpi+snd_intel_sst_acpi snd_soc_sst_acpi+snd_intel_sst_acpi
> acpi 80860F41:00 acpi:80860F41:80860F41: i2c_designware_platform i2c_designware_platform
> acpi 80860F41:01 acpi:80860F41:80860F41: i2c_designware_platform i2c_designware_platform
> acpi 80860F41:02 acpi:80860F41:80860F41: i2c_designware_platform i2c_designware_platform
> acpi 80860F41:03 acpi:80860F41:80860F41: i2c_designware_platform i2c_designware_platform
> acpi 80860F41:04 acpi:80860F41:80860F41: i2c_designware_platform i2c_designware_platform
> acpi 80860F41:05 acpi:80860F41:80860F41: i2c_designware_platform i2c_designware_platform
> acpi 80860F41:06 acpi:80860F41:80860F41: i2c_designware_platform i2c_designware_platform
> acpi ACCL0001:00 acpi:ACCL0001:INTACEL:
> acpi ACPI0003:00 acpi:ACPI0003:
> acpi ACPI000C:00 acpi:ACPI000C:ACPI000C: acpi_pad acpi_pad
> acpi BCM2E84:00 acpi:BCM2E84:
> acpi CALS0001:00 acpi:CALS0001:INTLALS:
> acpi HISP0011:00 acpi:HISP0011:HISP0011:
> acpi IMPJ0001:00 acpi:IMPJ0001:IMPJ0001:
> acpi IMPJ0002:00 acpi:IMPJ0002:IMPJ0002:
> acpi IMPJ0003:00 acpi:IMPJ0003:IMPJ0003:
> acpi INT0002:00 acpi:INT0002:INT0002:
> acpi INT0800:00 acpi:INT0800:
> acpi INT3396:00 acpi:INT3396:PNP0D80:
> acpi INT33BB:00 acpi:INT33BB:PNP0D40:
> acpi INT33BD:00 acpi:INT33BD:INT33BD:
> acpi INT33FC:00 acpi:INT33FC:INT33FC:
> acpi INT33FC:01 acpi:INT33FC:INT33FC:
> acpi INT33FC:02 acpi:INT33FC:INT33FC:
> acpi INT33FD:00 acpi:INT33FD:INT33FD:
> acpi INT3400:00 acpi:INT3400: int3400_thermal int3400_thermal
> acpi INT3401:00 acpi:INT3401: processor_thermal_device processor_thermal_device
> acpi INT3402:00 acpi:INT3402: int3402_thermal int3402_thermal
> acpi INT3403:00 acpi:INT3403: int3403_thermal int3403_thermal
> acpi INT3403:01 acpi:INT3403: int3403_thermal int3403_thermal
> acpi INT3403:02 acpi:INT3403: int3403_thermal int3403_thermal
> acpi INT3403:03 acpi:INT3403: int3403_thermal int3403_thermal
> acpi INT3403:04 acpi:INT3403: int3403_thermal int3403_thermal
> acpi INT3406:00 acpi:INT3406:
> acpi INT3407:00 acpi:INT3407:
> acpi INT3409:00 acpi:INT3409:
> acpi INTCFD9:00 acpi:INTCFD9:PNP0C40: soc_button_array soc_button_array
> acpi INTL9C60:00 acpi:INTL9C60: dw_dmac dw_dmac
> acpi INTL9C60:01 acpi:INTL9C60: dw_dmac dw_dmac
> acpi LNV4752:00 acpi:LNV4752: rfkill_gpio rfkill_gpio
> acpi LNXCPU:00 acpi:LNXCPU:
> acpi LNXCPU:01 acpi:LNXCPU:
> acpi LNXCPU:02 acpi:LNXCPU:
> acpi LNXCPU:03 acpi:LNXCPU:
> acpi LNXPOWER:00 acpi:LNXPOWER:
> acpi LNXPOWER:01 acpi:LNXPOWER:
> acpi LNXPOWER:02 acpi:LNXPOWER:
> acpi LNXPOWER:03 acpi:LNXPOWER:
> acpi LNXPOWER:04 acpi:LNXPOWER:
> acpi LNXPOWER:05 acpi:LNXPOWER:
> acpi LNXPOWER:06 acpi:LNXPOWER:
> acpi LNXSYBUS:00 acpi:LNXSYBUS:
> acpi LNXSYBUS:01 acpi:LNXSYBUS:
> acpi LNXSYSTM:00 acpi:LNXSYSTM:
> acpi LNXTHERM:00 acpi:LNXTHERM:
> acpi LNXVIDEO:00 acpi:LNXVIDEO: video video
> acpi MAGN0001:00 acpi:MAGN0001:INTMAGN:
> acpi MAX17047:00 acpi:MAX17047:MAX17047:
> acpi MCD0001:00 acpi:MCD0001:MCD0001:
> acpi MSFT0101:00 acpi:MSFT0101: tpm_crb tpm_crb
> acpi MXM1120:00 acpi:MXM1120:
> acpi OVTI8865:00 acpi:OVTI8865:OVTI8865:
> acpi OVTI9760:00 acpi:OVTI9760:OVTI9760:
> acpi PNP0000:00 acpi:PNP0000:
> acpi PNP0100:00 acpi:PNP0100:
> acpi PNP0103:00 acpi:PNP0103:
> acpi PNP0501:00 acpi:PNP0501: 8250_fintek 8250_fintek
> acpi PNP0A08:00 acpi:PNP0A08:PNP0A03:
> acpi PNP0B00:00 acpi:PNP0B00:
> acpi PNP0C02:00 acpi:PNP0C02:
> acpi PNP0C02:01 acpi:PNP0C02:
> acpi PNP0C0A:00 acpi:PNP0C0A:
> acpi PNP0C0D:00 acpi:PNP0C0D:
> acpi PNP0C0F:00 acpi:PNP0C0F:
> acpi PNP0C0F:01 acpi:PNP0C0F:
> acpi PNP0C0F:02 acpi:PNP0C0F:
> acpi PNP0C0F:03 acpi:PNP0C0F:
> acpi PNP0C0F:04 acpi:PNP0C0F:
> acpi PNP0C0F:05 acpi:PNP0C0F:
> acpi PNP0C0F:06 acpi:PNP0C0F:
> acpi PNP0C0F:07 acpi:PNP0C0F:
> acpi SMB0349:00 acpi:SMB0349:SMB0349:
> acpi SRCL0001:00 acpi:SRCL0001:INTSRCL:
> acpi SYNA0001:00 acpi:SYNA0001:PNP0C50: i2c_hid i2c_hid
> acpi WM510205:00 acpi:WM510205:WM510205:
> hid 0003:04D9:2517.0002 hid:b0003g0001v000004D9p00002517 hid_generic hid_generic
> hid 0003:04D9:2517.0003 hid:b0003g0001v000004D9p00002517 hid_generic hid_generic
> hid 0018:2ABB:8101.0001 hid:b0018g0004v00002ABBp00008101 hid_multitouch hid_multitouch
> i2c i2c-ACCL0001:00 acpi:ACCL0001:INTACEL:
> i2c i2c-CALS0001:00 acpi:CALS0001:INTLALS:
> i2c i2c-INT33FD:00 acpi:INT33FD:INT33FD:
> i2c i2c-MXM1120:00 acpi:MXM1120:
> i2c i2c-OVTI8865:00 acpi:OVTI8865:OVTI8865:
> i2c i2c-OVTI9760:00 acpi:OVTI9760:OVTI9760:
> i2c i2c-SYNA0001:00 acpi:SYNA0001:PNP0C50: i2c_hid i2c_hid
> mei mei::2a13f92f-b34c-41af-ba0f-33c459a28c10 mei::2ff9132a4cb3af41ba0f33c459a28c10:
> mei mei::309dcde8-ccb1-4062-8f78-600115a34327 mei::e8cd9d30b1cc62408f78600115a34327:
> mei mei::3c4852d6-d47b-4f46-b05e-b5edc1aa430a mei::d652483c7bd4464fb05eb5edc1aa430a:
> mei mei::3c4852d6-d47b-4f46-b05e-b5edc1aa440e mei::d652483c7bd4464fb05eb5edc1aa440e:
> mei mei::55213584-9a29-4916-badf-0fb7ed682aeb mei::84352155299a1649badf0fb7ed682aeb:
> mei mei::b638ab7e-94e2-4ea2-a552-d1c54b627f04 mei::7eab38b6e294a24ea552d1c54b627f04:
> mei mei::f908627d-13bf-4a04-b91f-a64e9245323d mei::7d6208f9bf13044ab91fa64e9245323d:
> mei mei::fa8f55e8-ab22-42dd-b916-7dce39002574 mei::e8558ffa22abdd42b9167dce39002574:
> mei mei:pn544:0bb17a78-2a8e-4c50-94d4-50266723775c mei:pn544:787ab10b8e2a504c94d450266723775c: pn544_mei pn544_mei
> pci 0000:00:00.0 pci:v00008086d00000F00sv00008086sd00007270bc06sc00i00
> pci 0000:00:02.0 pci:v00008086d00000F31sv00008086sd00007270bc03sc00i00 i915 i915
> pci 0000:00:14.0 pci:v00008086d00000F35sv00008086sd00007270bc0Csc03i30
> pci 0000:00:1a.0 pci:v00008086d00000F18sv00008086sd00007270bc10sc80i00 mei_txe mei_txe
> pci 0000:00:1f.0 pci:v00008086d00000F1Csv00008086sd00007270bc06sc01i00 lpc_ich lpc_ich
> platform 80860F0A:00 acpi:80860F0A:80860F0A: 8250_dw 8250_dw
> platform 80860F0A:01 acpi:80860F0A:80860F0A: 8250_dw 8250_dw
> platform 80860F0E:00 acpi:80860F0E:80860F0E: spi_pxa2xx_platform spi_pxa2xx_platform
> platform 80860F14:00 acpi:80860F14:PNP0D40:
> platform 80860F14:01 acpi:80860F14:PNP0D40:
> platform 80860F28:00 acpi:80860F28:80860F28: snd_soc_sst_acpi+snd_intel_sst_acpi snd_soc_sst_acpi+snd_intel_sst_acpi
> platform 80860F41:00 acpi:80860F41:80860F41: i2c_designware_platform i2c_designware_platform
> platform 80860F41:01 acpi:80860F41:80860F41: i2c_designware_platform i2c_designware_platform
> platform 80860F41:02 acpi:80860F41:80860F41: i2c_designware_platform i2c_designware_platform
> platform 80860F41:03 acpi:80860F41:80860F41: i2c_designware_platform i2c_designware_platform
> platform 80860F41:04 acpi:80860F41:80860F41: i2c_designware_platform i2c_designware_platform
> platform 80860F41:05 acpi:80860F41:80860F41: i2c_designware_platform i2c_designware_platform
> platform 80860F41:06 acpi:80860F41:80860F41: i2c_designware_platform i2c_designware_platform
> platform ACPI0003:00 acpi:ACPI0003:
> platform ACPI000C:00 acpi:ACPI000C:ACPI000C: acpi_pad acpi_pad
> platform BCM2E84:00 acpi:BCM2E84:
> platform Fixed MDIO bus.0 platform:Fixed MDIO bus
> platform INT0002:00 acpi:INT0002:INT0002:
> platform INT0800:00 acpi:INT0800:
> platform INT3396:00 acpi:INT3396:PNP0D80:
> platform INT33BB:00 acpi:INT33BB:PNP0D40:
> platform INT33BD:00 acpi:INT33BD:INT33BD:
> platform INT33FC:00 acpi:INT33FC:INT33FC:
> platform INT33FC:01 acpi:INT33FC:INT33FC:
> platform INT33FC:02 acpi:INT33FC:INT33FC:
> platform INT3400:00 acpi:INT3400: int3400_thermal int3400_thermal
> platform INT3401:00 acpi:INT3401: processor_thermal_device processor_thermal_device
> platform INT3403:01 acpi:INT3403: int3403_thermal int3403_thermal
> platform INT3403:02 acpi:INT3403: int3403_thermal int3403_thermal
> platform INT3403:04 acpi:INT3403: int3403_thermal int3403_thermal
> platform INT3406:00 acpi:INT3406:
> platform INT3407:00 acpi:INT3407:
> platform INTCFD9:00 acpi:INTCFD9:PNP0C40: soc_button_array soc_button_array
> platform INTL9C60:00 acpi:INTL9C60: dw_dmac dw_dmac
> platform INTL9C60:01 acpi:INTL9C60: dw_dmac dw_dmac
> platform LNV4752:00 acpi:LNV4752: rfkill_gpio rfkill_gpio
> platform MSFT0101:00 acpi:MSFT0101: tpm_crb tpm_crb
> platform PNP0103:00 acpi:PNP0103:
> platform PNP0C0D:00 acpi:PNP0C0D:
> platform SRCL0001:00 acpi:SRCL0001:INTSRCL:
> platform alarmtimer platform:alarmtimer
> platform clk-lpt platform:clk-lpt
> platform crystal_cove_adc platform:crystal_cove_adc
> platform crystal_cove_bcu platform:crystal_cove_bcu
> platform crystal_cove_gpio platform:crystal_cove_gpio
> platform crystal_cove_pmic platform:crystal_cove_pmic
> platform crystal_cove_pwm platform:crystal_cove_pwm
> platform crystal_cove_pwrsrc platform:crystal_cove_pwrsrc
> platform crystal_cove_thermal platform:crystal_cove_thermal
> platform e820_pmem platform:e820_pmem
> platform efi-framebuffer.0 platform:efi-framebuffer
> platform gpio-keys.0.auto platform:gpio-keys gpio_keys gpio_keys
> platform gpio-keys.1.auto platform:gpio-keys gpio_keys gpio_keys
> platform iTCO_wdt.2.auto platform:iTCO_wdt iTCO_wdt iTCO_wdt
> platform microcode platform:microcode
> platform pcspkr platform:pcspkr pcspkr+snd_pcsp pcspkr
> platform reg-dummy platform:reg-dummy
> platform regulatory.0 platform:regulatory
> platform serial8250 platform:serial8250
> platform snd-soc-dummy platform:snd-soc-dummy
> sdio mmc1:0001:1 sdio:c00v02D0d4324 brcmfmac brcmfmac
> sdio mmc1:0001:2 sdio:c00v02D0d4324 brcmfmac brcmfmac
> usb 1-0:1.0 usb:v1D6Bp0002d0403dc09dsc00dp01ic09isc00ip00in00
> usb 1-1:1.0 usb:v04D9p2517d0100dc00dsc00dp00ic03isc01ip01in00 usbhid+usbkbd usbhid+usbkbd
> usb 1-1:1.1 usb:v04D9p2517d0100dc00dsc00dp00ic03isc01ip02in01 usbhid+usbmouse usbhid+usbmouse
> usb 2-0:1.0 usb:v1D6Bp0003d0403dc09dsc00dp03ic09isc00ip00in00
>
> Regards,
> Hubert Tonneau
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

