From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt: bindings: Make compatible optional for mmc
 function nodes
Date: Mon, 1 Aug 2016 11:41:56 -0500
Message-ID: <20160801164156.GA29075@rob-hp-laptop>
References: <1469891030-28838-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1469891030-28838-1-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: devicetree <devicetree@vger.kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Sat, Jul 30, 2016 at 05:03:50PM +0200, Hans de Goede wrote:
> On some boards (android tablets) different batches use different sdio
> wifi modules. This is not a problem since mmc/sdio is an enumerable bus,
> so we only need to describe and activate the mmc controller in dt and
> then the kernel will automatically load the right driver.
> 
> Sometimes it is useful to specify certain ethernet properties for these
> "unknown" sdio devices, specifically we want the boot-loader to be able
> to set "local-mac-address" as some of these sdio wifi modules come without
> an eeprom / without a factory programmed mac address.
> 
> Since the exact device is unknown (differs per batch) we cannot use
> a wifi-chip specific compatible, thus sometimes it is desirable to have a
> mmc function node, without having to make up an otherwise unused compatible
> for the node, so make the compatible property optional.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Change the commit-msg to explain why it sometimes is desirable to have a
>  mmc function node without a compatible
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
