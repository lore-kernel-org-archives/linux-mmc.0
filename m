From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH RFC 03/15] mmc: sunxi: Block signal voltage
 switching (CMD11)
Date: Fri, 29 Jan 2016 22:44:55 +0800
Message-ID: <CAGb2v65qHXN07Lz+W7rHM6yNc1OJpOj8d=Kgk-Q91fZJ0-eA4Q@mail.gmail.com>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-4-git-send-email-wens@csie.org> <CAPDyKFrG8cXChSRuAx-a++iNHUHU_GuUApDhxfPSJZb1Oo1fsg@mail.gmail.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBAHWVW2QKGQEK32LWWQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAPDyKFrG8cXChSRuAx-a++iNHUHU_GuUApDhxfPSJZb1Oo1fsg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 29, 2016 at 6:42 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 21 January 2016 at 06:26, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
>> Allwinner's mmc controller supports signal voltage switching. This is
>> supported in code in Allwinner's kernel. However, publicly available
>> boards all tie it to a fixed 3.0/3.3V regulator, with options to tie
>> it to 1.8V for eMMC on some.
>>
>> Since Allwinner's kernel is an ancient 3.4, it is hard to say whether
>> adapting it's code to a modern mainline kernel would work. Block signal
>> voltage switching until someone has proper hardware to implement and
>> test this.
>>
>> This only affects SD UHS-1 modes, as eMMC switches the voltage directly
>> without any signaling.
>>
>> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>> ---
>>  drivers/mmc/host/sunxi-mmc.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index 790f01662b4e..0495ae7da6d6 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -816,6 +816,20 @@ static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>                 }
>>         }
>>
>> +       /*
>> +        * TODO Support signal voltage switching
>> +        *
>> +        * Compared to Allwinner's kernel, recent updates in the mmc core
>> +        * mean this should be as easy as setting the flags in cmd_val and
>> +        * imask, and waiting for it to finish. However no boards support
>> +        * this so this cannot be tested. Block it for now.
>> +        */
>> +       if (cmd->opcode == SD_SWITCH_VOLTAGE) {
>> +               mrq->cmd->error = -EPERM;
>> +               mmc_request_done(mmc, mrq);
>> +               return;
>> +       }
>
> Unless some of the MMC_CAP_UHS* mode is set, this command shouldn't be sent.
>
> So, if you *really* want to protect from this, I think it's better to
> clear these caps in the ->probe() function, after mmc_of_parse() has
> been called.

OK. If we need to block these, then we need to block all the other
unsupported caps, which seems excessive and unnecessary. I'll drop
this patch.

Thanks
ChenYu

>
>> +
>>         if (cmd->opcode == MMC_GO_IDLE_STATE) {
>>                 cmd_val |= SDXC_SEND_INIT_SEQUENCE;
>>                 imask |= SDXC_COMMAND_DONE;
>> --
>> 2.7.0.rc3
>>
>
> Kind regards
> Uffe
