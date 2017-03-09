From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [regression] next-20170307: led trigger deferral breaks sdhci
Date: Thu, 9 Mar 2017 21:30:13 +0100
Message-ID: <6f75da43-3c26-e744-5ef1-432f18b769b4@gmail.com>
References: <20246b21-4c00-e22e-232d-49596f5f275e@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20246b21-4c00-e22e-232d-49596f5f275e@nvidia.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, Richard Purdie <rpurdie@rpsys.net>, Pavel Machek <pavel@ucw.cz>, Adrian Hunter <adrian.hunter@intel.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-leds@vger.kernel.org, linux-mmc@vger.kernel.org, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Joe,

On 03/08/2017 10:17 PM, Jon Hunter wrote:
> Hello!
> 
> I noticed that sdhci is broken for me on yesterday's and today's -next
> and the bisect is pointing to commit 3f1318e01bb4 ('leds: core: use
> deferred probing if default trigger isn't available yet').
> 
> At first I thought that ok, the problem is that sdhci driver is first
> registering the led and then the trigger. However, then I looked at the
> led_trigger_register() function and it appears to allow you to register
> the led first and the trigger sometime later and populate the default
> trigger later on. So then I am not sure why the above commit is needed?
> 
> It is not clear to me from the commit message for the above commit what
> actual problem was caused by not registering the trigger first.

The problem was the case when the trigger that has been defined as
"default-trigger" in DT is not registered at the moment of LED class
driver probing. It is silently ignored by LED core.

It turned out that we accepted the commit too hastily, and in fact
that case seems not to be critical to the extent justifying preventing
LED class device registration.

Probably dev_warn() should be enough in this case. I've already dropped
the commit. Sorry for making confusion.

-- 
Best regards,
Jacek Anaszewski
