From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH] sdio: fix suspend/resume regression
Date: Wed, 13 Oct 2010 11:06:51 +0200
Message-ID: <AANLkTi=oM6bzga1HffOxZ6_T7yjSNi5RTCZtTFd4r=7j@mail.gmail.com>
References: <1286788315.3101.11.camel@sven>
	<1286955116-22793-1-git-send-email-ohad@wizery.com>
	<AANLkTiki_Sky6pry+vWAoTtJ5ctVUpawAH6iRYV6L-+z@mail.gmail.com>
	<AANLkTimTSPU3pzDscG3TSaqs45Q=eGEaqiDmk9AYyuY_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56711 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab0JMJGw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Oct 2010 05:06:52 -0400
In-Reply-To: <AANLkTimTSPU3pzDscG3TSaqs45Q=eGEaqiDmk9AYyuY_@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Maxim Levitsky <maximlevitsky@gmail.com>, libertas-dev@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Sven Neumann <s.neumann@raumfeld.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Mack <daniel@caiaq.de>, Colin Cross <ccross@android.com>, Chris Ball <cjb@laptop.org>, stable@kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Oct 13, 2010 at 10:55 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Vitaly,
>
> On Wed, Oct 13, 2010 at 9:54 AM, Vitaly Wool <vitalywool@gmail.com> wrote:
>> what about moving this logic to sdio bus_ops as this seems to be
>> completely specific to sdio right now?
>
> I actually prefer not to have any SDIO-specific logic of that kind at
> all, and instead, to use the logic we already have in mmc_pm_notify
> for all types of MMC buses.

I don't really see the point. Instead of having SDIO-specific handling
in the SDIO specific code, we're trying to address SDIO specific
corner cases elsewhere. What's the rationale?

Thanks,
   Vitaly
