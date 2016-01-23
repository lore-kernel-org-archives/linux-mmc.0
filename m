From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH RFC 12/15] ARM: dts: sun9i: Use sun9i
 specific mmc compatible
Date: Sat, 23 Jan 2016 18:50:40 +0800
Message-ID: <CAGb2v671vypQxPcmnWa86ipCgRd0prqeTcTkbH_G+Q+AM71zFQ@mail.gmail.com>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-13-git-send-email-wens@csie.org> <20160122204402.GE3682@lukather>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBF5WRW2QKGQECVDPFTY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20160122204402.GE3682@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Jan 23, 2016 at 4:44 AM, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Thu, Jan 21, 2016 at 01:26:39PM +0800, Chen-Yu Tsai wrote:
>> sun9i/A80 MMC controllers have a larger FIFO, and the FIFO DMA
>> trigger levels can be increased. Also, the mmc module clock parent
>> has a higher clock rate, and the sample and output delay phases
>> are different.
>>
>> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>
> Applied, thanks!
>
> Does that count as a fix, or does the A80 board can safely operate
> without it?

The compatible was added in v4.3, in commit 51424b286067 ("mmc:
sunxi: Fix clk-delay settings").

I've not tested using the old compatibles with 50/52 MHz DDR. They
do work just fine with the transfer modes we already supported.

Either way its been there for a while so i don't see any need to
pick it out as a fix.

ChenYu
