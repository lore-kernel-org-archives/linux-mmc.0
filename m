From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH V2 2/2] ARM: dts: omap3-ldp: fix mmc configuration
Date: Thu, 20 Feb 2014 18:51:45 +0530
Message-ID: <53060169.2050207@ti.com>
References: <1392356749-32091-1-git-send-email-nm@ti.com>
 <1392356749-32091-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1392356749-32091-3-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Friday 14 February 2014 11:15 AM, Nishanth Menon wrote:
> MMC1 is the only MMC interface available on the platform. Further,
> since the platform is based on older revision of SoC which is not
> capable of doing multi-block reads, mark it with compatibility for the
> same and add pinmux to ensure that all relevant pins are configured
> for non-MMC boot mode.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

looks good to me
Acked-by: Balaji T K <balajitk@ti.com>
