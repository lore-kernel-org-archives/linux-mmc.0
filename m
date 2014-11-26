From: Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: RE: [PATCH v2] mmc: Add Production State Awareness Support
Date: Wed, 26 Nov 2014 16:38:47 +0000
Message-ID: <282CEDFCBC30114F83C499CB8F2ED5333ECBDCE0@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0086.outbound.protection.outlook.com ([207.46.100.86]:17408
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752963AbaKZQix convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Nov 2014 11:38:53 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>

Hi Jaehoon,

Thank you for reviewing the patch.

> -----Original Message-----
> From: Jaehoon Chung [mailto:jh80.chung@samsung.com]
> Sent: Wednesday, November 26, 2014 6:33 AM
> To: Alex Lemberg; ulf.hansson@linaro.org
> Cc: linux-mmc@vger.kernel.org; chris@printf.net; Avi Shchislowski
> Subject: Re: [PATCH v2] mmc: Add Production State Awareness Support
> 
> Hi,
> 
> On 11/26/2014 12:01 AM, Alex Lemberg wrote:
> > In this patch driver should recognize if eMMC device (Rev >=5.0) was
> > left in PRE_SOLDERING_POST_WRITES (0x02) state, and switch it to
> > NORMAL (0x00).
> > PRE_SOLDERING_POST_WRITES (0x02) state - represents a state where the
> > device is in production process and the host (usually programmer)
> > completed loading the content to the device.
> > The host (usually programmer) sets the device to this state after
> > loading the content and just before soldering.
> > After soldering the device to the real host (not programmer), the
> > device should be switched to NORMAL (0x00) mode.
> > The NORMAL (0x00) mode of PSA register represents a state in which the
> > device is running in the field and uses regular operations.
> > Leaving device in PRE_SOLDERING_POST_WRITES (0x02) might cause
> > unexpected behaviour of eMMC device.
> >
> > More details about PSA feature can be found in eMMC5.0 JEDEC spec
> (JESD84-B50.pdf):
> > http://www.jedec.org/standards-documents/technology-focus-areas/flash-
> > memory-ssds-ufs-emmc/e-mmc
> >
> > Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
> > ---
> > Changes in v2:
> >  - Remove typo in patch code
> > ---
> >  drivers/mmc/core/mmc.c   | 28 ++++++++++++++++++++++++++++
> >  include/linux/mmc/card.h |  2 ++
> >  include/linux/mmc/mmc.h  |  8 ++++++++
> >  3 files changed, 38 insertions(+)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> > 02ad792..3923c90 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -571,6 +571,16 @@ static int mmc_decode_ext_csd(struct mmc_card
> *card, u8 *ext_csd)
> >  		card->ext_csd.ffu_capable =
> >  			(ext_csd[EXT_CSD_SUPPORTED_MODE] & 0x1) &&
> >  			!(ext_csd[EXT_CSD_FW_CONFIG] & 0x1);
> > +		card->ext_csd.psa =
> > +			ext_csd[EXT_CSD_PSA];
> > +		if (ext_csd[EXT_CSD_PSA_TIMEOUT] > 0) {
> > +			card->ext_csd.psa_timeout =
> > +				100 *
> > +				(1 << ext_csd[EXT_CSD_PSA_TIMEOUT]);
> > +		} else {
> > +			pr_warn("%s: EXT_CSD PSA Timeout is zero\n",
> > +					mmc_hostname(card->host));
> 
> I remembered Ulf's previous comment. Did you check it?
Are you referring to psa_timeout?
In case it is zero, we are printing warning, and let host controller 
to handle this.
Every switch command timeout setting in mmc driver done in this way. 
> 
> > +		}
> >  	}
> >  out:
> >  	return err;
> > @@ -1331,6 +1341,24 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
> >  		mmc_set_dsr(host);
> >
> >  	/*
> > +	 * eMMC v5.0 or later
> > +	 * and Production State Awareness state is
> > +	 * EXT_CSD_PSA_POST_SOLDERING_WRITES (0x02)
> > +	 * The host should set the device to NORMAL mode
> > +	 */
> > +	if ((card->ext_csd.rev >= 7) &&
> > +		(card->ext_csd.psa ==
> EXT_CSD_PSA_POST_SOLDERING_WRITES)) {
> 
> Is it right? how did you get "revision"?

In linux-next, the EXT_CSD revision set was moved
to mmc_decode_ext_csd() function.
Anyway, thanks for pointing me on this, I will move this check to 
the right place. 

> 
> > +		unsigned int timeout;
> > +
> > +		timeout = DIV_ROUND_UP(card->ext_csd.psa_timeout, 1000);
> > +		card->ext_csd.psa = EXT_CSD_PSA_NORMAL;
> 
> Why did card->ext_csd.psa assign to EXT_CSD_PSA_NORMAL as hard-coding?
> 
I think this is a right way to set ext_csd structure in order to prevent additional read
from device ext_csd register, which was already read during the init.


> > +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > +			EXT_CSD_PSA, card->ext_csd.psa, timeout);
> > +		if (err && err != -EBADMSG)
> > +			goto free_card;
> > +	}
> > +
> > +	/*
> >  	 * Select card, as all following commands rely on that.
> >  	 */
> >  	if (!mmc_host_is_spi(host)) {
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
> > 4d69c00..09ac3b0 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -60,9 +60,11 @@ struct mmc_ext_csd {
> >  	u8			packed_event_en;
> >  	unsigned int		part_time;		/* Units: ms */
> >  	unsigned int		sa_timeout;		/* Units: 100ns */
> > +	unsigned int		psa_timeout;		/* Units: 100us */
> >  	unsigned int		generic_cmd6_time;	/* Units: 10ms */
> >  	unsigned int            power_off_longtime;     /* Units: ms */
> >  	u8			power_off_notification;	/* state */
> > +	u8			psa; /* production state awareness */
> >  	unsigned int		hs_max_dtr;
> >  	unsigned int		hs200_max_dtr;
> >  #define MMC_HIGH_26_MAX_DTR	26000000
> > diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h index
> > 49ad7a9..458814d 100644
> > --- a/include/linux/mmc/mmc.h
> > +++ b/include/linux/mmc/mmc.h
> > @@ -285,6 +285,7 @@ struct _mmc_csd {
> >  #define EXT_CSD_EXP_EVENTS_STATUS	54	/* RO, 2 bytes */
> >  #define EXT_CSD_EXP_EVENTS_CTRL		56	/* R/W, 2 bytes */
> >  #define EXT_CSD_DATA_SECTOR_SIZE	61	/* R */
> > +#define EXT_CSD_PSA			133	/* R/W/E */
> >  #define EXT_CSD_GP_SIZE_MULT		143	/* R/W */
> >  #define EXT_CSD_PARTITION_SETTING_COMPLETED 155	/* R/W */
> >  #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
> > @@ -315,6 +316,7 @@ struct _mmc_csd {
> >  #define EXT_CSD_PWR_CL_26_360		203	/* RO */
> >  #define EXT_CSD_SEC_CNT			212	/* RO, 4 bytes */
> >  #define EXT_CSD_S_A_TIMEOUT		217	/* RO */
> > +#define EXT_CSD_PSA_TIMEOUT		218	/* RO */
> >  #define EXT_CSD_REL_WR_SEC_C		222	/* RO */
> >  #define EXT_CSD_HC_WP_GRP_SIZE		221	/* RO */
> >  #define EXT_CSD_ERASE_TIMEOUT_MULT	223	/* RO */
> > @@ -433,6 +435,12 @@ struct _mmc_csd {
> >  #define EXT_CSD_BKOPS_LEVEL_2		0x2
> >
> >  /*
> > + * PRODUCTION STATE AWARENESS fields
> > + */
> > +#define EXT_CSD_PSA_NORMAL		0x00
> > +#define EXT_CSD_PSA_POST_SOLDERING_WRITES	0x02
> > +
> > +/*
> >   * MMC_SWITCH access modes
> >   */
> >
> >

