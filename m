From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-pci: Add platform tuning callback for amd
 hs200 mode
Date: Wed, 23 Dec 2015 08:18:18 +0800
Message-ID: <CAKT61h_Aw4WSRPkQEGGsGa5LBUarovHGz6AGwpiwkqrpfQ=AhA@mail.gmail.com>
References: <1450802408-16354-1-git-send-email-vincent.wan@amd.com>
 <1450802408-16354-2-git-send-email-vincent.wan@amd.com> <CAHp75VcwcVnTEQYNKm5WZevVQ4143OVG2krumTL53r+rsv+wgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:32837 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932541AbbLWASi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Dec 2015 19:18:38 -0500
In-Reply-To: <CAHp75VcwcVnTEQYNKm5WZevVQ4143OVG2krumTL53r+rsv+wgA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wan Zongshun <vincent.wan@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Borislav Petkov <bp@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>

>> +
>>  static const struct sdhci_pci_fixes sdhci_amd =3D {
>>         .probe          =3D amd_probe,
>> +       .probe_slot     =3D amd_probe_slot,
>>  };
>>
>>  static const struct pci_device_id pci_ids[] =3D {
>> @@ -1508,6 +1519,17 @@ static int sdhci_pci_select_drive_strength(st=
ruct sdhci_host *host,
>>                                            card_drv, drv_type);
>>  }
>>
>> +static int sdhci_pci_platform_execute_tuning(struct sdhci_host *hos=
t,
>> +                                            u32 opcode)
>> +{
>> +       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
>> +
>> +       if (!slot->platform_execute_tuning)
>> +               return -EPERM;
>
> Here you return an error code.
>
>> +
>> +       return slot->platform_execute_tuning(host, opcode);
>> +}
>> +
>>  static const struct sdhci_ops sdhci_pci_ops =3D {
>>         .set_clock      =3D sdhci_set_clock,
>>         .enable_dma     =3D sdhci_pci_enable_dma,
>> @@ -1516,6 +1538,7 @@ static const struct sdhci_ops sdhci_pci_ops =3D=
 {
>>         .set_uhs_signaling =3D sdhci_set_uhs_signaling,
>>         .hw_reset               =3D sdhci_pci_hw_reset,
>>         .select_drive_strength  =3D sdhci_pci_select_drive_strength,
>> +       .platform_execute_tuning =3D sdhci_pci_platform_execute_tuni=
ng,
>>  };
>>
>>  /******************************************************************=
***********\
>> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-p=
ci.h
>> index d1a0b4d..48d98f1 100644
>> --- a/drivers/mmc/host/sdhci-pci.h
>> +++ b/drivers/mmc/host/sdhci-pci.h
>> @@ -83,6 +83,7 @@ struct sdhci_pci_slot {
>>                                      struct mmc_card *card,
>>                                      unsigned int max_dtr, int host_=
drv,
>>                                      int card_drv, int *drv_type);
>> +       int (*platform_execute_tuning)(struct sdhci_host *host, u32 =
opcode);
>>  };
>>
>>  struct sdhci_pci_chip {
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 2753b722d..2a5a6ce 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1937,7 +1937,8 @@ static int sdhci_execute_tuning(struct mmc_hos=
t *mmc, u32 opcode)
>>                 spin_unlock_irqrestore(&host->lock, flags);
>>                 err =3D host->ops->platform_execute_tuning(host, opc=
ode);
>>                 sdhci_runtime_pm_put(host);
>> -               return err;
>> +               if (err !=3D EPERM)
>
> =E2=80=A6and here you ignore it. Perhaps better to introduce various =
positive codes
>
> #define AMD_TUNNING_DONE 0
> #define AMD_TUNNING_NA 1

Andy, It looks a good idea, thanks.


>
>
>> +                       return err;
>>         }
>>
>>         ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
> --
> With Best Regards,
> Andy Shevchenko



--=20
---
Vincent Wan(Zongshun)
www.mcuos.com
