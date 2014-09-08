From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/7 v3] mmc: use .multi_io_quirk on tmio_mmc
Date: Mon, 8 Sep 2014 13:45:22 +0200
Message-ID: <CAPDyKFpfHVeyenV=EJz1w0Zdxz8JbNzH-JjBnBKJj+vsWmw3+Q@mail.gmail.com>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87bnqx78xr.wl%kuninori.morimoto.gx@gmail.com>
	<877g1l78v9.wl%kuninori.morimoto.gx@gmail.com>
	<CAPDyKFoVQjO7CLAQM-9DX12H5bOwwP6aqJtb=y3uRMNaWqV89A@mail.gmail.com>
	<20140908111118.GC24563@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140908111118.GC24563@lee--X1>
Sender: linux-sh-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 8 September 2014 13:11, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 08 Sep 2014, Ulf Hansson wrote:
>
>> On 3 September 2014 04:09, Kuninori Morimoto
>> <kuninori.morimoto.gx@gmail.com> wrote:
>> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> >
>> > Now, tmio_mmc can use .multi_io_quirk callback
>> > instead of MMC_CAP2_NO_MULTI_READ flags.
>> > let's use it.
>> >
>> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> > ---
>> > v2 -> v3
>> >
>> >  - blk_size_workaround -> multi_io_quirk
>> >
>> >  drivers/mmc/host/tmio_mmc_pio.c |   13 +++++++++++++
>> >  include/linux/mfd/tmio.h        |    4 ++++
>>
>> "mfd"? That was an odd place for storing the tmio mmc specific platform data.
>>
>> So, we need an ack for the mfd maintainer on this one as well. Lee,
>> can you have a look?
>>
>> Future wise, I would also suggest the include/linux/mfd/tmio.h to be
>> split up in proper pieces.
>
> struct tmio_mmc_data looks like it's populated in the MFD driver, thus
> this is probably the correct place for it.

You are right, just that we normally put these in
include/linux/platform_data/* nowadays. Similar applies to struct
tmio_nand_data and struct tmio_fb_data.

Additionally, struct tmio_mmc_dma, could be moved to mmc and may be
forward declared at wherever struct tmio_mmc_data is put.

I also found tmio_core_mmc_enable(), tmio_core_mmc_resume(),
tmio_core_mmc_pwr() and tmio_core_mmc_clk_div() - those could stay in
a local mfd subsystem header file instead of in /include/linux/...

Anyway, I just thought it make sense to clean it up, to possibly
prevent further unnecessary cross subsystem acks. :-)

Kind regards
Uffe
