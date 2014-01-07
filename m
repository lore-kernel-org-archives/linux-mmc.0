From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH REPOST3] mmc: tegra: add support for Tegra124
Date: Tue, 07 Jan 2014 03:05:44 +0000
Message-ID: <86lhys7apj.fsf@void.printf.net>
References: <1389032267-2567-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389032267-2567-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> (Stephen
	Warren's message of "Mon, 6 Jan 2014 11:17:47 -0700")
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Stephen,

On Mon, Jan 06 2014, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> Tegra124's MMC controller is very similar to earlier SoC generations,
> and can be supported by the same driver.
>
> However, there are some non-backwards-compatible HW differences, and
> hence a new DT compatible value must be used to describe the HW. This
> patch updates the driver to support that new compatible value.
>
> That said, the HW differences are only relevant when enabling certain
> high-performance transfer modes. Since the driver is currently very
> simple and doesn't enable those modes, we don't actually need to address
> any of these HW differences in the code yet, hence the simple nature of
> this patch.
>
> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Thanks, pushed to mmc-next for 3.14; sorry for the delay.

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
