From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 2/2] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Thu, 26 Sep 2013 20:01:34 +0530
Message-ID: <52444546.4060303@ti.com>
References: <20130925234544.3745.55170.stgit@localhost> <20130925234740.3745.50637.stgit@localhost> <CALtMJEBKbbpM47uhM-KeSRHRkM5CJkgBx4kFq4j+GG9sKXEfag@mail.gmail.com> <20130926141936.GE8949@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20130926141936.GE8949@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Chris Ball <cjb@laptop.org>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thursday 26 September 2013 07:49 PM, Tony Lindgren wrote:
> Hi,
>
> * Andreas Fenkart <afenkart@gmail.com> [130926 01:34]:
>> 2013/9/26 Tony Lindgren <tony@atomide.com>:
>>> @@ -463,27 +469,34 @@ static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
>>>   static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
>>>                                    struct mmc_command *cmd)
>>>   {
>>> -       unsigned int irq_mask;
>>> +       u32 irq_mask = INT_EN_MASK;
>>> +       unsigned long flags;
>>>
>>>          if (host->use_dma)
>>> -               irq_mask = INT_EN_MASK & ~(BRR_EN | BWR_EN);
>>> -       else
>>> -               irq_mask = INT_EN_MASK;
>>> +               irq_mask &= ~(BRR_EN | BWR_EN);
>>>
>>>          /* Disable timeout for erases */
>>>          if (cmd->opcode == MMC_ERASE)
>>>                  irq_mask &= ~DTO_EN;
>>>
>>> +       spin_lock_irqsave(&host->irq_lock, flags);
>>>          OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>>>          OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
>>> +       if (host->flags & HSMMC_SDIO_IRQ_ENABLED)
>>> +               irq_mask |= CIRQ_EN;
>>>          OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
>>> +       spin_unlock_irqrestore(&host->irq_lock, flags);
>>>   }
>>>
>>>   static void omap_hsmmc_disable_irq(struct omap_hsmmc_host *host)
>>>   {
>>> +       unsigned long flags;
>>> +
>>> +       spin_lock_irqsave(&host->irq_lock, flags);
>>>          OMAP_HSMMC_WRITE(host->base, ISE, 0);
>>>          OMAP_HSMMC_WRITE(host->base, IE, 0);
>>>          OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>>
>> This is wrong. SDIO IRQ must not be disabled upon host initiated transfer.
>> see omap_hsmmc_request_done
>
> Hmm I don't quite follow you here, are you saying that
> omap_hsmmc_request_done() should call this conditionally?
>
> Or maybe even do a patch on top of this based on what you discovered
> with your earlier patches?
Hi Tony,

Resetting CIRQ_ENABLE in ISE and IE, clears the (latched) pending CIRQ_EN
if set in STAT register and also disables SDIO interrupt during interrupt
period (outside of command/data transaction).

+	u32 irq_mask = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->irq_lock, flags);
+
+	/* no transfer running, need to signal cirq if */
+	if (host->sdio_irq_en)
+		irq_mask |= CIRQ_EN;
+
+	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);

I will try testing these patches with above code change and let you know

