From: Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: [PATCH 3/3] mmc: sunxi: use controller automatic
 clock gating.
Date: Wed, 12 Aug 2015 15:19:20 +0200
Message-ID: <55CB47D8.4010207@schinagl.nl>
References: <cover.1439381423.git.hramrach@gmail.com> <c33b221f9b622e3bad9d855a7ad1887b82827244.1439381423.git.hramrach@gmail.com> <55CB3D92.6040403@redhat.com>
Reply-To: oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDDZ7YMYRMGBBWUPVWXAKGQEKAOMTCY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <55CB3D92.6040403-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?B?RGF2aWQgTGFuemVuZMO2cmZlcg==?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hey,

On 12-08-15 14:35, Hans de Goede wrote:
> Hi,
>
> On 12-08-15 14:23, Michal Suchanek wrote:
>> When core does not set the MMC_QUIRK_BROKEN_CLK_GATING flag enable
>> automatic hardware controlled clock gating on the mmc interface.
>>
>> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> In general this looks good, but I wonder how intensively this has
> been tested ?
It doesn't matter actually, it took some time longer, but the mmc still 
craps out even with Michal's 3 patches. I'll revert hans's earlier patch 
again and do a bit more extensive testing.
> Also given the long latencies when using manual
> clock on/off support, have you done any testing to check what
> sort of latencies this adds, e.g. Both with and without
> the patch, dump all the filesystem caches:
>
> echo 3 > /proc/sys/vm/drop_caches
>
> And then do:
>
> time cat /some/small/file/on/the/sdcard
>
> Do this at least 3 time both with and without the patch, and see
> if there are any noticable differences ?
>
> Regards,
>
> Hans
>
>
>
>> ---
>>   drivers/mmc/host/sunxi-mmc.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index f808a02..443cab5 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -601,8 +601,13 @@ static int sunxi_mmc_oclk_onoff(struct 
>> sunxi_mmc_host *host, u32 oclk_en)
>>       rval = mmc_readl(host, REG_CLKCR);
>>       rval &= ~(SDXC_CARD_CLOCK_ON | SDXC_LOW_POWER_ON);
>>
>> -    if (oclk_en)
>> +    if (oclk_en) {
>>           rval |= SDXC_CARD_CLOCK_ON;
>> +        if (!host->mmc->card ||
>> +             !(host->mmc->card->quirks & MMC_QUIRK_BROKEN_CLK_GATING))
>> +
>> +            rval |= SDXC_LOW_POWER_ON;
>> +    }
>>
>>       start = jiffies;
>>       end = start + msecs_to_jiffies(750);
>>
>
