From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] MMC: Fix multiblock SDIO transfers in ATMEL MCI
Date: Sun, 12 Dec 2010 01:42:03 +0100
Message-ID: <20101212004203.GG19897@game.jcrosoft.org>
References: <20101210162351.GA11798@void.printf.net>
	<1292004872-5122-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1292004872-5122-1-git-send-email-nicolas.ferre@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: yauhen.kharuzhy@promwad.com, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 19:14 Fri 10 Dec     , Nicolas Ferre wrote:
> Based on report made by Yauhen in:
> "MMC: Fix multiblock SDIO transfers in AT91 MCI" patch,
> I report those changes to the brother driver: atmel-mci.
> 
> So, this patch sets SDIO transfer types: SDIO block and SDIO byte
> transfers instead of using ordinary MMC block transfers.
> It is checking opcode for SDIO CMD53 and setting transfer
> type in MCI_CMDR register properly.
> 
> Reported-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
