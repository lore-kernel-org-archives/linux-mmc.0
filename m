From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 1/6] ARM: dts: rockchip: add basic dtsi file for RK3229 SoC
Date: Mon, 19 Jun 2017 14:30:47 +0200
Message-ID: <25831201.s5BUplWuV7@diego>
References: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com> <18070472.si2qlgbqtt@phil> <7e8e2097-d5ca-a594-cb87-1b7b221fd58a@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7e8e2097-d5ca-a594-cb87-1b7b221fd58a@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Wang <frank.wang@rock-chips.com>
Cc: robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, wmc@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

Hi Frank,

Am Montag, 19. Juni 2017, 18:34:27 CEST schrieb Frank Wang:
> On 2017/6/18 2:12, Heiko Stuebner wrote:
> > Am Donnerstag, 15. Juni 2017, 15:16:15 CEST schrieb Frank Wang:
> >> Due to some tiny differences between RK3228 and RK3229, this patch
> >> adds a basic dtsi file which includes a new CPU opp table and PSCI
> >> brought up support for RK3229.
> >> 
> >> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

[...]

> >> +	psci {
> >> +		compatible = "arm,psci-1.0", "arm,psci-0.2";
> >> +		method = "smc";
> >> +	};
> >> +};
> >> +
> >> +&cpu0 {
> >> +	enable-method = "psci";
> >> +};
> > 
> > Hmm, I don't really understand this.
> > What method of core-bringup does the rk3228 use? In the current
> > rk322x.dtsi there is no enable-method at all defined.
> 
> For non-security, the same with rk3036 SoC, we use rk3036-smp method to
> bring-up cores, and for security, we use arm-psci method.
> As security become more and more important and required, we would prefer
> using arm-psci method, and it is also an easy way to use.
> 
> > So is the rk3228 firmware using a different method than the rk3229?
> 
> No, they are the same. How about I move these changes to rk322x.dtsi?

yep, that is what I was getting at with my question ;-)


> > And out of curiosity as this is a arm32 without atf, is the psci
> > implementation (for uboot?) you're using available somewhere?
> 
> Ah, it is included in op-tee :-)

Is that super secret or will this be part of the official op-tee [0]
at some point (Similar to the ATF stuff on arm64)?


Heiko

[0] https://github.com/OP-TEE/optee_os/tree/master/core/arch/arm
