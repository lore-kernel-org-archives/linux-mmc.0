From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 12/16] mmc: host: omap_hsmmc: Add support to set IODELAY
 values
Date: Mon, 19 Jun 2017 13:24:43 +0530
Message-ID: <3149f88d-c33f-0d3e-aabe-ac6f840bb41c@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
 <20170616124544.15046-13-kishon@ti.com> <20170619060256.GK3730@atomide.com>
 <810fba3e-a488-fa0d-5639-47f1c76ea2b6@ti.com>
 <20170619072523.GL3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170619072523.GL3730@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, nsekhar@ti.com, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ravikumar Kattekola <rk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Tony,

On Monday 19 June 2017 12:55 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [170618 23:37]:
>> Hi Tony,
>>
>> On Monday 19 June 2017 11:32 AM, Tony Lindgren wrote:
>>> * Kishon Vijay Abraham I <kishon@ti.com> [170616 05:47]:
>>>> The data manual of J6/J6 Eco recommends to set different IODELAY values
>>>> depending on the mode in which the MMC/SD is enumerated in order to
>>>> ensure IO timings are met.
>>>>
>>>> Add support to set the IODELAY values depending on the various MMC
>>>> modes using the pinctrl APIs.
>>>
>>> This does not seem to apply against Linux next for me for
>>> the binding. Fixing that, compile fails for me with:
>>>
>>> drivers/mmc/host/omap_hsmmc.c:2384:13: error:
>>> 'struct omap_hsmmc_platform_data' has no member named 'version'
>>
>> This series has a dependency with
>> https://www.spinics.net/lists/arm-kernel/msg586215.html series
>>
>> *version* member is added in patch with $subject
>> "ARM: OMAP2+: Add pdata-quirks for MMC/SD on DRA74x EVM"
> 
> Ah sorry I keep forgetting that. Looks like the only thing
> pending with that series is that you were going to send
> an update for omap3-overo-base.

I've sent that as a separate patch [1]. But I can resend the entire series if
that's what you'd prefer.

Thanks
Kishon

[1] -> http://www.spinics.net/lists/devicetree/msg180747.html
> 
> BTW, we really should get rid of the mach-omap2/hsmmc.c,
> I think overo is the only user for it now.
> 
> Regards,
> 
> Tony
> 
