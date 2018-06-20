From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: broken clock stable indicator
 on arasan controllers
Date: Wed, 20 Jun 2018 13:08:28 -0600
Message-ID: <20180620190828.GA26510@rob-hp-laptop>
References: <20180615081830.zrgx6arwn6ga27gu@laureti-dev>
 <cover.1529493667.git.h.grohne@intenta.de>
 <12953dbf9af1f1a71aaf3ef77782e56a2a7ad893.1529493667.git.h.grohne@intenta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <12953dbf9af1f1a71aaf3ef77782e56a2a7ad893.1529493667.git.h.grohne@intenta.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Helmut Grohne <h.grohne@intenta.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Atul Garg <agarg@arasan.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 20, 2018 at 01:32:51PM +0200, Helmut Grohne wrote:
> Some controllers immediately report that their internal clock is stable
> after activating it even when the clock is not stable. When used in
> conjunction with older/slower cards, this can result in:
> 
>     mmc0: error -84 whilst initialising SD card
> 
> This flag allows documenting and thus working around such a hardware
> defect.
> 
> Signed-off-by: Helmut Grohne <h.grohne@intenta.de>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
