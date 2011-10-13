From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V4 3/3] ARM: SAMSUNG: Add lookup of sdhci-s3c clocks
	using generic names
Date: Thu, 13 Oct 2011 09:55:21 +0100
Message-ID: <20111013085521.GJ21648@n2100.arm.linux.org.uk>
References: <1318412587-29987-1-git-send-email-rajeshwari.s@samsung.com>
	<1318412587-29987-4-git-send-email-rajeshwari.s@samsung.com>
	<4E956ADB.3060604@samsung.com>
	<CAPs=JDf2N1kh4BO9nPBb-J6k51e-ytntrNOvw_UOKtw-ktdycA@mail.gmail.com>
	<4E95BDF8.2080406@samsung.com>
	<CAPs=JDeFyoCYnR-Xa_fdmBVHxfNGuVNfdHd-MZgYcPytprsmFg@mail.gmail.com>
	<4E969958.9020200@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4E969958.9020200@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kgene.kim@samsung.com, Rajeshwari Shinde <rajeshwari.s@samsung.com>, cjb@laptop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 13, 2011 at 09:55:04AM +0200, Sylwester Nawrocki wrote:
> Yes, it allowed to add clkdev support with minimal changes required.
> 
> But let's see what happens when the works on common struct clk for all
> architectures are more or less completed and we convert Samsung platforms
> to use it;)

The common struct clk shouldn't have much to do with the clkdev part of
it - clkdev just provides a method to associate a struct clk with the
drivers request.  The common struct clk doesn't change that.
