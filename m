From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] mmc: sunxi: fix timeout in sunxi_mmc_oclk_onoff
Date: Tue, 25 Aug 2015 14:06:31 +0200
Message-ID: <CAPDyKFp67DTNXYiphqPKsKL9ZtGO28x_UZa-d-KifD-7EXGzhw@mail.gmail.com>
References: <cover.1439381423.git.hramrach@gmail.com>
	<7f9c6f99b31702c02436ef3356b3ebffa4754260.1439381423.git.hramrach@gmail.com>
	<bdcb7ce26f359b7fedbd8559eb275c324bfb52bb.1439386047.git.hramrach@gmail.com>
	<55CB5CE6.1000303@redhat.com>
Reply-To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDF57NG2XIHRBSFU6GXAKGQE3D7VRWY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <55CB5CE6.1000303-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 12 August 2015 at 16:49, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Hi,
>
> On 08/12/2015 03:29 PM, Michal Suchanek wrote:
>>
>> The 250ms timeout is too short.
>>
>> On my system enabling the oclk takes under 50ms and disabling slightly
>> over 100ms when idle. Under load disabling the clock can take over
>> 350ms.
>>
>> This does not make mmc clock gating look like good option to have on
>> sunxi but the system should not crash with mmc clock gating enabled
>> nonetheless.
>>
>> This patch sets the timeout to 750ms.
>>
>> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> ---
>> v3
>>   - remove debug message
>
>
> Thanks, this one looks good to me:
>
> Acked-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>
> Ulf, can you apply this one please?
>
> Thanks & Regards,
>
> Hans
>

Thanks, applied for next!

Kind regards
Uffe

>
>
>> v2
>>   - fix formatting
>> ---
>>   drivers/mmc/host/sunxi-mmc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index 4d3e1ff..a7b7a67 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -595,7 +595,7 @@ static irqreturn_t sunxi_mmc_handle_manual_stop(int
>> irq, void *dev_id)
>>
>>   static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32
>> oclk_en)
>>   {
>> -       unsigned long expire = jiffies + msecs_to_jiffies(250);
>> +       unsigned long expire = jiffies + msecs_to_jiffies(750);
>>         u32 rval;
>>
>>         rval = mmc_readl(host, REG_CLKCR);
>>
>
