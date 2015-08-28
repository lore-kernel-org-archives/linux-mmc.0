From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 02/15] mmc: host: omap_hsmmc: return on fatal errors
 from omap_hsmmc_reg_get
Date: Fri, 28 Aug 2015 11:07:57 -0700
Message-ID: <CAOesGMjW=3qqBfqdxGwEqk1uVj_08rnvP095V-9+O=rsmjLOxQ@mail.gmail.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
	<1440666847-12594-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440666847-12594-3-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, afenkart@gmail.com, Tony Lindgren <tony@atomide.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Neil Brown <neilb@suse.de>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Aug 27, 2015 at 2:13 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Now return error only if the return value of
> devm_regulator_get_optional() is not the same as -ENODEV, since with
> -EPROBE_DEFER, the regulator can be obtained later and all other
> errors are fatal.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Tested-by: Tony Lindgren <tony@atomide.com>

I bisected boot failures on Panda ES with multi_v7_defconfig down to
this commit on last night's -next build:

http://arm-soc.lixom.net/bootlogs/next/next-20150828/pandaes-arm-multi_v7_defconfig.html

-Olof
