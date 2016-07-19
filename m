From: "Steven J. Hill" <Steven.Hill@caviumnetworks.com>
Subject: Re: [PATCH V8 2/2] mmc: OCTEON: Add host driver for OCTEON MMC
 controller.
Date: Tue, 19 Jul 2016 13:31:02 -0500
Message-ID: <578E71E6.2020700@caviumnetworks.com>
References: <57853474.9050108@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <57853474.9050108@cavium.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-mmc@vger.kernel.org

On 07/12/2016 01:18 PM, Steven J. Hill wrote:
> The OCTEON MMC controller is currently found on cn61XX and cn71XX
> devices. Device parameters are configured from device tree data.
> eMMC, MMC and SD devices are supported. Tested on Rhino labs UTM8
> and Cavium CN7130 board.
>
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>
>
Has anyone reviewed the driver or have any comments? Thanks.

Steve
