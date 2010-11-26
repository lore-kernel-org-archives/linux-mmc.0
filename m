From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] MMC: Fix multiblock SDIO transfers in AT91 MCI
Date: Fri, 26 Nov 2010 20:46:54 +0100
Message-ID: <20101126194654.GI26540@game.jcrosoft.org>
References: <1290679911-5992-1-git-send-email-yauhen.kharuzhy@promwad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1290679911-5992-1-git-send-email-yauhen.kharuzhy@promwad.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 12:11 Thu 25 Nov     , Yauhen Kharuzhy wrote:
> The AT91 MCI has special SDIO transfer types: SDIO block and SDIO byte
> transfers, but at91_mci driver doesn't use them and handles all SDIO
> transfers as ordinary MMC block transfers. This causes problems for
> multiple-block SDIO transfers (in particular for 256-bytes blocks).
> 
> Fix this situation by check opcode for SDIO CMD53 and set transfer
> type in AT91_MCI_CMDR register properly.
> 
> This patch was tested with libertas SDIO driver: problem with TX
> timeouts on big packets was eliminated.
> 
> Signed-off-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
