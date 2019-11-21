From: Rob Herring <rob.e.herring@gmail.com>
Subject: Re: [PATCH v6 4/8] dt-bindings: mmc: Add optional generic properties
 for mmc
Date: Thu, 21 Nov 2019 13:01:16 -0600
Message-ID: <CAC=3edbHWA7gv-mTFVXXcMzN6hyzO4LPqkbcRZ-zDp5BAm8_Vw@mail.gmail.com>
References: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com> <1574232449-13570-5-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1574232449-13570-5-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Manish Narani <manish.narani@xilinx.com>
Cc: ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, adrian.hunter@intel.com, michal.simek@xilinx.com, jolly.shah@xilinx.com, rajan.vaja@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org, linux-mmc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, git@xilinx.com
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 20, 2019 at 12:49 AM Manish Narani <manish.narani@xilinx.com> wrote:
>
> Add optional properties for mmc hosts which are used to set clk delays
> for different speed modes in the controller.
>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/mmc/mmc-controller.yaml     | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 080754e0ef35..305b2016bc17 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -333,6 +333,18 @@ patternProperties:
>      required:
>        - reg
>
> +  "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":
> +    minItems: 2
> +    maxItems: 2
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +        maximum: 359

This is wrong. It can't be both minItems of 2 and a single uint32.
What's needed is:

allOf:
  - $ref: /schemas/types.yaml#/definitions/uint32-array
minItems: 2
maxItems: 2
items:
  minimum: 0
  maximum: 359
