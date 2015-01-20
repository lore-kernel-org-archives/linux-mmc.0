From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tmio: add missing EXPORT_SYMBOL for tmio_mmc_host_alloc/free
Date: Tue, 20 Jan 2015 10:15:23 +0100
Message-ID: <CAPDyKFp57T5ZNUofS1TxDe=xV7zCukNov1j21WmrZ8tRS52PDQ@mail.gmail.com>
References: <201501131902.WqokttpY%fengguang.wu@intel.com>
	<87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
	<CAPDyKFrNFr493FcN3A3k_tGo9J801ga91ooL=sZT6DS0vFwVoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrNFr493FcN3A3k_tGo9J801ga91ooL=sZT6DS0vFwVoQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "kbuild-all@01.org" <kbuild-all@01.org>
List-Id: linux-mmc@vger.kernel.org

+ MFD maintainer

On 14 January 2015 at 09:30, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 14 January 2015 at 03:21, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> tmio_mmc_host_alloc/free were added on tmio_mmc_pio.c,
>> but, it is missing EXPORT_SYMBOL for it.
>> Compile will be failed without this patch
>>
>>  ERROR: "tmio_mmc_host_free" [drivers/mmc/host/tmio_mmc.ko] undefined!
>>  ERROR: "tmio_mmc_host_alloc" [drivers/mmc/host/tmio_mmc.ko] undefined!
>>  ERROR: "tmio_mmc_host_free" [drivers/mmc/host/sh_mobile_sdhi.ko] undefined!
>>  ERROR: "tmio_mmc_host_alloc" [drivers/mmc/host/sh_mobile_sdhi.ko] undefined!
>>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Thanks!
>
> I decided to squashed this change into patch "mmc: tmio: add
> tmio_mmc_host_alloc/free()", which was the one adding the related
> functions.
>
> Kind regards
> Uffe
