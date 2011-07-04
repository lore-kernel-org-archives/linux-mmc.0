From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] MMC: OMAP: change HSMMC maintainence to Orphan
Date: Mon, 4 Jul 2011 14:30:02 +0530
Message-ID: <CANfBPZ9XiHomYEmnf_xobtVvOs=PpGLnifAkn6wDFquBR+8QHQ@mail.gmail.com>
References: <1309541802-5975-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309541802-5975-1-git-send-email-khilman@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jul 1, 2011 at 11:06 PM, Kevin Hilman <khilman@ti.com> wrote:
> From: Madhusudhan Chikkature <madhu.cr@ti.com>
>
> Update the OMAP HS MMC entry from the MAINTAINERS file as I will
> no longer be able to maintain this driver.
>
> Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> [khilman@ti.com: change to Orphan rather than complete removal]
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Applies to v3.0-rc5
>
> =A0MAINTAINERS | =A0 =A03 +--
> =A01 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0358cd..2f238b5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4574,9 +4574,8 @@ S: =A0 =A0 =A0 =A0Maintained
> =A0F: =A0 =A0 drivers/mmc/host/omap.c
>
> =A0OMAP HS MMC SUPPORT
> -M: =A0 =A0 Madhusudhan Chikkature <madhu.cr@ti.com>
> =A0L: =A0 =A0 linux-omap@vger.kernel.org
> -S: =A0 =A0 Maintained
> +S: =A0 =A0 Orphan
> =A0F: =A0 =A0 drivers/mmc/host/omap_hsmmc.c
>
> =A0OMAP RANDOM NUMBER GENERATOR SUPPORT
> --
> 1.7.6
>
Note for the record:
I am interested in making sure that this driver is well supported, even=
 if
not designated as 'official' maintainer due to other commitments (as of=
 now).
Patches are welcome.

Acked-by: Venkatraman S <svenkatr@ti.com>
