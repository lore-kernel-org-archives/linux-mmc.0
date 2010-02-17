From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
Date: Wed, 17 Feb 2010 22:34:24 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9EB1A8634@dnce01.ent.ti.com>
References: <cover.1265801967.git.david.vrabel@csr.com>
 <846fbf1a68cde5fd2d7c7ab084ace239c8de6867.1265801967.git.david.vrabel@csr.com>
 <f4f02c7875316b7f65466a5ac06f5b2b2960aa96.1265801967.git.david.vrabel@csr.com>
 <9ce6cf93ba1e6c3fd239f732ea5889a856948db3.1265801967.git.david.vrabel@csr.com>
 <4B7C30F3.904@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Class: urn:content-classes:message
In-Reply-To: <4B7C30F3.904@csr.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
List-Id: linux-mmc@vger.kernel.org

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of David Vrabel
>Sent: Wednesday, February 17, 2010 7:10 PM
>
>David Vrabel wrote:
>>
>> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>> +{
>> +    struct omap_hsmmc_host *host = mmc_priv(mmc);
>> +    u32 ie, con;
>> +    unsigned long flags;
>> +
>> +    spin_lock_irqsave(&host->irq_lock, flags);
>> +
>> +    /*
>> +     * When interrupts are enabled, CTPL must be set to enable
>> +     * DAT1 input buffer (or the card interrupt is always
>> +     * asserted) and FCLK must be enabled else wakeup does not
>> +     * work.
>> +     *
>> +     * FIXME: the power save code probably shouldn't be playing
>> +     * with FCLK and allow the clock subsystem to put it into
>> +     * smart-idle mode instead.
>> +     */
>> +    con = OMAP_HSMMC_READ(host->base, CON);
>> +    ie = OMAP_HSMMC_READ(host->base, IE);
>> +    if (enable) {
>> +            clk_enable(host->fclk);
>> +            ie |= CIRQ_ENABLE;
>> +            con |= CTPL;
>> +    } else {
>> +            clk_disable(host->fclk);
>> +            ie &= ~CIRQ_ENABLE;
>> +            con &= ~CTPL;
>> +    }
>> +    OMAP_HSMMC_WRITE(host->base, CON, con);
>> +    OMAP_HSMMC_WRITE(host->base, IE, ie);
>> +
>> +    spin_unlock_irqrestore(&host->irq_lock, flags);
>> +}
>
>This isn't doing a posted write flush but when it's added this ends up
>looking like:
>
>       spin_lock_irqsave(&host->lock, flags);
>
>       /*
>        * When interrupts are enabled, CTPL must be set to enable
>        * DAT1 input buffer (or the card interrupt is always
>        * asserted) and FCLK must be enabled else wakeup does not
>        * work.  Take care to disable FCLK after all the register
>        * accesses as they might not complete if FCLK is off.
>        *
>        * FIXME: the power save code probably shouldn't be playing
>        * with FCLK and allow the clock subsystem to put it into
>        * smart-idle mode instead.
>        */
>       con = OMAP_HSMMC_READ(host->base, CON);
>       ie = OMAP_HSMMC_READ(host->base, IE);
>       if (enable) {
>               clk_enable(host->fclk);
>               ie |= CIRQ_ENABLE;
>               con |= CTPL;
>       } else {
>               ie &= ~CIRQ_ENABLE;
>               con &= ~CTPL;
>       }
>       OMAP_HSMMC_WRITE(host->base, CON, con);
>       OMAP_HSMMC_WRITE(host->base, IE, ie);
>       OMAP_HSMMC_READ(host->base, IE); /* flush posted write */
>        if (!enable) {
>            clk_disable(host->fclk);
>        }
>
>       spin_unlock_irqrestore(&host->lock, flags);
>
>Could someone from TI could comment on why disabling FCLK affects
>register read?

Most IPs will require both iclk and fclk to be active in order to access them. Some simple IP can work with only an iclk.
Otherwise, accessing a register while enabling only iclk will lead to unpredictable behavior.

Regards,
Benoit

Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



