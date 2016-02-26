From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Disable UHS-I modes for tegra114
Date: Fri, 26 Feb 2016 09:39:11 +0000
Message-ID: <56D01D3F.7040205@nvidia.com>
References: <1455806924-14967-1-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFowEH=4PU1ErNxMA0=SiDT1Q86H0SfMuiH5jA+H7mvquA@mail.gmail.com>
 <56CECC9E.9010501@nvidia.com> <1456428771.7433.4.camel@lynxeye.de>
 <56CF89DF.1000206@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56CF89DF.1000206-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


On 25/02/16 23:10, Adrian Hunter wrote:
> On 25/02/2016 9:32 p.m., Lucas Stach wrote:
>> Am Donnerstag, den 25.02.2016, 09:42 +0000 schrieb Jon Hunter:
>>> Hi Adrian, Lucas,
>>>
>>> On 18/02/16 16:07, Ulf Hansson wrote:
>>>> +Adrian
>>>>
>>>> On 18 February 2016 at 15:48, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>> wrote:
>>>>> SD card support for Tegra114 started failing after commit
>>>>> a8e326a911d3
>>>>> ("mmc: tegra: implement module external clock change") was
>>>>> merged. This
>>>>> commit was part of a series to enable UHS-I modes for Tegra. To
>>>>> workaround this problem for now, only disable UHS-I modes for
>>>>> Tegra114
>>>>> and in order to do this it is necessary to revert changes from
>>>>> commits
>>>>> a8e326a911d3 ("mmc: tegra: implement module external clock
>>>>> change"),
>>>>> c3c2384c3ac0 ("mmc: tegra: implement UHS tuning"), 7ad2ed1dfcbe
>>>>> ("mmc: tegra: enable UHS-I modes") that impact Tegra114. To do
>>>>> this so
>>>>> that UHS-I mode can be disabled for Tegra114 but not for Tegra124
>>>>> separate the platform data, soc data and sdhci-ops so they are no
>>>>> longer
>>>>> common to both Tegra114 and Tegra124.
>>>>>
>>>>> Fixes: a8e326a911d3 ("mmc: tegra: implement module external clock
>>>>> change")
>>>>>
>>>>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>>
>>>> This looks okay to me, although I need and ack from Adrian to pick
>>>> up
>>>> this for fixes. Adrian did recently step in as the maintainer for
>>>> sdhci.
>>>
>>> Are you guys ok with this? It would be good to get your ACK's so that
>>> Ulf can pick it up.
>>>
>> I don't see why you need to duplicate the tegra114_sdhci_ops.
>> Together with the first hunk of this patch, having soc_data_tegra114
>> not set any UHS-I capabilities (quirks) should be enough to disable
>> UHS-I modes on Tegra114. The core should never call any of the UHS-I
>> related functions from tegra114_sdhci_ops in that case.
> 
> I am on vacation until the middle of next week so I haven't had a
> chance to look at this, but it is not obvious if the changes to
> the ops are needed.  Jon, please comment.

No problem. I was not sure so reverted all the changes for Tegra114. I
have posted an updated version [0] without the duplicate ops (forgot to
mark as V2). I have tested this and confirm that it is working. Please
ACK this if you are happy.

Jon

[0] http://marc.info/?l=linux-mmc&m=145647928317400&w=2
