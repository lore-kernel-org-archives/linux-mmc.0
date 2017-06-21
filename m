From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 1/6] ARM: dts: rockchip: add basic dtsi file for RK3229 SoC
Date: Wed, 21 Jun 2017 10:55:38 +0200
Message-ID: <1868991.PqQ2sgDds2@diego>
References: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com> <CAFLEztTZPeqbE++uRS-jXYUb7KzSik7=5v8+p07L788HWvwQqg@mail.gmail.com> <74d18546-cde9-2c71-caf1-139d202c42e3@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <74d18546-cde9-2c71-caf1-139d202c42e3@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Huang, Tao" <huangtao@rock-chips.com>
Cc: Jacob Chen <jacobchen110@gmail.com>, Frank Wang <frank.wang@rock-chips.com>, robh+dt@kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, wmc@rock-chips.com, =?utf-8?B?6ZmI5YGl5rSq?= <chenjh@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

Am Mittwoch, 21. Juni 2017, 15:29:18 CEST schrieb Huang, Tao:
> Hi Jacob and Heiko:
> 
> On 2017年06月21日 12:11, Jacob Chen wrote:
> > Hi,
> > 
> > 2017-06-20 18:48 GMT+08:00 Heiko Stübner <heiko@sntech.de
> > 
> > <mailto:heiko@sntech.de>>:
> > > Hi Frank,
> > > 
> > > Am Dienstag, 20. Juni 2017, 15:13:00 CEST schrieb Frank Wang:
> > >> Hi Heiko,
> > >> 
> > >> On 2017/6/19 20:30, Heiko Stübner wrote:
> > >> > Hi Frank,
> > >> > 
> > >> > Am Montag, 19. Juni 2017, 18:34:27 CEST schrieb Frank Wang:
> > >> >> On 2017/6/18 2:12, Heiko Stuebner wrote:
> > >> >>> Am Donnerstag, 15. Juni 2017, 15:16:15 CEST schrieb Frank Wang:
> > >> >>>> Due to some tiny differences between RK3228 and RK3229, this patch
> > >> >>>> adds a basic dtsi file which includes a new CPU opp table and PSCI
> > >> >>>> brought up support for RK3229.
> > >> >>>> 
> > >> >>>> Signed-off-by: Frank Wang<frank.wang@rock-chips.com
> > 
> > <mailto:frank.wang@rock-chips.com>>
> > 
> > >> > [...]
> > >> > 
> > >> >>>> +        psci {
> > >> >>>> +                compatible = "arm,psci-1.0", "arm,psci-0.2";
> > >> >>>> +                method = "smc";
> > >> >>>> +        };
> > >> >>>> +};
> > >> >>>> +
> > >> >>>> +&cpu0 {
> > >> >>>> +        enable-method = "psci";
> > >> >>>> +};
> > >> >>> 
> > >> >>> Hmm, I don't really understand this.
> > >> >>> What method of core-bringup does the rk3228 use? In the current
> > >> >>> rk322x.dtsi there is no enable-method at all defined.
> > >> >> 
> > >> >> For non-security, the same with rk3036 SoC, we use rk3036-smp
> > 
> > method to
> > 
> > >> >> bring-up cores, and for security, we use arm-psci method.
> > >> >> As security become more and more important and required, we
> > 
> > would prefer
> > 
> > >> >> using arm-psci method, and it is also an easy way to use.
> > >> >> 
> > >> >>> So is the rk3228 firmware using a different method than the rk3229?
> > >> >> 
> > >> >> No, they are the same. How about I move these changes to
> > 
> > rk322x.dtsi?
> > 
> > >> > yep, that is what I was getting at with my question ;-)
> > >> > 
> > >> >>> And out of curiosity as this is a arm32 without atf, is the psci
> > >> >>> implementation (for uboot?) you're using available somewhere?
> > >> >> 
> > >> >> Ah, it is included in op-tee :-)
> > >> > 
> > >> > Is that super secret or will this be part of the official op-tee [0]
> > >> > at some point (Similar to the ATF stuff on arm64)?
> > >> 
> > >> Hmm, the op-tee itself must keep secure, but the psci part in it can be
> > >> extracted to public, although it may have a bit of secure risk.
> > >> Due to Rockchip have amended the frame of op-tee to support psci,
> > 
> > we can
> > 
> > >> try to upstream these changes to official op-tee or push them to source
> > >> codes of Rockchip in git-hub.
> > > 
> > > I just want to make sure, people can actually create a working system
> > > with this, as there is mainline u-boot support for the rk3228/rk3229 in
> > > the works - hopefully also with SPL support later on.
> > > So I'm wondering how this is supposed to be setup?
> > > 
> > > On arm64 we now have the SPL load the ATF, which in turn loads
> > 
> > uboot, so I
> > 
> > > guess the mechanism for the op-tee would be somehow similar? And
> > 
> > there all
> > 
> > > necessary components are available to build everything from source.
> > > 
> > > I really don't care about all the other super-secret stuff happening in
> > > that op-tee thingy, but I really want people to be able to build a
> > 
> > complete
> > 
> > > firmware on their machine, without having to rely on arbitary binary
> > 
> > blobs.
> > 
> > > Which is something companies adopting Rockchip socs seem to rely on
> > > a lot these days ;-) .
> > > 
> > > 
> > > One alternative I can think of, would be to also create a u-boot psci
> > > implementation for arm32, like sunxi [0] and others use for example.
> > > That way people could choose where their psci should come from (u-boot
> > > itself or the op-tee).
> > > 
> > > 
> > > Heiko
> > > 
> > > [0]
> > 
> > http://git.denx.de/?p=u-boot.git;a=blob;f=arch/arm/cpu/armv7/sunxi/psci.c
> > 
> > >> BR.
> > >> Frank
> > >> 
> > >> > Heiko
> > >> > 
> > >> > [0]https://github.com/OP-TEE/optee_os/tree/master/core/arch/arm
> > 
> > 😀 Implement psci in upstream u-boot  sounds a good idea.
> > 
> > I don't like the bundled solution, like if I want  to enable  power
> > management in my board,  i have to use OP-TEE, then i have to use
> > vendor u-boot, then vendor kernel, rootfs, tools......
> 
> No. The kernel only depends on PSCI. Anyone can implement PSCI firmware
> through
> OPTEE/Trusty/U-Boot/UEFI or other open source implementation. We don't limit
> people use vendor software or not. As Frank said, we will open source OPTEE
> which support PSCI for our chips.

That is great to hear. In Franks mail yesterday it didn't sound that certain 
yet :-) . 
I really only want to make sure people can build a complete firmware from 
source. Without having to rely on binary stuff.

So if you're going to release the op-tee variant for it, we should be fine.

As I've also ordered one of the rk3229 tv-boxes for my boardfarm, do you
have any timeframe for that? [Sorry for being pushy :-) ].


> BTW people can implement SMP/suspend function builtin in kernel as
> usual. We just hope use PSCI by default, so we can support TEE more easy
> as arm64.

Yep, having smp in firmware is quite nice, as seen on arm64. So I definitly 
encourage this, instead of doing the "legacy" smp option in the kernel.


Thanks
Heiko
