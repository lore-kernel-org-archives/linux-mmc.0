From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [CFT 03/11] mmc: omap_hsmmc: remove private DMA API implementation
Date: Thu, 7 Jun 2012 23:23:43 +0530
Message-ID: <CANfBPZ-wWpwf_AoZV1jToFr=44FYPDtoOQCdd+Hzy03u53POeQ@mail.gmail.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk> <E1ScaYb-0003tZ-Pb@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <E1ScaYb-0003tZ-Pb@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 7, 2012 at 4:37 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Remove the private DMA API implementation from omap_hsmmc, making it
> use entirely the DMA engine API.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested this on 4430SDP with rootfs usage, untarring the kernel source
and compiling it natively.

Tested-by: Venkatraman S <svenkatr@ti.com>

> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0265 ++++++++++-----------------=
--------------
> =A01 files changed, 64 insertions(+), 201 deletions(-)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
