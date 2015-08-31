From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 02/15] mmc: host: omap_hsmmc: return on fatal errors
 from omap_hsmmc_reg_get
Date: Mon, 31 Aug 2015 11:14:17 +0530
Message-ID: <55E3E9B1.8070908@ti.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com> <1440666847-12594-3-git-send-email-kishon@ti.com> <CAOesGMjW=3qqBfqdxGwEqk1uVj_08rnvP095V-9+O=rsmjLOxQ@mail.gmail.com> <20150828190354.GZ4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36110 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbbHaFo3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 31 Aug 2015 01:44:29 -0400
In-Reply-To: <20150828190354.GZ4215@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, afenkart@gmail.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Neil Brown <neilb@suse.de>

Hi,

On Saturday 29 August 2015 12:33 AM, Tony Lindgren wrote:
> * Olof Johansson <olof@lixom.net> [150828 11:11]:
>> Hi,
>>
>> On Thu, Aug 27, 2015 at 2:13 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> Now return error only if the return value of
>>> devm_regulator_get_optional() is not the same as -ENODEV, since with
>>> -EPROBE_DEFER, the regulator can be obtained later and all other
>>> errors are fatal.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> Tested-by: Tony Lindgren <tony@atomide.com>
>>
>> I bisected boot failures on Panda ES with multi_v7_defconfig down to
>> this commit on last night's -next build:
>>
>> http://arm-soc.lixom.net/bootlogs/next/next-20150828/pandaes-arm-multi_v7_defconfig.html
> 
> MMC is working for me at least on Duovero. Interesting that you also
> have all kind of errors there, I guess this is some older revision
> of the board.
> 
> Anyways, Kishon, care to look into what might be causing this?

I think this might be because my pbias fix [1] patch wasn't merged yet.
I'll try to get that resolved asap.

Thanks
Kishon

[1] -> http://lkml.iu.edu/hypermail/linux/kernel/1507.3/01594.html
> 
> Regards,
> 
> Tony
> 
