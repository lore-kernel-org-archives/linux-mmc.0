From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] sdio: fix suspend/resume regression
Date: Wed, 13 Oct 2010 11:46:36 +0200
Message-ID: <AANLkTimqo5exLf46ONKvMs5=aPwXgLrBGPAexVZJHje0@mail.gmail.com>
References: <1286788315.3101.11.camel@sven> <1286955116-22793-1-git-send-email-ohad@wizery.com>
 <AANLkTiki_Sky6pry+vWAoTtJ5ctVUpawAH6iRYV6L-+z@mail.gmail.com>
 <AANLkTimTSPU3pzDscG3TSaqs45Q=eGEaqiDmk9AYyuY_@mail.gmail.com> <AANLkTi=oM6bzga1HffOxZ6_T7yjSNi5RTCZtTFd4r=7j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35777 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab0JMJq5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Oct 2010 05:46:57 -0400
In-Reply-To: <AANLkTi=oM6bzga1HffOxZ6_T7yjSNi5RTCZtTFd4r=7j@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Maxim Levitsky <maximlevitsky@gmail.com>, libertas-dev@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Sven Neumann <s.neumann@raumfeld.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Mack <daniel@caiaq.de>, Colin Cross <ccross@android.com>, Chris Ball <cjb@laptop.org>, stable@kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Oct 13, 2010 at 11:06 AM, Vitaly Wool <vitalywool@gmail.com> wrote:
> I don't really see the point. Instead of having SDIO-specific handling
> in the SDIO specific code, we're trying to address SDIO specific
> corner cases elsewhere. What's the rationale?

MMC core already has a card-removal mechanism which is bus independent
(in mmc_pm_notify).

Why would you prefer to duplicate this code for SDIO ?

Thanks,
Ohad.
