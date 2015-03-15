From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v3] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Sun, 15 Mar 2015 20:37:01 +0200
Message-ID: <20150315183701.GB586@fuloong-minipc.musicnaut.iki.fi>
References: <1425567033-31236-1-git-send-email-aleksey.makarov@auriga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1425567033-31236-1-git-send-email-aleksey.makarov@auriga.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Aleksey Makarov <aleksey.makarov@auriga.com>
Cc: linux-mmc@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Aaron Williams <aaron.williams@cavium.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Mar 05, 2015 at 05:50:31PM +0300, Aleksey Makarov wrote:
> The OCTEON MMC controller is currently found on cn61XX and cnf71XX
> devices.  Device parameters are configured from device tree data.
> 
> eMMC, MMC and SD devices are supported.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
> Signed-off-by: Aaron Williams <aaron.williams@cavium.com>
> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
> Signed-off-by: Peter Swain <pswain@cavium.com>
> [aleksey.makarov@auriga.com: preparation for submission]
> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>

Seems to work fine on EdgeRouter Pro (cn61xx).

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

However, there is a sparse warning that probably needs to be fixed:

	octeon_mmc.c:1141:29: error: incompatible types for operation (>=)
	octeon_mmc.c:1141:29:    left side has type struct gpio_desc *pwr_gpiod
	octeon_mmc.c:1141:29:    right side has type int

A.
