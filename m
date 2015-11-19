From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-esdhc-imx: move the setting of watermark
 level out of probe
Date: Fri, 20 Nov 2015 00:29:58 +0800
Message-ID: <CAA+hA=T=+cQ5PLm=eWrunXMV_YiHs18QEdfsQVQWgx=Cp-n3LQ@mail.gmail.com>
References: <1447148610-2770-1-git-send-email-haibo.chen@freescale.com>
	<CAPDyKFpoH4ZKW4x+biB+5O5fFhYNsOFvPWzqVmQdbmhOkux2NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:33959 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312AbbKSQ37 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2015 11:29:59 -0500
In-Reply-To: <CAPDyKFpoH4ZKW4x+biB+5O5fFhYNsOFvPWzqVmQdbmhOkux2NA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Haibo Chen <haibo.chen@freescale.com>, Dong Aisheng <aisheng.dong@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Nov 19, 2015 at 7:17 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 10 November 2015 at 10:43, Haibo Chen <haibo.chen@freescale.com> wrote:
>> Currently, we config the watermark_level register only in probe.
>> This will cause the mmc write operation timeout issue after system
>> resume back in LPSR mode. Because in LPSR mode, after system resume
>> back, the watermark_level register(0x44) changes to 0x08000880, which
>> set the write watermark level as 0, and set the read watermark level
>> as 128. This value is incorrect.
>>
>> This patch move the setting of watermark level register out of probe,
>> so after system resume back, mmc driver can set this watermark level
>> register back to 0x10401040.
>
> This seems all reasonable! But...
>
>>
>> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
>> ---
>>  drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 1f1582f..1508949 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -584,6 +584,14 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
>>                 mask = 0xffff & ~(ESDHC_CTRL_BUSWIDTH_MASK | ESDHC_CTRL_D3CD);
>>
>>                 esdhc_clrset_le(host, mask, new_val, reg);
>> +
>> +               /*
>> +                * The imx6q/imx7d ROM code will change the default watermark
>> +                * level setting to something insane.  Change it back here.
>> +                */
>> +                if (esdhc_is_usdhc(imx_data))
>> +                        writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
>> +
>
> ... why don't keep setting the watermark in ->probe() and instead just
> add it at as additional task to do at system PM resume?
>

I guess the reason may be keep using common sdhci_pltfrm_suspend() function
instead of creating new one.

But i think it's a good suggestion that we can create a platform
specific suspend/resume
function and put pm stuff into there for better code organization.
Haibo, you may try Ulf's suggestion.

Regards
Dong Aisheng

>>                 return;
>>         }
>>         esdhc_clrset_le(host, 0xff, val, reg);
>> @@ -1155,13 +1163,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>>                 host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
>>                         | SDHCI_QUIRK_BROKEN_ADMA;
>>
>> -       /*
>> -        * The imx6q ROM code will change the default watermark level setting
>> -        * to something insane.  Change it back here.
>> -        */
>>         if (esdhc_is_usdhc(imx_data)) {
>> -               writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
>> -
>>                 host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
>>                 host->mmc->caps |= MMC_CAP_1_8V_DDR;
>>
>> --
>> 1.9.1
>>
>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
