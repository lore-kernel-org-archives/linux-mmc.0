From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH V3] MMC: PM: add suspend/resume in atmel-mci
Date: Mon, 11 Jul 2011 11:47:06 +0200
Message-ID: <4E1AC69A.6060307@atmel.com>
References: <1309530754.4373.3.camel@hcegtvedt.norway.atmel.com>	<1309779505-25509-1-git-send-email-nicolas.ferre@atmel.com>
	<m2iprbkw6v.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <m2iprbkw6v.fsf@bob.laptop.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, kernel@avr32linux.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, hans-christian.egtvedt@atmel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Le 09/07/2011 22:58, Chris Ball :
> Hi,
> 
> On Mon, Jul 04 2011, Nicolas Ferre wrote:
>> Take care of slots while going to suspend state.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>> V3: take care of each slot SUSPENDED state
>>     (adding a status bit in the slot "flags")
>> V2: move to pm_ops
> 
> Thanks, I've merged v3 of this patch for mmc-next/3.1 with Felipe's

You mean v4, I have checked: everything is ok.

> Reviewed-by, and your [2/2] kconfig change.

Perfect, thanks a lot Chris!
-- 
Nicolas Ferre
