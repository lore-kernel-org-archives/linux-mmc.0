From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: Re: [PATCH 2/23]  Alternative mmc structure to support pxa168, pxa910,
	mmp2 family SD
Date: Thu, 23 Dec 2010 13:26:03 +0100
Message-ID: <lyei98vfok.fsf@ensc-virt.intern.sigma-chemnitz.de>
References: <661A407B-8073-4B51-AE40-E3BA6D0B5C42@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Philip Rakity <prakity@marvell.com> writes:

> --- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
> +++ b/arch/arm/mach-mmp/include/mach/regs-apmu.h
> +#define APMU_SDH2	APMU_REG(0x0e8)
> +#define APMU_SDH3	APMU_REG(0x0ec)

is this really correct?  "ARMADA 16x Application Processor Family"
(October 2010) manual says that these registers are at 0xe0 + 0xe4.


Enrico
