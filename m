From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH v3 3/5] arm: configs: remove CONFIG_MMC_DW_IDMAC
Date: Wed, 5 Aug 2015 16:48:52 +0800
Message-ID: <55C1CDF4.5070302@rock-chips.com>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
 <1438762690-22286-1-git-send-email-shawn.lin@rock-chips.com>
 <C2D7FE5348E1B147BCA15975FBA23075665B111F@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
        format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075665B111F@IN01WEMBXB.internal.synopsys.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: shawn.lin@rock-chips.com, "dianders@chromium.org" <dianders@chromium.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Stefan Agner <stefan@agner.ch>, Zhou Wang <wangzhou.bry@gmail.com>, Kumar Gala <galak@codeaurora.org>, Alim Akhtar <alim.akhtar@samsung.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Wang Long <long.wanglong@huawei.com>, Rob Herring <robh+dt@kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Lukasz Majewski <l.majewski@samsung.com>, Jun Nie <jun.nie@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Kevin Hao <haokexin@gmail.com>, Olof Johansson <olof@lixom.net>R
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2015/8/5 16:34, Vineet Gupta =E5=86=99=E9=81=93:
> On Wednesday 05 August 2015 01:52 PM, Shawn Lin wrote:
>> DesignWare MMC Controller's transfer mode should be decided
>> at runtime instead of compile-time. So we remove this config
>> option, and elaborate more in Documentation(synopsys-dw-mshc).
>>
>> Modify these files:
>> arch/arc/configs/axs101_defconfig
>> arch/arc/configs/axs103_defconfig
>> arch/arc/configs/axs103_smp_defconfig
> While you remove the config option from ARC defconfigs, you fail to a=
dd the
> corresponding DT glue in ARC files (like you did for ARM). The pointe=
r to DT is
> contained in corresponding defconfig. Please fix that .

Yes,  I will fix it ASAP.
Thanks, Vineet.

> -Vineet
>
>
>


--=20
Shawn Lin
