From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/6] ARM: dts: rockchip: add basic dtsi file for RK3229 SoC
Date: Tue, 20 Jun 2017 12:48:44 +0200
Message-ID: <1880551.X2BOMRmHZh@diego>
References: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com> <25831201.s5BUplWuV7@diego> <354e6995-cc80-660b-41c4-535be85564c4@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <354e6995-cc80-660b-41c4-535be85564c4-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Wang <frank.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, charles.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kevan.lan-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wmc-TNX95d0MmH7DzftRWevZcw@public.gmane.org, =?utf-8?B?6ZmI5YGl5rSq?= <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Kever Yang <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Frank,

Am Dienstag, 20. Juni 2017, 15:13:00 CEST schrieb Frank Wang:
> Hi Heiko,
> 
> On 2017/6/19 20:30, Heiko Stübner wrote:
> > Hi Frank,
> > 
> > Am Montag, 19. Juni 2017, 18:34:27 CEST schrieb Frank Wang:
> >> On 2017/6/18 2:12, Heiko Stuebner wrote:
> >>> Am Donnerstag, 15. Juni 2017, 15:16:15 CEST schrieb Frank Wang:
> >>>> Due to some tiny differences between RK3228 and RK3229, this patch
> >>>> adds a basic dtsi file which includes a new CPU opp table and PSCI
> >>>> brought up support for RK3229.
> >>>> 
> >>>> Signed-off-by: Frank Wang<frank.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > 
> > [...]
> > 
> >>>> +	psci {
> >>>> +		compatible = "arm,psci-1.0", "arm,psci-0.2";
> >>>> +		method = "smc";
> >>>> +	};
> >>>> +};
> >>>> +
> >>>> +&cpu0 {
> >>>> +	enable-method = "psci";
> >>>> +};
> >>> 
> >>> Hmm, I don't really understand this.
> >>> What method of core-bringup does the rk3228 use? In the current
> >>> rk322x.dtsi there is no enable-method at all defined.
> >> 
> >> For non-security, the same with rk3036 SoC, we use rk3036-smp method to
> >> bring-up cores, and for security, we use arm-psci method.
> >> As security become more and more important and required, we would prefer
> >> using arm-psci method, and it is also an easy way to use.
> >> 
> >>> So is the rk3228 firmware using a different method than the rk3229?
> >> 
> >> No, they are the same. How about I move these changes to rk322x.dtsi?
> > 
> > yep, that is what I was getting at with my question ;-)
> > 
> >>> And out of curiosity as this is a arm32 without atf, is the psci
> >>> implementation (for uboot?) you're using available somewhere?
> >> 
> >> Ah, it is included in op-tee :-)
> > 
> > Is that super secret or will this be part of the official op-tee [0]
> > at some point (Similar to the ATF stuff on arm64)?
> 
> Hmm, the op-tee itself must keep secure, but the psci part in it can be
> extracted to public, although it may have a bit of secure risk.
> Due to Rockchip have amended the frame of op-tee to support psci, we can
> try to upstream these changes to official op-tee or push them to source
> codes of Rockchip in git-hub.

I just want to make sure, people can actually create a working system
with this, as there is mainline u-boot support for the rk3228/rk3229 in
the works - hopefully also with SPL support later on.
So I'm wondering how this is supposed to be setup?

On arm64 we now have the SPL load the ATF, which in turn loads uboot, so I 
guess the mechanism for the op-tee would be somehow similar? And there all 
necessary components are available to build everything from source.

I really don't care about all the other super-secret stuff happening in
that op-tee thingy, but I really want people to be able to build a complete
firmware on their machine, without having to rely on arbitary binary blobs.

Which is something companies adopting Rockchip socs seem to rely on
a lot these days ;-) .


One alternative I can think of, would be to also create a u-boot psci 
implementation for arm32, like sunxi [0] and others use for example.
That way people could choose where their psci should come from (u-boot
itself or the op-tee).


Heiko

[0] http://git.denx.de/?p=u-boot.git;a=blob;f=arch/arm/cpu/armv7/sunxi/psci.c

> 
> 
> BR.
> Frank
> 
> > Heiko
> > 
> > [0]https://github.com/OP-TEE/optee_os/tree/master/core/arch/arm


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
