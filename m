From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] mmc: mmci: Bugfix in pio read for small packets
Date: Sat, 8 Oct 2011 10:10:36 +0100
Message-ID: <20111008091036.GF25689@n2100.arm.linux.org.uk>
References: <1317109568-17905-1-git-send-email-ulf.hansson@stericsson.com>
	<20111001160937.GF11710@n2100.arm.linux.org.uk>
	<4E8F028C.10102@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4E8F028C.10102@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Lee Jones <lee.jones@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stefan NILSSON9 <stefan.xk.nilsson@stericsson.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 07, 2011 at 03:45:48PM +0200, Ulf Hansson wrote:
> My feeling is that since discussing this patch, the rest of the patches  
> in this serie and are kind of "put on hold". The reason for keeping them  
> together is more of functional purpose. I hope you can have a look at  
> them anyway, they shall be possible to apply without this one.

Well, the patch system says that each one depends on the previous one,
and the first one in the series contains the PIO read thing.

Do 7108/1 onwards depend on 7106/1 and 7107/1 ?
