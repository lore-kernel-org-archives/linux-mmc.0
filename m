From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: convert to device tree support only
Date: Mon, 27 Aug 2012 18:28:35 -0400
Message-ID: <87a9xgynos.fsf@octavius.laptop.org>
References: <1345187071-6619-1-git-send-email-josephl@nvidia.com>
	<502E950B.2010205@wwwdotorg.org>
	<1345772433.5081.1.camel@jlo-ubuntu-64.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1345772433.5081.1.camel-yx3yKKdKkHfc7b1ADBJPm0n48jw8i0AO@public.gmane.org> (Joseph Lo's
	message of "Fri, 24 Aug 2012 09:40:33 +0800")
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-tegra@vger.kernel.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc@vger.kernel.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Aug 23 2012, Joseph Lo wrote:
> On Sat, 2012-08-18 at 03:01 +0800, Stephen Warren wrote:
>> On 08/17/2012 01:04 AM, Joseph Lo wrote:
>> > When compiling a kernel that supports only Tegra30 and not Tegra20,
>> > the SDHCI driver will fail to compile since the of_match_device() failure
>> > fallback code unconditinally references soc_data_tegra20, which is only
>> > compiled in when Tegra20 support is enabled.
>> > 
>> > In Kernel 3.7, both Tegra20 and Tegra30 will only support booting using
>> > device tree, Hence, there is never a need to fall back to using
>> > soc_data_tegra20 if of_mach_device() fails. Instead, make this case an
>> > error. This removes the reference to soc_data_tegra20, and hence solves
>> > the compile failure.
>> 
>> Tested-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
>> 
>> (built and tested both Tegra20-only and Tegr30-only kernels with this
>> applied on top of next-20120816).
>
> Ping.

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
