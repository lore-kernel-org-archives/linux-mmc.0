From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH V3 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
Date: Thu, 13 Jun 2019 15:02:02 +0200
Message-ID: <5b7e1ae5-c97e-5a21-fc3e-7cc328087f04@st.com>
References: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

hi Ulf

Just a "gentleman ping" about this series.
I know you are busy, it's just to be sure you do not forget me :-)

Regards
Ludo

On 6/3/19 5:55 PM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series adds busy detect for stm32 sdmmc variant.
> Some adaptations are required:
> -Clear busy status bit if busy_detect_flag and busy_detect_mask are
>   different.
> -Add hardware busy timeout with MMCIDATATIMER register.
> 
> V3:
> -rebase on latest mmc next
> -replace re-read by status parameter.
> 
> V2:
> -mmci_cmd_irq cleanup in separate patch.
> -simplify the busy_detect_flag exclude
> -replace sdmmc specific comment in
> "mmc: mmci: avoid fake busy polling in mmci_irq"
> to focus on common behavior
> 
> Ludovic Barre (3):
>    mmc: mmci: fix read status for busy detect
>    mmc: mmci: add hardware busy timeout feature
>    mmc: mmci: add busy detect for stm32 sdmmc variant
> 
>   drivers/mmc/host/mmci.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
>   drivers/mmc/host/mmci.h |  3 +++
>   2 files changed, 44 insertions(+), 8 deletions(-)
> 
