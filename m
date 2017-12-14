From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH 08/12] mmc: sdhci-omap: Add support to override f_max and
 iodelay from pdata
Date: Thu, 14 Dec 2017 15:04:22 +0100
Message-ID: <CAOFm3uH0qvwE6fqkMoNAz9Qf_2VaaBvf78tPVTsyfGPRMz7TkA@mail.gmail.com>
References: <20171214130941.26666-1-kishon@ti.com> <20171214130941.26666-9-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214130941.26666-9-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

Kishon,

On Thu, Dec 14, 2017 at 2:09 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> DRA74x EVM Rev H EVM comes with revision 2.0 silicon. However, earlier
> versions of EVM can come with either revision 1.1 or revision 1.0 of
> silicon.
>
> The device-tree file is written to support rev 2.0 of silicon.
> pdata-quirks are used to then override the settings needed for
> PG 1.1 silicon.
>
> PG 1.1 silicon has limitations w.r.t frequencies at which MMC1/2/3
> can operate as well as different IOdelay numbers.
>
> Add support in sdhci-omap driver to get platform data if available
> (added using pdata quirks) and override the data (max-frequency and
> iodelay data) obtained from device tree.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

<snip>

> --- /dev/null
> +++ b/include/linux/platform_data/sdhci-omap.h
> @@ -0,0 +1,35 @@
> +/**
> + * SDHCI Controller Platform Data for TI's OMAP SoCs
> + *
> + * Copyright (C) 2017 Texas Instruments
> + * Author: Kishon Vijay Abraham I <kishon@ti.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 of
> + * the License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */

Could you use the new SPDX tags instead of this fine and long boilerplate? See
Thomas doc for details [1]

[1] https://lkml.org/lkml/2017/12/4/934

Thanks!
PS: if you could spread the word out in your team too, this would be
much welcomed!

-- 
Cordially
Philippe Ombredanne
