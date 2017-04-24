From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] MMC support for Octeon platforms.
Date: Mon, 24 Apr 2017 21:56:42 +0200
Message-ID: <CAPDyKFoAeyqnomWSphRt95WPDuhHRnAuowYHRnMkAB6izZv4nw@mail.gmail.com>
References: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: "Steven J. Hill" <steven.hill@cavium.com>
Cc: David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-mips@linux-mips.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 24 April 2017 at 20:41, Steven J. Hill <steven.hill@cavium.com> wrote:
> From: "Steven J. Hill" <Steven.Hill@cavium.com>
>
> Enable MMC support on Octeon SoCs. Tested on EdgeRouter Pro,
> SFF7000, and SFF7800 platforms. This should be applied on top
> of the "Cavium MMC driver" patch series from Jan Glauber.
>
> Steven J. Hill (3):
>   mmc: cavium: Fix detection of block or byte addressing.
>   mmc: cavium: Add MMC support for Octeon SOCs.
>   MIPS: Octeon: cavium_octeon_defconfig: Enable Octeon MMC
>
> Ulf Hansson (1):
>   mmc: core: Export API to allow hosts to get the card address
>
>  arch/mips/configs/cavium_octeon_defconfig |   5 +
>  drivers/mmc/core/core.c                   |   6 +
>  drivers/mmc/host/Kconfig                  |  10 +
>  drivers/mmc/host/Makefile                 |   2 +
>  drivers/mmc/host/cavium-octeon.c          | 351 ++++++++++++++++++++++++++++++
>  drivers/mmc/host/cavium.c                 |   2 +-
>  include/linux/mmc/card.h                  |   2 +
>  7 files changed, 377 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mmc/host/cavium-octeon.c
>
> --
> 2.1.4
>

Thanks, applied patch 1->3. Patch 4 is for the MIPS SoC maintainer,
unless I get an ack for it.

Kind regards
Uffe
