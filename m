From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 3/4] mmc: host: sdhci-tegra: cleanup ifdefs
Date: Wed, 06 Mar 2013 16:17:47 -0700
Message-ID: <5137CE9B.3070203@wwwdotorg.org>
References: <1361385317-6020-1-git-send-email-rklein@nvidia.com> <1361385317-6020-4-git-send-email-rklein@nvidia.com> <5137B07C.1040700@wwwdotorg.org> <87r4js16ml.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87r4js16ml.fsf-DGHOrqG7t0YzNDMTQreKSUB+6BGkLq7r@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pritesh Raithatha <praithatha-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 03/06/2013 03:54 PM, Chris Ball wrote:
> Hi,
> 
> On Wed, Mar 06 2013, Stephen Warren wrote:
>> On 02/20/2013 11:35 AM, Rhyland Klein wrote:
>>> The structs wrapped with the SOC ifdefs are small enough where having
>>> them always there shouldn't be a big overhead. Removing the ifdefs
>>> also makes the code a little cleaner.
>>
>> I think patches 3 and 4 of this series can go through either the MMC
>> tree (I checked there are no conflicts with the MMC patch I have to take
>> through the Tegra tree), or the Tegra tree (since I'm taking another
>> Tegra MMC patch though there), both without any dependency issues.
>>
>> It's your call. Let me know if you want me to take them through the
>> Tegra tree with an ack. Or, if you want to take them through the MMC
>> tree that's fine too. If you need them reposted to see the content, let
>> me know, or they're at:
> 
> Via the MMC tree with an ack sounds good

OK, thanks. Patches 3/4 and 4/4,
Acked-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
