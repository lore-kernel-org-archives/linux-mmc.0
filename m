From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: Add YAML schemas for the
 generic MMC options
Date: Tue, 28 May 2019 19:26:49 +0200
Message-ID: <20190528172649.6mkdkscnu5d2rybi@flea>
References: <c6b8789d71ce1970be77387c066a262dca0a0dec.1558340089.git-series.maxime.ripard@bootlin.com>
 <CAPDyKFrs6f4_Xr=ATay_wDYNPa+-jdZvP4XSB55B-EFMAETN1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrs6f4_Xr=ATay_wDYNPa+-jdZvP4XSB55B-EFMAETN1Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Tue, May 28, 2019 at 10:40:16AM +0200, Ulf Hansson wrote:
> > +patternProperties:
> > +  "^.*@[0-9]+$":
> > +    properties:
> > +      reg:
> > +        items:
> > +          - minimum: 0
> > +            maximum: 7
> > +            description:
> > +              Must contain the SDIO function number of the function this
> > +              subnode describes. A value of 0 denotes the memory SD
> > +              function, values from 1 to 7 denote the SDIO functions.
> > +
> > +      broken-hpi:
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        description:
> > +          Use this to indicate that the mmc-card has a broken hpi
> > +          implementation, and that hpi should not be used.
> > +
> > +    required:
> > +      - reg
> > +
>
> [...]
>
> > -Use of Function subnodes
> > -------------------------
> > -
> > -On embedded systems the cards connected to a host may need additional
> > -properties. These can be specified in subnodes to the host controller node.
> > -The subnodes are identified by the standard 'reg' property.
> > -Which information exactly can be specified depends on the bindings for the
> > -SDIO function driver for the subnode, as specified by the compatible string.
> > -
> > -Required host node properties when using function subnodes:
> > -- #address-cells: should be one. The cell is the slot id.
> > -- #size-cells: should be zero.
> > -
> > -Required function subnode properties:
> > -- reg: Must contain the SDIO function number of the function this subnode
> > -       describes. A value of 0 denotes the memory SD function, values from
> > -       1 to 7 denote the SDIO functions.
> > -
> > -Optional function subnode properties:
> > -- compatible: name of SDIO function following generic names recommended practice
> > -
>
> I think most of the information of how we use sub(child) nodes
> disappeared in this conversion - or at least gets harder to
> understand. Could we perhaps keep some of this?

Sure, what would you like to keep in particular?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
