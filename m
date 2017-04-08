From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v9] mmc: OCTEON: Add host driver for OCTEON MMC
 controller.
Date: Sat, 8 Apr 2017 03:13:35 +0300
Message-ID: <20170408001335.2eyajki3ujgomcz4@raspberrypi-3.musicnaut.iki.fi>
References: <836c0ca9-18f0-f6b5-bb79-8d0301d54154@cavium.com>
 <c1d0ccad-10e2-9d5d-8192-2bbd7d7357b3@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <c1d0ccad-10e2-9d5d-8192-2bbd7d7357b3@cavium.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: "Steven J. Hill" <Steven.Hill@cavium.com>
Cc: linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, David Daney <david.daney@cavium.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Oct 03, 2016 at 08:18:59PM -0500, Steven J. Hill wrote:
> On 09/19/2016 03:24 PM, Steven J. Hill wrote:
> > The OCTEON MMC controller is currently found on cn61XX and cn71XX
> > devices. Device parameters are configured from device tree data.
> > eMMC, MMC and SD devices are supported. Tested on Cavium CN7130.
> > 
> > Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> > Acked-by: David Daney <david.daney@cavium.com>
> 
> Have any MMC maintainers gotten a chance to review our driver now
> that v4.8 is out? Thanks.

Also v4.9, v4.10 and v4.11 went by.

I think you should resend the patch, to get this driver finally merged.

A.
