From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: remove useless include of <mach/*.h>
Date: Tue, 28 Aug 2012 13:24:38 -0400
Message-ID: <87bohvvsix.fsf@octavius.laptop.org>
References: <1346137258-7186-1-git-send-email-swarren@wwwdotorg.org>
	<503CFE0C.4070502@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <503CFE0C.4070502-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> (Stephen Warren's message of "Tue,
	28 Aug 2012 10:21:16 -0700")
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Stephen,

On Tue, Aug 28 2012, Stephen Warren wrote:
> On 08/28/2012 12:00 AM, Stephen Warren wrote:
>> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> 
>> Nothing from this file is needed, so remove the include. This helps
>> single zImage work by reducing use of the mach-tegra/include/mach/
>> directory.
>
> BTW, it'd be easiest for me to take this through the Tegra tree, since I
> may be able to delete <mach/gpio-tegra.h> after this.

Fine with me:

Acked-by: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
