From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 11/41] mmc: host: omap_hsmmc: Add new compatible string
 to support dra7
Date: Tue, 23 May 2017 09:44:24 -0500
Message-ID: <20170523144424.5aj5xl3vlwyuj6ws@rob-hp-laptop>
References: <20170519081541.26753-1-kishon@ti.com>
 <20170519081541.26753-12-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170519081541.26753-12-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, Jonathan Corbet <corbet@lwn.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, May 19, 2017 at 01:45:11PM +0530, Kishon Vijay Abraham I wrote:
> Add a new compatible string "ti,dra7-hsmmc" to support
> dra7 and dra72 controllers. Also create a new controller flag
> "OMAP_HSMMC_REQUIRE_IODELAY" to specify all controllers that use
> "ti,dra7-hsmmc" require iodealy configuration to be set.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt |  1 +
>  drivers/mmc/host/omap_hsmmc.c                           | 10 ++++++++++
>  include/linux/platform_data/hsmmc-omap.h                |  1 +
>  3 files changed, 12 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
