From: Wrobel Heinz-R39252 <r39252@freescale.com>
Subject: RE: [PATCH 1/2] Powerpc: Add voltage ranges support for T4
Date: Mon, 22 Jul 2013 09:47:53 +0000
Message-ID: <192298D25D96A042975E372855100DB70A1A93DC@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1374479636-9254-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1374479636-9254-1-git-send-email-Haijun.Zhang@freescale.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: Wood Scott-B07421 <B07421@freescale.com>, "cjb@laptop.org" <cjb@laptop.org>, Fleming Andy-AFLEMING <afleming@freescale.com>, Zhang Haijun-B42677 <B42677@freescale.com>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>
List-Id: linux-mmc@vger.kernel.org

> Subject: [PATCH 1/2] Powerpc: Add voltage ranges support for T4
> 
> Special voltages that can be support by eSDHC of T4 in esdhc node.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>

> --- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> @@ -19,6 +19,8 @@ Optional properties:
>      "bus-width = <1>" property.
>    - sdhci,auto-cmd12: specifies that a controller can only handle auto
>      CMD12.
> +  - 3300 3300: specifies that eSDHC controller can support voltages
> ranges
> +    from 3300 to 3300. This is an optional.

"This is an optional." is an unclear statement.

> +++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> @@ -399,6 +399,7 @@
>  	sdhc@114000 {
>  		compatible = "fsl,t4240-esdhc", "fsl,esdhc";
>  		sdhci,auto-cmd12;
> +		voltage-ranges = <1800 1800 3300 3300>;

This is IMHO incorrect and potentially dangerous.
The T4 silicon will only support 1.8V on SDHC pins per hardware specification.
The Freescale T4240QDS reference board has extra voltage shifters added to allow 3.3V operation, but that is _not_ a silicon feature. It is a specific board feature that may or may not translate to other boards, depending on how SD spec conformant a board builder wants to be.

If the intent is to state that a physical SDHC interface on a board has to be built to support 3.3V operation to be SD spec conformant for off-the-shelf cards because a reset would change the signal voltage to 3.3V, then I am not sure that putting this down as silicon "feature" without further explanation about the background anywhere is the right way to go.
IMHO silicon features are really just silicon features and not technically optional external circuitry additions implied by common use.

Best regards,

Heinz
