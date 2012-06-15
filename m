From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 1/2] regulator: core.c Pass voltage to notifier when
 setting voltage
Date: Fri, 15 Jun 2012 11:29:51 -0700
Message-ID: <84B43340-7E4D-474B-9217-56E809FF16A9@marvell.com>
References: <1339711609-3417-1-git-send-email-prakity@marvell.com>
 <CADTbHxq5rmHJtFTp53sYhFSYWVrSqyo_Jq+0aWNOF2HQR+nhGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADTbHxq5rmHJtFTp53sYhFSYWVrSqyo_Jq+0aWNOF2HQR+nhGA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pankaj Jangra <jangra.pankaj9@gmail.com>
Cc: Philip Rakity <philipspatches@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


On Jun 15, 2012, at 10:58 AM, Pankaj Jangra wrote:

> Hi Philip,
> 
> Just a cosmetic comments.
> 
> On Fri, Jun 15, 2012 at 3:36 AM, Philip Rakity <philipspatches@gmail.com> wrote:
> V2
> --
> 
> Incorporate performance suggestions made by Mark Brown
> Use linux-next as base code rather than mmc-next
> 
> The voltage being set should be passed to the handler requesting
> the callback.  Currently this is not done.

thanks -- my typo when redoing the patch -- V3 has this fixed.

> 
> The callback cannot call regulator_get_voltage() to get the
> information since the mutex is held by the regulator and
> deadlock occurs.
> 
> Without this change the receiver of the notify cannot now what
>  
> You mean to say "cannot know what" ?   
> 
> action to take.  This is used, for example, to set PAD voltages
> when doing SD vccq voltage changes.


if you call in that receives the notify does not know the new voltage
then in our case we do not know if we should switch the pad from
3.3v to 1.8v for example.  vccq signaling in SD is normally 3.3V
but in UHS mode it is lowered to 1.8V

> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/regulator/core.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 63507a5..5b04916 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -2153,7 +2153,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
>        if (rdev->desc->ops->list_voltage)
>                best_val = rdev->desc->ops->list_voltage(rdev, selector);
>        else
> -               best_val = -1;
> +               best_val = _regulator_get_voltage(rdev);
> 
>        /* Call set_voltage_time_sel if successfully obtained old_selector */
>        if (_regulator_is_enabled(rdev) && ret == 0 && old_selector >= 0 &&
> @@ -2176,9 +2176,9 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
>                udelay(delay);
>        }
> 
> -       if (ret == 0)
> +       if (ret == 0 && best_val >= 0)
>                _notifier_call_chain(rdev, REGULATOR_EVENT_VOLTAGE_CHANGE,
> -                                    NULL);
> +                                    (void *)best_val);
> 
> 
> I am also curious to know if you pass the  voltage here to notifier call how does it make any difference, since in 
> blocking_notifier_call_chain() again passes the NULL. So does your patch should  modify the arguments to this function also?
> Please let me know if i am missing something in understanding.
> 
> Regards,
> Pankaj Jangra
> 
>        trace_regulator_set_voltage_complete(rdev_get_name(rdev), best_val);
> 
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
