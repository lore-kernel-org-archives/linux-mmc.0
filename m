From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 1/3] mmc: dw_mmc-bluefield: Add driver extension
Date: Fri, 18 Jan 2019 11:06:04 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1901181059100.1647@nanos.tec.linutronix.de>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com> <1525805210-15246-1-git-send-email-lsun@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525805210-15246-1-git-send-email-lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liming Sun <lsun@mellanox.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaehoon Chung <jh80.chung@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>
List-Id: linux-mmc@vger.kernel.org

Liming,

On Tue, 8 May 2018, Liming Sun wrote:
> index 0000000..54c3fbb
> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Mellanox Technologies.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */

This license information is broken. The SPDX license identifier and the
boiler plate text are contradicting. The SPDX id is GPL v2 only and the
boiler plate says v2 or later.

Please decide which version you want and fix ASAP. If you fix that up
please add a Fixes: tag and cc stable. While at it please remove the boiler
plate text as the SPDX id is sufficient and the boiler plate is redundant
information.

See Documentation/process/license-rules.txt

Thanks,

	tglx
