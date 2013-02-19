From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: assume CONFIG_OF, remove platform data
Date: Tue, 19 Feb 2013 14:22:53 -0500
Message-ID: <87ppzwglbm.fsf@octavius.laptop.org>
References: <1360966039-24071-1-git-send-email-swarren@wwwdotorg.org>
	<5123CFB9.7020209@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5123CFB9.7020209-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> (Stephen Warren's message of
	"Tue, 19 Feb 2013 12:17:13 -0700")
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Stephen,

On Tue, Feb 19 2013, Stephen Warren wrote:
>> Tegra only supports, and always enables, device tree. Remove all ifdefs
>> and runtime checks for DT support from the driver. Platform data is
>> therefore no longer required. Rework the driver to parse the device tree
>> directly into struct sdhci_tegra.
>
> Chris,
>
> If you can take this for 3.9, everything is simple. I understand it's
> very late for that.

I'll take it for 3.9 (perhaps straight after -rc1), since this is a more
of a cleanup than a new feature.  I've pushed it to mmc-next now so that
testing can happen in the meantime.

Thanks,

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
