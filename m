From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH V2 2/2] mmc: tegra: use mmc_of_parse to get the support
 of standard MMC DT bindings
Date: Wed, 06 Mar 2013 14:32:57 -0700
Message-ID: <5137B609.2060808@wwwdotorg.org>
References: <1361503420-16473-1-git-send-email-josephl@nvidia.com> <1361503420-16473-3-git-send-email-josephl@nvidia.com> <5137AF30.80006@wwwdotorg.org> <87zjygtekh.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87zjygtekh.fsf-DGHOrqG7t0YzNDMTQreKSUB+6BGkLq7r@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 03/06/2013 02:15 PM, Chris Ball wrote:
> Hi,
> 
> On Wed, Mar 06 2013, Stephen Warren wrote:
>> On 02/21/2013 08:23 PM, Joseph Lo wrote:
>>> Updating the sdhci-tegra driver to use mmc_of_parse to support standard
>>> MMC DT bindings. Then we can remove the redundant code that already support
>>> in generic MMC core.
>>>
>>> drivers/mmc/host/sdhci-tegra.c | 92 +++++---------------------------------
>>>  1 file changed, 10 insertions(+), 82 deletions(-)
>>
>> Chris,
>>
>> Are you OK with this patch? Let me know if you need a resend if you
>> don't have the email any more.
> 
> With the diffstat above, how could I object.  :-)
> 
> Acked-by: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>

Thanks. I've applied the patch in question to Tegra's
for-3.10/drivers-mmc branch.
