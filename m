From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/4] MMC: atmel-mci: fix two parameters swapped
Date: Thu, 29 Apr 2010 09:45:35 +0200
Message-ID: <4BD9391F.6070707@atmel.com>
References: <bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>	<bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>
	<20100428112245.23e99d70.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100428112245.23e99d70.akpm@linux-foundation.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, kernel@avr32linux.org, haavard.skinnemoen@atmel.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Le 28/04/2010 20:22, Andrew Morton :
> Patches 1-3 (at least) appear to be applicable to 2.6.33.x and perhaps
> earlier.

Correct.

> But you didn't cc stable@kernel.org and there was no Cc:
> <stable@kernel.org> in the changelog and in this case I'd prefer not to
> make that decision myself?

You are right. In fact I was waiting for feedback before pushing this
also to "stable"...

I keep this in mind and will do this when it will be merged in mainline.

Thanks, best regards,
-- 
Nicolas Ferre
