From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 02/15] mmc: host: omap_hsmmc: return on fatal errors
 from omap_hsmmc_reg_get
Date: Fri, 28 Aug 2015 12:03:54 -0700
Message-ID: <20150828190354.GZ4215@atomide.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
 <1440666847-12594-3-git-send-email-kishon@ti.com>
 <CAOesGMjW=3qqBfqdxGwEqk1uVj_08rnvP095V-9+O=rsmjLOxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:47026 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752341AbbH1TD7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 28 Aug 2015 15:03:59 -0400
Content-Disposition: inline
In-Reply-To: <CAOesGMjW=3qqBfqdxGwEqk1uVj_08rnvP095V-9+O=rsmjLOxQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, afenkart@gmail.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Neil Brown <neilb@suse.de>

* Olof Johansson <olof@lixom.net> [150828 11:11]:
> Hi,
> 
> On Thu, Aug 27, 2015 at 2:13 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > Now return error only if the return value of
> > devm_regulator_get_optional() is not the same as -ENODEV, since with
> > -EPROBE_DEFER, the regulator can be obtained later and all other
> > errors are fatal.
> >
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > Tested-by: Tony Lindgren <tony@atomide.com>
> 
> I bisected boot failures on Panda ES with multi_v7_defconfig down to
> this commit on last night's -next build:
> 
> http://arm-soc.lixom.net/bootlogs/next/next-20150828/pandaes-arm-multi_v7_defconfig.html

MMC is working for me at least on Duovero. Interesting that you also
have all kind of errors there, I guess this is some older revision
of the board.

Anyways, Kishon, care to look into what might be causing this?

Regards,

Tony
