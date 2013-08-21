From: Yuvaraj Kumar <yuvaraj.cd@gmail.com>
Subject: Re: [PATCH V2 1/2] ARM: dts: remove dwmmc nodes from exynos5 common
 dts file.
Date: Wed, 21 Aug 2013 17:16:56 +0530
Message-ID: <CAKuRcOJ34DDDZSfu7QSWrBQGuOSf_WptGjztEqvKKmE72grvxA@mail.gmail.com>
References: <52146040.87c5440a.4207.5aff@mx.google.com>
	<1567576.DPSCbfljYs@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1567576.DPSCbfljYs@amdc1227>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, kgene.kim@samsung.com, ks.giri@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 21, 2013 at 4:04 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Yuvaraj,
>
> On Wednesday 21 of August 2013 12:07:38 yuvaraj.cd@gmail.com wrote:
>> From: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>>
>> Exynos5 series SOC's 5250 and 5420 have different versions of
>> DWMMC controller.So there is a new compatible string to distinguish
>> between them.So these nodes should be moved out of Exynos5 series
>> common device tree source.
>
> This series should be split in a different way, because patch 1/2 breaks
> dwmmc on Exynos5250 and only patch 2/2 fixes this, so bisection is broken.
 will make a single patch and resend.
>
> Also patch 2/2 contains two logically separate changes - moving dwmmc nodes
> and making status disabled by default. Those should be in separate patches.
 will separate patch2/2 and resend.
>
> Best regards,
> Tomasz
>
