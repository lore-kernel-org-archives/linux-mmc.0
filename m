From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/3] mmc: jz4740: Remove platform data and use standard
 APIs
Date: Mon, 28 Jan 2019 09:58:13 -0300
Message-ID: <1548680293.3021.0@crapouillou.net>
References: <20190125200927.21045-1-paul@crapouillou.net>
        <CAPDyKFrkq4GQbCbcJFqeERt3y41VJ7we+eL9NziPf2Obe+yGkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrkq4GQbCbcJFqeERt3y41VJ7we+eL9NziPf2Obe+yGkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, DTML <devicetree@vger.kernel.org>, linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

Le lun. 28 janv. 2019 =E0 9:02, Ulf Hansson <ulf.hansson@linaro.org> a=20
=E9crit :
> On Fri, 25 Jan 2019 at 21:09, Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Drop the custom code to get the 'cd' and 'wp' GPIOs. The driver now
>>  calls mmc_of_parse() which will init these from devicetree or
>>  device properties.
>>=20
>>  Also drop the custom code to get the 'power' GPIO. The MMC core
>>  provides us with the means to power the MMC card through an external
>>  regulator.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>=20
> Applied for next, thanks!
>=20
> Should I also pick up the other two MIPS patches or you want to funnel
> those through the MIPS soc tree?

I'd prefer through the MIPS tree, then I can still push some other=20
patches
on top of these in the 5.1 dev window.

>>  ---
>>   drivers/mmc/host/jz4740_mmc.c | 71=20
>> +++++++++----------------------------------
>>   1 file changed, 14 insertions(+), 57 deletions(-)
>>=20
>>  diff --git a/drivers/mmc/host/jz4740_mmc.c=20
>> b/drivers/mmc/host/jz4740_mmc.c
>>  index 33215d66afa2..e41c7230815f 100644
>>  --- a/drivers/mmc/host/jz4740_mmc.c
>>  +++ b/drivers/mmc/host/jz4740_mmc.c
>>  @@ -21,7 +21,6 @@
>>   #include <linux/dmaengine.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/err.h>
>>  -#include <linux/gpio/consumer.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/io.h>
>>   #include <linux/irq.h>
>>  @@ -36,7 +35,6 @@
>>   #include <asm/cacheflush.h>
>>=20
>>   #include <asm/mach-jz4740/dma.h>
>>  -#include <asm/mach-jz4740/jz4740_mmc.h>
>>=20
>>   #define JZ_REG_MMC_STRPCL      0x00
>>   #define JZ_REG_MMC_STATUS      0x04
>>  @@ -148,9 +146,7 @@ enum jz4780_cookie {
>>   struct jz4740_mmc_host {
>>          struct mmc_host *mmc;
>>          struct platform_device *pdev;
>>  -       struct jz4740_mmc_platform_data *pdata;
>>          struct clk *clk;
>>  -       struct gpio_desc *power;
>>=20
>>          enum jz4740_mmc_version version;
>>=20
>>  @@ -894,16 +890,16 @@ static void jz4740_mmc_set_ios(struct=20
>> mmc_host *mmc, struct mmc_ios *ios)
>>          switch (ios->power_mode) {
>>          case MMC_POWER_UP:
>>                  jz4740_mmc_reset(host);
>>  -               if (host->power)
>>  -                       gpiod_set_value(host->power, 1);
>>  +               if (!IS_ERR(mmc->supply.vmmc))
>>  +                       mmc_regulator_set_ocr(mmc,=20
>> mmc->supply.vmmc, ios->vdd);
>>                  host->cmdat |=3D JZ_MMC_CMDAT_INIT;
>>                  clk_prepare_enable(host->clk);
>>                  break;
>>          case MMC_POWER_ON:
>>                  break;
>>          default:
>>  -               if (host->power)
>>  -                       gpiod_set_value(host->power, 0);
>>  +               if (!IS_ERR(mmc->supply.vmmc))
>>  +                       mmc_regulator_set_ocr(mmc,=20
>> mmc->supply.vmmc, 0);
>>                  clk_disable_unprepare(host->clk);
>>                  break;
>>          }
>>  @@ -936,38 +932,6 @@ static const struct mmc_host_ops=20
>> jz4740_mmc_ops =3D {
>>          .enable_sdio_irq =3D jz4740_mmc_enable_sdio_irq,
>>   };
>>=20
>>  -static int jz4740_mmc_request_gpios(struct jz4740_mmc_host *host,
>>  -                                   struct mmc_host *mmc,
>>  -                                   struct platform_device *pdev)
>>  -{
>>  -       struct jz4740_mmc_platform_data *pdata =3D=20
>> dev_get_platdata(&pdev->dev);
>>  -       int ret =3D 0;
>>  -
>>  -       if (!pdata)
>>  -               return 0;
>>  -
>>  -       if (!pdata->card_detect_active_low)
>>  -               mmc->caps2 |=3D MMC_CAP2_CD_ACTIVE_HIGH;
>>  -       if (!pdata->read_only_active_low)
>>  -               mmc->caps2 |=3D MMC_CAP2_RO_ACTIVE_HIGH;
>>  -
>>  -       /*
>>  -        * Get optional card detect and write protect GPIOs,
>>  -        * only back out on probe deferral.
>>  -        */
>>  -       ret =3D mmc_gpiod_request_cd(mmc, "cd", 0, false, 0, NULL);
>>  -       if (ret =3D=3D -EPROBE_DEFER)
>>  -               return ret;
>>  -
>>  -       ret =3D mmc_gpiod_request_ro(mmc, "wp", 0, false, 0, NULL);
>>  -       if (ret =3D=3D -EPROBE_DEFER)
>>  -               return ret;
>>  -
>>  -       host->power =3D devm_gpiod_get_optional(&pdev->dev, "power",
>>  -                                             GPIOD_OUT_HIGH);
>>  -       return PTR_ERR_OR_ZERO(host->power);
>>  -}
>>  -
>>   static const struct of_device_id jz4740_mmc_of_match[] =3D {
>>          { .compatible =3D "ingenic,jz4740-mmc", .data =3D (void *)=20
>> JZ_MMC_JZ4740 },
>>          { .compatible =3D "ingenic,jz4725b-mmc", .data =3D (void=20
>> *)JZ_MMC_JZ4725B },
>>  @@ -982,9 +946,6 @@ static int jz4740_mmc_probe(struct=20
>> platform_device* pdev)
>>          struct mmc_host *mmc;
>>          struct jz4740_mmc_host *host;
>>          const struct of_device_id *match;
>>  -       struct jz4740_mmc_platform_data *pdata;
>>  -
>>  -       pdata =3D dev_get_platdata(&pdev->dev);
>>=20
>>          mmc =3D mmc_alloc_host(sizeof(struct jz4740_mmc_host),=20
>> &pdev->dev);
>>          if (!mmc) {
>>  @@ -993,29 +954,25 @@ static int jz4740_mmc_probe(struct=20
>> platform_device* pdev)
>>          }
>>=20
>>          host =3D mmc_priv(mmc);
>>  -       host->pdata =3D pdata;
>>=20
>>          match =3D of_match_device(jz4740_mmc_of_match, &pdev->dev);
>>          if (match) {
>>                  host->version =3D (enum=20
>> jz4740_mmc_version)match->data;
>>  -               ret =3D mmc_of_parse(mmc);
>>  -               if (ret) {
>>  -                       if (ret !=3D -EPROBE_DEFER)
>>  -                               dev_err(&pdev->dev,
>>  -                                       "could not parse of data:=20
>> %d\n", ret);
>>  -                       goto err_free_host;
>>  -               }
>>          } else {
>>                  /* JZ4740 should be the only one using legacy probe=20
>> */
>>                  host->version =3D JZ_MMC_JZ4740;
>>  -               mmc->caps |=3D MMC_CAP_SDIO_IRQ;
>>  -               if (!(pdata && pdata->data_1bit))
>>  -                       mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>>  -               ret =3D jz4740_mmc_request_gpios(host, mmc, pdev);
>>  -               if (ret)
>>  -                       goto err_free_host;
>>          }
>>=20
>>  +       ret =3D mmc_of_parse(mmc);
>>  +       if (ret) {
>>  +               if (ret !=3D -EPROBE_DEFER)
>>  +                       dev_err(&pdev->dev,
>>  +                               "could not parse device properties:=20
>> %d\n", ret);
>>  +               goto err_free_host;
>>  +       }
>>  +
>>  +       mmc_regulator_get_supply(mmc);
>>  +
>>          host->irq =3D platform_get_irq(pdev, 0);
>>          if (host->irq < 0) {
>>                  ret =3D host->irq;
>>  --
>>  2.11.0
>>=20
=
