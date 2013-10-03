From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v2 0/9] ARM: dts: DT data for OMAP platforms for v3.13
Date: Thu, 03 Oct 2013 15:25:12 +0200
Message-ID: <524D7038.9070303@baylibre.com>
References: <1380553986-15910-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1380553986-15910-1-git-send-email-joelf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>
List-Id: linux-mmc@vger.kernel.org

+ DT list and DT maintainers.

Hi Joel,

Thanks for the update. It looks good to me.

For the new bindings added below;

 >   .../devicetree/bindings/crypto/omap-aes.txt        | 34 ++++++++++
 >   .../devicetree/bindings/crypto/omap-sham.txt       | 31 +++++++++

I will need the acked-by from one of the DT maintainers.

Regards,
Benoit

On 30/09/2013 17:12, Joel Fernandes wrote:
> Following series is a collection of dts patches for the below features:
> crypto:
>   aes, sha on am335x
>   aes, des on am437x
>   aes, des on omap4
> display:
>    beaglebone black HDMI
>    am335x-evm panel
>
> Series is based on Benoit Cousson's for_3.13/dts branch (commit sha 45646cd)
> Available at: git@github.com:joelagnel/linux-kernel.git (branch for-benoit)
>
> v2 changes:
>   - Fixed hex capitalization
>   - Dropped interrupt-parent property and use macros
>
> Benoit Parrot (1):
>    ARM: dts: AM33XX: Add LCDC info into am335x-evm
>
> Darren Etheridge (1):
>    dts: boneblack: add pinmux and hdmi node to enable display
>
> Joel Fernandes (5):
>    omap4: dts: Add node for AES
>    omap4: dts: Add node for DES3DES module
>    am33xx: dts: Fix AES interrupt number
>    ARM: am437x: dts: Add AES node for am437x
>    ARM: am437x: dts: Add DES node for am437x
>
> Mark A. Greer (2):
>    ARM: dts: Add SHAM data and documentation for AM33XX
>    ARM: dts: Add AES data and documentation for AM33XX
>
>   .../devicetree/bindings/crypto/omap-aes.txt        | 34 ++++++++++
>   .../devicetree/bindings/crypto/omap-sham.txt       | 31 +++++++++
>   arch/arm/boot/dts/am335x-bone.dts                  |  8 +++
>   arch/arm/boot/dts/am335x-boneblack.dts             | 48 +++++++++++++
>   arch/arm/boot/dts/am335x-evm.dts                   | 79 ++++++++++++++++++++++
>   arch/arm/boot/dts/am335x-evmsk.dts                 |  8 +++
>   arch/arm/boot/dts/am33xx.dtsi                      | 28 ++++++++
>   arch/arm/boot/dts/am4372.dtsi                      | 14 ++++
>   arch/arm/boot/dts/omap4.dtsi                       | 18 +++++
>   9 files changed, 268 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/crypto/omap-aes.txt
>   create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt
>

