From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] mmc: tegra: Disable UHS-I modes for tegra114
Date: Fri, 26 Feb 2016 08:58:10 +0000
Message-ID: <56D013A2.7080909@nvidia.com>
References: <1455806924-14967-1-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFowEH=4PU1ErNxMA0=SiDT1Q86H0SfMuiH5jA+H7mvquA@mail.gmail.com>
 <56CECC9E.9010501@nvidia.com> <1456428771.7433.4.camel@lynxeye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2964 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbcBZI6S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Feb 2016 03:58:18 -0500
In-Reply-To: <1456428771.7433.4.camel@lynxeye.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lucas Stach <dev@lynxeye.de>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>


On 25/02/16 19:32, Lucas Stach wrote:
> Am Donnerstag, den 25.02.2016, 09:42 +0000 schrieb Jon Hunter:
>> Hi Adrian, Lucas,
>>
>> On 18/02/16 16:07, Ulf Hansson wrote:
>>> +Adrian
>>>
>>> On 18 February 2016 at 15:48, Jon Hunter <jonathanh@nvidia.com>
>>> wrote:
>>>> SD card support for Tegra114 started failing after commit
>>>> a8e326a911d3
>>>> ("mmc: tegra: implement module external clock change") was
>>>> merged. This
>>>> commit was part of a series to enable UHS-I modes for Tegra. To
>>>> workaround this problem for now, only disable UHS-I modes for
>>>> Tegra114
>>>> and in order to do this it is necessary to revert changes from
>>>> commits
>>>> a8e326a911d3 ("mmc: tegra: implement module external clock
>>>> change"),
>>>> c3c2384c3ac0 ("mmc: tegra: implement UHS tuning"), 7ad2ed1dfcbe
>>>> ("mmc: tegra: enable UHS-I modes") that impact Tegra114. To do
>>>> this so
>>>> that UHS-I mode can be disabled for Tegra114 but not for Tegra124
>>>> separate the platform data, soc data and sdhci-ops so they are no
>>>> longer
>>>> common to both Tegra114 and Tegra124.
>>>>
>>>> Fixes: a8e326a911d3 ("mmc: tegra: implement module external clock
>>>> change")
>>>>
>>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>>
>>> This looks okay to me, although I need and ack from Adrian to pick
>>> up
>>> this for fixes. Adrian did recently step in as the maintainer for
>>> sdhci.
>>
>> Are you guys ok with this? It would be good to get your ACK's so that
>> Ulf can pick it up.
>>
> I don't see why you need to duplicate the tegra114_sdhci_ops.
> Together with the first hunk of this patch, having soc_data_tegra114
> not set any UHS-I capabilities (quirks) should be enough to disable
> UHS-I modes on Tegra114. The core should never call any of the UHS-I
> related functions from tegra114_sdhci_ops in that case.

Ok, I will give that a try. I was not sure if I needed to completely
remove all the changes or not and so I wanted to make it equivalent to
what we had before to ensure there would be no other problems crop up. I
will re-work and test and hopefully we can get this sorted.

Jon
