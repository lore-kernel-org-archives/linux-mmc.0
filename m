From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH v2 01/12] mmc: sdhci: add support for auto CMD23
Date: Wed, 9 Mar 2011 06:55:25 -0600
Message-ID: <6C03668EAF45B747AF947A1603D1B300E3A04FAC@SAUSEXMBP01.amd.com>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
 <1299238369-1768-2-git-send-email-arindam.nath@amd.com>
 <000c01cbde54$9dc93720$d95ba560$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:38322
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932239Ab1CIMzj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 Mar 2011 07:55:39 -0500
In-Reply-To: <000c01cbde54$9dc93720$d95ba560$@org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "cjb@laptop.org" <cjb@laptop.org>
Cc: "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "prakity@marvell.com" <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

Hi Subhash,


> -----Original Message-----
> From: subhashj@codeaurora.org [mailto:subhashj@codeaurora.org]
> Sent: Wednesday, March 09, 2011 5:52 PM
> To: Nath, Arindam; cjb@laptop.org
> Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
> mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> Subject: RE: [PATCH v2 01/12] mmc: sdhci: add support for auto CMD23
> 
> 
> 
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Arindam Nath
> > Sent: Friday, March 04, 2011 5:03 PM
> > To: cjb@laptop.org
> > Cc: zhangfei.gao@gmail.com; prakity@marvell.com;
> > subhashj@codeaurora.org; linux-mmc@vger.kernel.org; henry.su@amd.com;
> > aaron.lu@amd.com; anath.amd@gmail.com; Arindam Nath
> > Subject: [PATCH v2 01/12] mmc: sdhci: add support for auto CMD23
> >
> > Host Controller v3.00 and later support Auto CMD23 in the Transfer
> > Mode register. Since Auto CMD23 can be used with or without DMA,
> > and if used with DMA, it should _only_ be ADMA, we check against
> > SDHCI_USE_SDMA not being set. This flag is reset when SDHCI_USE_ADMA
> > is set.
> >
> > A new definition for SDHCI_ARGUMENT2 register has been added in v3.00
> > spec, which is the same as SDHCI_DMA_ADDRESS. We program the block
> > count for CMD23 in SDHCI_ARGUMENT2, so we don't need CMD12 to stop
> > multiple block transfers. But during error recovery procedure, we
> will
> > need to send Abort command, so we use a variable saved_abort_cmd to
> > save the stop command to be used later.
> >
> > Two bits are added to SCR register as per the Physical Layer Spec
> > v3.01,
> > which specify whether the card supports CMD20 and/or CMD23. We use
> this
> > as one of the conditions to decide whether to enable Auto CMD23 or
> not.
> >
> > Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> > ---
> >  drivers/mmc/core/sd.c     |    6 ++++
> >  drivers/mmc/host/sdhci.c  |   69
> > +++++++++++++++++++++++++++++++++++++++++---
> >  drivers/mmc/host/sdhci.h  |    2 +
> >  include/linux/mmc/card.h  |    4 ++
> >  include/linux/mmc/sd.h    |    2 +-
> >  include/linux/mmc/sdhci.h |    2 +
> >  6 files changed, 79 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index d18c32b..b3f8a3c 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -188,6 +188,12 @@ static int mmc_decode_scr(struct mmc_card *card)
> >
> >  	scr->sda_vsn = UNSTUFF_BITS(resp, 56, 4);
> >  	scr->bus_widths = UNSTUFF_BITS(resp, 48, 4);
> > +	if (scr->sda_vsn == SCR_SPEC_VER_2) {
> > +		/* Check if Physical Layer Spec v3.0 is supported*/
> > +		scr->sda_spec3 = UNSTUFF_BITS(resp, 47, 1);
> > +		if (scr->sda_spec3)
> > +			scr->cmd_support = UNSTUFF_BITS(resp, 32, 2);
> > +	}
> Looks fine.
> 
> >
> >  	if (UNSTUFF_BITS(resp, 55, 1))
> >  		card->erased_byte = 0xFF;
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 9e15f41..8914a25 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -25,6 +25,7 @@
> >
> >  #include <linux/mmc/mmc.h>
> >  #include <linux/mmc/host.h>
> > +#include <linux/mmc/card.h>
> >
> >  #include "sdhci.h"
> >
> > @@ -812,6 +813,30 @@ static void sdhci_prepare_data(struct sdhci_host
> > *host, struct mmc_data *data)
> >  	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> >  }
> >
> > +/*
> > + * Does the Host Controller support Auto CMD23?
> > + *
> > + * There are four preconditions for Auto CMD23 to be supported:
> > + *  1. Host Controller v3.00 or later
> > + *  2. Card supports CMD23
> > + *  3. If DMA is used, it should be ADMA
> > + *  4. Only when CMD18 or CMD25 is issued
> > + */
> > +static int sdhci_host_auto_cmd23_supported(struct sdhci_host *host,
> > +	struct mmc_request *mrq)
> > +{
> > +	struct mmc_card *card = host->mmc->card;
> > +
> > +	if ((host->version >= SDHCI_SPEC_300) &&
> > +	   card && (card->scr.cmd_support & SD_SCR_CMD23_SUPPORT) &&
> > +	   !(host->flags & SDHCI_USE_SDMA) &&
> > +	   ((mrq->cmd->opcode == MMC_READ_MULTIPLE_BLOCK) ||
> > +	   (mrq->cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK)))
> > +		return 1;
> > +
> > +	return 0;
> > +}
> Just a thought. Shouldn't the name should say *cmd23_required? Because
> here
> you are not just checking the card capability but also checking if
> current
> command requires CMD23 or not.

Yes, *cmd23_required looks good to me. I will change the function name.

> 
> > +
> >  static void sdhci_set_transfer_mode(struct sdhci_host *host,
> >  	struct mmc_data *data)
> >  {
> > @@ -825,10 +850,21 @@ static void sdhci_set_transfer_mode(struct
> > sdhci_host *host,
> >  	mode = SDHCI_TRNS_BLK_CNT_EN;
> >  	if (data->blocks > 1) {
> >  		if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
> > -			mode |= SDHCI_TRNS_MULTI | SDHCI_TRNS_ACMD12;
> > -		else
> > -			mode |= SDHCI_TRNS_MULTI;
> > +			mode |= SDHCI_TRNS_ACMD12;
> > +		else if (sdhci_host_auto_cmd23_supported(host, host->mrq))
> > {
> > +			/*
> > +			 * Host Controller v3.00 can automatically send
> CMD23
> > +			 * before CMD18 or CMD25. For that, we need to
> enable
> > +			 * Auto CMD23 in the Transfer Mode register and
> > +			 * program the block count in Argument 2 register.
> > +			 */
> > +			mode |= SDHCI_TRNS_AUTO_CMD23;
> > +			sdhci_writel(host, data->blocks, SDHCI_ARGUMENT2);
> > +		}
> > +
> > +		mode |= SDHCI_TRNS_MULTI;
> >  	}
> > +
> >  	if (data->flags & MMC_DATA_READ)
> >  		mode |= SDHCI_TRNS_READ;
> >  	if (host->flags & SDHCI_REQ_USE_DMA)
> > @@ -1131,6 +1167,23 @@ static void sdhci_request(struct mmc_host
> *mmc,
> > struct mmc_request *mrq)
> >  #ifndef SDHCI_USE_LEDS_CLASS
> >  	sdhci_activate_led(host);
> >  #endif
> > +	/*
> > +	 * Since the block count for CMD23 has already been specified in
> > the
> > +	 * Argument 2 register, we don't need CMD12 to stop multiple
> > block
> > +	 * transfers.
> > +	 */
> > +	if (sdhci_host_auto_cmd23_supported(host, mrq)) {
> > +		if (mrq->stop) {
> > +			/*
> > +			 * Save the stop command here to be used during
> > +			 * error recovery
> > +			 */
> > +			host->saved_abort_cmd = mrq->data->stop;
> > +			mrq->data->stop = NULL;
> > +			mrq->stop = NULL;
> > +		}
> > +	}
> > +
> >  	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12) {
> >  		if (mrq->stop) {
> >  			mrq->data->stop = NULL;
> > @@ -1396,6 +1449,7 @@ static void sdhci_timeout_timer(unsigned long
> > data)
> >
> >  		if (host->data) {
> >  			host->data->error = -ETIMEDOUT;
> > +			host->data->stop = host->saved_abort_cmd;
> >  			sdhci_finish_data(host);
> >  		} else {
> >  			if (host->cmd)
> > @@ -1534,9 +1588,10 @@ static void sdhci_data_irq(struct sdhci_host
> > *host, u32 intmask)
> >  		host->data->error = -EIO;
> >  	}
> >
> > -	if (host->data->error)
> > +	if (host->data->error) {
> > +		host->data->stop = host->saved_abort_cmd;
> >  		sdhci_finish_data(host);
> > -	else {
> > +	} else {
> >  		if (intmask & (SDHCI_INT_DATA_AVAIL |
> > SDHCI_INT_SPACE_AVAIL))
> >  			sdhci_transfer_pio(host);
> >
> > @@ -1792,6 +1847,10 @@ int sdhci_add_host(struct sdhci_host *host)
> >  		host->flags &= ~SDHCI_USE_ADMA;
> >  	}
> >
> > +	/* If the host can perform ADMA operation, we reset SDMA flag */
> > +	if (host->flags & SDHCI_USE_ADMA)
> > +		host->flags &= ~SDHCI_USE_SDMA;
> > +
> >  	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
> >  		if (host->ops->enable_dma) {
> >  			if (host->ops->enable_dma(host)) {
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 6e0969e..223762c 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -25,6 +25,7 @@
> >   */
> >
> >  #define SDHCI_DMA_ADDRESS	0x00
> > +#define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
> >
> >  #define SDHCI_BLOCK_SIZE	0x04
> >  #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz
> &
> > 0xFFF))
> > @@ -37,6 +38,7 @@
> >  #define  SDHCI_TRNS_DMA		0x01
> >  #define  SDHCI_TRNS_BLK_CNT_EN	0x02
> >  #define  SDHCI_TRNS_ACMD12	0x04
> > +#define  SDHCI_TRNS_AUTO_CMD23	0x08
> >  #define  SDHCI_TRNS_READ	0x10
> >  #define  SDHCI_TRNS_MULTI	0x20
> >
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > index 8ce0827..22b0335 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -58,9 +58,13 @@ struct mmc_ext_csd {
> >
> >  struct sd_scr {
> >  	unsigned char		sda_vsn;
> > +	unsigned char		sda_spec3;
> >  	unsigned char		bus_widths;
> >  #define SD_SCR_BUS_WIDTH_1	(1<<0)
> >  #define SD_SCR_BUS_WIDTH_4	(1<<2)
> > +	unsigned char		cmd_support;
> > +#define SD_SCR_CMD20_SUPPORT	(1<<0)
> > +#define SD_SCR_CMD23_SUPPORT	(1<<1)
> Looks good. I am just curious about: spec says that UHS104 card must
> support
> CMD23. so are you handling this anywhere? Means what if card is
> detected as
> UHS104 card and if it doesn't set this CMD23 bit? Just an error
> condition.

The description from Auto CMD23 Enable in the spec mentions card supporting CMD23 as a _required_ condition before using Auto CMD23. So I assume UHS104 cards should have this bit set for sure.

Thanks,
Arindam

