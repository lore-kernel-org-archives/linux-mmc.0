From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] OMAP4: MMC driver support on OMAP4
Date: Fri, 4 Sep 2009 12:19:12 -0700
Message-ID: <20090904121912.4b4e2b5a.akpm@linux-foundation.org>
References: <34590.192.168.10.89.1251897876.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933882AbZIDTTp@vger.kernel.org>
In-Reply-To: <34590.192.168.10.89.1251897876.squirrel@dbdmail.itg.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, madhu.cr@ti.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, 2 Sep 2009 18:54:36 +0530 (IST)
"kishore kadiyala" <kishore.kadiyala@ti.com> wrote:

> This Patch adds basic support for all 5 MMC controllers on OMAP4.
> 
> -Kishore
> 
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> ---
> This patch doesn't include mmc-regulator support
> 
>  arch/arm/mach-omap2/devices.c          |   42 +++++++++++++++++++++++++++++----
>  arch/arm/plat-omap/include/mach/irqs.h |    2 +
>  arch/arm/plat-omap/include/mach/mmc.h  |    9 ++++++-
>  drivers/mmc/host/Kconfig               |    6 ++--
>  drivers/mmc/host/omap_hsmmc.c          |   10 +++++++
>  5 files changed, 60 insertions(+), 9 deletions(-)

This looks like an ARM patch more than an MMC patch.  I grabbed it as
an MMC thing but hopefully someone else will grab it for a more
appropriate tree.
