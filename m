From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH 02/12] ARM: ep93xx: vision_ep9307: Use MMC CD and RO GPIO
Date: Thu, 25 Jul 2013 18:33:44 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DAC5C20A6@AUSP01VMBX24.collaborationhost.net>
References: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1374794808-21890-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374794808-21890-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Ryan Mallon <rmallon@gmail.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

On Thursday, July 25, 2013 4:27 PM, Laurent Pinchart wrote:
>
> Pass the CD and RO GPIO numbers to the MMC SPI driver and remove the
> custom .get_cd() and .get_ro() callback functions.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/mach-ep93xx/vision_ep9307.c | 56 +++---------------------------------
>  1 file changed, 4 insertions(+), 52 deletions(-)

I'll try testing this tomorrow.

Thanks,
Hartley
