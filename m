From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-arasan: add phy support for
 sdhci-of-arasan
Date: Mon, 19 Oct 2015 22:56:53 +0800
Message-ID: <562504B5.7090206@rock-chips.com>
References: <1441961698-10516-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFpwgZSkE+TNehZ1Un=5CfjoEtfvELfrS6t-ZHZPscy3Yg@mail.gmail.com>
 <56243E85.2040202@rock-chips.com>
 <CAPDyKFpkH00roc=Nn067PufmQL59wqsi1c58tdv_UyP-7Gs-vg@mail.gmail.com>
 <5624AC51.9060907@rock-chips.com>
 <CAPDyKFqyXNUS2GwPjVWpoiPxOLNJ3T=FgDLO2NT+pEBGYMR1eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:57030 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbbJSO5F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Oct 2015 10:57:05 -0400
In-Reply-To: <CAPDyKFqyXNUS2GwPjVWpoiPxOLNJ3T=FgDLO2NT+pEBGYMR1eQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Michal Simek <michal.simek@xilinx.com>, S?ren Brinkmann <soren.brinkmann@xilinx.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 2015/10/19 18:54, Ulf Hansson wrote:
> [...]
>

[...]

>
>>
>>> 2) Considering the runtime PM case for the sdhci device. Typically you
>>> can gate clocks etc at runtime suspend to save power, but what about
>>> the phy? Can you power off it in runtime suspend?
>>
>>
>> yes, we can power off it in runtime suspend. So we can append some patches
>> later to introduce runtime pm for sdhci-of-arasan?
>
> Yes, that's fine. I would thus expect that you want to do phy power
> off/on from the runtime PM callbacks, right!?
>
> If that's the case I think $subject patch should deal with *both* phy
> init and phy power on during ->probe().
>

yes. I will do phy power_off/on from runtime pm for the next version of 
$subject patchset.

Thanks.

> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


-- 
Best Regards
Shawn Lin

