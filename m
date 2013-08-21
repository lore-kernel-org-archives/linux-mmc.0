From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH V2 1/2] ARM: dts: remove dwmmc nodes from exynos5 common
 dts file.
Date: Wed, 21 Aug 2013 12:34:28 +0200
Message-ID: <1567576.DPSCbfljYs@amdc1227>
References: <52146040.87c5440a.4207.5aff@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <52146040.87c5440a.4207.5aff@mx.google.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: yuvaraj.cd@gmail.com
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kgene.kim@samsung.com, ks.giri@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Yuvaraj,

On Wednesday 21 of August 2013 12:07:38 yuvaraj.cd@gmail.com wrote:
> From: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> 
> Exynos5 series SOC's 5250 and 5420 have different versions of
> DWMMC controller.So there is a new compatible string to distinguish
> between them.So these nodes should be moved out of Exynos5 series
> common device tree source.

This series should be split in a different way, because patch 1/2 breaks 
dwmmc on Exynos5250 and only patch 2/2 fixes this, so bisection is broken.

Also patch 2/2 contains two logically separate changes - moving dwmmc nodes 
and making status disabled by default. Those should be in separate patches.

Best regards,
Tomasz
