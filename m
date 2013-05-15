From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH V2 07/10] ARM: mvebu: Use standard MMC binding for all
 users of mvsdio
Date: Tue, 14 May 2013 20:29:56 -0400
Message-ID: <20130515002956.GH31290@titan.lakedaemon.net>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
 <1368479941-10084-8-git-send-email-gmbnomis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1368479941-10084-8-git-send-email-gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Mon, May 13, 2013 at 11:18:58PM +0200, Simon Baatz wrote:
> In order to prepare the switch to the standard MMC device tree parser
> for mvsdio, adapt all current uses of mvsdio in the dts files to the
> standard format.
> 
> Signed-off-by: Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/armada-370-db.dts                |    1 +
>  arch/arm/boot/dts/armada-370-mirabox.dts           |    1 +
>  arch/arm/boot/dts/armada-370-rd.dts                |    1 +
>  arch/arm/boot/dts/armada-370-xp.dtsi               |    4 ++++
>  arch/arm/boot/dts/armada-xp-db.dts                 |    1 +
>  arch/arm/boot/dts/kirkwood-dreamplug.dts           |    1 +
>  .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |    2 ++
>  arch/arm/boot/dts/kirkwood-mplcec4.dts             |    2 +-
>  arch/arm/boot/dts/kirkwood-topkick.dts             |    1 +
>  arch/arm/boot/dts/kirkwood.dtsi                    |    4 ++++
>  10 files changed, 17 insertions(+), 1 deletion(-)

Applied to mvebu/dt

thx,

Jason.
