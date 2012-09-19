From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sh-mmcif: properly handle MMC_WRITE_MULTIPLE_BLOCK completion IRQ
Date: Wed, 19 Sep 2012 02:25:41 -0400
Message-ID: <m37grqil5m.fsf@pullcord.laptop.org>
References: <Pine.LNX.4.64.1209190105080.31203@axis700.grange>
	<505932E9.8050202@kmckk.co.jp>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <505932E9.8050202@kmckk.co.jp> (Tetsuyuki Kobayashi's message of
	"Wed, 19 Sep 2012 11:50:17 +0900")
Sender: linux-sh-owner@vger.kernel.org
To: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, yusuke.goda.sx@renesas.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Sep 18 2012, Tetsuyuki Kobayashi wrote:
> (2012/09/19 8:10), Guennadi Liakhovetski wrote:
>> Upon completion of a MMC_WRITE_MULTIPLE_BLOCK command MMCIF issues an IRQ
>> with the DTRANE bit set and often with one or several of CMD12 bits set.
>> If those interrupts are not acknowledged, an additional interrupt can be
>> produced and will be delivered later, possibly, when the transaction has
>> already been completed. To prevent this from happening, CMD12 completion
>> interrupt sources have to be cleared too upon reception of an DTRANE IRQ.
>>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> ---
>>
>> Tested on kzm9g and mackerel. Kobayashi-san, this fixes spurious
>> interrupts, that you are observing.
>
> I verified on kzm9g.
> This works with
> [PATCH] mmc: sh-mmcif: avoid Oops on spurious interrupts
>
> Tested-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
