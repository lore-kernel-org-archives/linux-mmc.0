From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH V2 2/2] mmc: sdhci-msm: support voltage pad switching
Date: Fri, 2 Mar 2018 10:25:38 -0800
Message-ID: <CAD=FV=VXWbFDtDPboSpj=Pp3iCujN6RaE2dzXRpUEX-F-B_uZA@mail.gmail.com>
References: <1518415278-59062-1-git-send-email-vviswana@codeaurora.org> <1518415278-59062-3-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1518415278-59062-3-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Krishna Konda <kkonda@codeaurora.org>, evgreen@chromium.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sun, Feb 11, 2018 at 10:01 PM, Vijay Viswanath
<vviswana@codeaurora.org> wrote:
> From: Krishna Konda <kkonda@codeaurora.org>
>
> The PADs for SD card are dual-voltage that support 3v/1.8v. Those PADs
> have a control signal  (io_pad_pwr_switch/mode18 ) that indicates
> whether the PAD works in 3v or 1.8v.
>
> SDHC core on msm platforms should have IO_PAD_PWR_SWITCH bit set/unset
> based on actual voltage used for IO lines. So when power irq is
> triggered for io high or io low, the driver should check the voltages
> supported and set the pad accordingly.
>
> Signed-off-by: Krishna Konda <kkonda@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 5c23e92..96c81df 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -78,6 +78,8 @@
>  #define CORE_HC_MCLK_SEL_DFLT  (2 << 8)
>  #define CORE_HC_MCLK_SEL_HS400 (3 << 8)
>  #define CORE_HC_MCLK_SEL_MASK  (3 << 8)
> +#define CORE_IO_PAD_PWR_SWITCH_EN      (1 << 15)
> +#define CORE_IO_PAD_PWR_SWITCH  (1 << 16)
>  #define CORE_HC_SELECT_IN_EN   BIT(18)
>  #define CORE_HC_SELECT_IN_HS400        (6 << 19)
>  #define CORE_HC_SELECT_IN_MASK (7 << 19)
> @@ -1109,6 +1111,7 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>         u32 irq_status, irq_ack = 0;
>         int retry = 10;
>         int pwr_state = 0, io_level = 0;
> +       u32 config = 0;

Don't init things to 0 unless you're relying on it (you're not).
Doing so tends to bypass compiler warnings about "use before init" and
leads to uncaught bugs.


>         irq_status = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
> @@ -1166,6 +1169,30 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>          */
>         writel_relaxed(irq_ack, msm_host->core_mem + CORE_PWRCTL_CTL);
>
> +       /* Ensure order between core_mem and hc_mem */
> +       mb();

I spent a bit of time brushing up on my memory barriers and (as far as
I understand) I agree that in general mb() between accesses of
core_mem and hc_mem is technically needed since, as you say, there are
two separate io-mapped devices here and you're using relaxed
accessors.

Oh, but hold on.  In this particular case they're truly not needed,
right?  The value stored in CORE_VENDOR_SPEC should be exactly the
value you wrote last to it, right?  ...and you're just reading it
back.  There should be no need for any sort of barrier here...
...and, if you wanted to be _truly_ efficient (maybe you do since
you're going through all this trouble of using readl_relaxed) you
could just cache this value in "struct sdhci_msm_host" and you don't
even have to read it back at all.


> +       /*
> +        * We should unset IO PAD PWR switch only if the register write can
> +        * set IO lines high and the regulator also switches to 3 V.
> +        * Else, we should keep the IO PAD PWR switch set.
> +        * This is applicable to certain targets where eMMC vccq supply is only
> +        * 1.8V. In such targets, even during REQ_IO_HIGH, the IO PAD PWR
> +        * switch must be kept set to reflect actual regulator voltage. This
> +        * way, during initialization of controllers with only 1.8V, we will
> +        * set the IO PAD bit without waiting for a REQ_IO_LOW.
> +        */
> +       config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
> +
> +       if ((io_level & REQ_IO_HIGH) && (msm_host->caps_0 & CORE_3_0V_SUPPORT))
> +               config &= ~CORE_IO_PAD_PWR_SWITCH;
> +       else if ((io_level & REQ_IO_LOW) ||
> +                       (msm_host->caps_0 & CORE_1_8V_SUPPORT))
> +               config |= CORE_IO_PAD_PWR_SWITCH;

Part of me thinks that this would all be much cleaner using the same
solution as "drivers/power/avs/rockchip-io-domain.c".  AKA: register
to be notified about changes to vqmmc and set the bit whenever it
flips.  ...but I won't insist on that.  I don't know a whole lot about
the whole "REQ_IO_HIGH" bug I guess it's a sane place to do this...

...but I will say that the fact that sometimes "config" isn't set to
anything at all here confuses me (IOW if you don't hit either the "if"
or "else if" then config is unchanged).  I think the comment block
above tries to explain it, but I still don't really get it.  Maybe
more examples?  If I was describing the current algorithm, I'd give
these examples:

* If vqmmc can only be 1.8V then at init time we'll have set
PAD_PWR_SWITCH_EN and leave the PAD_PWR_SWITCH set to 3.3V, but then
upon the first "REQ_IO_LOW" we'll transition down to 1.8V and stay
there forever.

* If vqmmc can only be 3.3V then at init time we'll have set
PAD_PWR_SWITCH_EN and leave the PAD_PWR_SWITCH set to 3.3V always.

* If vqmmc can be either 3.3V or 1.8V then at init time we'll have set
PAD_PWR_SWITCH_EN and leave the PAD_PWR_SWITCH set to 3.3V, but then
we'll honor REQ_IO_LOW / REQ_IO_HIGH.

* If vqmmc has an unknown range (or ins't provided) then we'll behave
like the 3.3V case (because earlier code initted PAD_PWR_SWITCH_EN to
0 when it wrote CORE_VENDOR_SPEC_POR_VAL and then we never change it).


> +
> +       writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
> +       /* Ensure IO pad update before any further register read/writes */
> +       mb();

I agree that (to the best of my understanding) this mb() ought to be
there, but maybe mention that the reason is that you have two separate
IO ranges for registers and that's why you need it.

Also: if you truly care about avoiding mb() calls (and since you're
using _relaxed variants I assume you do), you should avoid writing the
config and doing the "mb" if you didn't actually make a change.


> +
>         if (pwr_state)
>                 msm_host->curr_pwr_state = pwr_state;
>         if (io_level)
> @@ -1518,6 +1545,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         }
>
>         /*
> +        * Set the PAD_PWR_SWITCH_EN bit so that the PAD_PWR_SWITCH bit can
> +        * be used as required later on.
> +        */
> +       config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
> +       config |= CORE_IO_PAD_PWR_SWITCH_EN;
> +       writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);

If this is going to be unconditional (as you've written it) should
this be combined with the statement earlier in the same function where
we write "CORE_VENDOR_SPEC_POR_VAL" to this same register?

Seems like you could write:

#define CORE_VENDOR_SPEC_INIT_VAL (CORE_VENDOR_SPEC_POR_VAL | \
                           CORE_IO_PAD_PWR_SWITCH_EN)

...then just change the init line to use "CORE_VENDOR_SPEC_INIT_VAL"
instead of "CORE_VENDOR_SPEC_POR_VAL".

---

...but it seems like it might be even better just leave the "en" bit
off for now and just turn it on when you actually need it.

BTW: All I have is a very terse register spec in front of me, but do
you happen to know why "HC_IO_PAD_PWR_SWITCH_EN" even exists at all?
Is there some difference between "enabled but choose 3.3 V" and "not
enabled?"  Also: do all versions of the controller supported by this
driver support this bit?

One last thing: on SDM845 one of the two SD controllers doesn't
support 1.8V, though the register description still describes these
bits.  Presumably for that controller it's better to just not set
"enabled" at all?




-Doug
