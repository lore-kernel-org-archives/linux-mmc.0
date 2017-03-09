From: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [regression] next-20170307: led trigger deferral breaks sdhci
Date: Thu, 9 Mar 2017 07:50:51 +0100
Message-ID: <07b458b8-73fd-2e9f-cc06-c58a8e2f3f13@microchip.com>
References: <20246b21-4c00-e22e-232d-49596f5f275e@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20246b21-4c00-e22e-232d-49596f5f275e-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 03/08/2017 10:17 PM, Jon Hunter wrote:
> Hello!
>
> I noticed that sdhci is broken for me on yesterday's and today's -next
> and the bisect is pointing to commit 3f1318e01bb4 ('leds: core: use
> deferred probing if default trigger isn't available yet').

I have noticed it yesterday, I was going to perform a bisect but thanks 
to you I won't have to do it.

Ludovic

>
> At first I thought that ok, the problem is that sdhci driver is first
> registering the led and then the trigger. However, then I looked at the
> led_trigger_register() function and it appears to allow you to register
> the led first and the trigger sometime later and populate the default
> trigger later on. So then I am not sure why the above commit is needed?
>
> It is not clear to me from the commit message for the above commit what
> actual problem was caused by not registering the trigger first.
>
> Cheers
> Jon
>
