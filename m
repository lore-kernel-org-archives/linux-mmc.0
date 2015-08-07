From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH v4 1/9] mmc: dw_mmc: Add external dma interface
 support
Date: Sat, 8 Aug 2015 07:37:55 +0800
Message-ID: <55C54153.2070709@rock-chips.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <1438843491-23853-1-git-send-email-shawn.lin@rock-chips.com>
 <CAGhQ9VxUYvgGD=K3J3cQ0CNpCC-RfGE9cxhBHnTeAU2CmWkiKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
        format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <CAGhQ9VxUYvgGD=K3J3cQ0CNpCC-RfGE9cxhBHnTeAU2CmWkiKA@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Joachim Eastwood <manabian@gmail.com>
Cc: lintao@rock-chips.com, jh80.chung@samsung.com, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, Doug Anderson <dianders@chromium.org>, Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Russell King <linux@arm.linux.org.uk>, Jun Nie <jun.nie@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, Govindraj Raja <govindraj.raja@imgtec.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-rockchip@lists.infrade
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2015/8/8 5:32, Joachim Eastwood =E5=86=99=E9=81=93:
> Hi Shawn,
>
> On 6 August 2015 at 08:44, Shawn Lin <shawn.lin@rock-chips.com> wrote=
:
>> DesignWare MMC Controller can supports two types of DMA
>> mode: external dma and internal dma. We get a RK312x platform
>> integrated dw_mmc and ARM pl330 dma controller. This patch add
>> edmac ops to support these platforms. I've tested it on RK312x
>> platform with edmac mode and RK3288 platform with idmac mode.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
>> @@ -2256,26 +2373,30 @@ static irqreturn_t dw_mci_interrupt(int irq,=
 void *dev_id)
>>
>>          }
>>
>> -#ifdef CONFIG_MMC_DW_IDMAC
>> -       /* Handle DMA interrupts */
>> -       if (host->dma_64bit_address =3D=3D 1) {
>> -               pending =3D mci_readl(host, IDSTS64);
>> -               if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_=
RI)) {
>> -                       mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_TI=
 |
>> -                                                       SDMMC_IDMAC_=
INT_RI);
>> -                       mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI=
);
>> -                       host->dma_ops->complete(host);
>> -               }
>> -       } else {
>> -               pending =3D mci_readl(host, IDSTS);
>> -               if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_=
RI)) {
>> -                       mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI |
>> -                                                       SDMMC_IDMAC_=
INT_RI);
>> -                       mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
>> -                       host->dma_ops->complete(host);
>> +       if (host->use_dma =3D=3D TRANS_MODE_IDMAC) {
>
> Doing:
> if (host->use_dma !=3D TRANS_MODE_IDMAC)
>      return IRQ_HANDLED;
>

Okay.

> Could save you the extra level of identation you add below.
>
>> +               /* Handle DMA interrupts */
>> +               if (host->dma_64bit_address =3D=3D 1) {
>> +                       pending =3D mci_readl(host, IDSTS64);
>> +                       if (pending & (SDMMC_IDMAC_INT_TI |
>> +                                      SDMMC_IDMAC_INT_RI)) {
>> +                               mci_writel(host, IDSTS64,
>> +                                          SDMMC_IDMAC_INT_TI |
>> +                                          SDMMC_IDMAC_INT_RI);
>> +                               mci_writel(host, IDSTS64, SDMMC_IDMA=
C_INT_NI);
>> +                               host->dma_ops->complete((void *)host=
);
>> +                       }
>> +               } else {
>> +                       pending =3D mci_readl(host, IDSTS);
>> +                       if (pending & (SDMMC_IDMAC_INT_TI |
>> +                                      SDMMC_IDMAC_INT_RI)) {
>> +                               mci_writel(host, IDSTS,
>> +                                          SDMMC_IDMAC_INT_TI |
>> +                                          SDMMC_IDMAC_INT_RI);
>> +                               mci_writel(host, IDSTS, SDMMC_IDMAC_=
INT_NI);
>> +                               host->dma_ops->complete((void *)host=
);
>> +                       }
>>                  }
>>          }
>> -#endif
>>
>>          return IRQ_HANDLED;
>>   }
>
>
>> @@ -2437,6 +2567,21 @@ static void dw_mci_cleanup_slot(struct dw_mci=
_slot *slot, unsigned int id)
>>   static void dw_mci_init_dma(struct dw_mci *host)
>>   {
>>          int addr_config;
>> +       int trans_mode;
>> +       struct device *dev =3D host->dev;
>> +       struct device_node *np =3D dev->of_node;
>> +
>> +       /* Check tansfer mode */
>> +       trans_mode =3D (mci_readl(host, HCON) >> 16) & 0x3;
>
> I think it would be nice if you could add some defines for 16 and 0x0=
3
> or add a macro like SDMMC_GET_FCNT() that is in dw_mmc.h.
>

yes, it's better to avoid magic number for register operation to make
others understand w/o checking databook for details. And might more tha=
n=20
one (e.g "Check ADDR_CONFIG bit in HCON to find IDMAC address bus=20
width") should be modified.

Although one patch only do one thing, I will drop by to make it in v5.

>> +       if (trans_mode =3D=3D 0) {
>> +               trans_mode =3D TRANS_MODE_IDMAC;
>> +       } else if (trans_mode =3D=3D 1 || trans_mode =3D=3D 2) {
>> +               trans_mode =3D TRANS_MODE_EDMAC;
>> +       } else {
>> +               trans_mode =3D TRANS_MODE_PIO;
>> +               goto no_dma;
>> +       }
>> +
>>          /* Check ADDR_CONFIG bit in HCON to find IDMAC address bus =
width */
>>          addr_config =3D (mci_readl(host, HCON) >> 27) & 0x01;
>
> I'll try to get this patch tested on my lpc18xx platform soon.
> btw, the HCON reg on lpc18xx reads as 0x00e42cc1 (address 0x40004070)=
=2E
>

yes, HCON[17:16] is 2b'00 means your lpc18xx use IDMAC.

>
> regard,
> Joachim Eastwood
>
>
>


--=20
Shawn Lin
