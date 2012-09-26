From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sh-mmcif: avoid Oops on spurious interrupts
Date: Wed, 26 Sep 2012 06:04:51 -0400
Message-ID: <m3a9wdksl8.fsf@pullcord.laptop.org>
References: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
	<20120803050039.GA1614@linux-sh.org>
	<20120809042844.GF1614@linux-sh.org>
	<87hasc3bv5.wl%kuninori.morimoto.gx@renesas.com>
	<874nobqntv.wl%kuninori.morimoto.gx@renesas.com>
	<20120810123804.GK1614@linux-sh.org> <502DDC97.5080501@kmckk.co.jp>
	<87wr0us6tg.wl%kuninori.morimoto.gx@renesas.com>
	<20120820031352.GC25767@linux-sh.org>
	<87obm6ry98.wl%kuninori.morimoto.gx@renesas.com>
	<20120820043853.GD25767@linux-sh.org>
	<87mx1qrx1x.wl%kuninori.morimoto.gx@renesas.com>
	<5031D9FF.8060801@kmckk.co.jp>
	<Pine.LNX.4.64.1208220840400.26767@axis700.grange>
	<505932DD.8010703@kmckk.co.jp> <50625ECB.6020601@kmckk.co.jp>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <50625ECB.6020601@kmckk.co.jp> (Tetsuyuki Kobayashi's message of
	"Wed, 26 Sep 2012 10:47:55 +0900")
Sender: linux-sh-owner@vger.kernel.org
To: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, yusuke.goda.sx@renesas.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Kobayashi,

On Tue, Sep 25 2012, Tetsuyuki Kobayashi wrote:
> (09/19/2012 11:50 AM), Tetsuyuki Kobayashi wrote:
>> (2012/08/22 15:49), Guennadi Liakhovetski wrote:
>>> On some systems, e.g., kzm9g, MMCIF interfaces can produce spurious
>>> interrupts without any active request. To prevent the Oops, that results
>>> in such cases, don't dereference the mmc request pointer until we make
>>> sure, that we are indeed processing such a request.
>>>
>>> Reported-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
>>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> 
>> I verified on kzm9g.
>> This works with
>> [PATCH] mmc: sh-mmcif: properly handle MMC_WRITE_MULTIPLE_BLOCK 
>> completion IRQ
>> 
>> Tested-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
>
> Without this patch, the following Oops occurs. (kzm9g on v3.6-rc7)
> Please push this to v3.6, not only 3.7-next.

I'm traveling from Shanghai to Boston (home) at the moment, so I can't
push this immediately.  I'll either get it into 3.6, or 3.7 with a tag
for 3.6-stable.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
