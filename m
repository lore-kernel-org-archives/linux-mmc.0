From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/7 v4] mmc: sh_mmcif: add parent clk support
Date: Tue, 5 May 2015 10:33:31 +0200
Message-ID: <CAPDyKFq3Q1xCZmhQJKraQohPF6WXxbwj8O8OV+8QRPW9DQypFg@mail.gmail.com>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com>
	<87d22vgt8u.wl%kuninori.morimoto.gx@renesas.com>
	<3057568.fukq3GllLM@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <3057568.fukq3GllLM@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, kobayashi <keita.kobayashi.ym@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On 23 April 2015 at 12:07, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Morimoto-san,
>
> Thank you for the patches.
>
> On Thursday 23 April 2015 08:11:36 Kuninori Morimoto wrote:
>> Hi Ulf, Simon
>>
>> These patches are v4 of sh_mmcif.
>> Current sh_mmcif driver was used on Renesas SH-Mobile series,
>> and it is also used on Renesas R-Car series.
>> But, R-Car series can setup parent clock.
>> We couldn't setup it when SH-Mobile.
>>
>> These patches are tested by Kobayashi-san on Lager board.
>>
>> Simon
>>
>> 6), 7) are ARM side patches, but these doesn't depend on
>> 1) - 5) patches.
>>
>> Kuninori Morimoto (7):
>>   1) mmc: sh_mmcif: move mmcif_of_match to upside
>>   2) mmc: sh_mmcif: cleanup to use dev instead of &pdev->dev
>>   3) mmc: sh_mmcif: remove unnecessary int clk from struct sh_mmcif_host
>>   4) mmc: sh_mmcif: separate sh_mmcif_clk_update() into setup and prepare
>
> For patches 1-4,
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> I'll comment separately on patch 5.
>
>>   5) mmc: sh_mmcif: calculate best clock with parent clock
>>   6) ARM: shmobile: r8a7790: add MMCIF parent clock range
>>   7) ARM: shmobile: r8a7791: add MMCIF parent clock range
>>
>>  Documentation/devicetree/bindings/mmc/renesas,mmcif.txt |   3 ++
>>  arch/arm/boot/dts/r8a7790.dtsi                          |   2 ++
>>  arch/arm/boot/dts/r8a7791.dtsi                          |   1 +
>>  drivers/mmc/host/sh_mmcif.c                             | 173 +++++++++----
>>  4 files changed, 135 insertions(+), 44 deletions(-)
>
> --

Thanks, applied patches 1->4.

I am delaying patch 5, until it gets acked.

Kind regards
Uffe
