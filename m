From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Sun, 18 Oct 2009 18:44:52 +0200
Message-ID: <4ADB4604.2090704@googlemail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>	 <4AD81DC2.4080607@googlemail.com>	 <42153.192.168.10.89.1255715021.squirrel@dbdmail.itg.ti.com>	 <4AD8C959.1000004@googlemail.com>	 <004701ca4ea5$aeacefe0$544ff780@am.dhcp.ti.com> <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060304000104020501030605"
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: John Rigby <jcrigby@gmail.com>
Cc: Madhusudhan <madhu.cr@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Steve Sakoman <sakoman@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------060304000104020501030605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

John Rigby wrote:
> It appears to never get cleared in the status register.
> 
> I added some printks to sdio_irq.c to print the pending interrupts in
> the SDIO_CCCR_INTx register for the card and there are no pending
> interrupts so I don't think it is a card driver or card issue.
> 
> It would be funny if the TRM was wrong and the CIRQ bit is really
> cleared by writing 1 to it.  I'll try that.

2.6.22.18 TI kernel for Beagle from

http://www.beagleboard.org/uploads/2.6_kernel_revb-v2.tar.gz

seems to have SDIO support in omap_hsmmc.c/h. Both in attachment.

Having a short look to it:

- enable_sdio_irq()/int_enable() seems to be done the same way

- interrupt acknowledge in irq handler seems to be done the same way 
as we do it, too

but

- IBG bit doesn't seem to be used (?)

- SDIO interrupt is additionally enabled in mmc_omap_start_command()

Anything more?

Cheers

Dirk

> On Fri, Oct 16, 2009 at 3:14 PM, Madhusudhan <madhu.cr@ti.com> wrote:
>>
>>> -----Original Message-----
>>> From: Dirk Behme [mailto:dirk.behme@googlemail.com]
>>> Sent: Friday, October 16, 2009 2:28 PM
>>> To: Madhusudhan Chikkature
>>> Cc: linux-mmc@vger.kernel.org; John Rigby; linux-omap@vger.kernel.org;
>>> Steve Sakoman
>>> Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
>>>
>>> Madhusudhan Chikkature wrote:
>>>> Hi Dirk,
>>>>
>>>> I am inlining the patch so that it helps review.
>>> ...
>>>> @@ -1165,8 +1178,15 @@ static void omap_hsmmc_set_ios(struct mm
>>>>             break;
>>>>     case MMC_BUS_WIDTH_4:
>>>>             OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
>>>> -           OMAP_HSMMC_WRITE(host->base, HCTL,
>>>> -                   OMAP_HSMMC_READ(host->base, HCTL) | FOUR_BIT);
>>>> +           if (mmc_card_sdio(host->mmc->card)) {
>>>>
>>>> I wish it could be moved to "enable_sdio_irq" so that we can avoid
>>> inclusion of
>>>> card.h and checking the type of card in the host controller driver.
>>> Yes, this would be the real clean way. But ...
>>>
>>>> But the
>>>> dependancy on 4-bit seems to be a problem here.
>>> ... most probably we have to find a workaround until (if ever?) above
>>> clean implementation is available.
>>>
>>> What we need is after SDIO mode and bus width is known, and before the
>>> first interrupt comes, to set IBG.
>>>
>>>> On the problems being discussed on testing is the interrupt source
>>> geting
>>>> cleared at the SDIO card level upon genaration of the CIRQ? If not it
>>> remains
>>>> asserted.
>>> Yes, this seems to be exactly the problem John reports in his follow
>>> up mail.
>>>
>>> Any hint how to clear SDIO interrupt?
>>>
>> On the controller side I guess it is cleared when you pass "disable" in the
>> enable_sdio_irq" fn. This happens when you call mmc_signal_sdio_irq.
>>
>> I am not too sure about how it gets disabled from the card side. I see that
>> SDIO core has a function "sdio_release_irq" which is used by the sdio uart
>> driver. The usage of this could give a clue.
>>
>> Regards,
>> Madhu
>>
>>> Many thanks
>>>
>>> Dirk
>>>
>>>> +                   OMAP_HSMMC_WRITE(host->base, HCTL,
>>>> +                                    OMAP_HSMMC_READ(host->base, HCTL)
>>>> +                                    | IBG | FOUR_BIT);
>>>> +           } else {
>>>> +                   OMAP_HSMMC_WRITE(host->base, HCTL,
>>>> +                                    OMAP_HSMMC_READ(host->base, HCTL)
>>>> +                                    | FOUR_BIT);
>>>> +           }
>>>>             break;
>>>>     case MMC_BUS_WIDTH_1:
>>>>             OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
>>>> @@ -1512,6 +1532,24 @@ static int omap_hsmmc_disable_fclk(struc
>>>>     return 0;
>>>>  }
>>>>
>>>> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int
>>> enable)
>>>> +{
>>>> +   struct omap_hsmmc_host *host = mmc_priv(mmc);
>>>> +   u32 ie, ise;
>>>> +
>>>> +   ise = OMAP_HSMMC_READ(host->base, ISE);
>>>> +   ie  = OMAP_HSMMC_READ(host->base, IE);
>>>> +
>>>> +   if (enable) {
>>>> +           OMAP_HSMMC_WRITE(host->base, ISE, ise | CIRQ_ENABLE);
>>>> +           OMAP_HSMMC_WRITE(host->base, IE,  ie  | CIRQ_ENABLE);
>>>> +   } else {
>>>> +           OMAP_HSMMC_WRITE(host->base, ISE, ise & ~CIRQ_ENABLE);
>>>> +           OMAP_HSMMC_WRITE(host->base, IE,  ie  & ~CIRQ_ENABLE);
>>>> +   }
>>>> +
>>>> +}
>>>> +
>>>>  static const struct mmc_host_ops omap_hsmmc_ops = {
>>>>     .enable = omap_hsmmc_enable_fclk,
>>>>     .disable = omap_hsmmc_disable_fclk,
>>>> @@ -1519,7 +1557,7 @@ static const struct mmc_host_ops omap_hs
>>>>     .set_ios = omap_hsmmc_set_ios,
>>>>     .get_cd = omap_hsmmc_get_cd,
>>>>     .get_ro = omap_hsmmc_get_ro,
>>>> -   /* NYET -- enable_sdio_irq */
>>>> +   .enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>>>>  };
>>>>
>>>>  static const struct mmc_host_ops omap_hsmmc_ps_ops = {
>>>> @@ -1529,7 +1567,7 @@ static const struct mmc_host_ops omap_hs
>>>>     .set_ios = omap_hsmmc_set_ios,
>>>>     .get_cd = omap_hsmmc_get_cd,
>>>>     .get_ro = omap_hsmmc_get_ro,
>>>> -   /* NYET -- enable_sdio_irq */
>>>> +   .enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>>>>  };
>>>>
>>>>  #ifdef CONFIG_DEBUG_FS
>>>> @@ -1734,7 +1772,7 @@ static int __init omap_hsmmc_probe(struc
>>>>     mmc->max_seg_size = mmc->max_req_size;
>>>>
>>>>     mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>>>> -                MMC_CAP_WAIT_WHILE_BUSY;
>>>> +                MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_SDIO_IRQ;
>>>>
>>>>     if (mmc_slot(host).wires >= 8)
>>>>             mmc->caps |= MMC_CAP_8_BIT_DATA;
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>> John Rigby wrote:
>>>>>> I have seen several discussions about lack of sdio irq support in the
>>>>>> hsmmc driver but no patches.  Has anyone on this list implemented this
>>>>>> and/or can anyone point me to patches?
>>>>> What a coincidence ;)
>>>>>
>>>>> I'm currently working on this. See attachment what I currently have.
>>>>> It is compile tested only against recent omap linux head. I don't have
>>>>> a board using SDIO at the moment, so no real testing possible :(
>>>>>
>>>>> Some background, maybe it helps people to step in:
>>>>>
>>>>> Gumstix OMAP3 based Overo air board connects Marvell 88W8686 wifi by
>>>>> MMC port 2 in 4 bit configuration [1]. The wifi performance is quite
>>>>> bad (~100kB/s). There is some rumor that this might be SDIO irq
>>>>> related [2]. There was an attempt to fix this [3] already, but this
>>>>> doesn't work [4]. Having this, I started to look into it.
>>>>>
>>>>> I used [3], the TI Davinci driver [5] (supporting SDIO irq), the SDIO
>>>>> Simplified Specification [6] and the OMAP35x TRM [7] as starting
>>> points.
>>>>> Unfortunately, the Davinci MMC registers and irqs are different
>>>>> (Davinci has a dedicated SDIO irq). But combining [3] and [5] helps to
>>>>> get an idea what has to be done.
>>>>>
>>>>> I think the main issues of [3] were that it doesn't enable IBG for 4
>>>>> bit mode ([6] chapter 8.1.2) and that mmc_omap_irq() doesn't reset the
>>>>> irq bits.
>>>>>
>>>>> Topics I still open:
>>>>>
>>>>> - Is it always necessary to deal with IE _and_ ISE register? I'm not
>>>>> totally clear what the difference between these two registers are ;)
>>>>> And in which order they have to be set.
>>>>>
>>>>> - Davinci driver [5] in line 1115 checks for data line to call
>>>>> mmc_signal_sdio_irq() for irq enable.
>>>>>
>>>>> - Davinci driver deals with SDIO in xfer_done() (line 873)
>>>>>
>>>>> - Davinci driver sets block size to 64 if SDIO in line 701
>>>>>
>>>>> It would be quite nice if anybody likes to comment on attachment and
>>>>> help testing.
>>>>>
>>>>> Many thanks and best regards
>>>>>
>>>>> Dirk
>>>>>
>>>>> [1] http://gumstix.net/wiki/index.php?title=Overo_Wifi
>>>>>
>>>>> [2] http://groups.google.com/group/beagleboard/msg/14e822778c5eeb56
>>>>>
>>>>> [3] http://groups.google.com/group/beagleboard/msg/d0eb69f4c20673be
>>>>>
>>>>> [4] http://groups.google.com/group/beagleboard/msg/5cdfe2a319531937
>>>>>
>>>>> [5]
>>>>> http://arago-project.org/git/projects/?p=linux-
>>> davinci.git;a=blob;f=drivers/mmc/host/davinci_mmc.c;h=1bf0587250614c6d8abf
>>> e02028b96e0e47148ac8;hb=HEAD
>>>>> [6] http://www.sdcard.org/developers/tech/sdio/sd_bluetooth_spec/
>>>>>
>>>>> [7] http://focus.ti.com/lit/ug/spruf98c/spruf98c.pdf
>>>>>
>>>>>
>>>>
>>>>
>>
>>
> 


--------------060304000104020501030605
Content-Type: text/x-csrc;
 name="omap_hsmmc.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap_hsmmc.c"

/*
 * drivers/mmc/omap_hsmmc.c
 *
 * Driver for OMAP2430/3430 MMC controller.
 *
 * Copyright (C) 2006-2007 Texas Instruments, Inc
 * Author: Texas Instruments
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
 * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 */

#include <linux/module.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/delay.h>
#include <linux/dma-mapping.h>
#include <linux/platform_device.h>
#include <linux/timer.h>
#include <linux/i2c.h>

#include <linux/mmc/mmc.h>
#include <linux/mmc/sd.h>
#include <linux/mmc/sdio.h>
#include <linux/mmc/host.h>
#include <linux/mmc/core.h>
#include <linux/mmc/card.h>

#include <asm/io.h>
#include <asm/irq.h>
#include <asm/dma.h>
#include <asm/mach-types.h>
#include <asm/arch/twl4030.h>
#include <asm/hardware.h>
#include <asm/arch/board.h>
#include <asm/arch/cpu.h>
#include <asm/arch/clock.h>
#include <asm/semaphore.h>
#include "omap_hsmmc.h"
#include <asm/scatterlist.h>

#ifdef CONFIG_PM
#include <linux/notifier.h>
#include <linux/pm.h>
#endif
#ifdef CONFIG_DPM
#include <linux/dpm.h>
#endif

/* TAG for Aggressive Power changes in MMC */
//#define AGGR_PM_CAP 1
#undef AGGR_PM_CAP

#ifdef AGGR_PM_CAP
#define mmc_clk_enable_aggressive(host)		mmc_clk_enable(host)
#define mmc_clk_disable_aggressive(host)	mmc_clk_disable(host)
#else
#define mmc_clk_enable_aggressive(host)		/* NULL */
#define mmc_clk_disable_aggressive(host)	/* NULL */
#endif


#ifdef AGGR_PM_CAP
/* SYSCONFIG bit values */
#define OMAP_MMC_SYSCONFIG_CLKACT_IOFF_FOFF	0x0
#define OMAP_MMC_SYSCONFIG_CLKACT_ION_FOFF	0x1
#define OMAP_MMC_SYSCONFIG_CLKACT_IOFF_FON	0x2
#define OMAP_MMC_SYSCONFIG_CLKACT_ION_FON	0x3

#define OMAP_MMC_SYSCONFIG_SIDLE_FORCEIDLE	0x0
#define OMAP_MMC_SYSCONFIG_SIDLE_NOIDLE		0x1
#define OMAP_MMC_SYSCONFIG_SIDLE_SMARTIDLE	0x2

#define OMAP_MMC_SYSCONFIG_ENAWAKEUP	0x1

#define OMAP_MMC_SYSCONFIG_AUTOIDLE	0x1

/* SYSCONFIG bit Masks */
#define OMAP_MMC_SYSCONFIG_CLKACT_SHIFT		0x8
#define OMAP_MMC_SYSCONFIG_SIDLE_SHIFT		0x3
#define OMAP_MMC_SYSCONFIG_ENAWAKEUP_SHIFT	0x2

#define OMAP_MMC_SYSCONFIG_LVL1	0x1
#define OMAP_MMC_SYSCONFIG_LVL2	0x2
#endif /* #ifdef AGGR_PM_CAP */

#if defined(CONFIG_MACH_OMAP_2430SDP) || \
	defined(CONFIG_MACH_OMAP_3430SDP) || \
	defined(CONFIG_MACH_OMAP_3430LABRADOR) || \
	defined(CONFIG_MACH_OMAP3EVM) || defined(CONFIG_MACH_OMAP3_BEAGLE)
extern int enable_mmc_power(int slot);
extern int disable_mmc_power(int slot);
extern int mask_carddetect_int(int slot);
extern int unmask_carddetect_int(int slot);
extern int setup_mmc_carddetect_irq(int irq);
extern int switch_power_mode(int power_mode);

extern ssize_t mmc_omap_show_cover_switch(struct device *dev, struct
					device_attribute *attr, char *buf);
extern ssize_t set_mmc_carddetect(struct device *dev, struct device_attribute
				*attr, const char *buf, size_t count);
DEVICE_ATTR(mmc_cover_switch, S_IRUGO, mmc_omap_show_cover_switch, NULL);
DEVICE_ATTR(mmc_card_detect, S_IWUSR, NULL, set_mmc_carddetect);
#endif

#define MMC_CARD_NONE 4
#define MAX_CRC_RETRY 1

struct mmc_omap_host *saved_host1, *saved_host2;

struct mmc_omap_host {
	int		suspended;
	struct		mmc_host *mmc;
	struct		mmc_request *mrq;
	struct		mmc_command *cmd;
	struct		mmc_data *data;
#ifdef CONFIG_OMAP_SDIO
	struct		mmc_data *sdiodata;
	int		sdio_card_intr;
#endif
	struct		timer_list detect_timer;
	struct		resource *mem_res;
	void		__iomem *base;
	void		*mapbase;
	struct		clk *fclk, *iclk, *dbclk;
	/* Required for a 3430 ES1.0 Sil errata fix */
	struct		clk *gptfck;
	unsigned int	id;
	int		irq;
	int		card_detect_irq;
	unsigned char	bus_mode;
	struct		semaphore sem;
	unsigned char	datadir;
	u32		*buffer;
	u32		bytesleft;
	int		use_dma, dma_ch;
	unsigned int	dma_len;
	unsigned int	sg_dma_len;
	unsigned int	dma_dir;
	int chain_id;
	struct omap_dma_channel_params params;
	u32 chains_requested;/* Number of chains to be requested */
	u32 extra_chain_reqd;/* if there is a need of last chaining*/
	u32 no_of_chain_reqd;/*No of times callback called*/
	u32 current_cb_cnt;
	int brs_received;
	int dma_done;
	int dma_is_read;
	spinlock_t dma_lock;
	unsigned int sg_len;
	int sg_idx;
	u32 buffer_bytes_left;
	u32 total_bytes_left;
	struct		work_struct mmc_carddetect_work;
	int		initstream;
	/*Added for CRC retry*/
	bool card_detected;
	u32 rca, mod_addr, org_addr;
	int is_high_capacity;
	int flag_err, cmd_12,cmd_13, crc_retry;
};

#ifdef CONFIG_OMAP34XX_OFFMODE
struct omap_hsmmc_regs {
	u32 hctl;
	u32 capa;
	u32 sysconfig;
	u32 ise;
	u32 ie;
	u32 con;
	u32 sysctl;
};
static struct omap_hsmmc_regs hsmmc_ctx[2];
#endif /* #ifdef CONFIG_OMAP34XX_OFFMODE */

#ifdef CONFIG_OMAP_SDIO
static int blkmode_bytecount[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
static int polling_mode = 0;
static void mmc_omap_polling_command(struct mmc_omap_host *host,
				struct mmc_command *cmd, u32 cmdreg);
#endif /* ifdef CONFIG_OMAP_SDIO */

#ifdef CONFIG_MMC_OMAP3430
static spinlock_t mmc_gpt_lock;
static int gptfclk_counter;
#endif /* #ifdef CONFIG_MMC_OMAP3430 */

static int mmc_clk_counter [NO_OF_MMC_HOSTS];
#define OMAP_MMC_STAT_BRR						  1 << 5
#define OMAP_MMC_STAT_BWR						  1 << 4
#define NO_OF_DMA_CHAINS_USED 2//This will work  with 2 chains currently

static void mmc_chain_dma(struct mmc_omap_host *host, struct mmc_data *data);
static int mmc_omap_get_dma_channel(struct mmc_omap_host *host, struct mmc_data *data);

#ifdef AGGR_PM_CAP
static int omap_mmc_sysconfig (struct mmc_omap_host *host, int level)
{
	u32 sysconfig_val;

	switch (level) {
	case OMAP_MMC_SYSCONFIG_LVL1:
		/*
		 * All features of SYSCONFIG enabled
		 * Note: MMC has Wakeup capability enabled at reset.
		 * If this capability is required then care needs to be taken
		 * for other wakeup related register such as HCTL(IWE bit) and
		 * interrupts in IE and ISE registers
		 *
		 * Clock activity has only FCLK ON
		 *
		 * Enabling SmartIdle in ES1.0, pervents CORE from going to
		 * retention. Hence even Wakeup capability is disabled.
		 */
		sysconfig_val = (
					(OMAP_MMC_SYSCONFIG_CLKACT_IOFF_FON <<
					OMAP_MMC_SYSCONFIG_CLKACT_SHIFT) |
					(OMAP_MMC_SYSCONFIG_SIDLE_SMARTIDLE <<
					OMAP_MMC_SYSCONFIG_SIDLE_SHIFT) |
					OMAP_MMC_SYSCONFIG_AUTOIDLE
				);

		OMAP_HSMMC_WRITE(host->base, SYSCONFIG, sysconfig_val);
		break;

	case OMAP_MMC_SYSCONFIG_LVL2:
		/*
		 * Clock activity has ICLK and FCLK OFF
		 */
		sysconfig_val = (
					(OMAP_MMC_SYSCONFIG_CLKACT_IOFF_FOFF <<
					OMAP_MMC_SYSCONFIG_CLKACT_SHIFT) |
					OMAP_MMC_SYSCONFIG_AUTOIDLE
				);

		OMAP_HSMMC_WRITE(host->base, SYSCONFIG, sysconfig_val);
		break;
	}
	return 0;
}
#endif /* #ifdef AGGR_PM_CAP */

#ifdef CONFIG_OMAP34XX_OFFMODE
static void omap2_hsmmc_save_ctx(struct mmc_omap_host *host)
{
	/* MMC : context save */
	hsmmc_ctx[host->id - 1].hctl = OMAP_HSMMC_READ(host->base, HCTL);
	hsmmc_ctx[host->id - 1].capa = OMAP_HSMMC_READ(host->base, CAPA);
	hsmmc_ctx[host->id - 1].sysconfig = OMAP_HSMMC_READ(host->base,
								SYSCONFIG);
	hsmmc_ctx[host->id - 1].ise = OMAP_HSMMC_READ(host->base, ISE);
	hsmmc_ctx[host->id - 1].ie = OMAP_HSMMC_READ(host->base, IE);
	hsmmc_ctx[host->id - 1].con = OMAP_HSMMC_READ(host->base, CON);
	hsmmc_ctx[host->id - 1].sysctl = OMAP_HSMMC_READ(host->base, SYSCTL);
}

static void omap2_hsmmc_restore_ctx(struct mmc_omap_host *host)
{
	/* MMC : context restore */
	OMAP_HSMMC_WRITE(host->base, HCTL, hsmmc_ctx[host->id - 1].hctl);
	OMAP_HSMMC_WRITE(host->base, CAPA, hsmmc_ctx[host->id - 1].capa);
	OMAP_HSMMC_WRITE(host->base, CON, hsmmc_ctx[host->id - 1].con);
	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
					hsmmc_ctx[host->id - 1].sysconfig);
	OMAP_HSMMC_WRITE(host->base, ISE, hsmmc_ctx[host->id - 1].ise);
	OMAP_HSMMC_WRITE(host->base, IE, hsmmc_ctx[host->id - 1].ie);
	OMAP_HSMMC_WRITE(host->base, SYSCTL, hsmmc_ctx[host->id - 1].sysctl);
	OMAP_HSMMC_WRITE(host->base, HCTL, OMAP_HSMMC_READ(host->base,
								HCTL) | SDBP);
}
#endif /* #ifdef CONFIG_OMAP34XX_OFFMODE */

static int mmc_clk_enable (struct mmc_omap_host *host)
{
	int hostid = host->id - 1;

#ifdef CONFIG_MMC_OMAP3430
	/* 3430-ES1.0  Sil errata fix */
	if (is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
		spin_lock(&mmc_gpt_lock);
		if (!gptfclk_counter) {
			if (clk_enable(host->gptfck) != 0) {
				dev_dbg(mmc_dev(host->mmc),
					"Unable to enable gptfck clock \n");
				goto clk_en_err;
			}
		}
		gptfclk_counter ++;
		spin_unlock(&mmc_gpt_lock);
	}
#endif /* #ifdef CONFIG_MMC_OMAP3430 */

	if (!mmc_clk_counter[hostid]) {
		if (clk_enable(host->iclk) != 0)
			goto clk_en_err1;

		if (clk_enable(host->fclk) != 0)
			goto clk_en_err2;

#ifdef AGGR_PM_CAP
		omap_mmc_sysconfig (host, OMAP_MMC_SYSCONFIG_LVL1);
#endif /* #ifdef AGGR_PM_CAP */
#ifdef CONFIG_OMAP34XX_OFFMODE
		if (context_restore_required(host->fclk))
			omap2_hsmmc_restore_ctx(host);
#endif /* #ifdef CONFIG_OMAP34XX_OFFMODE */
	}
	mmc_clk_counter[hostid] ++;
	return 0;

clk_en_err2:
	/* On fclk failure */
	clk_disable(host->iclk);

clk_en_err1:
	/* On iclk failure */
#ifdef CONFIG_MMC_OMAP3430
	if (is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
		spin_lock(&mmc_gpt_lock);
		gptfclk_counter --;
		if (!gptfclk_counter)
			clk_disable(host->gptfck);
		spin_unlock(&mmc_gpt_lock);
	}
#endif /* #ifdef CONFIG_MMC_OMAP3430 */

clk_en_err:
	dev_dbg(mmc_dev(host->mmc),
		"Unable to enable MMC clocks \n");
#ifdef CONFIG_MMC_OMAP3430
	spin_unlock(&mmc_gpt_lock);
#endif /* #ifdef CONFIG_MMC_OMAP3430 */
	return -1;
}

static int mmc_clk_disable (struct mmc_omap_host *host)
{
	int hostid = host->id - 1;

	mmc_clk_counter[hostid] --;
	if (!mmc_clk_counter[hostid]) {
#ifdef CONFIG_OMAP34XX_OFFMODE
		omap2_hsmmc_save_ctx(host);
#endif /* #ifdef CONFIG_OMAP34XX_OFFMODE */
#ifdef AGGR_PM_CAP
		omap_mmc_sysconfig (host, OMAP_MMC_SYSCONFIG_LVL2);
#endif /* #ifdef AGGR_PM_CAP */
		clk_disable(host->fclk);
		clk_disable(host->iclk);
	}

#ifdef CONFIG_MMC_OMAP3430
	/* 3430-ES1.0  Sil errata fix */
	if (is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
		spin_lock(&mmc_gpt_lock);
		gptfclk_counter --;
		if (!gptfclk_counter)
			clk_disable(host->gptfck);
		spin_unlock(&mmc_gpt_lock);
	}
#endif /* #ifdef CONFIG_MMC_OMAP3430 */
	return 0;
}

/*
 * Stop clock to the card
 */
static void omap_mmc_stop_clock(struct mmc_omap_host *host)
{
	/* Stop clock to the card */
	OMAP_HSMMC_WRITE(host->base, SYSCTL,
			OMAP_HSMMC_READ(host->base, SYSCTL) & ~CEN);
	if ((OMAP_HSMMC_READ(host->base, SYSCTL) & CEN) != 0x0)
		dev_dbg(mmc_dev(host->mmc), "MMC clock not stoped,"
					"clock freq can not be altered\n");
}

/*
 * Send init stream sequence to the card before sending IDLE command
 */
static void send_init_stream(struct mmc_omap_host *host)
{
	int reg = 0, status;
	typeof(jiffies) timeout;

	disable_irq(host->irq);
	OMAP_HSMMC_WRITE(host->base, ISE, INT_CLEAR);
	OMAP_HSMMC_WRITE(host->base, IE, INT_CLEAR);

	OMAP_HSMMC_WRITE(host->base, CON,
			OMAP_HSMMC_READ(host->base, CON) | INIT_STREAM);
	OMAP_HSMMC_WRITE(host->base, CMD, INIT_STREAM_CMD);

	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
	while ((reg != CC) && time_before(jiffies, timeout)) {
		reg = OMAP_HSMMC_READ(host->base, STAT) & CC;
	}

	OMAP_HSMMC_WRITE(host->base, CON,
			OMAP_HSMMC_READ(host->base, CON) & ~INIT_STREAM);

	status = OMAP_HSMMC_READ(host->base, STAT);
	OMAP_HSMMC_WRITE(host->base, STAT, status);

	enable_irq(host->irq);
}


/*
 * Configure the resptype, cmdtype and send the given command to the card
 */
static void
mmc_omap_start_command18(struct mmc_omap_host *host, struct mmc_command *cmd)
{
	int  cmdreg = 0, resptype = 0, cmdtype = 0;

	mmc_clk_enable_aggressive(host);
	/* Clear status bits and enable interrupts */
	OMAP_HSMMC_WRITE(host->base, STAT, OMAP_HSMMC_STAT_CLEAR);

	resptype = 2;
	cmdreg = (MMC_READ_MULTIPLE_BLOCK << 24) | (resptype << 16) | (cmdtype << 22);
	cmdreg |= DP_SELECT | DDIR | MSBS | BCE | DMA_EN;
	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
	OMAP_HSMMC_WRITE(host->base, ARG, host->mod_addr);
	OMAP_HSMMC_WRITE(host->base, CMD, cmdreg);
}

/*
 * Configure the resptype, cmdtype and send the given command to the card
 */
static void
mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd)
{
	int  cmdreg = 0, resptype = 0, cmdtype = 0;
#ifdef CONFIG_OMAP_SDIO
	int func = 0, new_size = 0;
#endif	/* ifdef CONFIG_OMAP_SDIO */

	dev_dbg(mmc_dev(host->mmc), "%s: CMD%d, argument 0x%08x\n",
			mmc_hostname(host->mmc), cmd->opcode, cmd->arg);

	host->cmd = cmd;

#ifdef CONFIG_OMAP_SDIO
	if (cmd->opcode == IO_RW_DIRECT) {
		if ((cmd->arg & IO_RW_DIRECT_MASK) == IO_RW_DIRECT_ARG_MASK)
			cmdtype = 0x2;
	}
#endif	/* ifdef CONFIG_OMAP_SDIO */

	mmc_clk_enable_aggressive(host);

	/* Clear status bits and enable interrupts */
	OMAP_HSMMC_WRITE(host->base, STAT, OMAP_HSMMC_STAT_CLEAR);

	switch (RSP_TYPE(mmc_resp_type(cmd))) {
	case RSP_TYPE(MMC_RSP_R1):
	case RSP_TYPE(MMC_RSP_R3):
		/* resp 1, resp 1b */
		resptype = 2;
		break;
	case RSP_TYPE(MMC_RSP_R2):
		resptype = 1;
		break;
	default:
		break;
	}

	cmdreg = (cmd->opcode << 24) | (resptype << 16) | (cmdtype << 22);
	if (cmd->opcode == MMC_SEND_CSD)
		host->rca = cmd->arg;
	if (cmd->opcode == MMC_READ_MULTIPLE_BLOCK)
		host->org_addr = cmd->arg;


	if (cmd->opcode == MMC_READ_SINGLE_BLOCK
		|| cmd->opcode == MMC_READ_MULTIPLE_BLOCK
		|| cmd->opcode == SD_APP_SEND_SCR
		|| (cmd->opcode == SD_SWITCH && cmd->arg == 0xfffff1)
		|| (cmd->opcode == SD_SWITCH && cmd->arg == 0x80fffff1)
		|| (cmd->opcode == MMC_SEND_EXT_CSD && cmd->arg == 0)) {

		if (host->use_dma)
			cmdreg |= DP_SELECT | DDIR | MSBS | BCE | DMA_EN;
		else
			cmdreg |= DP_SELECT | DDIR | MSBS | BCE;

	} else if (cmd->opcode == MMC_WRITE_BLOCK
		|| cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK) {

		if (host->use_dma)
			cmdreg |= DP_SELECT | MSBS | BCE | DMA_EN;
		else
			cmdreg |= DP_SELECT | MSBS | BCE;

		cmdreg &= ~(DDIR);
	}

#ifdef CONFIG_OMAP_SDIO
	/* Handle I/O related command settings */
	if (cmd->opcode == IO_RW_EXTENDED) {

		if (polling_mode == 1) {
			return mmc_omap_polling_command(host, cmd, cmdreg);
		}

		if (cmd->arg & OMAP_SDIO_READ) {
#ifdef	CONFIG_OMAP_SDIO_NON_DMA_MODE
			cmdreg |= DP_SELECT;
#else
			cmdreg |= DP_SELECT | DMA_EN | BCE | MSBS;
#endif
			cmdreg &= ~(DDIR);
		} else {
#ifdef	CONFIG_OMAP_SDIO_NON_DMA_MODE
			cmdreg |= DP_SELECT | DDIR;
#else
			cmdreg |= DP_SELECT | DDIR | DMA_EN | BCE | MSBS;
#endif
		}
	}

	if (cmd->opcode == IO_RW_DIRECT) {
		if (cmd->arg & OMAP_SDIO_READ) {
			cmdreg &= ~(DDIR);
			if ((cmd->arg & sdio_blkmode_mask) ==
					sdio_blkmode_regaddr1) {
				func = ((cmd->arg & sdio_rw_function_mask)
					>> 17);
				new_size = (cmd->arg & 0xFF);
				blkmode_bytecount[func] =
					blkmode_bytecount[func] & 0xFF00;
				blkmode_bytecount[func] =
					blkmode_bytecount[func] | new_size;
			} else if ((cmd->arg & sdio_blkmode_mask) ==
					sdio_blkmode_regaddr2) {
				func = ((cmd->arg & sdio_rw_function_mask)
					>> 17);
				new_size = ((cmd->arg & 0xFF) << 8);
				blkmode_bytecount[func] =
					blkmode_bytecount[func] & 0x00FF;
				blkmode_bytecount[func] =
					blkmode_bytecount[func] | new_size;
			} else
				cmdreg |= DDIR;
		}
	}

#endif	/* ifdef CONFIG_OMAP_SDIO */
	if (cmd->opcode == MMC_GO_IDLE_STATE || cmd->opcode == MMC_SEND_OP_COND
		|| cmd->opcode == MMC_ALL_SEND_CID)
		OMAP_HSMMC_WRITE(host->base, CON,
				OMAP_HSMMC_READ(host->base, CON) | OD);

	if (cmd->opcode == MMC_GO_IDLE_STATE) {
		if (host->initstream == 0) {
			send_init_stream(host);
			host->initstream = 1;
		}
	}

#ifdef CONFIG_OMAP_SDIO
	if (host->sdio_card_intr) {
		OMAP_HSMMC_WRITE(host->base, ISE, SDIO_CARD_INT_EN_MASK);
		OMAP_HSMMC_WRITE(host->base, IE, SDIO_CARD_INT_EN_MASK);
	} else {
#endif
	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
#ifdef CONFIG_OMAP_SDIO
	}
#endif

	OMAP_HSMMC_WRITE(host->base, ARG, cmd->arg);
	OMAP_HSMMC_WRITE(host->base, CMD, cmdreg);
}

#ifdef CONFIG_OMAP_SDIO
/*
 * Notify the xfer done on SDIO card to the core
 */
static void
sdio_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *sdiodata)
{
	if (!sdiodata)
		return;
#ifndef  CONFIG_OMAP_SDIO_NON_DMA_MODE
	if (polling_mode == 0)
		dma_unmap_sg(mmc_dev(host->mmc), host->mrq->data->sg,
			host->dma_len, host->dma_dir);
#endif
	host->data = NULL;
	host->sdiodata = NULL;
	host->datadir = OMAP_MMC_DATADIR_NONE;

	mmc_clk_disable_aggressive(host);

	if (!host->cmd) {
		host->mrq = NULL;
		mmc_request_done(host->mmc, sdiodata->mrq);
	}
	return;
}
#endif	/* ifdef CONFIG_OMAP_SDIO */

/*
 * Notify the xfer done on MMC/SD cards to the core
 */
static void
mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
{
	if(host->use_dma)
	{
		/* Un-map the memory required for DMA */
		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_len,
			host->dma_dir);
	}

	/* Reset the variables as transfer is complete */
	host->data = NULL;
	host->sg_len = 0;
	host->sg_dma_len = 0;

	host->datadir = OMAP_MMC_DATADIR_NONE;

	if (data->error == MMC_ERR_NONE)
		data->bytes_xfered += data->blocks * (data->blksz);
	else
		data->bytes_xfered = 0;

	mmc_clk_disable_aggressive(host);

	if (!data->stop) {
		host->mrq = NULL;
		mmc_request_done(host->mmc, data->mrq);
		return;
	}
	/* Send the stop command. Remember FCLK is not stopped before this call */
	mmc_omap_start_command(host, data->stop);
}


static void
mmc_omap_end_of_data(struct mmc_omap_host *host, struct mmc_data *data)
{
	unsigned long flags;
	int done;

	if (!host->use_dma) {
		mmc_omap_xfer_done(host, data);
		return;
	}
	done = 0;
	spin_lock_irqsave(&host->dma_lock, flags);
	if (host->dma_done)
		done = 1;
	else
		host->brs_received = 1;
	spin_unlock_irqrestore(&host->dma_lock, flags);

	if (done)
		mmc_omap_xfer_done(host, data);
}


static void
mmc_omap_dma_done(struct mmc_omap_host *host, struct mmc_data *data)
{
	unsigned long flags;
	int done;

	done = 0;
	spin_lock_irqsave(&host->dma_lock, flags);
	if (host->brs_received)
		done = 1;
	else
		host->dma_done = 1;
	spin_unlock_irqrestore(&host->dma_lock, flags);
	if (done)
		mmc_omap_xfer_done(host, data);
}

/*
 * Notify the core about command completion
 */
static void
mmc_omap_cmd_done(struct mmc_omap_host *host, struct mmc_command *cmd)
{
	host->cmd = NULL;
	if (cmd->flags & MMC_RSP_PRESENT) {
		if (cmd->flags & MMC_RSP_136) {
			/* response type 2 */
			cmd->resp[3] = OMAP_HSMMC_READ(host->base, RSP10);
			cmd->resp[2] = OMAP_HSMMC_READ(host->base, RSP32);
			cmd->resp[1] = OMAP_HSMMC_READ(host->base, RSP54);
			cmd->resp[0] = OMAP_HSMMC_READ(host->base, RSP76);
		} else {
			/* response types 1, 1b, 3, 4, 5, 6 */
			cmd->resp[0] = OMAP_HSMMC_READ(host->base, RSP10);
		}
	}
	if(cmd->opcode == SD_APP_OP_COND)
	{
		if(cmd->resp[0] & 0x40000000)
		{
			host->is_high_capacity = 1;
		}
		else
		{
			host->is_high_capacity = 0;
		}
	}
	if(cmd->opcode == MMC_SEND_OP_COND)
	{
		if(cmd->resp[0] & 0x40000000)
		{
			host->is_high_capacity = 1;
		}
		else
		{
			host->is_high_capacity = 0;
		}
	}

#ifdef CONFIG_OMAP_SDIO
	if (host->mmc->mode == MMC_MODE_SDIO) {
		if (host->sdiodata == NULL || cmd->error != MMC_ERR_NONE) {
			dev_dbg(mmc_dev(host->mmc), "%s: End request, err %x\n",
					mmc_hostname(host->mmc), cmd->error);
			host->mrq = NULL;

			mmc_clk_disable_aggressive(host);

			mmc_request_done(host->mmc, cmd->mrq);
		}
	} else {
#endif
		if (host->data == NULL || cmd->error != MMC_ERR_NONE) {
			dev_dbg(mmc_dev(host->mmc), "%s: End request, err %x\n",
					mmc_hostname(host->mmc), cmd->error);
			host->mrq = NULL;

			mmc_clk_disable_aggressive(host);

			mmc_request_done(host->mmc, cmd->mrq);
		}

#ifdef CONFIG_OMAP_SDIO
	}
#endif
}

/*
 * Dma cleaning in case of command errors
 */
static void mmc_dma_cleanup(struct mmc_omap_host *host)
{
	int dma_ch;

	host->data->error |= MMC_ERR_TIMEOUT;

	if(host->mmc->mode == MMC_MODE_SDIO)
	{
		if (host->use_dma && host->dma_ch != -1) {
			dma_unmap_sg(mmc_dev(host->mmc), host->data->sg, host->dma_len,
				host->dma_dir);
			dma_ch = host->dma_ch;
			host->dma_ch = -1;
			omap_free_dma(dma_ch);

		}
	}
	else
	{
		if (host->use_dma) {
			omap_stop_dma_chain_transfers(host->chain_id);
			dma_unmap_sg(mmc_dev(host->mmc), host->data->sg, host->sg_len,
				host->dma_dir);
			omap_free_dma_chain(host->chain_id);
			mmc_omap_dma_done(host, host->data);
			host->chain_id = -1;
		}
	}
	host->data = NULL;
#ifdef CONFIG_OMAP_SDIO
	host->sdiodata = NULL;
#endif
	host->datadir = OMAP_MMC_DATADIR_NONE;
}

#if defined(CONFIG_OMAP_SDIO) && defined(CONFIG_OMAP_SDIO_NON_DMA_MODE)
/*
 * Sdio non dma mode data transfer function
 */
static void sdio_non_dma_xfer(struct mmc_omap_host *host)
{
	int i, readCnt, bytec;
	typeof(jiffies) timeout;

	if (host->cmd) {
		timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);

		if (host->cmd->opcode == IO_RW_EXTENDED) {
			bytec = (host->cmd->arg & 0x1FF);

			if (bytec == 0)
				bytec = 0x200;

			readCnt = (bytec / 4);

			if (bytec % 4)
				readCnt++;

			if (host->cmd->arg & OMAP_SDIO_READ) {
				while (((OMAP_HSMMC_READ(host->base, PSTATE)
					& BWE) != BRW)
					&& time_before(jiffies, timeout));

				for (i = 0; i < readCnt; i++)
					OMAP_HSMMC_WRITE(host->base, DATA,
							*host->buffer++);
			} else {
				while (((OMAP_HSMMC_READ(host->base, PSTATE)
					& BRE) != BRR)
					&& time_before(jiffies, timeout));

				for (i = 0; i < readCnt; i++)
					*host->buffer++ =
					OMAP_HSMMC_READ(host->base, DATA);
			}
		}
	}
}
#endif

/* PIO only */
static void
mmc_omap_sg_to_buf(struct mmc_omap_host *host)
{
	struct scatterlist *sg;

	sg = host->data->sg + host->sg_idx;
	host->buffer_bytes_left = sg->length;
	host->buffer = page_address(sg->page) + sg->offset;
	if (host->buffer_bytes_left > host->total_bytes_left)
		host->buffer_bytes_left = host->total_bytes_left;
}


/* PIO only */
static void
mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
{
	int n;

	if (host->buffer_bytes_left == 0) {
		host->sg_idx++;
		BUG_ON(host->sg_idx == host->sg_len);
		mmc_omap_sg_to_buf(host);
	}
	n = 64;
	if (n > host->buffer_bytes_left)
		n = host->buffer_bytes_left;
	host->buffer_bytes_left -= n;
	host->total_bytes_left -= n;
	host->data->bytes_xfered += n;

	if (write) {
		__raw_writesw(host->base + OMAP_HSMMC_DATA, host->buffer, n);
	} else {
		__raw_readsw(host->base + OMAP_HSMMC_DATA, host->buffer, n);
	}
}


/*
 * Configure the resptype, cmdtype and send the given command to the card
 */
static void
mmc_omap_start_command13(struct mmc_omap_host *host, struct mmc_command *cmd)
{
	int  cmdreg = 0, resptype = 0, cmdtype = 0;
	unsigned long flags;

	mmc_clk_enable_aggressive(host);
	/* Clear status bits and enable interrupts */
	OMAP_HSMMC_WRITE(host->base, STAT, OMAP_HSMMC_STAT_CLEAR);
	resptype = 2;
	cmdreg = (MMC_SEND_STATUS << 24) | (resptype << 16) | (cmdtype << 22);

	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
	OMAP_HSMMC_WRITE(host->base, ARG, host->rca);
	OMAP_HSMMC_WRITE(host->base, CMD, cmdreg);
	spin_lock_irqsave(&host->dma_lock, flags);
	host->cmd_13 = 1;
	spin_unlock_irqrestore(&host->dma_lock, flags);
}

/*
 * Notify the core about command completion
 */
static void
mmc_omap_err_cmd_done(struct mmc_omap_host *host, struct mmc_command *cmd)
{
	cmd->resp[0] = OMAP_HSMMC_READ(host->base, RSP10);
	mmc_clk_disable_aggressive(host);
	if(host->cmd_13 == 1)
	{
		if(cmd->resp[0] != 0x900)
			dev_dbg(mmc_dev(host->mmc),
				"%s:CMD response error cmd->resp[0]%x\n",
				mmc_hostname(host->mmc),cmd->resp[0]);
	}
}



static int
mmc_omap_err_calc(struct mmc_omap_host *host)
{
	unsigned sg_len_remain;
	struct mmc_data *data = host->data;
	unsigned long flags;

	if(unlikely(host == NULL))
	{
		return -1;
	}
	/* Enable DMA */
	host->use_dma = 1;
	spin_lock_irqsave(&host->dma_lock, flags);

	if(host->extra_chain_reqd == 0)
	{
		if(host->data->sg_len <= NO_OF_DMA_CHAINS_USED)
			host->sg_idx = 0;
		else
			host->sg_idx = host->sg_idx-NO_OF_DMA_CHAINS_USED;
	}
	else
	{
		if(host->sg_idx == host->data->sg_len)
			host->sg_idx = host->data->sg_len;
		else
			host->sg_idx = host->sg_idx-NO_OF_DMA_CHAINS_USED;
	}
	if(host->sg_idx == host->data->sg_len)
		sg_len_remain =1;
	else
		sg_len_remain = data->sg_len - host->sg_idx;
	if(sg_len_remain >= NO_OF_DMA_CHAINS_USED)
	{
		host->chains_requested = NO_OF_DMA_CHAINS_USED;
	}
	else
	{
		host->chains_requested = 1;
	}
	if(host->data->sg_len <= NO_OF_DMA_CHAINS_USED)
	{
		host->extra_chain_reqd = 0;
		host->no_of_chain_reqd = 0;
		host->current_cb_cnt = 0;
	}
	else
	{
		host->no_of_chain_reqd = sg_len_remain/NO_OF_DMA_CHAINS_USED;
		host->extra_chain_reqd= sg_len_remain%NO_OF_DMA_CHAINS_USED;
		host->current_cb_cnt = 1;
	}
	spin_unlock_irqrestore(&host->dma_lock, flags);

	return 0;

}



/*
 * Routine to configure block leangth for MMC/SD/SDIO cards
 * and intiate the transfer.
 */
static int
mmc_omap_err_prepare_data(struct mmc_omap_host *host)
{
	int i;
	unsigned count=0, count1=0;
	struct mmc_data *data = host->data;

	if(unlikely(host == NULL))
	{
		return -1;
	}
	mmc_clk_enable_aggressive(host);	
	if (host->use_dma && host->chain_id != -1) {
		omap_stop_dma_chain_transfers(host->chain_id);
/*		  dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_len,
			host->dma_dir);*/
		omap_free_dma_chain(host->chain_id);
		host->chain_id = -1;
	}

	for(i = 0 ;i < host->sg_idx; i++)
	{
		count1 += (sg_dma_len(&data->sg[i])/data->blksz);
	}

	for(i = host->sg_idx ;i < (host->chains_requested+host->sg_idx); i++)
	{
		count += (sg_dma_len(&data->sg[i])/data->blksz);
	}

	OMAP_HSMMC_WRITE(host->base, BLK, (host->data->blksz));
	OMAP_HSMMC_WRITE(host->base, BLK,
					OMAP_HSMMC_READ(host->base,
					BLK) | (count << 16));
	host->mod_addr = host->org_addr;
	if(host->is_high_capacity ==1)
		host->mod_addr += count1;//as card is high capacity
	else
		host->mod_addr += (count1*512);//as card is not high capacity
	host->datadir = (host->data->flags & MMC_DATA_WRITE) ?
			OMAP_MMC_DATADIR_WRITE : OMAP_MMC_DATADIR_READ;
	if (mmc_omap_get_dma_channel(host, data) == 0)
	{
		enum dma_data_direction dma_data_dir;

		if (data->flags & MMC_DATA_WRITE)
			dma_data_dir = DMA_TO_DEVICE;
		else
			dma_data_dir = DMA_FROM_DEVICE;
		host->total_bytes_left = 0;
		mmc_chain_dma(host, host->data);
		host->brs_received = 0;
		host->dma_done = 0;
		/* Enable DMA */
		host->use_dma = 1;
	}
	mmc_clk_disable_aggressive(host);	
	return 0;
}

/*
 * Notify the xfer done on MMC/SD cards to the core
 */
static void
mmc_omap_read_err_done(struct mmc_omap_host *host, struct mmc_data *data)
{
	unsigned long flags;

	spin_lock_irqsave(&host->dma_lock, flags);
	host->flag_err = 1;
	host->cmd_12 = 1;
	spin_unlock_irqrestore(&host->dma_lock, flags);
	mmc_clk_disable_aggressive(host);
	mmc_omap_start_command(host, data->stop);
}


/*
 * Notify the xfer done on MMC/SD cards to the core
 */
static void
mmc_omap_err_done(struct mmc_omap_host *host, struct mmc_data *data)
{
	host->data = NULL;
	if (host->use_dma && host->chain_id != -1) {
		omap_stop_dma_chain_transfers(host->chain_id);
		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_len,
			host->dma_dir);
		omap_free_dma_chain(host->chain_id);
		host->chain_id = -1;
	}

	host->datadir = OMAP_MMC_DATADIR_NONE;
	host->sg_dma_len = 0;

	mmc_clk_disable_aggressive(host);

	if (!data->stop) {
		host->mrq = NULL;
		mmc_request_done(host->mmc, data->mrq);
		return;
	}
	mmc_omap_start_command(host, data->stop);
}



/*
 * The MMC controller IRQ handler
 */
static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
{
	struct mmc_omap_host *host = (struct mmc_omap_host *)dev_id;
	int end_command, end_transfer, status, read_crc =0;
	unsigned long flags;
	typeof(jiffies) timeout;

	if (unlikely(host == NULL))
	{
		return IRQ_HANDLED;
	}

	if(unlikely(host->cmd == NULL && host->data == NULL)) {
		status = OMAP_HSMMC_READ(host->base, STAT);
		if (status != 0) {
			OMAP_HSMMC_WRITE(host->base, STAT, status);
		}

		mmc_clk_disable_aggressive(host);

		return IRQ_HANDLED;
	}

	end_command = 0;
	end_transfer = 0;
	if (host->cmd) {
		if (host->cmd->opcode == MMC_SELECT_CARD
			|| host->cmd->opcode == MMC_SWITCH) {
			timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
			while (time_before(jiffies, timeout)) {
				if ((OMAP_HSMMC_READ(host->base, STAT)
					& CC) == CC)
					break;
			}
		}
	}
	status = OMAP_HSMMC_READ(host->base, STAT);
	dev_dbg(mmc_dev(host->mmc), "Status in IRQ %x\n", status);

	if(unlikely(host->use_dma == 0))
	{
		if (host->total_bytes_left != 0) {
			if ((status & OMAP_MMC_STAT_BRR) ||
				(status & TC))
				mmc_omap_xfer_data(host, 0);
			if (status & OMAP_MMC_STAT_BWR)
				mmc_omap_xfer_data(host, 1);
		}
	}

	if (status & (OMAP_HSMMC_ERR)) {
		if (status & (OMAP_HSMMC_CMD_TIMEOUT) ||
			status & (OMAP_HSMMC_CMD_CRC)) {
			if (host->cmd) {
				if (status & (OMAP_HSMMC_CMD_TIMEOUT)) {
					/*
					 * Timeouts are normal in case of
					 * MMC_SEND_STATUS
					 */

					if (host->cmd->opcode !=
						MMC_ALL_SEND_CID)
						dev_dbg(mmc_dev(host->mmc),
							"CMD Timeout CMD%d\n",
							host->cmd->opcode);
					host->cmd->error |= MMC_ERR_TIMEOUT;
				} else {
					dev_dbg(mmc_dev(host->mmc),
						"%s: Command CRC error CMD%d\n",
						mmc_hostname(host->mmc),
						host->cmd->opcode);
					host->cmd->error |= MMC_ERR_BADCRC;
				}
				end_command = 1;
			}

			if (host->data)
				mmc_dma_cleanup(host);
		}

		if (status & (OMAP_HSMMC_DATA_TIMEOUT) ||
			status & (OMAP_HSMMC_DATA_CRC)) {
			if (host->data) {
				if (status & (OMAP_HSMMC_DATA_TIMEOUT)) {
					dev_dbg(mmc_dev(host->mmc),
						"%s:Data timeout\n",
						mmc_hostname(host->mmc));
					mmc_dma_cleanup(host);
				} else {
					if(host->data->flags & MMC_DATA_READ)
					{
						read_crc = 1;
						if(host->flag_err == 1)
						{
							dev_dbg(mmc_dev(host->mmc),
								"%s:Data CRC for the second time\n",
								mmc_hostname(host->mmc));
							spin_lock_irqsave(&host->dma_lock, flags);
							host->crc_retry++;
							host->flag_err = 0;
							spin_unlock_irqrestore(&host->dma_lock, flags);
							if(host->crc_retry == MAX_CRC_RETRY)
							{
								spin_lock_irqsave(&host->dma_lock, flags);
								host->mod_addr = host->org_addr = 0;
								host->flag_err = host->cmd_12 = host->cmd_13 = 0;
								spin_unlock_irqrestore(&host->dma_lock, flags);
								host->data->error |= MMC_ERR_BADCRC;
								mmc_omap_err_done(host, host->data);
							}
						}
				   }
					else
						host->data->error |= MMC_ERR_BADCRC;
					dev_dbg(mmc_dev(host->mmc),
							"%s: Data CRC error,"
							" bytes left %d\n",
							mmc_hostname(host->mmc),
							host->bytesleft);
				}
				end_transfer = 1;
			}
		}

		if (status & OMAP_HSMMC_CARD_ERR) {
			dev_dbg(mmc_dev(host->mmc),
				"MMC%d: Card status error (CMD%d)\n",
				host->id, host->cmd->opcode);
			if (host->cmd) {
				host->cmd->error |= MMC_ERR_FAILED;
				end_command = 1;
			}
			if (host->data) {
				host->data->error |= MMC_ERR_FAILED;
				end_transfer = 1;
			}
		}
	}

#ifdef CONFIG_OMAP_SDIO
	if (host->mmc->mode == MMC_MODE_SDIO && host->sdio_card_intr) {
		if (status & OMAP_HSMMC_CARD_INT) {
			dev_dbg(mmc_dev(host->mmc),
				"MMC%d: SDIO CARD interrupt status %x\n",
				host->id, status);
			OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK &
				(~OMAP_HSMMC_CARD_INT));
			host->sdio_card_intr = 0;
			/*
			 * SDIO Card interrupt notifier code should go here,
			 * it should clear the source of interrupt and then
			 * call again the interrupt enable API.
			 */
			return IRQ_HANDLED;
		}
	}
#endif

#if defined(CONFIG_OMAP_SDIO) && defined(CONFIG_OMAP_SDIO_NON_DMA_MODE)
	sdio_non_dma_xfer(host);
#endif /* ifdef CONFIG_OMAP_SDIO */

	OMAP_HSMMC_WRITE(host->base, STAT, status);
	if(host->flag_err == 1)
	{
		if(host->cmd_12 == 1)
		{
			if (status & CC) {
				mmc_omap_err_cmd_done(host, host->cmd);
				spin_lock_irqsave(&host->dma_lock, flags);
				host->cmd_12 =0;
				spin_unlock_irqrestore(&host->dma_lock, flags);
				mmc_omap_start_command13(host, host->cmd);
				return IRQ_HANDLED;
			}
		}
		if(host->cmd_13 == 1)
		{
			if (status & CC) {
				mmc_omap_err_cmd_done(host, host->cmd);
				spin_lock_irqsave(&host->dma_lock, flags);
				host->cmd_13 =0;
				spin_unlock_irqrestore(&host->dma_lock, flags);
				mmc_omap_err_prepare_data(host);
				omap_start_dma_chain_transfers(host->chain_id);
				mmc_omap_start_command18(host, host->cmd);
				return IRQ_HANDLED;
			}
		}
		return IRQ_HANDLED;
	}

	if (end_command || (status & CC)) {
		mmc_omap_cmd_done(host, host->cmd);
	}

	if (host->mmc->mode == MMC_MODE_MMC
		|| host->mmc->mode == MMC_MODE_SD){
		if (end_transfer){
			if(read_crc)
			{
				mmc_omap_err_calc(host);
				mmc_omap_read_err_done(host, host->data);
			}
			else
				mmc_omap_err_done(host, host->data);
			}
		else if (status & TC)
			mmc_omap_end_of_data(host, host->data);
	}
#ifdef CONFIG_OMAP_SDIO
	if(host->mmc->mode == MMC_MODE_SDIO){
		if (end_transfer || (status & TC))
			sdio_omap_xfer_done(host, host->sdiodata);
	}
#endif	/* ifdef CONFIG_OMAP_SDIO */

	return IRQ_HANDLED;
}

#ifdef CONFIG_OMAP_SDIO
/*
 * Function for polling mode read write for SDIO cards
 */
static void mmc_omap_polling_command(struct mmc_omap_host *host,
					 struct mmc_command *cmd, u32 cmdreg)
{
	int i, readCnt, bytec, status = 0;
	typeof(jiffies) timeout;

	if (cmd->arg & OMAP_SDIO_READ) {
		cmdreg |= DP_SELECT;
		cmdreg &= ~(DDIR);
	} else {
		cmdreg |= DP_SELECT | DDIR;
	}

	OMAP_HSMMC_WRITE(host->base, STAT, OMAP_HSMMC_STAT_CLEAR);
	OMAP_HSMMC_WRITE(host->base, ISE, INT_CLEAR);
	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);

	OMAP_HSMMC_WRITE(host->base, ARG, cmd->arg);
	OMAP_HSMMC_WRITE(host->base, CMD, cmdreg);

	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
	while (time_before(jiffies, timeout)) {
		status = OMAP_HSMMC_READ(host->base, STAT);
		if ((status & CC))
			break;
	}
	if (!(status & CC)) {
		dev_dbg(mmc_dev(host->mmc),
		"SDIO Command error CMD IO_RW_extd\n");
		host->cmd->error |= MMC_ERR_TIMEOUT;
		mmc_omap_cmd_done(host, host->cmd);
		return;
	}

	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
	bytec = (host->cmd->arg & 0x1FF);
	readCnt = (bytec / 4);

	if (bytec % 4)
		readCnt++;

	if (host->cmd->arg & OMAP_SDIO_READ) {
		while (((OMAP_HSMMC_READ(host->base, PSTATE)
			& BWE) != BRW)
			&& time_before(jiffies, timeout)) ;

		for (i = 0; i < readCnt; i++)
			OMAP_HSMMC_WRITE(host->base, DATA, *host->buffer++);
	} else {
		while (((OMAP_HSMMC_READ(host->base, PSTATE) & BRE) != BRR)
			&& time_before(jiffies, timeout)) ;

		for (i = 0; i < readCnt; i++)
			*host->buffer++ = OMAP_HSMMC_READ(host->base, DATA);
	}

	status = 0;
	mmc_omap_cmd_done(host, host->cmd);
	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);

	while (time_before(jiffies, timeout)) {
		status = OMAP_HSMMC_READ(host->base, STAT);
		if (status & TC)
			break;
	}

	if (!(status & TC)) {
		dev_dbg(mmc_dev(host->mmc), "SDIO data sending error \n");
		host->data->error = MMC_ERR_TIMEOUT;
		return;
	}

	sdio_omap_xfer_done(host, host->sdiodata);
	return;
}
#endif

/*
 * Turn the socket power ON/OFF
 */
static int mmc_omap_power(struct mmc_omap_host *host, int on)
{
	int ret = 0;

	if (on){
		if (machine_is_omap_2430sdp() ||
					machine_is_omap_3430sdp() ||
					machine_is_omap_3430labrador() ||
					machine_is_omap3evm() || machine_is_omap3_beagle() )

			ret = enable_mmc_power(host->id);
	} else {
		if (machine_is_omap_2430sdp() ||
					machine_is_omap_3430sdp() ||
					machine_is_omap_3430labrador() ||
					machine_is_omap3evm() || machine_is_omap3_beagle() )

			ret = disable_mmc_power(host->id);
	}

	return ret;
}
/*
 * power switching module for mmc slot 1
 * power_mode=0 switches to 1.8V
 * power_mode=1 switches to 3V
 * Caller makes sure that it calls on  slot 1 with correct cpu revision
 */
static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int power_mode)
{
	int ret = 0;

	mmc_clk_disable(host);

	if (cpu_is_omap2430())
		clk_disable(host->dbclk);

	ret = mmc_omap_power(host,0);
	if (ret != 0)
		dev_dbg(mmc_dev(host->mmc),"Unable to disable power to MMC1\n");

		if (machine_is_omap_2430sdp() ||
					machine_is_omap_3430sdp() ||
					machine_is_omap_3430labrador() ||
					machine_is_omap3evm() || machine_is_omap3_beagle() ) {

		if (switch_power_mode(power_mode))
			dev_dbg(mmc_dev(host->mmc), "Unable to switch operating"
				"voltage to the card\n");
	}

	mmc_clk_enable(host);

	if (cpu_is_omap2430()) {
		if (clk_enable(host->dbclk) != 0)
			dev_dbg(mmc_dev(host->mmc),
				"Unable to enable MMC1 debounce clock"
				"while switching power\n");
	}

	OMAP_HSMMC_WRITE(host->base, HCTL,
			OMAP_HSMMC_READ(host->base, HCTL) & SDVSCLR);
	if (power_mode == 0) {
		OMAP_HSMMC_WRITE(host->base, HCTL,
			OMAP_HSMMC_READ(host->base, HCTL) | SDVS18);
	} else {
		OMAP_HSMMC_WRITE(host->base, HCTL,
			OMAP_HSMMC_READ(host->base, HCTL) | SDVS30);
		host->initstream = 0;
	}
	OMAP_HSMMC_WRITE(host->base, HCTL,
			OMAP_HSMMC_READ(host->base, HCTL) | SDBP);

	return 0;
}

/*
 * Work Item to notify the core about card insertion/removal
 */
static void mmc_omap_detect(struct work_struct *work)
{
	struct mmc_omap_host *host = container_of(work, struct mmc_omap_host,
		mmc_carddetect_work);

	mmc_clk_enable_aggressive(host);

	if (cpu_is_omap34xx() || (cpu_is_omap2430()
		&& omap2_cpu_rev() == 2)) {
		if (host->id == OMAP_MMC1_DEVID) {
			if (!(OMAP_HSMMC_READ(host->base, HCTL)
				& SDVSDET)) {
				if (omap_mmc_switch_opcond(host, 1) != 0)
					dev_dbg(mmc_dev(host->mmc),
					"mmc_omap_detect:switch"
					"command operation failed\n");
				host->mmc->ios.vdd =
					fls(host->mmc->ocr_avail) - 1;
			}
		}
	}
	mmc_detect_change(host->mmc, (HZ * 200) / 1000);

	mmc_clk_disable_aggressive(host);
}

/*
 * Interrupt service routine for handling card insertion and removal
 */
static irqreturn_t mmc_omap_irq_cd(int irq, void *dev_id)
{
	struct mmc_omap_host *host = (struct mmc_omap_host *)dev_id;
	unsigned long flags;

	if (machine_is_omap_2430sdp() ||
			machine_is_omap_3430sdp() ||
			machine_is_omap_3430labrador() ||
			machine_is_omap3evm() || machine_is_omap3_beagle() )
	{
		spin_lock_irqsave(&host->dma_lock, flags);
		host->card_detected = 1;
		host->mmc->mode = MMC_CARD_NONE;
		host->rca = host->mod_addr = host->org_addr = 0;
		host->is_high_capacity = 0;
		host->flag_err = host->cmd_12 = host->cmd_13 = 0;
		spin_unlock_irqrestore(&host->dma_lock, flags);
		schedule_work(&host->mmc_carddetect_work);
	}
	else
		dev_dbg(mmc_dev(host->mmc), "Place to implement MMC hotplug"
			"implementation based on what the other"
			"board can support\n");

	return IRQ_HANDLED;
}

/*
 * DMA call back function
 lch is chain id in case of chaining
 */
static void mmc_omap_dma_cb(int lch, u16 ch_status, void *data)
{
	struct mmc_omap_host *host = (struct mmc_omap_host *)data;
	int chainid = host->chain_id;
	int dma_ch;
	unsigned long flags;

	if(host->flag_err)
	{
		spin_lock_irqsave(&host->dma_lock, flags);
		host->crc_retry =0;
		spin_unlock_irqrestore(&host->dma_lock, flags);
		if(host->no_of_chain_reqd > host->current_cb_cnt)
		{
			spin_lock_irqsave(&host->dma_lock, flags);
			host->current_cb_cnt++;
			spin_unlock_irqrestore(&host->dma_lock, flags);
			mmc_omap_read_err_done(host, host->data);
		}
		else if(host->no_of_chain_reqd == host->current_cb_cnt)
		{
			if(host->extra_chain_reqd == 0)
			{
				/*cleanup and go away*/
				spin_lock_irqsave(&host->dma_lock, flags);
				host->flag_err = 0;
				spin_unlock_irqrestore(&host->dma_lock, flags);
				omap_stop_dma_chain_transfers(chainid);
				omap_free_dma_chain(chainid);
				mmc_omap_dma_done(host, host->data);
				host->chain_id = -1;

			}
			else
			{
				/*do the last transfer*/
				spin_lock_irqsave(&host->dma_lock, flags);
				host->chains_requested = host->extra_chain_reqd;
				host->extra_chain_reqd = 0;
				spin_unlock_irqrestore(&host->dma_lock, flags);
				mmc_omap_read_err_done(host, host->data);
			}
		}
		return;
	}
	if(host->mmc->mode == MMC_MODE_SDIO)
	{
		/*
		 * Only report the error for the time being, until the error handling
		 * for these type of errors is supported from the core
		 */
		if (ch_status & (1 << 11))
			dev_dbg(mmc_dev(host->mmc), " %s :MISALIGNED_ADRS_ERR\n",
				mmc_hostname(host->mmc));

		if (host->dma_ch < 0) {
			dev_dbg(mmc_dev(host->mmc), "%s:"
				"DMA callback while DMA not enabled?\n",
				mmc_hostname(host->mmc));
			return;
		}

		dma_ch = host->dma_ch;
		host->dma_ch = -1;
		omap_free_dma(dma_ch);
	}
	else
	{
		/* If we are at the last transfer, Shut down the reciever */
		if (omap_dma_chain_status(chainid) == OMAP_DMA_CHAIN_INACTIVE) {
			if(host->no_of_chain_reqd > host->current_cb_cnt)
			{
				mmc_chain_dma(host, host->data);
				omap_dma_set_interrupt_ch(host->chain_id, OMAP_DMA_DROP_IRQ |
								 OMAP2_DMA_MISALIGNED_ERR_IRQ |
								 OMAP2_DMA_TRANS_ERR_IRQ,
								 OMAP_DMA_DROP_IRQ |
								 OMAP_DMA_BLOCK_IRQ |
								 OMAP2_DMA_MISALIGNED_ERR_IRQ |
								 OMAP2_DMA_TRANS_ERR_IRQ);
				omap_start_dma_chain_transfers(host->chain_id);
				spin_lock_irqsave(&host->dma_lock, flags);
				host->current_cb_cnt++;
				spin_unlock_irqrestore(&host->dma_lock, flags);
			}
			else if(host->no_of_chain_reqd == host->current_cb_cnt)
			{
				if(host->extra_chain_reqd == 0)
				{
					omap_stop_dma_chain_transfers(chainid);
					omap_free_dma_chain(chainid);
					mmc_omap_dma_done(host, host->data);
					host->chain_id = -1;
				}
				else
				{
					omap_stop_dma_chain_transfers(chainid);
					omap_free_dma_chain(chainid);
					host->chain_id = -1;
					spin_lock_irqsave(&host->dma_lock, flags);
					host->chains_requested = host->extra_chain_reqd;
					spin_unlock_irqrestore(&host->dma_lock, flags);
					mmc_omap_get_dma_channel(host, host->data);
					mmc_chain_dma(host, host->data);
					omap_start_dma_chain_transfers(host->chain_id);
					spin_lock_irqsave(&host->dma_lock, flags);
					host->extra_chain_reqd = 0;
					spin_unlock_irqrestore(&host->dma_lock, flags);
				}
			}
			else
			{
				dev_dbg(mmc_dev(host->mmc), "%s:"
					"DMA callback ERROR\n",
					mmc_hostname(host->mmc));
			}
		}
		else
		{
			dev_dbg(mmc_dev(host->mmc), "%s:"
				"DMA callback Channel active?\n",
				mmc_hostname(host->mmc));
		}
	}
}


#ifdef CONFIG_OMAP_SDIO
#ifndef CONFIG_OMAP_SDIO_NON_DMA_MODE

/*
 * Configure dma src and destination parameters
 */
static int mmc_omap_config_dma_param(int sync_dir, struct mmc_omap_host *host,
					 struct mmc_data *data)
{
	if (sync_dir == OMAP_DMA_DST_SYNC) {
		omap_set_dma_dest_params(host->dma_ch,
					0,	// dest_port required only for OMAP1
						OMAP_DMA_AMODE_CONSTANT,
				  (dma_addr_t) (host-> mapbase + OMAP_HSMMC_DATA),0, 0);
		omap_set_dma_src_params(host->dma_ch,
					0,	// src_port required only for OMAP1
					OMAP_DMA_AMODE_POST_INC,
				sg_dma_address(&data-> sg[0]), 0, 0);
	} else {
		omap_set_dma_src_params(host->dma_ch,
					0,	// src_port required only for OMAP1
				OMAP_DMA_AMODE_CONSTANT,
				(dma_addr_t) (host->mapbase +OMAP_HSMMC_DATA),0, 0);
		omap_set_dma_dest_params(host->dma_ch,
					0,	// dest_port required only for OMAP1
				OMAP_DMA_AMODE_POST_INC,
			sg_dma_address(&data->sg[0]), 0,0);
	}
	return 0;
}

/*
 * Routine to configure and start dma for SDIO card
 */
static int
sdio_omap_start_dma_transfer(struct mmc_omap_host *host,
				 struct mmc_request *req)
{
	int sync_dev, sync_dir, dma_ch, ret, readCnt, bytecount;
	int nob = 1, func = 0;
	struct mmc_data *data = req->data;
	/*
	 * If for some reason the DMA transfer is still active,
	 * we wait for timeout period and free the dma
	 */
	if (host->dma_ch != -1) {
		set_current_state(TASK_INTERRUPTIBLE);
		schedule_timeout(100);
		if (down_trylock(&host->sem)) {
			dma_ch = host->dma_ch;
			host->dma_ch = -1;
			omap_free_dma(dma_ch);
			up(&host->sem);
			return 1;
		}
	} else {
		if (down_trylock(&host->sem)) {
			dev_dbg(mmc_dev(host->mmc),
				"Semaphore was not initialized \n");
			BUG();
		}
	}

	if (req->cmd->opcode == IO_RW_EXTENDED) {
		if (req->cmd->arg & OMAP_SDIO_READ) {
			if (host->id == OMAP_MMC1_DEVID)
				sync_dev = OMAP24XX_DMA_MMC1_TX;
			else
				sync_dev = OMAP24XX_DMA_MMC2_TX;
		} else {
			if (host->id == OMAP_MMC1_DEVID)
				sync_dev = OMAP24XX_DMA_MMC1_RX;
			else
				sync_dev = OMAP24XX_DMA_MMC2_RX;
		}

		ret = omap_request_dma(sync_dev, "SDIO", mmc_omap_dma_cb,
						host,&dma_ch);
		if (ret != 0) {
			dev_dbg(mmc_dev(host->mmc),
				"%s: omap_request_dma() failed with %d\n",
				mmc_hostname(host->mmc), ret);
			return ret;
		}

		host->dma_len =  dma_map_sg(mmc_dev(host->mmc), data->sg,
						data->sg_len, host->dma_dir);
		host->dma_ch = dma_ch;

		if (req->cmd->arg & OMAP_SDIO_READ) {
			sync_dir = OMAP_DMA_DST_SYNC;
			mmc_omap_config_dma_param(sync_dir, host, data);
		} else {
			sync_dir = OMAP_DMA_SRC_SYNC;
			mmc_omap_config_dma_param(sync_dir, host, data);
		}

		if (req->cmd->arg & SDIO_BLKMODE) {
			nob = req->cmd->arg & 0x1FF;

			if (nob == 0)
				nob = 0x200;

			func = ((req->cmd->arg & sdio_function_mask) >> 28);
			bytecount = blkmode_bytecount[func];
			readCnt = (bytecount / 4);

			if (bytecount % 4)
				readCnt++;

		} else {
			bytecount = req->cmd->arg & 0x1FF;

			if (bytecount == 0)
				bytecount = 0x200;

			readCnt = (bytecount / 4);

			if (bytecount % 4)
				readCnt++;
		}

		omap_set_dma_transfer_params(dma_ch,
				OMAP_DMA_DATA_TYPE_S32, readCnt,
				nob,OMAP_DMA_SYNC_FRAME, sync_dev,sync_dir);

		omap_start_dma(dma_ch);
	}
	return 0;
}
#endif
#endif	/* ifdef CONFIG_OMAP_SDIO */

static int mmc_omap_get_dma_channel(struct mmc_omap_host *host, struct mmc_data *data)
{
	int ret = 0;
	int dma_chid;
	u16 frame;
	u32 count;
	struct scatterlist *sg = &data->sg[host->sg_idx];
	int sync_dev = 0;

	frame = data->blksz;/*blk size*/
	count = sg_dma_len(sg)/frame;/*No of blocks*/

	/*
	 * If for some reason the DMA transfer is still active,
	 * we wait for timeout period and free the dma
	 */
	 if(host->chain_id != -1)
		 dev_dbg(mmc_dev(host->mmc),
			 "%s: chain is not free\n",
			 mmc_hostname(host->mmc));

	/*Common params*/
	//host->params.burst_mode =
	host->params.data_type = OMAP_DMA_DATA_TYPE_S32;
	host->params.dst_ei = 0;
	host->params.dst_fi = 0;
	host->params.dst_port = 0;
	host->params.elem_count = (data->blksz / 4);
	//host->params.ie =
	host->params.read_prio = DMA_CH_PRIO_HIGH;
	host->params.src_ei = 0;
	host->params.src_fi = 0;
	host->params.src_port = 0;
	host->params.sync_mode = OMAP_DMA_SYNC_FRAME;
	host->params.write_prio = DMA_CH_PRIO_HIGH;


	if (!(data->flags & MMC_DATA_WRITE)) {
		host->dma_dir = DMA_FROM_DEVICE;
		if (host->id == OMAP_MMC1_DEVID)
			sync_dev = OMAP24XX_DMA_MMC1_RX;
		else
			sync_dev = OMAP24XX_DMA_MMC2_RX;

		host->params.dst_amode = OMAP_DMA_AMODE_POST_INC;
		host->params.dst_start = sg_dma_address(&data->sg[host->sg_idx]);

		host->params.frame_count = count;

		host->params.src_amode = OMAP_DMA_AMODE_CONSTANT;
		host->params.src_or_dst_synch = OMAP_DMA_SRC_SYNC;
		host->params.src_start = (dma_addr_t) (host->mapbase +OMAP_HSMMC_DATA);

		host->params.trigger = sync_dev;
	} else {
		host->dma_dir = DMA_TO_DEVICE;
		if (host->id == OMAP_MMC1_DEVID)
			sync_dev = OMAP24XX_DMA_MMC1_TX;
		else
			sync_dev = OMAP24XX_DMA_MMC2_TX;

		host->params.dst_amode = OMAP_DMA_AMODE_CONSTANT;
		host->params.dst_start = (dma_addr_t) (host->mapbase + OMAP_HSMMC_DATA);

		host->params.frame_count = count;

		host->params.src_amode = OMAP_DMA_AMODE_POST_INC;
		host->params.src_or_dst_synch = OMAP_DMA_DST_SYNC;
		host->params.src_start = sg_dma_address(&data->sg[host->sg_idx]);

		host->params.trigger = sync_dev;
	}

	/* Request a DMA chain for transfer
	 * A chain is requested before each transfer to avoid
	 * locking of DMA resources
	 */
	ret = omap_request_dma_chain(sync_dev, "MMC/SD", mmc_omap_dma_cb,
							&dma_chid, host->chains_requested,
							OMAP_DMA_DYNAMIC_CHAIN, host->params);
	if (ret != 0) {
		dev_dbg(mmc_dev(host->mmc),
			"%s: omap_request_dma_chain() failed with %d\n",
			mmc_hostname(host->mmc), ret);
		return ret;
	}
	else
	{
		if(host->chains_requested > 1)
		omap_dma_set_interrupt_ch(dma_chid, OMAP_DMA_DROP_IRQ |
						 OMAP2_DMA_MISALIGNED_ERR_IRQ |
						 OMAP2_DMA_TRANS_ERR_IRQ,
						 OMAP_DMA_DROP_IRQ |
						 OMAP_DMA_BLOCK_IRQ |
						 OMAP2_DMA_MISALIGNED_ERR_IRQ |
						 OMAP2_DMA_TRANS_ERR_IRQ);
	}
	host->chain_id = dma_chid;
	return 0;
}


static void mmc_chain_dma(struct mmc_omap_host *host, struct mmc_data *data)
{
	u16 frame;
	u32 count,i,dma_chain_status, sg_idx = host->sg_idx;
	struct scatterlist *sg;

	frame = data->blksz;
	for(i = host->sg_idx ;i < (host->chains_requested + sg_idx); i++)
	{
		sg = &data->sg[i];
		count = sg_dma_len(sg)/frame;
		host->sg_dma_len += (frame * count);
		if(!(data->flags & MMC_DATA_WRITE))
		{
			dma_chain_status = omap_dma_chain_a_transfer(host->chain_id,
			(dma_addr_t) (host->mapbase +OMAP_HSMMC_DATA),
			sg_dma_address(&data->sg[i]), (data->blksz / 4),
			count, host);
			if(dma_chain_status != 0)
				dev_dbg(mmc_dev(host->mmc),
					"%s: omap_dma_chain_a_transfer() failed during read with %d\n",
					mmc_hostname(host->mmc), dma_chain_status);
		}
		else
		{
			dma_chain_status = omap_dma_chain_a_transfer(host->chain_id,
			sg_dma_address(&data->sg[i]),
			(dma_addr_t) (host->mapbase + OMAP_HSMMC_DATA),
			(data->blksz / 4) ,count ,host);
			if(dma_chain_status != 0)
				dev_dbg(mmc_dev(host->mmc),
					"%s: omap_dma_chain_a_transfer() failed during write with %d\n",
					mmc_hostname(host->mmc), dma_chain_status);
		}
		host->sg_idx++;
	}

}

/*
 * Routine to configure block leangth for MMC/SD/SDIO cards
 * and intiate the transfer.
 */
static int
mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
{
	int use_dma;
	int i, block_size;
	unsigned sg_len;
	struct mmc_data *data = req->data;
	unsigned long flags;

#ifdef CONFIG_OMAP_SDIO
	int byte_count = 0, func = 0;
	int ret = 0;
#endif

	if(unlikely(host == NULL))
	{
		return -1;
	}

	/* Store the pointer for request */
	host->data = req->data;

#ifdef CONFIG_OMAP_SDIO
	host->sdiodata = req->data;
	if (req->cmd->opcode == IO_RW_EXTENDED) {
		if (req->cmd->arg & OMAP_SDIO_READ)
			host->datadir = OMAP_MMC_DATADIR_WRITE;
		else
			host->datadir = OMAP_MMC_DATADIR_READ;

		if ((req->cmd->arg & 0x1FF) == 0)
			byte_count = 0x200;
		else
			byte_count = req->cmd->arg & 0x1FF;

		func = ((req->cmd->arg & sdio_function_mask) >> 28);

		if (req->cmd->arg & SDIO_BLKMODE) {
			OMAP_HSMMC_WRITE(host->base, BLK,
					blkmode_bytecount[func]);
			OMAP_HSMMC_WRITE(host->base, BLK,
					OMAP_HSMMC_READ(host->base,
					BLK) | (byte_count << 16));
		} else {
			OMAP_HSMMC_WRITE(host->base, BLK, byte_count);
			OMAP_HSMMC_WRITE(host->base, BLK,
					OMAP_HSMMC_READ(host->base,BLK)
					| (1 << 16));
		}

#ifdef	CONFIG_OMAP_SDIO_NON_DMA_MODE
		host->buffer = (u32 *) req->data->sdio_buffer_virt;
#else
		if (polling_mode == 0) {
			ret = sdio_omap_start_dma_transfer(host, req);
			if (ret != 0) {
				dev_dbg(mmc_dev(host->mmc),
					"Sdio start dma failure\n");
				return ret;
			} else {
				host->buffer = NULL;
				host->bytesleft = 0;
			}
		} else {
			host->buffer = (u32 *) req->data->sdio_buffer_virt;
		}
#endif
		return 0;
	}
#endif	/* ifdef CONFIG_OMAP_SDIO */
	/* Enable DMA */
	host->use_dma = 1;
	if (req->data == NULL) {
		host->datadir = OMAP_MMC_DATADIR_NONE;
		OMAP_HSMMC_WRITE(host->base, BLK, BLK_CLEAR);
		/* Since there is nothing to DMA, clear the flag */
		host->use_dma = 0;
		return 0;
	}

	OMAP_HSMMC_WRITE(host->base, BLK, (req->data->blksz));
	OMAP_HSMMC_WRITE(host->base, BLK,
					OMAP_HSMMC_READ(host->base,
					BLK) | (req->data->blocks << 16));


	/* Copy the Block Size information */
	block_size = data->blksz;

	/* Cope with calling layer confusion; it issues "single
	 * block" writes using multi-block scatterlists.
	 */
	sg_len = (data->blocks == 1) ? 1 : data->sg_len;

	spin_lock_irqsave(&host->dma_lock, flags);
	if(sg_len > NO_OF_DMA_CHAINS_USED)
	{
		host->extra_chain_reqd = sg_len % NO_OF_DMA_CHAINS_USED;
		host->no_of_chain_reqd = sg_len / NO_OF_DMA_CHAINS_USED;
		host->chains_requested = NO_OF_DMA_CHAINS_USED;
		host->current_cb_cnt = 1;
	}
	else
	{
		host->extra_chain_reqd = 0;
		host->no_of_chain_reqd = 0;
		host->chains_requested = data->sg_len;
		host->current_cb_cnt = 0;
	}
	spin_unlock_irqrestore(&host->dma_lock, flags);

	/* Only do DMA for entire blocks */
	use_dma = host->use_dma;
	if (use_dma) {
		for (i = 0; i < sg_len; i++) {
			if ((data->sg[i].length % block_size) != 0) {
				use_dma = 0;
				break;
			}
		}
	}
	host->datadir = (req->data-> flags & MMC_DATA_WRITE) ?
			OMAP_MMC_DATADIR_WRITE : OMAP_MMC_DATADIR_READ;
	/* Initialize the internal scatter list count */
	host->sg_idx = 0;
	if (use_dma) {
		if (mmc_omap_get_dma_channel(host, data) == 0) {
			enum dma_data_direction dma_data_dir;

			if (data->flags & MMC_DATA_WRITE)
				dma_data_dir = DMA_TO_DEVICE;
			else
				dma_data_dir = DMA_FROM_DEVICE;

			host->sg_len = dma_map_sg(mmc_dev(host->mmc), data->sg,
						sg_len, dma_data_dir);
			host->total_bytes_left = 0;
			mmc_chain_dma(host, req->data);
			host->brs_received = 0;
			host->dma_done = 0;

			/* Enable DMA */
			host->use_dma = 1;
		}
		else
		{
			host->use_dma = 0;
		}
	} else {
		/* Revert to CPU copy */
		host->buffer =
			(u32 *) (page_address(req->data->sg->page) +
				req->data->sg->offset);
		host->bytesleft = req->data->blocks * (req->data->blksz);
		host->dma_ch = -1;
		host->use_dma = 0;
	}

	return 0;
}

/*
 * Request function. Exposed API to core for read/write operation
 */
static void omap_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
{
	struct mmc_omap_host *host = mmc_priv(mmc);

	WARN_ON(host->mrq != NULL);
	host->mrq = req;

	mmc_clk_enable_aggressive(host);

	/* Reset MMC Controller's Data FSM */
	if (req->cmd->opcode == MMC_GO_IDLE_STATE) {
		OMAP_HSMMC_WRITE(host->base, SYSCTL,
				OMAP_HSMMC_READ(host->base, SYSCTL) | 1 << 26);
		while (OMAP_HSMMC_READ(host->base, SYSCTL) & (1 << 26)) ;
	}

	if (req->cmd->opcode == SD_APP_SEND_SCR
		|| req->cmd->opcode == MMC_SEND_EXT_CSD)
		mmc->ios.bus_width = MMC_BUS_WIDTH_1;

	if (mmc_omap_prepare_data(host, req))
		dev_dbg(mmc_dev(host->mmc),
			"MMC host %s failed to initiate data transfer\n",
			mmc_hostname(host->mmc));

	/* Start the DMA if DMA is needed */
	if (host->use_dma && (host->mmc->mode == MMC_MODE_MMC
			|| host->mmc->mode == MMC_MODE_SD))
	{
		omap_start_dma_chain_transfers(host->chain_id);
	}
	if(host->card_detected == 1)
	{
		if (host->mmc->mode == MMC_MODE_MMC ||
			host->mmc->mode == MMC_MODE_SD)
		{
			host->mmc->max_hw_segs = 128;
			host->mmc->max_phys_segs = 128;
			host->mmc->max_blk_size = 512;
			host->mmc->max_blk_count = 0xFFFF;
			host->mmc->max_req_size = host->mmc->max_blk_size * host->mmc->max_blk_count;
			host->mmc->max_seg_size = host->mmc->max_req_size;
			host->card_detected = 0;
		}
		else if(host->mmc->mode == MMC_MODE_SDIO)
		{
			host->mmc->max_hw_segs = 1;
			host->mmc->max_phys_segs = 1;
			host->mmc->max_seg_size = 1<<12;
			host->mmc->max_req_size = 1<<12;
			host->mmc->max_blk_size = 512;
			host->mmc->max_blk_count = 1<<12 / 512;
			host->card_detected = 0;
		}
	}
	mmc_clk_disable_aggressive(host);

	mmc_omap_start_command(host, req->cmd);
}


/*
 * Routine to configure clock values. Exposed API to core
 */
static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
{
	struct mmc_omap_host *host = mmc_priv(mmc);
	u16 dsor = 0;
	unsigned long regVal;
	typeof(jiffies) timeout;
	int *addr;

	dev_dbg(mmc_dev(host->mmc), "%s: set_ios: clock %dHz busmode %d"
			"powermode %d Vdd %x Bus Width %d\n",
			mmc_hostname(host->mmc), ios->clock, ios->bus_mode,
			ios->power_mode, ios->vdd, ios->bus_width);

	switch (ios->power_mode) {
	case MMC_POWER_OFF:
		host->initstream = 0;
#ifdef CONFIG_MMC_OMAP3430
		if (host->id == OMAP_MMC1_DEVID) {
			addr = (int *)&OMAP2_CONTROL_PBIAS_1;
			*addr &= ~(1 << 1);
			if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0))
				*addr &= ~(1 << 9);
		}
#endif
		if (mmc_omap_power(host, 0))
			dev_dbg(mmc_dev(host->mmc),
				"Could not disable power to MMC%d\n",host->id);
		break;
	case MMC_POWER_UP:
		if (mmc_omap_power(host, 1))
			dev_dbg(mmc_dev(host->mmc),
				"Could not enable power to MMC%d\n",host->id);
#ifdef CONFIG_MMC_OMAP3430
		if (host->id == OMAP_MMC1_DEVID) {
			addr = (int *)&OMAP2_CONTROL_PBIAS_1;
			*addr |= (1 << 1);
			if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0))
				*addr |= (1 << 9);
		}
#endif
		break;
	}

	mmc_clk_enable_aggressive(host);

	switch (mmc->ios.bus_width) {
	case MMC_BUS_WIDTH_8:
				OMAP_HSMMC_WRITE(host->base, CON,
			OMAP_HSMMC_READ(host->base,CON)
			| EIGHT_BIT);
		break;
	case MMC_BUS_WIDTH_4:
		OMAP_HSMMC_WRITE(host->base, HCTL,
			OMAP_HSMMC_READ(host->base,HCTL)
			| FOUR_BIT);
		break;
	case MMC_BUS_WIDTH_1:
		OMAP_HSMMC_WRITE(host->base, CON,
			OMAP_HSMMC_READ(host->base,CON) & ~EIGHT_BIT);
		OMAP_HSMMC_WRITE(host->base, HCTL,
			OMAP_HSMMC_READ(host->base,HCTL) & ~FOUR_BIT);
		break;
	}

	if (host->id == OMAP_MMC1_DEVID) {
		if ((cpu_is_omap34xx() && is_sil_rev_less_than(OMAP3430_REV_ES2_0))
			|| (cpu_is_omap2430() && omap2_cpu_rev() == 2)) {
			if ((OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET) &&
					((ios->vdd == 7) || (ios->vdd == 8))) {
				if (omap_mmc_switch_opcond(host, 0) != 0)
					dev_dbg(mmc_dev(host->mmc),
							"omap_mmc_set_ios:"
						"switch operation failed\n");
				host->initstream = 0;
			}
		}
	}

	if (ios->clock) {
		/* Enable MMC_SD_CLK */
		dsor = OMAP_MMC_MASTER_CLOCK / ios->clock;
		if (dsor < 1)
			dsor = 1;

		if (OMAP_MMC_MASTER_CLOCK / dsor > ios->clock)
			dsor++;

		if (dsor > 250)
			dsor = 250;
	}

	omap_mmc_stop_clock(host);
	regVal = OMAP_HSMMC_READ(host->base, SYSCTL);
	regVal = regVal & ~(CLKD_MASK);
	regVal = regVal | (dsor << 6);
	regVal = regVal | (DTO << 16);
	OMAP_HSMMC_WRITE(host->base, SYSCTL, regVal);
	OMAP_HSMMC_WRITE(host->base, SYSCTL,
			OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);

	/* wait till the ICS bit is set */
	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
	while ((OMAP_HSMMC_READ(host->base, SYSCTL) & ICS) != 0x2
		&& time_before(jiffies, timeout)) ;
	/* Enable clock to the card */
	OMAP_HSMMC_WRITE(host->base, SYSCTL,
			OMAP_HSMMC_READ(host->base, SYSCTL) | CEN);

	mmc_clk_disable_aggressive(host);
}

static struct mmc_host_ops mmc_omap_ops = {
	.request = omap_mmc_request,
	.set_ios = omap_mmc_set_ios,
};

#ifdef CONFIG_OMAP_SDIO
/*
 * Routine implementing SDIO polling mode sysfs entry
 */
static ssize_t sdio_polling_switch(struct device *dev,
				struct device_attribute *attr,
				const char *buf, size_t count)
{
	char cmd[25];
	int i = 0;

	if (count < 6) {
		dev_dbg(dev, "Invalid string\n");
		return count;
	}

	while (buf[i] != ' ' && buf[i] != '\n' && i < count) {
		cmd[i] = buf[i];
		i++;
	}

	cmd[i] = '\0';
	i++;

	if (!strcmp(cmd, "Enable")) {
		polling_mode = 1;
	} else if (!strcmp(cmd, "Disable")) {
		polling_mode = 0;
	} else {
		dev_dbg(dev, "Unrecognized string\n");
		dev_dbg(dev, "Usage:\n");
		dev_dbg(dev, "echo Enable >"
			"/sys/devices/platform/hsmmc-omap/sdio_polling_switch\n");
		dev_dbg(dev, "echo Disable >"
			"/sys/devices/platform/hsmmc-omap/sdio_polling_switch\n");
	}
	return count;
}

static DEVICE_ATTR(sdio_polling_switch, S_IWUSR, NULL, sdio_polling_switch);
#endif

/*
 * Routine implementing the driver probe method
 */
static int __init omap_mmc_probe(struct platform_device *pdev)
{
	struct omap_mmc_conf *minfo = pdev->dev.platform_data;
	struct mmc_host *mmc;
	struct mmc_omap_host *host = NULL;
	struct resource *res;
	int ret = 0, irq, *addr;
	if (minfo == NULL) {
		dev_err(&pdev->dev, "platform data missing\n");
		return -ENXIO;
	}
	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	irq = platform_get_irq(pdev, 0);
	if (res == NULL || irq < 0)
		return -ENXIO;

	res = request_mem_region(res->start, res->end - res->start + 1,
							pdev->name);
	if (res == NULL)
		return -EBUSY;

	mmc = mmc_alloc_host(sizeof(struct mmc_omap_host), &pdev->dev);
	if (!mmc) {
		ret = -ENOMEM;
		goto mmc_alloc_err;
	}

	host = mmc_priv(mmc);
	host->mmc = mmc;

	sema_init(&host->sem, 1);

	host->use_dma = OMAP_USE_DMA;
	host->dma_ch = -1;
	host->initstream = 0;
	host->mem_res = res;
	host->irq = irq;
	host->id = pdev->id;
	host->mapbase = (void *)host->mem_res->start;
	host->base = (void __iomem *)IO_ADDRESS(host->mapbase);
	mmc->ops = &mmc_omap_ops;
	mmc->f_min = 400000;
	mmc->f_max = 52000000;
	mmc->mode = MMC_CARD_NONE;
	host->card_detected = 1;
	host->is_high_capacity = 0;
	host->flag_err = 0;
	host->cmd_12 = 0;
	host->cmd_13 = 0;
	host->crc_retry = 0;

#ifdef CONFIG_OMAP_SDIO
	host->sdio_card_intr = 0;
#endif
	spin_lock_init(&host->dma_lock);
	host->chain_id = -1;
	host->sg_dma_len = 0;

	if (cpu_is_omap2430()) {
		if (host->id == OMAP_MMC1_DEVID) {
			host->fclk = clk_get(&pdev->dev, "mmchs1_fck");
			if (IS_ERR(host->fclk)) {
				ret = PTR_ERR(host->fclk);
				host->fclk = NULL;
				goto clk_get_err;
			}
			host->iclk = clk_get(&pdev->dev, "mmchs1_ick");
			if (IS_ERR(host->iclk)) {
				ret = PTR_ERR(host->iclk);
				host->iclk = NULL;
				clk_put(host->fclk);
				goto clk_get_err;
			}
			host->dbclk = clk_get(&pdev->dev, "mmchsdb1_fck");
			/*
			 * Only through a error message, MMC can still work
			 * without debounce clock.
			 */
			if (IS_ERR(host->dbclk))
				dev_dbg(mmc_dev(host->mmc),
					"Failed to get debounce"
					"clock for MMC1\n");
		} else {
			host->fclk = clk_get(&pdev->dev, "mmchs2_fck");
			if (IS_ERR(host->fclk)) {
				ret = PTR_ERR(host->fclk);
				host->fclk = NULL;
				goto clk_get_err;
			}
			host->iclk = clk_get(&pdev->dev, "mmchs2_ick");
			if (IS_ERR(host->iclk)) {
				ret = PTR_ERR(host->iclk);
				host->iclk = NULL;
				clk_put(host->fclk);
				goto clk_get_err;
			}
			host->dbclk = clk_get(&pdev->dev, "mmchsdb2_fck");
			/*
			 * Only through a error message, MMC can still work
			 * without debounce clock.
			 */
			if (IS_ERR(host->dbclk))
				dev_dbg(mmc_dev(host->mmc),
						"Failed to get"
					"debounce clock for MMC2\n");
		}
	}

	if (cpu_is_omap34xx()) {
		/* 3430-ES1.0  Sil errata fix */
		if (is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
			host->gptfck = clk_get(&pdev->dev, "gpt10_fck");
			if (IS_ERR(host->gptfck)) {
				ret = PTR_ERR(host->gptfck);
				host->gptfck = NULL;
				goto clk_get_err;
			}
		}

		host->fclk = clk_get(&pdev->dev, "mmc_fck");
		if (IS_ERR(host->fclk)) {
			ret = PTR_ERR(host->fclk);
			host->fclk = NULL;
			goto clk_get_err;
		}

		host->iclk = clk_get(&pdev->dev, "mmc_ick");
		if (IS_ERR(host->iclk)) {
			ret = PTR_ERR(host->iclk);
			clk_put(host->fclk);
			host->iclk = NULL;
			goto clk_get_err;
		}
	}

#ifdef CONFIG_OMAP34XX_OFFMODE
	modify_timeout_value(host->fclk, 500);
#endif /* #ifdef CONFIG_OMAP34XX_OFFMODE */

	mmc_clk_enable(host);

	if (cpu_is_omap2430()) {
		if (clk_enable(host->dbclk) != 0)
			dev_dbg(mmc_dev(host->mmc),
				"Failed to enable debounce clock for MMC%d\n",
				host->id);
		omap_writel(omap_readl(OMAP2_CONTROL_DEVCONF1) | MMC1_ACTIVE_OVERWRITE,
							OMAP2_CONTROL_DEVCONF1);
		if (minfo->wire4)
			/* OMAP2430 ES2.0 and onwards can support 4-bit */
			if (omap2_cpu_rev() >= 1)
				mmc->caps = MMC_CAP_4_BIT_DATA;
	}

	if (host->id == OMAP_MMC1_DEVID) {
		if (cpu_is_omap34xx()) {
#ifdef CONFIG_MMC_OMAP3430
			addr = (int *)&OMAP2_CONTROL_PBIAS_1;
			*addr |= (1 << 2);

			addr = (int *)&OMAP2_CONTROL_DEVCONF0;
			*addr |= (1 << 24);
#endif
			/* There is no 8-bit field in the structure yet */
			if (minfo->wire4) {
				if (cpu_is_omap3410()) {
					mmc->caps = MMC_CAP_4_BIT_DATA;
				}
				else
					mmc->caps = MMC_CAP_8_BIT_DATA;
			}

			OMAP_HSMMC_WRITE(host->base, HCTL,
					OMAP_HSMMC_READ(host->base,
					HCTL) | SDVS30);
		} else if (cpu_is_omap2430()) {
			/* OMAP2430 MMC1 on ES1.0 and ES2.1 can support 3V */
			if (omap2_cpu_rev() == 0 || omap2_cpu_rev() > 1) {
				OMAP_HSMMC_WRITE(host->base, HCTL,
						OMAP_HSMMC_READ(host->base,
								HCTL) | SDVS30);
			} else {
				/* OMAP2430 MMC1 ES2.0 - 1.8V only */
				OMAP_HSMMC_WRITE(host->base, HCTL,
						OMAP_HSMMC_READ(host->base,
								HCTL) | SDVS18);
			}
		}
	} else if (host->id == OMAP_MMC2_DEVID) {
		if (cpu_is_omap34xx()) {
#ifdef CONFIG_MMC_OMAP3430
			addr = (int *)&OMAP2_CONTROL_DEVCONF1;
			*addr |= (1 << 6);
#endif

			if (minfo->wire4)
				mmc->caps = MMC_CAP_4_BIT_DATA;
		}
		OMAP_HSMMC_WRITE(host->base, HCTL,
				OMAP_HSMMC_READ(host->base,
						HCTL) | SDVS18);
	}

	/* Use scatterlist DMA to reduce per-transfer costs.
	 * NOTE max_seg_size assumption that small blocks aren't
	 * normally used (except e.g. for reading SD registers).
	 */
	mmc->max_phys_segs = 128;		 /* Largest sized scatter list
									 * the driver could handle. Since this is
									 * managed by us in software, we can tune
									 * this value */
	mmc->max_hw_segs = 128; 		 /* Largest number of address/length
									 * pairs the host adapter can actually
									 * give at once to the device. This value
									 * should be kept same as scatter list	*/
	mmc->max_blk_size = 512;	   /* Block Length at max can be 1024 */
	mmc->max_blk_count = 0xFFFF;	/* No. of Blocks is 16 bits 			*/
	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
	mmc->max_seg_size = mmc->max_req_size;

	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34 | MMC_VDD_165_195;

	OMAP_HSMMC_WRITE(host->base, CAPA,OMAP_HSMMC_READ(host->base,
							CAPA) | VS30 | VS18);

	mmc->caps |= MMC_CAP_MULTIWRITE | MMC_CAP_BYTEBLOCK | MMC_CAP_MMC_HIGHSPEED |
			MMC_CAP_SD_HIGHSPEED;

	/* Set the controller to AUTO IDLE mode */
	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
			OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
	/* Set SD bus power bit */
	OMAP_HSMMC_WRITE(host->base, HCTL,
			OMAP_HSMMC_READ(host->base, HCTL) | SDBP);

	if (machine_is_omap_2430sdp() ||
			machine_is_omap_3430sdp() ||
			machine_is_omap_3430labrador() ||
			machine_is_omap3evm() || machine_is_omap3_beagle() ) {
		/*
		 * Create sysfs entries for enabling/disabling hotplug
		 * support for MMC cards
		 */
		if (device_create_file(&pdev->dev,
				&dev_attr_mmc_cover_switch) < 0) {
			dev_dbg(mmc_dev(host->mmc),
					"Unable to create sysfs"
				"attribute for MMC1 cover switch\n");
		}
		if (device_create_file(&pdev->dev,
			&dev_attr_mmc_card_detect) < 0) {
			dev_dbg(mmc_dev(host->mmc),
				"Unable to create sysfs"
				"attribute for MMC1 card detect\n");
		}
	}

#ifdef CONFIG_OMAP_SDIO
	if (device_create_file(&pdev->dev, &dev_attr_sdio_polling_switch) < 0) {
		dev_dbg(mmc_dev(host->mmc),
			"Unable to create sysfs"
			"attribute for SDIO 1 polling switch\n");
	}
#endif

	/* Request IRQ for MMC operations */
	ret = request_irq(host->irq, mmc_omap_irq, 0, pdev->name,
				host);
	if (ret) {
		dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ");
		goto irq_err;
	}

	host->card_detect_irq = minfo->switch_pin;
	if (minfo->switch_pin >= 0) {
		if (machine_is_omap_2430sdp() ||
					machine_is_omap_3430sdp() ||
					machine_is_omap_3430labrador() ||
					machine_is_omap3evm() || machine_is_omap3_beagle() ) {
			host->card_detect_irq =
				TWL4030_GPIO_IRQ_NO(minfo->switch_pin);
			INIT_WORK(&host->mmc_carddetect_work, mmc_omap_detect);


			if (setup_mmc_carddetect_irq(minfo->switch_pin)) {
				free_irq(host->irq, host);
				goto irq_err;
			}

		}
	}

	if (minfo->switch_pin >= 0) {
		ret = request_irq(host->card_detect_irq,
			mmc_omap_irq_cd, IRQF_DISABLED, pdev->name,host);
		if (ret < 0) {
			dev_dbg(mmc_dev(host->mmc),
				"Unable to grab T2 GPIO IRQ");
			free_irq(host->irq, host);
			goto irq_err;
		}
	}

	if (host->id == OMAP_MMC1_DEVID)
		saved_host1 = host;
	else
		saved_host2 = host;

	platform_set_drvdata(pdev, host);

	mmc_clk_disable_aggressive(host);

	mmc_add_host(mmc);
	return 0;

clk_get_err:
	dev_dbg(mmc_dev(host->mmc),
		"Error getting clock for MMC\n");
	if (host) {
		mmc_free_host(mmc);
	}
	return ret;

mmc_alloc_err:
	if (host)
		mmc_free_host(mmc);
	return ret;

irq_err:
	mmc_clk_disable(host);

	if (cpu_is_omap2430())
		clk_disable(host->dbclk);

	clk_put(host->fclk);
	clk_put(host->iclk);

	if (cpu_is_omap2430())
		clk_put(host->dbclk);

	if (host)
		mmc_free_host(mmc);
	return ret;
}

/*
 * Routine implementing the driver remove method
 */
static int omap_mmc_remove(struct platform_device *pdev)
{
	struct mmc_omap_host *host = platform_get_drvdata(pdev);

	platform_set_drvdata(pdev, NULL);

	if (host) {
		free_irq(host->irq, host);
		free_irq(host->card_detect_irq, host);
		flush_scheduled_work();

		/* Free the clks */
#ifndef AGGR_PM_CAP
		mmc_clk_disable(host);
#endif /* #ifndef AGGR_PM_CAP */

		if (cpu_is_omap2430())
			clk_disable(host->dbclk);
		clk_put(host->fclk);
		clk_put(host->iclk);
		if (cpu_is_omap2430())
			clk_put(host->dbclk);

#ifdef CONFIG_OMAP_SDIO
		device_remove_file(&pdev->dev,
					&dev_attr_sdio_polling_switch);
#endif
		mmc_free_host(host->mmc);
	}
	return 0;
}

#ifdef CONFIG_PM
/*
 * Routine to suspend the MMC device
 */
static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
{
	int ret = 0;
	int status;
	struct mmc_omap_host *host = platform_get_drvdata(pdev);

	if (host && host->suspended)
		return 0;

	if (host) {
		/* Notify the core to suspend the host */
		ret = mmc_suspend_host(host->mmc, state);
		if (ret == 0) {
			host->suspended = 1;

		/* Temporarily enabling the clocks for configuration */
		mmc_clk_enable_aggressive(host);

		if (machine_is_omap_2430sdp() ||
					machine_is_omap_3430sdp() ||
					machine_is_omap_3430labrador() ||
					machine_is_omap3evm() || machine_is_omap3_beagle() ) {
			disable_irq(host->card_detect_irq);
			ret = mask_carddetect_int(host->id);
			if (ret)
				dev_dbg(mmc_dev(host->mmc),
					"Unable to mask the card detect"
					"interrupt in suspend\n");
		}

		if (cpu_is_omap34xx() || (cpu_is_omap2430()
				&& omap2_cpu_rev() == 2)) {
			if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
				OMAP_HSMMC_WRITE(host->base,HCTL,
						OMAP_HSMMC_READ(host->base,HCTL)
						& SDVSCLR);
				OMAP_HSMMC_WRITE(host->base,HCTL,
						OMAP_HSMMC_READ(host->base,HCTL)
						|SDVS30);
				OMAP_HSMMC_WRITE(host->base,HCTL,
						OMAP_HSMMC_READ(host->base,HCTL)
						| SDBP);
			}
		}

		/* Disable Interrupts */
		OMAP_HSMMC_WRITE(host->base, ISE, INT_CLEAR);
		OMAP_HSMMC_WRITE(host->base, IE, INT_CLEAR);

		/* Clearing the STAT register*/
		status = OMAP_HSMMC_READ(host->base, STAT);
			OMAP_HSMMC_WRITE(host->base, STAT, status);
		/* disable clks for MMC1 */
		mmc_clk_disable(host);

		if (cpu_is_omap2430())
			clk_disable(host->dbclk);

		if (cpu_is_omap2430()) {
			if (host->id == OMAP_MMC1_DEVID) {
				if (omap2_cpu_rev() == 2) {
					omap_writel(omap_readl(OMAP2_CONTROL_DEVCONF1)
						& ~MMC1_ACTIVE_OVERWRITE,
						OMAP2_CONTROL_DEVCONF1);
				}
			}
		}

		ret = mmc_omap_power(host,0);
		if (ret != 0)
			dev_dbg(mmc_dev(host->mmc),
				"Unable to disable power to MMC1\n");
		host->initstream = 0;
		}
	}
	return ret;
}

/*
 * Routine to resume the MMC device
 */
static int omap_mmc_resume(struct platform_device *pdev)
{
	int ret = 0;
	struct mmc_omap_host *host = platform_get_drvdata(pdev);

	if (host && !host->suspended)
		return 0;

	if (host) {
		if (cpu_is_omap2430()) {
			if (host->id == OMAP_MMC1_DEVID) {
				if (omap2_cpu_rev() == 2)
					omap_writel(omap_readl(OMAP2_CONTROL_DEVCONF1)
						| MMC1_ACTIVE_OVERWRITE,
						OMAP2_CONTROL_DEVCONF1);
			}
		}
		ret = mmc_omap_power(host,1);
		if (ret != 0) {
			dev_dbg(mmc_dev(host->mmc),
				   "Unable to enable power to MMC1\n");
			return ret;
		}

#ifndef AGGR_PM_CAP
		mmc_clk_enable(host);
#endif /* #ifndef AGGR_PM_CAP */

		if (cpu_is_omap2430()) {
			if (clk_enable(host->dbclk) != 0)
				dev_dbg(mmc_dev(host->mmc),
						"Unable to enable debounce"
					"clock for MMC1\n");
		}

		if (machine_is_omap_2430sdp() ||
					machine_is_omap_3430sdp() ||
					machine_is_omap_3430labrador() ||
					machine_is_omap3evm() || machine_is_omap3_beagle() ) {
			enable_irq(host->card_detect_irq);
			ret = unmask_carddetect_int(host->id);
			if (ret)
				dev_dbg(mmc_dev(host->mmc),
					"Unable to unmask the card"
					"detect interrupt\n");
		}

		/* Notify the core to resume the host */
		ret = mmc_resume_host(host->mmc);
		if (ret == 0)
			host->suspended = 0;
	}
	return ret;

#ifndef AGGR_PM_CAP
clk_en_err:
	dev_dbg(mmc_dev(host->mmc),
		"Unable to enable MMC clocks during resume\n");
	return -1;
#endif
}

#else
#define omap_mmc_suspend	NULL
#define omap_mmc_resume		NULL
#endif

#ifdef CONFIG_DPM
static int
omap_mmc_pre_scale(int slot, struct notifier_block *op, unsigned long level,
		   void *ptr)
{
	int i = 0, timeout = 20;
	struct mmc_omap_host *host = (slot == MMC1) ? saved_host1 : saved_host2;

	switch (level) {
	case SCALE_PRECHANGE:
		/* If DMA is active then enable the stop at block gap event */
		if (host->dma_ch) {
			OMAP_HSMMC_WRITE(host->base, HCTL,
					OMAP_HSMMC_READ(host->base,HCTL) | SBGR);
			while (((OMAP_HSMMC_READ(host->base, STAT) & TC) != 0x2)
				|| (i < timeout)) {
				i++;
				/*
				 * Wait for 5 Micro seconds before reading the
				 * Block gap status
				 */
				udelay(5);
			}
			host->dma_ch = -1;
		}
		break;
	}
	return 0;
}

static int
omap_mmc_post_scale(int slot, struct notifier_block *op, unsigned long level,
			void *ptr)
{
	struct mmc_omap_host *host = (slot == MMC1) ? saved_host1 : saved_host2;

	switch (level) {
	case SCALE_POSTCHANGE:
		if (host->dma_ch == -1) {
		/*
		 * Reset the stop at block gap event before re-starting the
		 * transmission
		 */
		OMAP_HSMMC_WRITE(host->base, HCTL,
				OMAP_HSMMC_READ(host->base,HCTL) & ~(SBGR));
		/* Restart the transmision from the previously left block */
		OMAP_HSMMC_WRITE(host->base, HCTL,
				OMAP_HSMMC_READ(host->base,HCTL) | CT);
		/* 1ms delay reuired after re-starting transfer */
		mdelay(1);
		}
		break;
	}
	return 0;
}

#if defined(CONFIG_OMAP2430_MMC1) || defined(CONFIG_OMAP3430_MMC1)
/*
 * Prescale function for MMC1 controller
 */
static int
omap_mmc1_scale_prechange(struct notifier_block *op, unsigned long level,
			  void *ptr)
{
	return omap_mmc_pre_scale(MMC1, op, level, ptr);
}

/*
 * Post scale  function for MMC1 controller
 */
static int
omap_mmc1_scale_postchange(struct notifier_block *op, unsigned long level,
			   void *ptr)
{
	return omap_mmc_post_scale(MMC1, op, level, ptr);
}

static struct notifier_block omap_mmc1_pre_scale = {
	.notifier_call = omap_mmc1_scale_prechange,
};

static struct notifier_block omap_mmc1_post_scale = {
	.notifier_call = omap_mmc1_scale_postchange,
};
#endif
#if defined(CONFIG_OMAP2430_MMC2) || defined(CONFIG_OMAP3430_MMC2)
/*
 * Prescale function for MMC2 controller
 */
static int
omap_mmc2_scale_prechange(struct notifier_block *op, unsigned long level,
			  void *ptr)
{
	return omap_mmc_pre_scale(MMC2, op, level, ptr);
}

/*
 * Post scale  function for MMC2 controller
 */
static int
omap_mmc2_scale_postchange(struct notifier_block *op, unsigned long level,
			   void *ptr)
{
	return omap_mmc_post_scale(MMC2, op, level, ptr);
}

static struct notifier_block omap_mmc2_pre_scale = {
	.notifier_call = omap_mmc2_scale_prechange,
};

static struct notifier_block omap_mmc2_post_scale = {
	.notifier_call = omap_mmc2_scale_postchange,
};
#endif
#endif

static struct platform_driver omap_mmc_driver = {
	.probe = omap_mmc_probe,
	.remove = omap_mmc_remove,
	.suspend = omap_mmc_suspend,
	.resume = omap_mmc_resume,
	.driver = {
		   .name = "hsmmc-omap",
		   },
};

#ifdef CONFIG_OMAP_SDIO
/* API for Enable/Disable SDIO card interrupt */
int sdio_card_int_enable(int enable, int slot)
{
	int intr_mask, intr_ena;
	struct mmc_omap_host *host = (slot == MMC1) ? saved_host1 : saved_host2;

	intr_ena = OMAP_HSMMC_READ(host->base, ISE);
	intr_mask = OMAP_HSMMC_READ(host->base, IE);
	host->sdio_card_intr = enable;

	if (enable == SDIO_CARD_INT_DISABLE) {
		intr_ena = intr_ena & ~(OMAP_HSMMC_CARD_INT);
		intr_mask = intr_mask & ~(OMAP_HSMMC_CARD_INT);
	} else {
		intr_ena = intr_ena | OMAP_HSMMC_CARD_INT;
		intr_mask = intr_mask | OMAP_HSMMC_CARD_INT;
	}
	OMAP_HSMMC_WRITE(host->base, ISE, intr_ena);
	OMAP_HSMMC_WRITE(host->base, IE, intr_mask);
	return 0;
}
EXPORT_SYMBOL(sdio_card_int_enable);
#endif

/*
 * Driver init method
 */
static int __init omap_mmc_init(void)
{
	/* Register the MMC driver */
	if (platform_driver_register(&omap_mmc_driver)) {
		printk(KERN_ERR ":failed to register MMC driver\n");
		return -ENODEV;
	}
#ifdef CONFIG_DPM
#if defined(CONFIG_OMAP2430_MMC1) || defined(CONFIG_OMAP3430_MMC1)
	/* DPM scale registration for MMC1 controller */
	dpm_register_scale(&omap_mmc1_pre_scale, SCALE_PRECHANGE);
	dpm_register_scale(&omap_mmc1_post_scale, SCALE_POSTCHANGE);
#endif
#if defined(CONFIG_OMAP2430_MMC2) || defined(CONFIG_OMAP3430_MMC2)
	/* DPM scale registration for MMC2 controller */
	dpm_register_scale(&omap_mmc2_pre_scale, SCALE_PRECHANGE);
	dpm_register_scale(&omap_mmc2_post_scale, SCALE_POSTCHANGE);
#endif
#endif
	return 0;
}

/*
 * Driver exit method
 */
static void __exit omap_mmc_cleanup(void)
{
	/* Unregister MMC driver */
	platform_driver_unregister(&omap_mmc_driver);

#ifdef CONFIG_DPM
#if defined(CONFIG_OMAP2430_MMC1) || defined(CONFIG_OMAP3430_MMC1)
	/* Unregister DPM scale functions for MMC1 controller */
	dpm_unregister_scale(&omap_mmc1_pre_scale, SCALE_PRECHANGE);
	dpm_unregister_scale(&omap_mmc1_post_scale, SCALE_POSTCHANGE);
#endif
#if defined(CONFIG_OMAP2430_MMC2) || defined(CONFIG_OMAP3430_MMC2)
	/* Unregister DPM scale functions for MMC2 controller */
	dpm_unregister_scale(&omap_mmc2_pre_scale, SCALE_PRECHANGE);
	dpm_unregister_scale(&omap_mmc2_post_scale, SCALE_POSTCHANGE);
#endif
#endif
}

module_init(omap_mmc_init);
module_exit(omap_mmc_cleanup);

MODULE_DESCRIPTION("OMAP 2430/3430 Multimedia Card driver");
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Texas Instruments");

--------------060304000104020501030605
Content-Type: text/x-chdr;
 name="omap_hsmmc.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap_hsmmc.h"

/*
* drivers/mmc/omap_hsmmc.h
*
* Header file for OMAP2430/3430 HSMMC controller.
*
* Copyright (C) 2007 Texas Instruments.
* Author: Texas Instruments
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License version 2 as
* published by the Free Software Foundation.
*
* THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
* IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
* WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
*/

#ifndef	DRIVERS_MEDIA_MMC_OMAP_H
#define	DRIVERS_MEDIA_MMC_OMAP_H

#define RSP_TYPE(x)	((x) & ~(MMC_RSP_BUSY|MMC_RSP_OPCODE))
#define OMAP_MMC1_DEVID	1
#define OMAP_MMC2_DEVID 2

#define OMAP_MMC_DATADIR_NONE	0
#define OMAP_MMC_DATADIR_READ	1
#define OMAP_MMC_DATADIR_WRITE	2
#define MMC1_ACTIVE_OVERWRITE (1<<31)

#define OMAP_MMC_MASTER_CLOCK	96000000
#define OMAP_USE_DMA		1
#define MMC1			1
#define MMC2			2

/* HSMMC Host Controller Registers */
#define OMAP_HSMMC_SYSCONFIG	0x0010
#define OMAP_HSMMC_SYSSTATUS	0x0014
#define OMAP_HSMMC_CSRE		0x0024
#define OMAP_HSMMC_SYSTEST	0x0028
#define OMAP_HSMMC_CON		0x002C
#define OMAP_HSMMC_BLK		0x0104
#define OMAP_HSMMC_ARG		0x0108
#define OMAP_HSMMC_CMD		0x010C
#define OMAP_HSMMC_RSP10	0x0110
#define OMAP_HSMMC_RSP32	0x0114
#define OMAP_HSMMC_RSP54	0x0118
#define OMAP_HSMMC_RSP76	0x011C
#define OMAP_HSMMC_DATA		0x0120
#define OMAP_HSMMC_PSTATE	0x0124
#define OMAP_HSMMC_HCTL		0x0128
#define OMAP_HSMMC_SYSCTL	0x012C
#define OMAP_HSMMC_STAT		0x0130
#define OMAP_HSMMC_IE		0x0134
#define OMAP_HSMMC_ISE		0x0138
#define OMAP_HSMMC_AC12		0x013C
#define OMAP_HSMMC_CAPA		0x0140
#define OMAP_HSMMC_CUR_CAPA	0x0148
#define OMAP_HSMMC_REV		0x01FC

/* HSMMC controller bit definitions */
#define VS18		(1<<26)
#define VS30		(1<<25)
#define SDVS18		(0x5<<9)
#define SDVS30		(0x6<<9)
#define SDVSCLR		0xFFFFF1FF
#define SDVSDET		0x00000400
#define SIDLE_MODE	(0x2<<3)
#define AUTOIDLE	0x1
#define SDBP		(1<<8)
#define DTO		0xe
#define ICE		0x1
#define ICS		0x2
#define CEN		(1<<2)
#define CLKD_MASK	0x0000FFC0
#define INT_EN_MASK	0x307F0033
#define SDIO_CARD_INT_EN_MASK	0x307F0133
#define INIT_STREAM	(1<<1)
#define DP_SELECT	(1<<21)
#define DDIR		(1<<4)
#define DMA_EN		0x1
#define MSBS		1<<5
#define BCE		1<<1
#define EIGHT_BIT	1 << 5
#define FOUR_BIT	1 << 1
#define CC		0x1
#define TC		0x02
#define OD		0x1
#define BRW		0x400
#define BRR		0x800
#define BRE		(1<<11)
#define BWE		(1<<10)
#define SBGR		(1<<16)
#define CT		(1<<17)
#define OMAP_SDIO_READ	(1<<31)
#define SDIO_BLKMODE	(1<<27)
#define OMAP_HSMMC_ERR	(1 << 15)	   /* Any error */
#define OMAP_HSMMC_CMD_TIMEOUT	(1 << 16)   /* Command response time-out */
#define OMAP_HSMMC_DATA_TIMEOUT	(1 << 20)   /* Data response time-out */
#define OMAP_HSMMC_CMD_CRC	(1 << 17)   /* Command CRC error */
#define OMAP_HSMMC_DATA_CRC	(1 << 21)   /* Date CRC error */
#define OMAP_HSMMC_CARD_ERR	(1 << 28)   /* Card ERR */
#define OMAP_HSMMC_CARD_INT	(1 << 8)   /* SDIO Card INT */
#define OMAP_HSMMC_STAT_CLEAR	0xFFFFFFFF
#define INIT_STREAM_CMD		0x00000000
#define INT_CLEAR		0x00000000
#define BLK_CLEAR		0x00000000

#define sdio_blkmode_regaddr1	0x2000
#define sdio_blkmode_regaddr2	0x2200
#define sdio_blkmode_mask	0x03F1FE00
#define sdio_function_mask	0x70000000
#define sdio_rw_function_mask	0x000E0000
#define IO_RW_DIRECT_MASK	0xF000FF00
#define IO_RW_DIRECT_ARG_MASK	0x80001A00
#define SDIO_CARD_INT_ENABLE	1
#define SDIO_CARD_INT_DISABLE	0

#define MMC_TIMEOUT_MS	20
#define NO_OF_MMC_HOSTS 2

/* MMC Host controller read/write API's */
#define OMAP_HSMMC_READ(base, reg)	__raw_readl((base) + OMAP_HSMMC_##reg)
#define OMAP_HSMMC_WRITE(base, reg, val)	__raw_writel((val), (base) + OMAP_HSMMC_##reg)

#ifdef CONFIG_OMAP34XX_OFFMODE
extern int context_restore_required(struct clk *clk);
extern void modify_timeout_value(struct clk *clk, u32 value);
#endif /* #ifdef CONFIG_OMAP34XX_OFFMODE */
#endif

--------------060304000104020501030605--
