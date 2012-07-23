From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Disable low power mode if SDIO interrupts
 are used
Date: Sun, 22 Jul 2012 19:48:34 -0700
Message-ID: <CAD=FV=WxcXFgf+0a1UfAPRWuvWptLm9RjSqW3tEZjyT0Z+4gkA@mail.gmail.com>
References: <1342808038-7558-1-git-send-email-dianders@chromium.org>
	<CAFbHwiQh-Cwo4xo6-vCbvWsmz_cheZK1m3SnwkvSziunV1ShBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFbHwiQh-Cwo4xo6-vCbvWsmz_cheZK1m3SnwkvSziunV1ShBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, James Hogan <james.hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sat, Jul 21, 2012 at 3:40 AM, Will Newton <will.newton@gmail.com> wrote:
>>  static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
>>  {
>>         struct dw_mci_slot *slot = mmc_priv(mmc);
>> @@ -871,6 +896,14 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
>>         /* Enable/disable Slot Specific SDIO interrupt */
>>         int_mask = mci_readl(host, INTMASK);
>>         if (enb) {
>> +               /*
>> +                * Turn off low power mode if it was enabled.  This is a bit of
>> +                * a heavy operation and we disable / enable IRQs a lot, so
>> +                * we'll leave them disabled; they will get re-enabled again in
>> +                * dw_mci_setup_bus().
>> +                */
>> +               dw_mci_disable_low_power(mmc);
>> +
>
> Is it safe to just disable low power here or could the setting be
> overwritten in setup_bus?

Very good question.  In my current setup I don't see setup_bus()
called during normal operation.  If it were, my kernel messages would
be constantly spammed with messages like:
    Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)

...and they're not.  Things may be different with different SDIO cards perhaps?

In any case, it's pretty easy for me to spin the patch so that we
don't clobber the low power bit in setup_bus() if SDIO interrupts are
enabled.  That makes a lot of sense, though I'd need to make sure that
low power mode does eventually get set again if someone ejects the
SDIO card and puts in a non-SDIO card.

I'll spin the patch tomorrow when I can test it properly and also
address some commenting concerns another engineer at chromium.org had.

It still feels to me like there ought to be a better place to put this
code.  I'd rather disable low power mode as soon as we detect an SDIO
card.  I spent time searching and the best I could find was
dw_mci_enable_sdio_irq(), but I'm all ears if someone has a better
idea!  :)  Certainly this code needs to go somewhere if we want SDIO
interrupts to be reliable.

Thanks for your feeback!  :)

-Doug
