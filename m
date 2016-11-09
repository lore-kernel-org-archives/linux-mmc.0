From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-iproc: Add brcm,sdhci-iproc compat
 string in bindings document
Date: Wed, 9 Nov 2016 12:26:15 -0600
Message-ID: <20161109182615.22m3wpkv3bi4rcto@rob-hp-laptop>
References: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
 <1478018277-10097-2-git-send-email-scott.branden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1478018277-10097-2-git-send-email-scott.branden@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Scott Branden <scott.branden@broadcom.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Anup Patel <anup.patel@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Nov 01, 2016 at 09:37:56AM -0700, Scott Branden wrote:
> Adds brcm,sdhci-iproc compat string to DT bindings document for
> the iProc SDHCI driver.
> 
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
