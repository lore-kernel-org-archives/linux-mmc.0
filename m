From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH 0/2] mmc: sdhci-iproc: Use defines instead of magic numbers
Date: Mon, 4 Jul 2016 10:02:04 -0700
Message-ID: <577A968C.3020107@broadcom.com>
References: <1467487394-28682-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467487394-28682-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Stefan,

On 16-07-02 12:23 PM, Stefan Wahren wrote:
> Hi,
>
> this small patch series should make the sdhci-iproc platform data easier
> to read. Since i don't have the adequate hardware it's only compile tested.
>
> Stefan
>
> Stefan Wahren (2):
>    mmc: sdhci: add define for suspend/resume capability
>    mmc: sdhci-iproc: Use defines instead of magic numbers
>
>   drivers/mmc/host/sdhci-iproc.c |   13 +++++++++++--
>   drivers/mmc/host/sdhci.h       |    1 +
>   2 files changed, 12 insertions(+), 2 deletions(-)
>
Patch series looks fine.

Acked-by: Scott Branden <scott.branden@broadcom.com>
