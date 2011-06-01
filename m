From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH v2 1/2] sdio: add quirk to handle pending IRQ in case
	of none	CCCR_INTx bits
Date: Wed, 01 Jun 2011 14:36:40 -0700
Message-ID: <4DE6B0E8.9050306@boundarydevices.com>
References: <1306918113-23872-1-git-send-email-per.forlin@stericsson.com>
	<1306918113-23872-2-git-send-email-per.forlin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1306918113-23872-2-git-send-email-per.forlin@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Per Forlin <per.forlin@stericsson.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Daniel Drake <dsd@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@linaro.org>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 6/1/2011 1:48 AM, Per Forlin wrote:
> From: Per Forlin <per.forlin@linaro.org>

> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 7b4fd7b..852021c 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -175,6 +175,7 @@ struct mmc_card {
>  #define MMC_QUIRK_DISABLE_CD	(1<<5)		/* disconnect CD/DAT[3] resistor */
>  #define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices have broken CMD38 */
>  #define MMC_QUIRK_BLK_NO_CMD23	(1<<7)		/* Avoid CMD23 for regular multiblock */
> +#define MMC_QUIRK_SDIO_IRQ_CCCR_INTX_0 (1<<7)	/* SDIO card has IRQ even if CCCR_INTx is 0 */

Using the same value as MMC_QUIRK_BLK_NO_CMD23 looks odd...
