From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 4/8] dt-bindings: mmc: Add optional generic properties
 for mmc
Date: Mon, 4 Nov 2019 17:14:27 -0600
Message-ID: <20191104231427.GA7606@bogus>
References: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
 <1572588353-110682-5-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1572588353-110682-5-git-send-email-manish.narani@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Manish Narani <manish.narani@xilinx.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, rajan.vaja@xilinx.com, nava.manne@xilinx.com, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org, jolly.shah@xilinx.com, linux-kernel@vger.kernel.org, git@xilinx.com
List-Id: linux-mmc@vger.kernel.org

On Fri, Nov 01, 2019 at 11:35:49AM +0530, Manish Narani wrote:
> Add optional properties for mmc hosts which are used to set clk delays
> for different speed modes in the controller.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../bindings/mmc/mmc-controller.yaml          | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 080754e0ef35..87a83d966851 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -212,6 +212,98 @@ properties:
>      description:
>        eMMC HS400 enhanced strobe mode is supported
>  
> +  # Below mentioned are the clock (phase) delays which are to be configured
> +  # in the controller while switching to particular speed mode. The range
> +  # of values are 0 to 359 degrees.
> +
> +  clk-phase-legacy:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for Legacy Mode.
> +
> +  clk-phase-mmc-hs:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair degrees for MMC HS.
> +
> +  clk-phase-sd-hs:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for SD HS.
> +
> +  clk-phase-uhs-sdr12:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for SDR12.
> +
> +  clk-phase-uhs-sdr25:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for SDR25.
> +
> +  clk-phase-uhs-sdr50:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for SDR50.
> +
> +  clk-phase-uhs-sdr104:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for SDR104.
> +
> +  clk-phase-uhs-ddr50:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for SD DDR50.
> +
> +  clk-phase-mmc-ddr52:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for MMC DDR52.
> +
> +  clk-phase-mmc-hs200:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for MMC HS200.
> +
> +  clk-phase-mmc-hs400:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for MMC HS400.

This can be condensed into:

patternProperties:
  
"^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":

Or if you want to divide them between SD and MMC ones, that would be 
fine for me.

Rob
