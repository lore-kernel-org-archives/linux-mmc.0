From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6] mmc: sdhci-moxart: Add MOXA ART SDHCI driver
Date: Fri, 17 Jan 2014 15:40:55 +0100
Message-ID: <201401171540.55948.arnd@arndb.de>
References: <1386763426-10158-1-git-send-email-jonas.jensen@gmail.com> <1389951825-14884-1-git-send-email-jonas.jensen@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389951825-14884-1-git-send-email-jonas.jensen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Jensen <jonas.jensen@gmail.com>
Cc: chris@printf.net, linux-mmc@vger.kernel.org, cjb@laptop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arm@kernel.org, mark.rutland@arm.com
List-Id: linux-mmc@vger.kernel.org

On Friday 17 January 2014, Jonas Jensen wrote:
> Add SDHCI driver for MOXA ART SoCs.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

I think this should be renamed to something other than SDHCI, since that
implies a specific register layout and would use the sdhci.c driver.

Maybe moxart-mmc?

> diff --git a/Documentation/devicetree/bindings/mmc/moxa,moxart-sdhci.txt b/Documentation/devicetree/bindings/mmc/moxa,moxart-sdhci.txt
> new file mode 100644
> index 0000000..020b13e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/moxa,moxart-sdhci.txt
> @@ -0,0 +1,28 @@
> +MOXA ART SD Host Controller Interface
> +
> +Required properties:
> +
> +- compatible :	Must be "moxa,moxart-sdhci"
> +- reg :		Should contain registers location and length
> +- interrupts :	Should contain the interrupt number
> +- clocks :	Should contain phandle for the clock feeding the SDHCI controller
> +
> +Optional properties:
> +
> +These are optional but required to enable DMA transfer mode:
> +
> +- dmas :	Should contain two DMA channels, line request number must be 5 for
> +		both channels
> +- dma-names :	Must be "tx", "rx"

I think you should add a reference to bindings/mmc/mmc.txt here.

> +#define MSD_CMD_REG		0
> +#define MSD_ARG_REG		4
> +#define MSD_RESP0_REG		8
> +#define MSD_RESP1_REG		0x0c
> +#define MSD_RESP2_REG		0x10
> +#define MSD_RESP3_REG		0x14
> +#define MSD_RESP_CMD_REG	0x18
> +#define MSD_DATA_CTRL_REG	0x1c
> +#define MSD_DATA_TIMER_REG	0x20
> +#define MSD_DATA_LEN_REG	0x24
> +#define MSD_STATUS_REG		0x28
> +#define MSD_CLEAR_REG		0x2c
> +#define MSD_INT_MASK_REG	0x30
> +#define MSD_POWER_CTRL_REG	0x34
> +#define MSD_CLOCK_CTRL_REG	0x38
> +#define MSD_BUS_WIDTH_REG	0x3c
> +#define MSD_DATA_WIN_REG	0x40
> +#define MSD_FEATURE_REG		0x44
> +#define MSD_REVISION_REG	0x48
> +
> +#define MMC_RSP_SHORT		1
> +#define MMC_RSP_LONG		2
> +#define MMC_RSP_MASK		3
> +#define MMC_ERR_NONE		0
> +#define MMC_ERR_TIMEOUT		1
> +#define MMC_MODE_MMC		0
> +#define MMC_MODE_SD		1
> +#define MMC_ERR_BADCRC		2
> +#define MMC_VDD_360		23
> +
> +#define MSD_RETRY_COUNT		10
> +
> +#define REG_COMMAND		0
> +#define REG_ARGUMENT		4
> +#define REG_RESPONSE0		8
> +#define REG_RESPONSE1		12
> +#define REG_RESPONSE2		16
> +#define REG_RESPONSE3		20
> +#define REG_RESPONSE_COMMAND	24
> +#define REG_DATA_CONTROL	28
> +#define REG_DATA_TIMER		32
> +#define REG_DATA_LENGTH		36
> +#define REG_STATUS		40
> +#define REG_CLEAR		44
> +#define REG_INTERRUPT_MASK	48
> +#define REG_POWER_CONTROL	52
> +#define REG_CLOCK_CONTROL	56
> +#define REG_BUS_WIDTH		60
> +#define REG_DATA_WINDOW		64
> +#define REG_FEATURE		68
> +#define REG_REVISION		72

The lists seem duplicated here, there is an MSD_foo_REG for each REG_foo.

> +	/*
> +	 * hardware does not support MMC_CAP_SD_HIGHSPEED
> +	 * CMD6 will timeout and make things not work
> +	 */
> +	mmc->caps = MMC_CAP_4_BIT_DATA;

Better get the bus-width from DT by calling the mmc_of_parse
function. Some boards might connect only one data bit, or in
fact 8 if it's an eMMC.

	Arnd
