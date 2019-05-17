From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: Add YAML schemas for the generic
 MMC options
Date: Fri, 17 May 2019 09:56:51 -0500
Message-ID: <CAL_Jsq+X8uyA6rJFXJWSno8eHz1LAE=Ywvo9DZ4FZTdEEjU=9w@mail.gmail.com>
References: <225e90a94e9558db9f72f64aca05b0951b88c7c5.1558017853.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <225e90a94e9558db9f72f64aca05b0951b88c7c5.1558017853.git-series.maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Frank Rowand <frowand.list@gmail.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, May 16, 2019 at 9:44 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The MMC controllers have a bunch of generic options that are needed in a
> device tree. Add a YAML schemas for those.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v1:
>
>   - Added back the cd-inverted and wp-inverted note
>   - Removed the dependency of cd-inverted and wp-inverted on cd-gpios and
>     wp-gpios
>   - Fixed typo in the title
>   - Fixed default in the bus-width property
>   - Fixed typo in the wp-inverted property
>   - Removed redundant type on cd-debounce-delay-ms
>   - Switched the dsr maximum to hex instead of decimal notation
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 358 +++++++-
>  Documentation/devicetree/bindings/mmc/mmc.txt             | 177 +---
>  2 files changed, 358 insertions(+), 177 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/mmc.txt

BTW, in order to avoid updating every reference to mmc.txt, I think it
is better to leave it with a note 'This file has moved to
mmc-controller.yaml'. Then we just update the references when we
convert those bindings.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
