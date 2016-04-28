From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] mmc: sdhci-pci: add Support of Synopsys DWC_MSHC IP
Date: Thu, 28 Apr 2016 12:19:28 +0300
Message-ID: <CAHp75Vfi_fMQ3-v+9GDoKbPX9crVNd6bbdfm84asu+QObA6FKQ@mail.gmail.com>
References: <705D14B1C7978B40A723277C067CEDE2010A4B4DB3@IN01WEMBXB.internal.synopsys.com>
	<CAHp75VfHrX-mH=edkuj-Vvq_=-hFgA2Kay79e9h4P9ew-KNqAg@mail.gmail.com>
	<705D14B1C7978B40A723277C067CEDE2010A4B4FA0@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36824 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbcD1JT3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2016 05:19:29 -0400
In-Reply-To: <705D14B1C7978B40A723277C067CEDE2010A4B4FA0@IN01WEMBXB.internal.synopsys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prabu Thangamuthu <Prabu.T@synopsys.com>
Cc: "Ulf Hansson (ulf.hansson@linaro.org)" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Guenter Roeck <linux@roeck-us.net>, Jiri Slaby <jslaby@suse.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Joshua Henderson <joshua.henderson@microchip.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Apr 28, 2016 at 11:35 AM, Prabu Thangamuthu
<Prabu.T@synopsys.com> wrote:

>> > +               mul = 0x2;
>> > +               for (div = 1; div <= 32; div++) {
>> > +                       if (((host->max_clk * mul) / div)
>> > +                                       <= clock)
>>
>> Too many parens.
>>
>> > +                               break;
>> > +               }
>>
>> So, you would like to find a minimum divider that guarantees the  clock >
>> max_clk * mul / div.
>>
>> This is completely long way to achieve.
>
> This for loop is exactly taken from drivers/mmc/host/sdhci.c
> We want to maintain the consistency between our file and sdhci.c

Any strong argument to do so? For now it's not an excuse, sorry.

>> What about
>> div = DIV_ROUND_UP(max_clk * mul / clock)
>>
>> div_val = max(div, 32);


>> > +               timeout = 20;
>> > +               while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
>> > +                                       & SDHCI_CLOCK_INT_STABLE)) {
>> > +                       if (timeout == 0) {
>>
>> This is invariant to the loop. Check how it's done in other drivers.
>
> This while loop also exactly taken from drivers/mmc/host/sdhci.c (function name sdhci_set_clock).
> We want to maintain the consistency between our file and sdhci.c for easy readability.

Ditto.

>> Something like
>>
>> while (condition && --timeout) {
>> ...
>> }
>> if (!timeout) {
>> ...
>> }

>> > +               if (clock <= 50000000) {
>> > +                       /*Change the Tx Phase value here */
>>
>> Space
>
> I didn't get any warning/error when I ran scripts/checkpatch.pl against my patch.
> Did you find this "Space" issue by manual check or by running any scripts?

I just noticed this like one above during manual review.

>> > +#define SDHCI_UHS2_VENDOR      0xE8
>> > +
>> > +#define DRIVER_NAME "sdhci-pci-dwc"
>> > +#define SDHC_DEF_TX_CLK_PH_VAL  4
>> > +#define SDHC_DEF_RX_CLK_PH_VAL  4
>> > +
>> > +/* Synopsys Vendor Specific Registers */
>> > +#define SDHC_DBOUNCE                           0x08
>> > +#define SDHC_TUNING_RX_CLK_SEL_MASK            0x000000FF

GENMASK() ?

>> > +#define SDHC_GPIO_OUT                          0x34
>> > +/* HAPS 51 Based implementation */
>> > +#define SDHC_BCLK_DCM_RST                      0x00000001

BIT() ?

>> > +#define SDHC_CARD_TX_CLK_DCM_RST               0x00000002
>> > +#define SDHC_TUNING_RX_CLK_DCM_RST             0x00000004
>> > +#define SDHC_TUNING_TX_CLK_DCM_RST             0x00000008

Ditto.

>> > +#define SDHC_TUNING_TX_CLK_SEL_MASK            0x00000070

GENMASK() ?

>> > +#define SDHC_TUNING_TX_CLK_SEL_SHIFT           4
>> > +#define SDHC_TX_CLK_SEL_TUNED                  0x00000080
>> > +
>> > +/* Offset of BCLK DCM DRP Attributes */
>> > +/* Every attribute is of 16 bit wide */
>> > +#define BCLK_DCM_DRP_BASE_51                   0x1000
>> > +
>> > +#define BCLK_DCM_MUL_DIV_DRP                   0x1050

>> > +#define MUL_MASK_DRP                           0xFF00
>> > +#define DIV_MASK_DRP                           0x00FF

Ditto.

-- 
With Best Regards,
Andy Shevchenko
