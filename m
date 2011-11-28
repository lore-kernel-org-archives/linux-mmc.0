From: Eliad Peller <eliad@wizery.com>
Subject: Re: [PATCH 2/3] omap_hsmmc: add pm_caps field
Date: Mon, 28 Nov 2011 11:23:17 +0200
Message-ID: <CAB3XZEeFSXBQZCR17bRdaG3UbhpE6JJHD_aEiq8Y2Kc3=eGRSQ@mail.gmail.com>
References: <1321970539-7104-1-git-send-email-eliad@wizery.com>
	<1321970539-7104-2-git-send-email-eliad@wizery.com>
	<4ED35131.6020206@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60088 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab1K1JXS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2011 04:23:18 -0500
In-Reply-To: <4ED35131.6020206@compulab.co.il>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Chris Ball <cjb@laptop.org>, Russell King <linux@arm.linux.org.uk>

hi Igor,

On Mon, Nov 28, 2011 at 11:15 AM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> On 11/22/11 16:02, Eliad Peller wrote:
>> Add pm_caps field to omap2_hsmmc_info and omap_mmc_slot_data
>> structs, so we will be able to indicate mmc pm capabilities
>> in the board file.
>
> Shouldn't this be user space runtime controllable?
> Instead of being a static per board decision?
>
we only declare here support for the pm capabilities.
the actual configuration of these capabilities is done at a later
stage, and can be controlled (implicitly) by userspace (e.g. by
enabling Wakeup-On-Wireless for the wl12xx chip).

regards,
Eliad.
