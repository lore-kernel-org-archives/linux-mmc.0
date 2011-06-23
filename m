From: Daniel Drake <dsd@laptop.org>
Subject: Re: SD8686 fast power-cycle problems
Date: Thu, 23 Jun 2011 15:29:38 +0100
Message-ID: <BANLkTinQNA8+Wkto_Hkwo_kKrXg6EGKidQ@mail.gmail.com>
References: <BANLkTimsjb_cvcDKQpuqN_GxNWnyA0ebRg@mail.gmail.com>
	<BANLkTim1rai5pv+hW3mMxXieq5289oYJSg@mail.gmail.com>
	<BANLkTimoOXZvNt_GR4EHcSX_YecOubLPbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:41036 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759455Ab1FWO3j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jun 2011 10:29:39 -0400
Received: by pzk26 with SMTP id 26so1256696pzk.10
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jun 2011 07:29:38 -0700 (PDT)
In-Reply-To: <BANLkTimoOXZvNt_GR4EHcSX_YecOubLPbw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: zhangfei.gao@marvell.com, bzhao@marvell.com, bchau@marvell.com, linux-mmc@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>

On 19 June 2011 14:10, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> How do you power off 8686 now?
> Use RESETn, PDn, or directly control regulator?
> Assume RESETn is kept high as Ohad mentioned before, do you control PDn?

We use mmc_power_off(), which calls mmc_set_ios() which is implemented by sdhci.

We don't make any effort to control the specific pins, we just rely on
what sdhci does for us, which presumably is a standard way of removing
power from SD cards.

Thanks,
Daniel
