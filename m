From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/4] mmc: tmio: Add tuning support
Date: Mon, 29 Aug 2016 16:05:55 +0200
Message-ID: <CAPDyKFoL1xvv1yog2tY7pF9fWoiGQ9Gew_QbrA06dSrBiFyVEQ@mail.gmail.com>
References: <1469592803-13842-1-git-send-email-horms+renesas@verge.net.au>
 <1469592803-13842-3-git-send-email-horms+renesas@verge.net.au>
 <CAPDyKFq_Fs_bNx7LP-J+nC3iaNgB7gvZAvhCp--qVOh1iAh0vg@mail.gmail.com>
 <20160823135251.GA25665@verge.net.au> <CAPDyKFpbMnOag7TZtQXxffXyq4XjTfz3vYM_atks15+d64QkfQ@mail.gmail.com>
 <20160825120424.GA3385@verge.net.au> <CAPDyKFpu85h3w2JkCjyQ15P8eWfkAkYcpxR4A6bD0EpQLw9rew@mail.gmail.com>
 <20160829120533.GA8647@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160829120533.GA8647@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 29 August 2016 at 14:05, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Aug 26, 2016 at 10:01:35AM +0200, Ulf Hansson wrote:
>> On 25 August 2016 at 14:04, Simon Horman <horms@verge.net.au> wrote:
>> > On Tue, Aug 23, 2016 at 05:02:56PM +0200, Ulf Hansson wrote:
>
> ...
>
>> >> >> I am wondering whether it would it be possible to keep a cache of the
>> >> >> currently used tuning values and then restore these values at
>> >> >> runtime_resume?
>> >> >>
>> >> >> In that way you wouldn't need to force new re-tuning cycle here.
>> >> >
>> >> > I will check with the hardware people to see if it is practical from
>> >> > that POV.
>> >>
>> >> Okay!
>> >
>> > The feedback I received is something like this:
>> >
>> > * The tap values calculated during retuning depend on the temperature of
>> >   the SoC and card.
>> > * So after resume the values may be invalid.
>>
>> They values may also become invalid during long continues transfers,
>> which prevents the ->runtime_suspend() callback to be invoked -
>> because the temperature may increase.
>>
>> > * It may be possible to re-use the TAP values and re-tune if a transfer
>> >   fails but the people I spoke with were unsure of the merit of that
>> >   approach
>>
>> There's is a huge benefit!
>>
>> You will get a significant decreased latency at ->runtime_resume() as
>> you don't need to run a complete re-tuning cycle.
>>
>> I can't really give you fresh numbers as it's a long time I tried this
>> myself, although if you did some measurements on this it would be
>> nice! :-)
>>
>> >
>> > Personally my feeling is that we should initiate a retune on resume for
>> > now as that seems to be the safest option.
>>
>> I don't agree. :-) I think it's better to postpone re-tune until it's
>> actually needed.
>>
>> Re-tune happens in the request error handling path, but also if you
>> configure a re-tuning period. That ought to be sufficient, don't you
>> think?
>
> Hi Ulf,
>
> Is something like this close to what you have in mind?
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 94e79449c533..fc43cf5ce958 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -357,11 +357,9 @@ static void sh_mobile_sdhi_prepare_tuning(struct tmio_mmc_host *host,
>
>  #define SH_MOBILE_SDHI_MAX_TAP 3
>
> -static int sh_mobile_sdhi_select_tuning(struct tmio_mmc_host *host,
> -                                       bool *tap, int tap_size)
> +static int sh_mobile_sdhi_select_tuning(struct tmio_mmc_host *host)
>  {
>         struct sh_mobile_sdhi *priv = host_to_priv(host);
> -       unsigned long tap_num;  /* total number of taps */
>         unsigned long tap_cnt;  /* counter of tuning success */
>         unsigned long tap_set;  /* tap position */
>         unsigned long tap_start;/* start position of tuning success */
> @@ -372,14 +370,6 @@ static int sh_mobile_sdhi_select_tuning(struct tmio_mmc_host *host,
>         /* Clear SCC_RVSREQ */
>         sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
>
> -       /* Select SCC */
> -       tap_num = (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL) >>
> -                  SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT) &
> -               SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_MASK;
> -
> -       if (tap_num * 2 != tap_size)
> -               return -EINVAL;
> -
>         /*
>          * Find the longest consecutive run of successful probes.  If that
>          * is more than SH_MOBILE_SDHI_MAX_TAP probes long then use the
> @@ -389,8 +379,8 @@ static int sh_mobile_sdhi_select_tuning(struct tmio_mmc_host *host,
>         ntap = 0;
>         tap_start = 0;
>         tap_end = 0;
> -       for (i = 0; i < tap_num * 2; i++) {
> -               if (tap[i] == 0)
> +       for (i = 0; i < host->tap_num * 2; i++) {
> +               if (test_bit(i, host->taps))
>                         ntap++;
>                 else {
>                         if (ntap > tap_cnt) {
> @@ -409,7 +399,7 @@ static int sh_mobile_sdhi_select_tuning(struct tmio_mmc_host *host,
>         }
>
>         if (tap_cnt >= SH_MOBILE_SDHI_MAX_TAP)
> -               tap_set = (tap_start + tap_end) / 2 % tap_num;
> +               tap_set = (tap_start + tap_end) / 2 % host->tap_num;
>         else
>                 return -EIO;
>
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index c932fe876690..4186045cce0d 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -171,8 +171,12 @@ struct tmio_mmc_host {
>         /* Mandatory callback for tuning to occur which is
>          * optional for SDR50 and mandatory for SDR104 */
>         unsigned int (*init_tuning)(struct tmio_mmc_host *host);
> -       int (*select_tuning)(struct tmio_mmc_host *host, bool *tap,
> -                            int tap_size);
> +       int (*select_tuning)(struct tmio_mmc_host *host);
> +
> +       /* Tuning values: 1 for success, 0 for failure */
> +       DECLARE_BITMAP(taps, BITS_PER_BYTE * sizeof(long));
> +       unsigned int tap_num;
> +       bool use_saved_taps;
>  };
>
>  struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index ded8fa53e0a0..2b5c8b090ed3 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -773,43 +773,50 @@ static void tmio_mmc_hw_reset(struct mmc_host *mmc)
>  static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>         struct tmio_mmc_host *host = mmc_priv(mmc);
> -       unsigned int num;
> -       int i, ret = 0;
> -       bool *tap;
> +       int ret = 0;
>
> -       if (!host->init_tuning || !host->select_tuning)
> -               /* Tuning is not supported */
> -               goto out;
> +       if (!host->tap_num) {
> +               if (!host->init_tuning || !host->select_tuning)
> +                       /* Tuning is not supported */
> +                       goto out;
>
> -       num = host->init_tuning(host);
> -       if (!num)
> -               /* Tuning is not supported */
> -               goto out;
> +               host->tap_num = host->init_tuning(host);
> +               if (!host->tap_num)
> +                       /* Tuning is not supported */
> +                       goto out;
>
> -       tap = kmalloc(num * 2 * sizeof(*tap), GFP_KERNEL);
> -       if (!tap) {
> -               ret = -ENOMEM;
> -               goto out;
> +               if (host->tap_num * 2 >= sizeof(host->taps) * BITS_PER_BYTE)
> +                       dev_warn_once(&host->pdev->dev,
> +                             "Too many taps, skipping tuning. Please consider "
> +                             "updating size of taps field of tmio_mmc_host\n");
> +
> +               host->use_saved_taps = false;
>         }
>
> -       /* Issue CMD19 twice for each tap */
> -       for (i = 0; i < 2 * num; i++) {
> -               if (host->prepare_tuning)
> -                       host->prepare_tuning(host, i % num);
> +       if (!host->use_saved_taps) {
> +               int i;
> +
> +               bitmap_zero(host->taps, host->tap_num * 2);
>
> -               ret = mmc_send_tuning(mmc, opcode, NULL);
> -               if (ret && ret != -EILSEQ)
> -                       goto err_free;
> -               tap[i] = (ret != 0);
> +               /* Issue CMD19 twice for each tap */
> +               for (i = 0; i < 2 * host->tap_num; i++) {
> +                       if (host->prepare_tuning)
> +                               host->prepare_tuning(host, i % host->tap_num);
>
> -               mdelay(1);
> +                       ret = mmc_send_tuning(mmc, opcode, NULL);
> +                       if (ret && ret != -EILSEQ)
> +                               goto out;
> +                       if (ret == 0)
> +                               set_bit(i, host->taps);
> +
> +                       mdelay(1);
> +               }
>         }
>
> -       ret = host->select_tuning(host, tap, num * 2);
> +       ret = host->select_tuning(host);
>
> -err_free:
> -       kfree(tap);
>  out:
> +       host->use_saved_taps = false;
>         if (ret < 0) {
>                 dev_warn(&host->pdev->dev, "Tuning procedure failed\n");
>                 mmc_hw_reset(mmc);
> @@ -1271,6 +1278,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
>
>         mmc_retune_timer_stop(host->mmc);
>         mmc_retune_needed(host->mmc);
> +       host->use_saved_taps = true;

I don't think you should trigger a re-tune here at all. Moreover you
don't need to keep track of whether you have valid tap values by using
the ->use_saved_taps variable, the mmc core deals with this for you.

Instead, you should restore the tap values by invoking
host->select_tuning() from the ->runtime_resume() callback, although
only when host->mmc->can_retune == 1. We should probably add a helper
function in the mmc core for this check, instead of accessing
"can_retune" directly.

>
>         tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
>

Kind regards
Uffe
