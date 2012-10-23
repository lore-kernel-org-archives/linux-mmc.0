From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 2/2] mmc: sdhci: Defer probe if regulator_get fails
Date: Tue, 23 Oct 2012 10:29:41 -0600
Message-ID: <5086C5F5.4070801@wwwdotorg.org>
References: <1350976740-19284-1-git-send-email-pkunapuli@nvidia.com>  <1350976740-19284-3-git-send-email-pkunapuli@nvidia.com> <1350979047.20572.6.camel@tellur>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350979047.20572.6.camel@tellur>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Cc: Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 10/23/2012 01:57 AM, Lucas Stach wrote:
> Am Dienstag, den 23.10.2012, 12:49 +0530 schrieb Pavan Kunapuli:
>> vmmc and vqmmc regulators control the voltage to
>> the host and device. Defer the probe if either of
>> them is not registered.
>
> Does this work with boards where we don't have any MMC supplies? Or are
> we just deferring the probe indefinitely there?
> 
> For boards that power MMC unconditionally, are we supposed to add dummy
> regulators to make them work with this patchset?

I believe that dummy (fixed) regulators are supposed to be provided in
all cases where the platform doesn't actually have one. The fact that
everything worked OK without them before this patch was most likely a
mistake/accident.
