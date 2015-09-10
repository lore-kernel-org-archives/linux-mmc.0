From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v3 02/15] mmc: host: omap_hsmmc: return on fatal errors
 from omap_hsmmc_reg_get
Date: Thu, 10 Sep 2015 09:59:35 -0700
Message-ID: <CAMAWPa-uf80P8026UH7kJsmzVO2K76HpuzRgpn9TadZS+12f5A@mail.gmail.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
	<1440666847-12594-3-git-send-email-kishon@ti.com>
	<CAOesGMjW=3qqBfqdxGwEqk1uVj_08rnvP095V-9+O=rsmjLOxQ@mail.gmail.com>
	<20150828190354.GZ4215@atomide.com>
	<55E3E9B1.8070908@ti.com>
	<20150831205829.GB4215@atomide.com>
	<20150831211450.GC4215@atomide.com>
	<55E5B730.9020409@ti.com>
	<20150901145002.GE4215@atomide.com>
	<55E5BC11.8090002@ti.com>
	<20150901150336.GF4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59221 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598AbbIJQ7l (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Sep 2015 12:59:41 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 1F87B208A7
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2015 16:59:40 +0000 (UTC)
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com [209.85.212.179])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 8D45320890
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2015 16:59:37 +0000 (UTC)
Received: by wicfx3 with SMTP id fx3so30535207wic.0
        for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2015 09:59:35 -0700 (PDT)
In-Reply-To: <20150901150336.GF4215@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Olof Johansson <olof@lixom.net>, Ulf Hansson <ulf.hansson@linaro.org>, afenkart@gmail.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Neil Brown <neilb@suse.de>, Tyler Baker <tyler.baker@linaro.org>

On Tue, Sep 1, 2015 at 8:03 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [150901 07:57]:
>> On 09/01/2015 05:50 PM, Tony Lindgren wrote:
>> >>
>> >>On -next, Above crash signature could be related to race
>> >>"ARM: OMAP2+: omap-device: fix race deferred probe of omap_hsmmc vs omap_device_late_init"
>> >>http://www.spinics.net/lists/linux-omap/msg121622.html
>> >
>> >Good point thanks, yes that's the case. MMC probing fails and then we hit this
>> >separate issue while MMC is trying to probe. Applying your fix makes the
>> >abort disappear, but naturally does not get MMC working again.
>>
>> you may need CONFIG_GPIO_PCF857X=y for dra7-evm
>
> This is a regression at least on omap4 as pointed out by Olof.

FWIW, this problem still exists in mainline[1], and note that it fails
for omap2plus_defconfig which already has CONFIG_REGULATOR_PBIAS=y, so
that is not the fix for this issue.

Kevin

[1] http://kernelci.org/boot/omap4-panda-es/?mainline&omap2plus_defconfig&lab-khilman
