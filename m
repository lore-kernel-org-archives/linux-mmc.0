From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH V6] mmc:host:sdhci-pci:Addition of Arasan PCI Controller
 with integrated phy.
Date: Wed, 3 Jan 2018 15:00:33 +0530
Message-ID: <da228a50-26ac-6055-61e0-38524da106bc@ti.com>
References: <1514938282-3794-1-git-send-email-agarg@arasan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514938282-3794-1-git-send-email-agarg@arasan.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Atul Garg <agarg@arasan.com>, linux-mmc@vger.kernel.org, kishon@ti.com, rk@ti.com, nm@ti.com, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wednesday 03 January 2018 05:41 AM, Atul Garg wrote:
> The Arasan Controller is based on a FPGA platform and has integrated phy
> with specific registers used during initialization and
> management of different modes. The phy and the controller are integrated
> and registers are very specific to Arasan.
> 
> Arasan being an IP provider, licenses these IPs to various companies for
> integration of IP in custom SOCs. The custom SOCs define own register
> map depending on how bits are tied inside the SOC for phy registers,
> depending on SOC memory plan and hence will require own platform drivers.
> 
> If more details on phy registers are required, an interface document is
> hosted at https: //arasandotcom/NF/eMMC5.1 PHY Programming in Linux.pdf.

Please fix this link (no space after : and arasan.com instead of
arasandotcom etc).

> 
> Signed-off-by: Atul Garg <agarg@arasan.com>

Apart from the comments given by Adrian, looks good to me.

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Regards,
Sekhar
