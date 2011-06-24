From: Daniel Drake <dsd@laptop.org>
Subject: Re: SD8686 fast power-cycle problems
Date: Fri, 24 Jun 2011 16:53:47 +0100
Message-ID: <BANLkTin67BsffwSU5bLQqNOqz+wy5=gBsg@mail.gmail.com>
References: <BANLkTimsjb_cvcDKQpuqN_GxNWnyA0ebRg@mail.gmail.com>
	<BANLkTim1rai5pv+hW3mMxXieq5289oYJSg@mail.gmail.com>
	<BANLkTimoOXZvNt_GR4EHcSX_YecOubLPbw@mail.gmail.com>
	<BANLkTinQNA8+Wkto_Hkwo_kKrXg6EGKidQ@mail.gmail.com>
	<BANLkTi=81-67hrgpeUoXdgemdmTLSM5Hsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54099 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759839Ab1FXPxs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jun 2011 11:53:48 -0400
Received: by pwj7 with SMTP id 7so1880275pwj.19
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jun 2011 08:53:47 -0700 (PDT)
In-Reply-To: <BANLkTi=81-67hrgpeUoXdgemdmTLSM5Hsw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: zhangfei.gao@marvell.com, bzhao@marvell.com, bchau@marvell.com, linux-mmc@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>

On 24 June 2011 16:38, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> Thanks Daniel,
> But mmc_set_ios does not mean can't access PDn pin.
> At least, in drivers/mmc/host/omap.c, set_ios->set_power->pdata->set_power.
> Whatever, if directly controller regulator, the time is required for
> voltage go to certain level.

Makes sense - thanks for the response.

Daniel
