From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/7 v3] mmc: use .multi_io_quirk on tmio_mmc
Date: Tue, 9 Sep 2014 08:32:35 +0200
Message-ID: <CAPDyKFo2mmDfdQFO0A87r1fpLHQQH5URW0TiW0D4bwN0zeP9Ag@mail.gmail.com>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87bnqx78xr.wl%kuninori.morimoto.gx@gmail.com>
	<877g1l78v9.wl%kuninori.morimoto.gx@gmail.com>
	<CAPDyKFoVQjO7CLAQM-9DX12H5bOwwP6aqJtb=y3uRMNaWqV89A@mail.gmail.com>
	<87y4tt7ir2.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87y4tt7ir2.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 9 September 2014 02:14, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>
> Hi Ulf
>
>> > @@ -142,6 +144,8 @@ struct tmio_mmc_data {
>> >         /* clock management callbacks */
>> >         int (*clk_enable)(struct platform_device *pdev, unsigned int *f);
>> >         void (*clk_disable)(struct platform_device *pdev);
>> > +       int (*multi_io_quirk)(struct mmc_card *card,
>> > +                             unsigned int direction, int blk_size);
>>
>> Do you really need to invent new platform callbacks for this? Wouldn't
>> it be possible to let the driver handle the quirk by itself?
>
> sh_mobile_sdhi is based on tmio_mmc_xxx,
> and sh_mobile_sdhi side needs this quirk.
> I don't know original tmio_mmc_xxx HW.
>
> Of course we can add new flag to tmio driver,
> but, it is same way as before ?

You are right, let's keep this patch as is, besides the "#include
<linux/blkdev.h>", which isn't needed.

Sorry for the noise.

Kind regards
Uffe

>
> Best regards
> ---
> Kuninori Morimoto
