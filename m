From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 3/3] Documentation: mmc: add description for new no-sd*
 and no-mmc
Date: Tue, 12 Jul 2016 09:51:10 +0800
Message-ID: <a4633f92-cbe1-55f7-607a-b210ce8b96c7@rock-chips.com>
References: <1467359130-11409-1-git-send-email-shawn.lin@rock-chips.com>
 <1467359130-11409-4-git-send-email-shawn.lin@rock-chips.com>
 <20160711135735.GA18339@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160711135735.GA18339@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Rob,

On 2016/7/11 21:57, Rob Herring WROTE:
> On Fri, Jul 01, 2016 at 03:45:30PM +0800, Shawn Lin wrote:
>> This patch adds description for no-sd, no-sdio, no-mmc. We
>> expect the specific boards adds these in DT to improve
>> the initialization. For instance, for a soldered eMMC slot,
>> we could skip sending SDIO and SD commands to probe its card
>> types as it's always should be the type fo MMC card.
>>
>> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>
>>  Documentation/devicetree/bindings/mmc/mmc.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
>> index ecc007a..b2046c6 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
>> @@ -49,6 +49,9 @@ Optional properties:
>>  - mmc-hs400-enhanced-strobe: eMMC HS400 enhanced strobe mode is supported
>>  - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
>>    programmed with. Valid range: [0 .. 0xffff].
>> +- no-sdio: skip sending sdio cmd during initialization
>> +- no-sd: skip sending sd cmd during initialization
>> +- no-mmc: skip sending mmc cmd during initialization
>
> I still have issue with the description for these properties and the
> commit msg. They are fine if described as controller limitations as Ulf
> described. If folks want to (ab)use the properties for just skipping
> init, then that's their problem.

Sounds like it's okay for you if I amend the commit msg and drscription
to emphasize that these properties are intent to describe the
limitations of controllers rather than to skip init.

I will fix them.

Thanks.

>
> Rob
>
>
>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
