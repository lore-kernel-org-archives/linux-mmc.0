From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 02/13] mmc: host: Add facility to support re-tuning
Date: Tue, 13 Jan 2015 12:25:37 +0100
Message-ID: <CAPDyKFo_51e=BERS9qX6x_LbK3tM5aijOicVkhQ5==39b+C93Q@mail.gmail.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
	<1417801271-15575-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:49536 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbbAMLZi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jan 2015 06:25:38 -0500
Received: by mail-qa0-f50.google.com with SMTP id k15so1564447qaq.9
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jan 2015 03:25:37 -0800 (PST)
In-Reply-To: <1417801271-15575-3-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Hi Adrian,

Thanks for working on this and apologize for my late reply!

On 5 December 2014 at 18:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Currently, there is core support for tuning during
> initialization. There can also be a need to re-tune
> periodically (e.g. sdhci) or to re-tune after the
> host controller is powered off (e.g. after PM
> runtime suspend / resume) or to re-tune in response
> to CRC errors.
>
> The main requirements for re-tuning are:
>   - ability to enable /disable re-tuning
>   - ability to flag that re-tuning is needed
>   - ability to re-tune before any request
>   - ability to hold off re-tuning if the card is busy
>   - ability to hold off re-tuning if re-tuning is in
>   progress
>   - ability to run a re-tuning timer

I suggest we skip the support for the re-tuning timer in this initial
step and thus remove the related functionality from this patchset. It
adds complexity, but more important it's not obvious that it actually
will help. I am more concerned that it randomly will cause a request
latency and thus decrease performance.

The re-tuning period can't be selected "perfectly", so in this initial
step let's instead just rely on re-tune from the request retry path.

If we do see a need for a doing re-tuning periodically, how about
using the runtime PM suspend path (of the mmc card device). In that
way, we should be able to minimize the impact on performance.

Kind regards
Uffe

>
> To support those requirements 5 members are added to struct
> mmc_host:
>
>   unsigned int          can_retune:1;   /* re-tuning can be used */
>   unsigned int          doing_retune:1; /* re-tuning in progress */
>   int                   need_retune;    /* re-tuning is needed */
>   int                   hold_retune;    /* hold off re-tuning */
>   struct timer_list     retune_timer;   /* for periodic re-tuning */
>
> need_retune is an integer so it can be set without needing
> synchronization. hold_retune is a integer to allow nesting.
>
> Various simple functions are provided to set / clear those
> variables.
>
> Subsequent patches take those functions into use.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
