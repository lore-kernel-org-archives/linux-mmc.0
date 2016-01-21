From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFC 05/15] mmc: sunxi: Support MMC_DDR52
 timing modes
Date: Thu, 21 Jan 2016 13:26:39 +0100
Message-ID: <56A0CE7F.3080203@redhat.com>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-6-git-send-email-wens@csie.org>
 <56A0BD8F.2000805@redhat.com>
 <CAGb2v640b6tygtu1TkBEYM6Uf6JqpytzqUQ-Y1uxKf9PUwpQaA@mail.gmail.com>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORBBU5QO2QKGQEIXGVJSY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAGb2v640b6tygtu1TkBEYM6Uf6JqpytzqUQ-Y1uxKf9PUwpQaA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 21-01-16 12:55, Chen-Yu Tsai wrote:
> On Thu, Jan 21, 2016 at 7:14 PM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Hi,
>>
>> On 21-01-16 06:26, Chen-Yu Tsai wrote:
>>>
>>> DDR transfer modes include UHS-1 DDR50 and MMC HS-DDR (or MMC_DDR52).
>>> Consider MMC_DDR52 when setting clock delays.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>>> ---
>>>    drivers/mmc/host/sunxi-mmc.c | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>>> index 4bec87458317..b403a2433eec 100644
>>> --- a/drivers/mmc/host/sunxi-mmc.c
>>> +++ b/drivers/mmc/host/sunxi-mmc.c
>>> @@ -687,7 +687,8 @@ static int sunxi_mmc_clk_set_rate(struct
>>> sunxi_mmc_host *host,
>>>                  oclk_dly = host->clk_delays[SDXC_CLK_25M].output;
>>>                  sclk_dly = host->clk_delays[SDXC_CLK_25M].sample;
>>>          } else if (rate <= 50000000) {
>>
>>
>> Shouldn't this be <= 52000000 then, considering that we may at one point get
>> some PLL setup where we may actually be able to do 52000000 for
>> MMC_TIMING_MMC_DDR52 ?
>
> Given that mmc->f_max = 50000000, the core will never try any clock rate higher
> than 50 MHz, and iirc clk_round_rate always rounds down. We could increase both
> numbers at the same time when we actually encounter such hardware.

I'm afraid that someone may increase mmc->f_max = 50000000 at one point without
adjusting the rate checks above at the same time, so lets update both of them now.

Regards,

Hans
