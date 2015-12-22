From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-pci: Add platform tuning callback for amd
 hs200 mode
Date: Tue, 22 Dec 2015 14:30:19 +0200
Message-ID: <CAHp75VcwcVnTEQYNKm5WZevVQ4143OVG2krumTL53r+rsv+wgA@mail.gmail.com>
References: <1450802408-16354-1-git-send-email-vincent.wan@amd.com>
	<1450802408-16354-2-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35167 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbbLVMaU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Dec 2015 07:30:20 -0500
In-Reply-To: <1450802408-16354-2-git-send-email-vincent.wan@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wan Zongshun <vincent.wan@amd.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wan Zongshun <mcuos.com@gmail.com>, Borislav Petkov <bp@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>

On Tue, Dec 22, 2015 at 6:40 PM, Wan Zongshun <vincent.wan@amd.com> wro=
te:
> From: Wan Zongshun <Vincent.Wan@amd.com>
>
> AMD hs200 mode tuning mode is not compatible with standard tuning pro=
cess,
> so we need .platform_execute_tuning callback support in sdhci-pci-cor=
e.c,
> this patch is to do:
>
> 1. Add platform_execute_tuning callback in sdhci_pci_slot.
> 2. Implement sdhci_pci_ops.platform_execute_tuning function.
>
> Signed-off-by: Wan Zongshun <Vincent.Wan@amd.com>
> ---
> Hi Ulf,
>
> Though modifying sdhci_pci_ops to be not const that is easy to implem=
ent
> my requirement, I am not sure it is right to do this.
>
> So I just follow sdhci_pci_select_drive_strength style to add new cal=
lback:
> sdhci_pci_platform_execute_tuning.
>
> But I also met trouble in sdhci_execute_tuning of sdhci.c, I have to =
suppose
> only sdhci_pci_platform_execute_tuning is returning -EPERM(current co=
de,
> my assumption is right), so that those vendor that has no
> slot->platform_execute_tuning could be skipped and go next standard
> tuning process.
>
> If you have better idea for my requirement, please correct me.
>
> Thanks!
> Wan Zongshun.
>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 23 +++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h      |  1 +
>  drivers/mmc/host/sdhci.c          |  3 ++-
>  3 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdh=
ci-pci-core.c
> index 01c5723..e7b2bbe 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -905,8 +905,19 @@ static int amd_probe(struct sdhci_pci_chip *chip=
)
>         return 0;
>  }
>
> +static int amd_probe_slot(struct sdhci_pci_slot *slot)
> +{
> +       struct sdhci_host *host =3D slot->host;
> +
> +       if (host->quirks2 & SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFOR=
E_CMD)
> +               slot->platform_execute_tuning =3D amd_execute_tuning;
> +
> +       return 0;
> +}
> +
>  static const struct sdhci_pci_fixes sdhci_amd =3D {
>         .probe          =3D amd_probe,
> +       .probe_slot     =3D amd_probe_slot,
>  };
>
>  static const struct pci_device_id pci_ids[] =3D {
> @@ -1508,6 +1519,17 @@ static int sdhci_pci_select_drive_strength(str=
uct sdhci_host *host,
>                                            card_drv, drv_type);
>  }
>
> +static int sdhci_pci_platform_execute_tuning(struct sdhci_host *host=
,
> +                                            u32 opcode)
> +{
> +       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> +
> +       if (!slot->platform_execute_tuning)
> +               return -EPERM;

Here you return an error code.

> +
> +       return slot->platform_execute_tuning(host, opcode);
> +}
> +
>  static const struct sdhci_ops sdhci_pci_ops =3D {
>         .set_clock      =3D sdhci_set_clock,
>         .enable_dma     =3D sdhci_pci_enable_dma,
> @@ -1516,6 +1538,7 @@ static const struct sdhci_ops sdhci_pci_ops =3D=
 {
>         .set_uhs_signaling =3D sdhci_set_uhs_signaling,
>         .hw_reset               =3D sdhci_pci_hw_reset,
>         .select_drive_strength  =3D sdhci_pci_select_drive_strength,
> +       .platform_execute_tuning =3D sdhci_pci_platform_execute_tunin=
g,
>  };
>
>  /*******************************************************************=
**********\
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pc=
i.h
> index d1a0b4d..48d98f1 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -83,6 +83,7 @@ struct sdhci_pci_slot {
>                                      struct mmc_card *card,
>                                      unsigned int max_dtr, int host_d=
rv,
>                                      int card_drv, int *drv_type);
> +       int (*platform_execute_tuning)(struct sdhci_host *host, u32 o=
pcode);
>  };
>
>  struct sdhci_pci_chip {
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2753b722d..2a5a6ce 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1937,7 +1937,8 @@ static int sdhci_execute_tuning(struct mmc_host=
 *mmc, u32 opcode)
>                 spin_unlock_irqrestore(&host->lock, flags);
>                 err =3D host->ops->platform_execute_tuning(host, opco=
de);
>                 sdhci_runtime_pm_put(host);
> -               return err;
> +               if (err !=3D EPERM)

=E2=80=A6and here you ignore it. Perhaps better to introduce various po=
sitive codes

#define AMD_TUNNING_DONE 0
#define AMD_TUNNING_NA 1


> +                       return err;
>         }
>
>         ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



--=20
With Best Regards,
Andy Shevchenko
