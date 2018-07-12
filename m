From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH] mmc: sunxi: Use new timing mode for A64
 eMMC controller
Date: Thu, 12 Jul 2018 18:17:23 +0800
Message-ID: <CAGb2v65rE2nQbyeiSPAyTzw-n-EQsUwQABx3nrvXTu4JogFPBQ@mail.gmail.com>
References: <20180712030225.15681-1-wens@csie.org> <20180712071959.fi4rhgwv2iuoelbl@flea>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBSWVTTNAKGQEXSRMEHI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180712071959.fi4rhgwv2iuoelbl@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jul 12, 2018 at 3:19 PM, Maxime Ripard
<maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:
> Hi,
>
> On Thu, Jul 12, 2018 at 11:02:25AM +0800, Chen-Yu Tsai wrote:
>> The eMMC controller is also a new timing mode controller, but it doesn't
>> have the timing mode switch. It does however have signal delay and
>> calibration controls, typical of Allwinner MMC controllers that support
>> the new timing mode.
>>
>> Enable the new timing mode setting for the A64 eMMC controller. This
>> also enables MMC HS-DDR modes, which gives higher throughput for eMMC
>> chips that support it, and can deliver such throughput.
>>
>> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>
> That doesn't look right. The datasheet explicitly mentions that this
> bit doesn't apply to the eMMC controller, and the BSP is doing the same:
> https://github.com/longsleep/linux-pine64/blob/lichee-dev-v3.10.65/drivers/mmc/host/sunxi-mmc-sun50iw1p1-1.c
>
> vs
> https://github.com/longsleep/linux-pine64/blob/lichee-dev-v3.10.65/drivers/mmc/host/sunxi-mmc-sun50iw1p1-2.c

You mean the bit in SDXC_REG_SD_NTSR? Yes I know that doesn't exist for
the eMMC controller. I mentioned this in the commit message. It doesn't
exist, and writes to it become a no-op.

Would a comment, or comments, help with making this clear?

> And I definitely remember having HS-DDR working back when I added the
> a64 eMMC support.

Well it doesn't at the moment. My BPI-M64 reports:

    [    1.634276] mmc2: new high speed MMC card at address 0001

And with the patch:

    [    1.632552] mmc2: new DDR MMC card at address 0001

Regards
ChenYu
