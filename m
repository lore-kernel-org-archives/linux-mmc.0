From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmc_spi: Add Card Detect comments and fix CD GPIO case
Date: Fri, 4 Mar 2016 10:41:34 +0100
Message-ID: <CAPDyKFrKGnvFgDS_jwHAE3Jb36Vkp0JaexOVb_8KF1HVi+8OvA@mail.gmail.com>
References: <20160216040641.31979.6202.sendpatchset@little-apple>
	<CAPDyKFo-+OWq1S7jD+j8e8fBOgL3A7igtp_rG5qFBwjgJF5U9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFo-+OWq1S7jD+j8e8fBOgL3A7igtp_rG5qFBwjgJF5U9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Esben Haabendal <eha@doredevelopment.dk>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 3 March 2016 at 16:28, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 16 February 2016 at 05:06, Magnus Damm <magnus.damm@gmail.com> wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> This patch adds comments to describe the various ways card detection
>> may be implemented and when polling is needed. Also a fix is included
>> to prevent the MMC SPI driver from polling when a CD GPIO that supports
>> interrupts is specified using the gpios DT property (case 1).
>>
>> Without this patch the DT node below results in the following output:
>>
>>  spi_gpio: spi-gpio { /* SD2 @ CN12 */
>>          compatible = "spi-gpio";
>>          #address-cells = <1>;
>>          #size-cells = <0>;
>>          gpio-sck = <&gpio6 16 GPIO_ACTIVE_HIGH>;
>>          gpio-mosi = <&gpio6 17 GPIO_ACTIVE_HIGH>;
>>          gpio-miso = <&gpio6 18 GPIO_ACTIVE_HIGH>;
>>          num-chipselects = <1>;
>>          cs-gpios = <&gpio6 21 GPIO_ACTIVE_LOW>;
>>          status = "okay";
>>
>>          spi@0 {
>>                  compatible = "mmc-spi-slot";
>>                  reg = <0>;
>>                  voltage-ranges = <3200 3400>;
>>                  spi-max-frequency = <25000000>;
>>                  gpios = <&gpio6 22 GPIO_ACTIVE_LOW>;   /* CD */
>>          };
>>  };
>>
>>  # dmesg | grep mmc
>>  mmc_spi spi32766.0: SD/MMC host mmc0, no WP, no poweroff, cd polling
>>  mmc0: host does not support reading read-only switch, assuming write-enable
>>  mmc0: new SDHC card on SPI
>>  mmcblk0: mmc0:0000 SU04G 3.69 GiB
>>  mmcblk0: p1
>>
>>  With this patch applied the "cd polling" portion above disappears.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>
> This looks good to me. Although do you think we need this for @stable as well?

Ehh, as I am soon will be travelling and wanted this to be tested in
linux next, I took the liberty to remove the comments, updated the
change log and applied a stable tag.

If think the comments are useful, please send a separate patch on top.

So applied for fixes! Please have a look to make sure I looks okay to you.

Kind regards
Uffe

>
> Kind regards
> Uffe
>
>> ---
>>
>>  Developed on top of renesas-drivers-2016-02-09-v4.5-rc3 which
>>  simply put is v4.5-rc3 + selected linux-next trees.
>>
>>  drivers/mmc/host/mmc_spi.c |   14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> --- 0001/drivers/mmc/host/mmc_spi.c
>> +++ work/drivers/mmc/host/mmc_spi.c     2016-02-16 12:47:47.900513000 +0900
>> @@ -1437,11 +1437,25 @@ static int mmc_spi_probe(struct spi_devi
>>         if (status != 0)
>>                 goto fail_add_host;
>>
>> +       /* Card detection in case of DT is supported in several ways:
>> +        * 1) GPIO with interrupt support using "gpios" DT property.
>> +        * 2) GPIO without interrupt support using "gpios" DT property.
>> +        * 3) Interrupt only using "interrupt-parent/interrupts" DT properties.
>> +        * 4) Both "gpios" and "interrupt-parent/interrupts" DT properties.
>> +        * 5) Nothing specified.
>> +        * For case 2 and 5 above polling is required.
>> +        */
>>         if (host->pdata && host->pdata->flags & MMC_SPI_USE_CD_GPIO) {
>>                 status = mmc_gpio_request_cd(mmc, host->pdata->cd_gpio,
>>                                              host->pdata->cd_debounce);
>>                 if (status != 0)
>>                         goto fail_add_host;
>> +
>> +               /* The platform has a CD GPIO signal that may support
>> +                * interrupts, so let mmc_gpiod_request_cd_irq() decide
>> +                * if polling is needed or not.
>> +                */
>> +               mmc->caps &= ~MMC_CAP_NEEDS_POLL;
>>                 mmc_gpiod_request_cd_irq(mmc);
>>         }
>>
