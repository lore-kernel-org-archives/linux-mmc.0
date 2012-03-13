From: Zach Sadecki <zsadecki@itwatchdogs.com>
Subject: Re: [PATCH v1 1/5] ARM: imx28: add basic dt support
Date: Tue, 13 Mar 2012 09:59:39 -0500
Message-ID: <4F5F60DB.9090801@itwatchdogs.com>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-2-git-send-email-b29396@freescale.com>
 <4F5F5B3F.2000303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F5F5B3F.2000303@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robherring2@gmail.com>
Cc: vinod.koul@linux.intel.com, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, rdunlap@xenotime.net, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, cjb@laptop.org, Dong Aisheng <b29396@freescale.com>, s.hauer@pengutronix.de, shawn.guo@freescale.com
List-Id: linux-mmc@vger.kernel.org

On 03/13/2012 09:35 AM, Rob Herring wrote:
> +	ahb@80080000 {
> +		fec@800f0000 {
> Use generic names: ethernet@800f0000
Generic is good, but consistency is better, IMHO.  grepping existing dts 
files in 3.2.9 finds 6 instances of "fec@" and 0 instances of "ethernet@"
>> +			uart1: uart@80074000 {
> Use generic names: uart1: serial@...
Same comment here, but unfortunately there is already inconsistency in 
existing files...  25 instances of "serial@" and 35 instances of "uart@"
