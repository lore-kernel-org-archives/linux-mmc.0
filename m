From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: dw_mmc: dw_mci_get_cd check MMC_CAP_NONREMOVABLE
Date: Wed, 06 May 2015 09:23:56 +0200
Message-ID: <5070892.H5Aty5Cb8i@wuerfel>
References: <1430816089-8857-1-git-send-email-zhangfei.gao@linaro.org> <5549B0EE.4000202@samsung.com> <5549B4FE.6080007@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:63454 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbbEFHYB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2015 03:24:01 -0400
In-Reply-To: <5549B4FE.6080007@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei <zhangfei.gao@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Wednesday 06 May 2015 14:30:22 zhangfei wrote:
> On 05/06/2015 02:13 PM, Jaehoon Chung wrote:
> >>>>>>>>> If you want to check it, use the "broken-cd" and "non-removable" 
> >>>>
> >>>> drivers/mmc/host/dw_mmc.c checks broken-cd, while mmc_of_parse checks non-removable.
> >>>> Yes, it works.
> >>>>
> >>>> But is it a workaround? and a little tricky.
> >>>> It costs me some time to find why non-removable does not work, someone else may meet the same issue.
> >>>> It does not align with Documentation/devicetree/bindings/mmc/mmc.txt, which is the guideline to write dts.
> >>>> And see drivers/mmc/host/sdhci.c: sdhci_do_get_cd, it also checks both.
> >>>
> >>> "non-removable" is assumed that card is not removed.
> >>> it's not also correct detect scheme. Then it's also able to say the broken card detection scheme.
> >>> (if CDETECT register can't use.)
> >>>
> >>> BROKEN_CARD_DETECTION quirk means that it has unreliable card detection.
> >>> When dw-mmc host controller has unreliable card detection scheme, it could be set.
> >>> Is this tricky? i don't think so.
> >>>
> >>> Though non-removable doesn't set, it has to work fine, isn't?
> >> If non-removable is not set, broken-cd has to be set.
> >> Or set both, but usually we may not consider this at first.
> >>
> >> When we first want to enable emmc, we naturally use non-removable, according to Documentation/devicetree/bindings/mmc/mmc.txt
> >
> > Why do you use naturally non-removable? eMMC can be removed at some SoC. (It's assumption.)
> > Is it common approach that consider how eMMC can be detected at host controller?
> The emmc chip we use is folded on board and can not be removed.
> non-removable will make mmc_rescan only executing once, while broken 
> will make mmc_rescan polling.

I agree. The current behavior of dw_mmc is different from what the
documentation says it is, and different from what the other host
controllers do.

Your patch looks correct to me, as it will make the dw_mmc driver behave
like the others but keep existing files working when they rely on the
nonstandard behavior.

	Arnd

