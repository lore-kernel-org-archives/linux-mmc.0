From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/6] mmc: core: implement enhanced strobe support
Date: Wed, 4 May 2016 15:07:01 +0300
Message-ID: <5729E5E5.6000409@intel.com>
References: <1461897751-28810-1-git-send-email-shawn.lin@rock-chips.com>
 <1461898029-28944-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFogNjwNs+fKPaah_X=AfSgtXUwefzon+ZQ2a2Va5Om5Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFogNjwNs+fKPaah_X=AfSgtXUwefzon+ZQ2a2Va5Om5Nw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index 4bc48f1..7e94b9d 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -332,12 +332,13 @@ int mmc_add_card(struct mmc_card *card)
>>                         mmc_card_ddr52(card) ? "DDR " : "",
>>                         type);
>>         } else {
>> -               pr_info("%s: new %s%s%s%s%s card at address %04x\n",
>> +               pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
>>                         mmc_hostname(card->host),
>>                         mmc_card_uhs(card) ? "ultra high speed " :
>>                         (mmc_card_hs(card) ? "high speed " : ""),
>>                         mmc_card_hs400(card) ? "HS400 " :
>>                         (mmc_card_hs200(card) ? "HS200 " : ""),
>> +                       mmc_card_hs400es(card) ? "Enhanced strobe" : "",
> 
> I am not sure this informations should be printed. It's still and
> HS400 card, there is no performance impact, right?

I actually asked for that I think.  HS400ES does not need re-tuning so there
is a performance and behavioural change which I think it is very useful to
know.  Kernels which don't support HS400ES will show "HS400" whereas kernels
which do support it will show something different.
